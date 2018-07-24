CREATE TABLE Airport
(
	airport_code         CHAR(4) NOT NULL ,
	country              CHAR(20) NOT NULL ,
	airport_location     CHAR(20) NOT NULL ,
	airport_name         CHAR(20) NOT NULL 
);

CREATE UNIQUE INDEX XPK공항 ON Airport
(airport_code   ASC);

ALTER TABLE Airport
	ADD CONSTRAINT  XPK공항 PRIMARY KEY (airport_code);

CREATE TABLE Passenger_plane
(
	registration_marks   CHAR(10) NOT NULL ,
	model_years          INTEGER NOT NULL ,
	owner                CHAR(20) NOT NULL ,
	model_name           CHAR(10) NOT NULL 
);

CREATE UNIQUE INDEX XPK여객기 ON Passenger_plane
(registration_marks   ASC);

ALTER TABLE Passenger_plane
	ADD CONSTRAINT  XPK여객기 PRIMARY KEY (registration_marks);

CREATE TABLE Flight
(
	flight_number        INTEGER NOT NULL ,
	schedule_number      INTEGER NOT NULL ,
	registration_marks   CHAR(10) NOT NULL 
);

CREATE UNIQUE INDEX XPK항공편 ON Flight
(flight_number   ASC);

ALTER TABLE Flight
	ADD CONSTRAINT  XPK항공편 PRIMARY KEY (flight_number);

CREATE TABLE Member
(
	member_number        INTEGER NOT NULL ,
	member_name          CHAR(20) NOT NULL ,
	member_age           INTEGER NOT NULL ,
	member_mileage       INTEGER NULL ,
	passport_number      CHAR(9) NOT NULL 
);

CREATE UNIQUE INDEX XPK고객 ON Member
(member_number   ASC);

ALTER TABLE Member
	ADD CONSTRAINT  XPK고객 PRIMARY KEY (member_number);

CREATE TABLE Model
(
	model_name           CHAR(10) NOT NULL ,
	payload              INTEGER NULL ,
	maximum_distance     INTEGER NOT NULL ,
	seating_capacity     INTEGER NOT NULL 
);

CREATE UNIQUE INDEX XPK모델명 ON Model
(model_name   ASC);

ALTER TABLE Model
	ADD CONSTRAINT  XPK모델명 PRIMARY KEY (model_name);

CREATE TABLE payment_information
(
	payment_number       INTEGER NOT NULL ,
	payment_option       CHAR(15) NOT NULL ,
	payment_price        INTEGER NOT NULL ,
	mileage_use          CHAR(1) NOT NULL 
);

CREATE UNIQUE INDEX XPK결제정보 ON payment_information
(payment_number   ASC);

ALTER TABLE payment_information
	ADD CONSTRAINT  XPK결제정보 PRIMARY KEY (payment_number);


CREATE TABLE Schedule
(
	schedule_number      INTEGER NOT NULL ,
	arrival_time         DATE NOT NULL ,
	depart_time          DATE NOT NULL ,
	depart_airport       CHAR(4) NOT NULL ,
    arrival_airport      CHAR(4) NOT NULL 
);

CREATE UNIQUE INDEX XPK노선스케쥴 ON Schedule
(schedule_number   ASC);

ALTER TABLE Schedule
	ADD CONSTRAINT  XPK노선스케쥴 PRIMARY KEY (schedule_number);

CREATE TABLE Seat
(
	seat_number          CHAR(5) NOT NULL ,
	cabin_class          CHAR(15) NOT NULL ,
	registration_marks   CHAR(10) NOT NULL 
);

CREATE UNIQUE INDEX XPK좌석 ON Seat
(seat_number   ASC,registration_marks   ASC);

ALTER TABLE Seat
	ADD CONSTRAINT  XPK좌석 PRIMARY KEY (seat_number,registration_marks);

CREATE TABLE Ticket
(
	ticket_number        INTEGER NOT NULL ,
	flight_number        INTEGER NOT NULL ,
	payment_number       INTEGER NOT NULL ,
	member_number        INTEGER NOT NULL ,
	seat_number          CHAR(5) NOT NULL ,
	registration_marks   CHAR(10) NOT NULL 
);

CREATE UNIQUE INDEX XPK티켓 ON Ticket
(ticket_number   ASC);

ALTER TABLE Ticket
	ADD CONSTRAINT  XPK티켓 PRIMARY KEY (ticket_number);

ALTER TABLE Passenger_plane
	ADD (CONSTRAINT R_12 FOREIGN KEY (model_name) REFERENCES Model (model_name) ON DELETE SET NULL);

ALTER TABLE Flight
	ADD (CONSTRAINT R_19 FOREIGN KEY (schedule_number) REFERENCES Schedule (schedule_number) ON DELETE SET NULL);

ALTER TABLE Flight
	ADD (CONSTRAINT R_22 FOREIGN KEY (registration_marks) REFERENCES Passenger_plane (registration_marks) ON DELETE SET NULL);

ALTER TABLE Schedule
	ADD (CONSTRAINT R_27 FOREIGN KEY (depart_airport) REFERENCES Airport (airport_code) ON DELETE SET NULL);
    
ALTER TABLE Schedule
	ADD (CONSTRAINT R_30 FOREIGN KEY (arrival_airport) REFERENCES Airport (airport_code) ON DELETE SET NULL);


ALTER TABLE Seat
	ADD (CONSTRAINT R_29 FOREIGN KEY (registration_marks) REFERENCES Passenger_plane (registration_marks));

ALTER TABLE Ticket
	ADD (CONSTRAINT R_15 FOREIGN KEY (flight_number) REFERENCES Flight (flight_number) ON DELETE SET NULL);

ALTER TABLE Ticket
	ADD (CONSTRAINT R_18 FOREIGN KEY (member_number) REFERENCES Member (member_number) ON DELETE SET NULL);

ALTER TABLE Ticket
	ADD (CONSTRAINT R_26 FOREIGN KEY (seat_number, registration_marks) REFERENCES Seat (seat_number, registration_marks) ON DELETE SET NULL);

ALTER TABLE Ticket
	ADD (CONSTRAINT R_17 FOREIGN KEY (payment_number) REFERENCES payment_information (payment_number) ON DELETE SET NULL);
    
