-- Create all 7 tables:
	-- Staff table
CREATE TABLE staff (
	staff_id SERIAL PRIMARY KEY,
	first_name VARCHAR,
	last_name VARCHAR,
	staff_type VARCHAR,
	email VARCHAR,
	address VARCHAR,
	phone_number VARCHAR
);
	
	-- Customer table
CREATE TABLE customer (
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR,
	last_name VARCHAR,
	address VARCHAR,
	email VARCHAR,
	billing_info VARCHAR
);

	-- Vehicle table
CREATE TABLE vehicle (
	vehicle_id SERIAL PRIMARY KEY,
	vehicle_make VARCHAR,
	vehicle_model VARCHAR,
	vehicle_year NUMERIC(4),
	vehicle_cost NUMERIC(9, 2),
	sale_service VARCHAR,
	new_used VARCHAR
);
	
	-- Part table
CREATE TABLE part (
	part_id SERIAL PRIMARY KEY,
	part_desc VARCHAR,
	part_cost NUMERIC(9, 2),
	part_upc NUMERIC(12, 0),
	in_stock BOOLEAN
);

	-- Sales_invoice table
CREATE TABLE sales_invoice (
	invoice_id SERIAL PRIMARY KEY,
	invoice_date DATE DEFAULT CURRENT_DATE,
	total_cost NUMERIC(9, 2),
	vehicle_id INTEGER NOT NULL,
	customer_id INTEGER NOT NULL,
	staff_id INTEGER NOT NULL,
	FOREIGN KEY (vehicle_id) REFERENCES vehicle(vehicle_id),
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

	-- Service_invoice table
CREATE TABLE service_invoice (
	service_id SERIAL PRIMARY KEY,
	invoice_date DATE DEFAULT CURRENT_DATE,
	service_total NUMERIC(9, 2),
	customer_id INTEGER,
	vehicle_id INTEGER,
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY (vehicle_id) REFERENCES vehicle(vehicle_id)
);

	-- Service_type table
CREATE TABLE service_type (
	type_id SERIAL PRIMARY KEY,
	service_date TIMESTAMPTZ DEFAULT NOW(),
	service_desc VARCHAR,
	service_cost NUMERIC(9, 2),
	service_id INTEGER,
	staff_id INTEGER,
	part_id INTEGER,
	FOREIGN KEY (service_id) REFERENCES service_invoice(service_id),
	FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
	FOREIGN KEY (part_id) REFERENCES part(part_id)
);


-- Insert 2+ records into each table:
-- Procedure to add record to vehicle table:
CREATE OR REPLACE PROCEDURE add_vehicle(
	_vehicle_make VARCHAR,
	_vehicle_model VARCHAR,
	_vehicle_year NUMERIC(4),
	_vehicle_cost NUMERIC(9, 2),
	_sale_service VARCHAR,
	_new_used VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO vehicle(vehicle_make, vehicle_model, vehicle_year, vehicle_cost, sale_service, new_used)
	VALUES (_vehicle_make, _vehicle_model, _vehicle_year, _vehicle_cost, _sale_service, _new_used);
END;
$$

-- Call add_vehicle procedure to add records to vehicle table:
-- Added 2+ records:
CALL add_vehicle('Honda', 'Accord', 2005, 8000, 'sale', 'used');
CALL add_vehicle('Toyota', 'Tacoma', 2021, 26400, 'sale', 'new');
CALL add_vehicle('Toyota', 'Tacoma', 2021, NULL, 'service', NULL);
CALL add_vehicle('Dodge', 'Ram', 2019, NULL, 'service', NULL);
CALL add_vehicle('Mitsubishi', 'Eclipse', 1997, NULL, 'service', NULL);
CALL add_vehicle('Tesla', 'Model S', 2022, 120000, 'sale', 'new');
CALL add_vehicle('Aston Martin', 'DBX', 2022, 140000, 'sale', 'new');

-- Procedure to add record to staff table:
CREATE OR REPLACE PROCEDURE add_staff(
	_first_name VARCHAR,
	_last_name VARCHAR,
	_staff_type VARCHAR,
	_email VARCHAR,
	_address VARCHAR,
	_phone_number VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO staff(first_name, last_name, staff_type, email, address, phone_number)
	VALUES (_first_name, _last_name, _staff_type, _email, _address, _phone_number);
END;
$$

-- Call add_staff procedure to add records to staff table:
-- Added 2+ records:
CALL add_staff('Spencer', 'Franklin', 'sales', 'spencer.f123@gmail.com', '123 Las Vegas Ave., Las Vegas, NV 89107', '+1 702 123-4567');
CALL add_staff('Joshua', 'Cunningham', 'sales', 'josh.c627@gmail.com', '3828 Chicago Ave., Chicago, IL 60007', '+1 312 362-4635');
CALL add_staff('Marc', 'Brown', 'sales', 'marqueseb92734@hotmail.com', '382 Chicago Rd., Chicago, IL 60176', '+1 312 236-3923');
CALL add_staff('Paris', 'Doss', 'sales', 'p.d007@gmail.com', '9822 Chicago St., Chicago, IL 60007', '+1 312 392-3028');
CALL add_staff('Jonathan', 'Smith', 'mechanic', 'smithjj@yahoo.com', '923 N Chicago Blvd., Chicago, IL 60007', '+1 773 732-7465');

-- Procedure to add record to customer table:
CREATE OR REPLACE PROCEDURE add_customer(
	_first_name VARCHAR,
	_last_name VARCHAR,
	_address VARCHAR,
	_email VARCHAR,
	_billing_info VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO customer(first_name, last_name, address, email, billing_info)
	VALUES (_first_name, _last_name, _address, _email, _billing_info);
END;
$$

-- Call add_customer procedure to add records to customer table:
-- Added 2+ records:
CALL add_customer('Isabella', 'Russell', '3828 Chicago Ave., Chicago, IL 60007', 'issabella123@gmail.com', '4242-4242-4242-4242 623 05/22');
CALL add_customer('Elijah', 'Theresa', '456 Street Drive Chicago, IL 90606', 'elit@yahoo.com', '1212-1212-1212-1212 101 05/22');
CALL add_customer('Vincent', 'Logan', '382 Chicago Rd., Chicago, IL 60176', 'loganv@gmail.com', '4747-4747-4747-1474 328 08/22');
CALL add_customer('Madison', 'Doss', '9822 Chicago St., Chicago, IL 60007', 'm.d007@gmail.com', '3817-4746-2121-3434 283 09/23');
CALL add_customer('Ann', 'Frances', '123 Street Drive Las Vegas, NV 89107', 'afran99@yahoo.com', '2378-8372-9372-3817 922 11/29');

-- Procedure to add record to part table:
CREATE OR REPLACE PROCEDURE add_part(
	_part_desc VARCHAR,
	_part_cost NUMERIC(9, 2),
	_part_upc NUMERIC(12, 0),
	_in_stock BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO part(part_desc, part_cost, part_upc, in_stock)
	VALUES (_part_desc, _part_cost, _part_upc, _in_stock);
END;
$$

-- Call add_part procedure to add records to part table:
-- Added 2+ records:
CALL add_part('carburetor', 23.00, 123456789012, '1');
CALL add_part('oil filter', 9.00, 937485736284, '1');
CALL add_part('5 quart oil', 30.00, 937485736284, '1');
CALL add_part('carburetor', 23.00, 123456789012, TRUE);
CALL add_part('transmission', 1900.00, 123456789012, FALSE);
CALL add_part('no part needed, labor only', 15.00, 372839173821, TRUE);

-- Procedure to add record to service_invoice table:
CREATE OR REPLACE PROCEDURE add_service_invoice(
	_service_total NUMERIC(9, 2),
	_customer_id INTEGER,
	_vehicle_id INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO service_invoice(service_total, customer_id, vehicle_id)
	VALUES (_service_total, _customer_id, _vehicle_id);
END;
$$

-- Call add_service_invoice procedure to add records to service_invoice table:
-- Added 2+ records:
CALL add_service_invoice(55.00, 1, 5);
CALL add_service_invoice(70.00, 2, 4);
CALL add_service_invoice(70.00, 3, 3);

-- Procedure to add record to sales_invoice table:
CREATE OR REPLACE PROCEDURE add_sales_invoice(
	_total_cost NUMERIC(9, 2),
	_vehicle_id INTEGER,
	_customer_id INTEGER,
	_staff_id INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO sales_invoice(total_cost, vehicle_id, customer_id, staff_id)
	VALUES (_total_cost, _vehicle_id, _customer_id, _staff_id);
END;
$$

-- Call add_sales_invoice procedure to add records to sales_invoice table:
-- Added 2+ records:
CALL add_sales_invoice(150000, 6, 4, 1);
CALL add_sales_invoice(170000, 7, 5, 2);
CALL add_sales_invoice(8500, 1, 4, 3);

-- Procedure to add record to service_type table:
CREATE OR REPLACE PROCEDURE add_service_type(
	_service_desc VARCHAR,
	_service_cost NUMERIC(9, 2),
	_service_id INTEGER,
	_staff_id INTEGER,
	_part_id INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO service_type(service_desc, service_cost, service_id, staff_id, part_id)
	VALUES (_service_desc, _service_cost, _service_id, _staff_id, _part_id);
END;
$$

-- Call add_service_type procedure to add records to service_type table:
-- Added 2+ records:
CALL add_service_type('oil change labor', 15.00, 1, 5, 6);
CALL add_service_type('5 quart oil', 30, 1, 5, 3);
CALL add_service_type('oil filter', 10, 1, 5, 2);
