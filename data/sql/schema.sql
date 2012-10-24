SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `hosho` DEFAULT CHARACTER SET utf8 ;
USE `hosho` ;

-- -----------------------------------------------------
-- Table `hosho`.`job_title`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`job_title` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`job_title` (
  `job_title_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `job_title` VARCHAR(100) NULL ,
  PRIMARY KEY (`job_title_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`person` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`person` (
  `person_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `title` VARCHAR(15) NULL ,
  `first_name` VARCHAR(100) NOT NULL ,
  `last_name` VARCHAR(100) NOT NULL ,
  `job_title_id` INT(11) UNSIGNED NOT NULL ,
  `email_id` INT(11) NULL ,
  `phone_id` INT(11) NULL ,
  `address_id` INT(11) NULL ,
  `updated` TIMESTAMP NULL ,
  `created` TIMESTAMP NULL ,
  PRIMARY KEY (`person_id`) ,
  INDEX `fk_person_job_title_idx` (`job_title_id` ASC) ,
  CONSTRAINT `fk_person_job_title`
    FOREIGN KEY (`job_title_id` )
    REFERENCES `hosho`.`job_title` (`job_title_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`user` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`user` (
  `user_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `person_id` INT(11) UNSIGNED NOT NULL ,
  `email` VARCHAR(120) NOT NULL ,
  `password` VARCHAR(120) NOT NULL ,
  `default_company` INT(11) NULL ,
  `default_rate` DOUBLE(10,2) NULL ,
  `default_rate_type_id` INT(11) UNSIGNED NULL ,
  `updated` TIMESTAMP NULL ,
  `created` TIMESTAMP NULL ,
  PRIMARY KEY (`user_id`) ,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) ,
  INDEX `fk_user_person_idx` (`person_id` ASC) ,
  CONSTRAINT `fk_user_person`
    FOREIGN KEY (`person_id` )
    REFERENCES `hosho`.`person` (`person_id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`phone_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`phone_type` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`phone_type` (
  `phone_type_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `phone_type` VARCHAR(15) NULL ,
  PRIMARY KEY (`phone_type_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`phone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`phone` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`phone` (
  `phone_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `phone_type_id` INT(11) UNSIGNED NOT NULL ,
  `country_code` INT(5) UNSIGNED NULL DEFAULT 1 ,
  `area_code` INT(8) UNSIGNED NULL ,
  `number` VARCHAR(15) NULL ,
  PRIMARY KEY (`phone_id`) ,
  INDEX `fk_phone_phone_type_idx` (`phone_type_id` ASC) ,
  CONSTRAINT `fk_phone_phone_type1`
    FOREIGN KEY (`phone_type_id` )
    REFERENCES `hosho`.`phone_type` (`phone_type_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`address_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`address_type` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`address_type` (
  `address_type_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `address_type` VARCHAR(15) NULL ,
  PRIMARY KEY (`address_type_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`city`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`city` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`city` (
  `city_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(100) NULL ,
  PRIMARY KEY (`city_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`subdivision_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`subdivision_type` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`subdivision_type` (
  `subdivision_type_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `subdivision_type` VARCHAR(45) NULL ,
  PRIMARY KEY (`subdivision_type_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`postal_code_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`postal_code_type` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`postal_code_type` (
  `postal_code_type_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `postal_code_type` VARCHAR(45) NULL ,
  PRIMARY KEY (`postal_code_type_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`country` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`country` (
  `country_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `abbreviation` VARCHAR(3) NULL ,
  `subdivision_type_id` INT(11) UNSIGNED NOT NULL ,
  `postal_code_type_id` INT(11) UNSIGNED NOT NULL ,
  PRIMARY KEY (`country_id`) ,
  INDEX `fk_country_subdivision_type_idx` (`subdivision_type_id` ASC) ,
  INDEX `fk_country_postal_code_type_idx` (`postal_code_type_id` ASC) ,
  CONSTRAINT `fk_country_subdivision_type`
    FOREIGN KEY (`subdivision_type_id` )
    REFERENCES `hosho`.`subdivision_type` (`subdivision_type_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_country_postal_code_type`
    FOREIGN KEY (`postal_code_type_id` )
    REFERENCES `hosho`.`postal_code_type` (`postal_code_type_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`subdivision`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`subdivision` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`subdivision` (
  `subdivision_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `abbreviation` VARCHAR(3) NULL ,
  `name` VARCHAR(50) NULL ,
  `country_id` INT(11) UNSIGNED NOT NULL ,
  PRIMARY KEY (`subdivision_id`) ,
  INDEX `fk_subdivision_country_idx` (`country_id` ASC) ,
  CONSTRAINT `fk_subdivision_country`
    FOREIGN KEY (`country_id` )
    REFERENCES `hosho`.`country` (`country_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`postal_code`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`postal_code` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`postal_code` (
  `postal_code_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `postal_code` VARCHAR(25) NULL ,
  PRIMARY KEY (`postal_code_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`address` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`address` (
  `address_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `address_type_id` INT(11) UNSIGNED NOT NULL ,
  `address_1` VARCHAR(120) NOT NULL ,
  `address_2` VARCHAR(120) NULL ,
  `city_id` INT(11) UNSIGNED NOT NULL ,
  `subdivision_id` INT(11) UNSIGNED NOT NULL ,
  `postal_code_id` INT(11) UNSIGNED NOT NULL ,
  `country_id` INT(11) UNSIGNED NOT NULL ,
  PRIMARY KEY (`address_id`) ,
  INDEX `fk_address_address_type_idx` (`address_type_id` ASC) ,
  INDEX `fk_address_city_idx` (`city_id` ASC) ,
  INDEX `fk_address_subdivision_idx` (`subdivision_id` ASC) ,
  INDEX `fk_address_1_idx` (`postal_code_id` ASC) ,
  INDEX `fk_address_1_idx1` (`country_id` ASC) ,
  CONSTRAINT `fk_address_address_type`
    FOREIGN KEY (`address_type_id` )
    REFERENCES `hosho`.`address_type` (`address_type_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_city`
    FOREIGN KEY (`city_id` )
    REFERENCES `hosho`.`city` (`city_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_subdivision`
    FOREIGN KEY (`subdivision_id` )
    REFERENCES `hosho`.`subdivision` (`subdivision_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_postal_code`
    FOREIGN KEY (`postal_code_id` )
    REFERENCES `hosho`.`postal_code` (`postal_code_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_country`
    FOREIGN KEY (`country_id` )
    REFERENCES `hosho`.`country` (`country_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`email_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`email_type` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`email_type` (
  `email_type_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `email_type` VARCHAR(15) NULL ,
  PRIMARY KEY (`email_type_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`email`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`email` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`email` (
  `email_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `email` VARCHAR(200) NOT NULL ,
  `email_type_id` INT(11) UNSIGNED NOT NULL ,
  PRIMARY KEY (`email_id`) ,
  INDEX `fk_email_email_type_idx` (`email_type_id` ASC) ,
  CONSTRAINT `fk_email_email_type`
    FOREIGN KEY (`email_type_id` )
    REFERENCES `hosho`.`email_type` (`email_type_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`company`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`company` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`company` (
  `company_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(200) NOT NULL ,
  `email_id` INT(11) UNSIGNED NULL ,
  `phone_id` INT(11) UNSIGNED NULL ,
  `address_id` INT(11) UNSIGNED NULL ,
  `updated` TIMESTAMP NULL ,
  `created` TIMESTAMP NULL ,
  PRIMARY KEY (`company_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`invoice_period`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`invoice_period` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`invoice_period` (
  `invoice_period_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `invoice_period` VARCHAR(120) NULL ,
  `invoice_day` VARCHAR(12) NULL ,
  PRIMARY KEY (`invoice_period_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`rate_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`rate_type` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`rate_type` (
  `rate_type_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `rate_type` VARCHAR(15) NOT NULL ,
  PRIMARY KEY (`rate_type_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`timesheet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`timesheet` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`timesheet` (
  `timesheet_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `company_id` INT(11) UNSIGNED NOT NULL ,
  `invoice_period_id` INT(11) UNSIGNED NOT NULL ,
  `rate_type_id` INT(11) UNSIGNED NOT NULL ,
  `rate` DOUBLE(10,2) NOT NULL ,
  `updated` TIMESTAMP NULL ,
  `created` TIMESTAMP NULL ,
  PRIMARY KEY (`timesheet_id`, `company_id`) ,
  INDEX `fk_timesheet_invoice_period_idx` (`invoice_period_id` ASC) ,
  INDEX `fk_timesheet_rate_type_idx` (`rate_type_id` ASC) ,
  INDEX `fk_timesheet_company_idx` (`company_id` ASC) ,
  CONSTRAINT `fk_timesheet_invoice_period`
    FOREIGN KEY (`invoice_period_id` )
    REFERENCES `hosho`.`invoice_period` (`invoice_period_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_timesheet_rate_type`
    FOREIGN KEY (`rate_type_id` )
    REFERENCES `hosho`.`rate_type` (`rate_type_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_timesheet_company`
    FOREIGN KEY (`company_id` )
    REFERENCES `hosho`.`company` (`company_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`time`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`time` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`time` (
  `time_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `timesheet_id` INT(11) UNSIGNED NOT NULL ,
  `in` TIMESTAMP NULL ,
  `out` TIMESTAMP NULL ,
  `notes` TEXT(3000) NULL ,
  PRIMARY KEY (`time_id`, `timesheet_id`) ,
  INDEX `fk_time_timesheet_idx` (`timesheet_id` ASC) ,
  CONSTRAINT `fk_time_timesheet`
    FOREIGN KEY (`timesheet_id` )
    REFERENCES `hosho`.`timesheet` (`timesheet_id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`company_person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`company_person` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`company_person` (
  `company_id` INT(11) UNSIGNED NOT NULL ,
  `person_id` INT(11) UNSIGNED NOT NULL ,
  PRIMARY KEY (`company_id`, `person_id`) ,
  INDEX `fk_company_person_person_idx` (`person_id` ASC) ,
  INDEX `fk_company_person_company_idx` (`company_id` ASC) ,
  CONSTRAINT `fk_company_person_company`
    FOREIGN KEY (`company_id` )
    REFERENCES `hosho`.`company` (`company_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_company_person_person`
    FOREIGN KEY (`person_id` )
    REFERENCES `hosho`.`person` (`person_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`company_phone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`company_phone` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`company_phone` (
  `company_id` INT(11) UNSIGNED NOT NULL ,
  `phone_id` INT(11) UNSIGNED NOT NULL ,
  PRIMARY KEY (`company_id`, `phone_id`) ,
  INDEX `fk_company_phone_phone_idx` (`phone_id` ASC) ,
  INDEX `fk_company_phone_company_idx` (`company_id` ASC) ,
  CONSTRAINT `fk_company_phone_company`
    FOREIGN KEY (`company_id` )
    REFERENCES `hosho`.`company` (`company_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_company_phone_phone`
    FOREIGN KEY (`phone_id` )
    REFERENCES `hosho`.`phone` (`phone_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`company_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`company_address` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`company_address` (
  `company_id` INT(11) UNSIGNED NOT NULL ,
  `address_id` INT(11) UNSIGNED NOT NULL ,
  PRIMARY KEY (`company_id`, `address_id`) ,
  INDEX `fk_company_address_address_idx` (`address_id` ASC) ,
  INDEX `fk_company_address_company_idx` (`company_id` ASC) ,
  CONSTRAINT `fk_company_address_company`
    FOREIGN KEY (`company_id` )
    REFERENCES `hosho`.`company` (`company_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_company_address_address`
    FOREIGN KEY (`address_id` )
    REFERENCES `hosho`.`address` (`address_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`company_email`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`company_email` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`company_email` (
  `company_id` INT(11) UNSIGNED NOT NULL ,
  `email_id` INT(11) UNSIGNED NOT NULL ,
  PRIMARY KEY (`company_id`, `email_id`) ,
  INDEX `fk_company_email_email_idx` (`email_id` ASC) ,
  INDEX `fk_company_email_company_idx` (`company_id` ASC) ,
  CONSTRAINT `fk_company_email_company`
    FOREIGN KEY (`company_id` )
    REFERENCES `hosho`.`company` (`company_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_company_email_email`
    FOREIGN KEY (`email_id` )
    REFERENCES `hosho`.`email` (`email_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`person_phone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`person_phone` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`person_phone` (
  `person_id` INT(11) UNSIGNED NOT NULL ,
  `phone_id` INT(11) UNSIGNED NOT NULL ,
  PRIMARY KEY (`person_id`, `phone_id`) ,
  INDEX `fk_person_phone_phone_idx` (`phone_id` ASC) ,
  INDEX `fk_person_phone_person_idx` (`person_id` ASC) ,
  CONSTRAINT `fk_person_phone_person`
    FOREIGN KEY (`person_id` )
    REFERENCES `hosho`.`person` (`person_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_phone_phone`
    FOREIGN KEY (`phone_id` )
    REFERENCES `hosho`.`phone` (`phone_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`person_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`person_address` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`person_address` (
  `person_id` INT(11) UNSIGNED NOT NULL ,
  `address_id` INT(11) UNSIGNED NOT NULL ,
  PRIMARY KEY (`person_id`, `address_id`) ,
  INDEX `fk_person_address_address_idx` (`address_id` ASC) ,
  INDEX `fk_person_address_person_idx` (`person_id` ASC) ,
  CONSTRAINT `fk_person_address_person`
    FOREIGN KEY (`person_id` )
    REFERENCES `hosho`.`person` (`person_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_address_address`
    FOREIGN KEY (`address_id` )
    REFERENCES `hosho`.`address` (`address_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hosho`.`person_email`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hosho`.`person_email` ;

CREATE  TABLE IF NOT EXISTS `hosho`.`person_email` (
  `person_id` INT(11) UNSIGNED NOT NULL ,
  `email_id` INT(11) UNSIGNED NOT NULL ,
  PRIMARY KEY (`person_id`, `email_id`) ,
  INDEX `fk_person_email_email_idx` (`email_id` ASC) ,
  INDEX `fk_person_email_person_idx` (`person_id` ASC) ,
  CONSTRAINT `fk_person_email_person`
    FOREIGN KEY (`person_id` )
    REFERENCES `hosho`.`person` (`person_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_email_email`
    FOREIGN KEY (`email_id` )
    REFERENCES `hosho`.`email` (`email_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
