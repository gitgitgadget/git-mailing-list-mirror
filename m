Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5599476
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="AWauQ4HY"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2084.outbound.protection.outlook.com [40.92.49.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F5C134
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 07:11:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9G1Ow2rDaQ7eWMyp4m9jdJgh5FRw31Aaz0g5pDgc0fbeO2CuNfFvjDLKHzj2UYQvO+FudP4N2HgntyC1i53LJfbyfQ6ze3hbXWg2UqV5NkBgoRmu3Oh0P+Rr1ncC6Kp8Z3pBgNZYFOdRtBSayAYn2tyJfkMN0+GEUbc6FlPuaTxPRFaNClhild+yfanaGcfF2Z2M6Ygk6FD2UVRtp2IUeQQjlrxsyI5/bEDYMF8NNEpKZoeEWigjknhnMt2VgxCybYaZDPb4Q5YF2CLZKBm9g5AK56STfO5lr/zN3sza7RasSohKz3YAwZM95RBmL3XpYWRxuLC+0gfsUYI92uQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlum6gNuSh9pRzxJib6oW+aBSB1r8tblMogtpebrEuo=;
 b=awhcn5LfSombvmWUCqcjBicttx1mseKJPS10M1cr3U4bMFO6/9vwjCr3RFTYKWs22UadHy1LCrvqp9yQKY/L7l1OEaHo3nX60IEsuasAkf6lllWyqOWQXuL0ZDZ6H07c1v1aUhhud8rLJPxRMQgvrzxj7AKq0qR2+G7Q/V3sedKQVKUTMNZEuZCPrLGeDWQl3qHN4GsSZbENQJ/Wv93TFBq4hMr+nVE4n9g9DwFXqnCbe2rFiaZjDyZwphtWH+7qHrt1Uu1t+wV45NY0ezRQYwQcrZmS47TW+P4GDrGMfnUeUzSKiOiH9oXGv3RALf+hHb7S7ONeLvmFcCMfH7d3GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlum6gNuSh9pRzxJib6oW+aBSB1r8tblMogtpebrEuo=;
 b=AWauQ4HYBgEv/bwW7JvshYsFmqof+igkm5P2YawPk+OBTXSZDO0orHqoF6cdQjajVuDmthgG7FrEA2Cbn3PU5VKm6qMgR2tubpGqPxV0zjtFBQCazkA9acWP+XBdofkXeWMBz5DsBWX9VHIdObzFaJG/EkNumjmqZAgA4zq2o25/OQCD0RoIS1NrIQh6wvxfIbtHk5m3mEODHyniGozhyJNRBc6rVXH4RHt2B9CCJG/6rUQybjPbUNkZ3Fz0RUxP5bUnTwV8GyYt990MLmNVmzrkwNTfYnATd2IlY+9NOAUl1RglKUX8EGexpgm1xxGhOV7qw3jGw5tex6Vz4vH0BQ==
Received: from AS4P195MB1527.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4ba::20)
 by GVXP195MB2029.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:17::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Mon, 6 Nov
 2023 15:11:54 +0000
Received: from AS4P195MB1527.EURP195.PROD.OUTLOOK.COM
 ([fe80::57a4:cb0a:3694:1a48]) by AS4P195MB1527.EURP195.PROD.OUTLOOK.COM
 ([fe80::57a4:cb0a:3694:1a48%4]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 15:11:54 +0000
From: Hans Meiser <brille1@hotmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Explanation of `eol` attribute doesn't seem correct for Windows
 machines
Thread-Topic: Explanation of `eol` attribute doesn't seem correct for Windows
 machines
Thread-Index: AQHaEMLJO+2VIgOO7Ui0hkVqixKktw==
Date: Mon, 6 Nov 2023 15:11:54 +0000
Message-ID:
 <AS4P195MB15272FE283D0CF606A8B074EE2AAA@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-tmn: [U2mGkHUmoNGb+xV6IG1dCwRPrKYXCV80]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4P195MB1527:EE_|GVXP195MB2029:EE_
x-ms-office365-filtering-correlation-id: 5042ce11-47dc-4500-f1be-08dbdedab60f
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 L7PssTooXUGJCG9h2Z7VYZ9i7fhh6q0eKGSASkffyooyUjOEEBpA+BEg/WmH9vZ4rTyGbJCp0wsrK7P0AznqORFJ8TVTSxrU2OTB6NSe0JvIm2UmJ59gKLMkStoGoNp7iqmRyxmB7PBnl0inP/Ky8XdxmkW6iLX5+QTt9rISUHABWdz/qHBrBfiS2dyav+ibeML+MtpJTU7hVfNgwQH4Qys5p6ppQY16yU1xTF9C2lsejX0AjrrduRmjNKdIX86+kfqLzmch4SEFMSISDpeaHs1S5jgw8dIJJhWKxrFQT1DP9TO33sc/5p8kVfttXmcpLCTcZt3GMIqtc7iA1TcKjfwjxqI6+lAjuSlSByqWPImVREACOCrUn8W8ckRU4duC1iGHYx8eKFTwPIgPyenTrNfzC3qk0FCSbkYp4qAcOf9Hgj/+Fs79b72Lps4a8MWxUK5BLxOvVKQwRBcDYMTpzTxxGIhLiDprBXmI+McoXjetpBazggzHm1yClGFANAvhVauuVVZirHsaXcyQq3R3OMTWYl0PvckbCUBwYK9Yn7nrnPtqSOulvwpWSHZQ5aL/ktNSTXsSCUPQZcunmh2AVc+XUid9p76ezKNkrXFWA0Q=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?Bg65duGs705xHJf1lGxtoNLlBlGWidkHofiWWsaT7C4SzKadm0TPTeDf?=
 =?Windows-1252?Q?akfw/xt0bDFj/nLetHbeOqz48e4Mk07/yODj/7rrl0COGUerVF6fcX5n?=
 =?Windows-1252?Q?ZGQt/dhlxzC39yIZLh5VuQH5QLm2ulIqgl8PLUZBHOyHox9s05qVPJKy?=
 =?Windows-1252?Q?S6UKGDPPeTAJFNg6ExSeLjwKjb8mXox7h4Y0Cv2T4mJLIKMpqlGbons+?=
 =?Windows-1252?Q?2WHqxb701e2iF6ejE/fMuyLgSTT7vDAY1nqN0jfO2WxMzApgRN7WX5R5?=
 =?Windows-1252?Q?Rm3j1LQ5PihGWZ6Srx3955vQOOAVxyG5qOTBi0iBoArFJJkGNb1/S9/8?=
 =?Windows-1252?Q?jpA19cvzYjj5jI/Y9oiArfqOx6NqdvF/tz0QdIKTynwqiWiDRRrsxctt?=
 =?Windows-1252?Q?PgvYP2LqZgMHwCh9NomyaovlKpvHsqkqbBUfWVklAZRm1CcCDeh8fnd/?=
 =?Windows-1252?Q?3j2OMaUbEDMrQuQlLJmPUgUwUNwBgPOxol1sieKgm3rfGmEf3+PiouCN?=
 =?Windows-1252?Q?xET50JPto4W2NtScE7TXmeUqhSXkaV04vxGrePkGGtBcgVkvrmwAfMRs?=
 =?Windows-1252?Q?cppBf6RfguIeREa5zrunMp/HZb3sdJKA5Cs0+12zVvmdqIH6hFt54qvX?=
 =?Windows-1252?Q?Rw9wOouzBmTK3SEgGt7Q4P+2HyaMJnZg/sM6iWa+G93y+X6l5ow6cXIt?=
 =?Windows-1252?Q?oZHSbDtXVW8KJVLQxDePi+uEW19pY0Thy4UYfCJ5ztyuyE0gnhjDMZUp?=
 =?Windows-1252?Q?x/lO1lXfSYvzcDD34hmT+300QceZyMze9pnpOkBhOZu1DUv4zXZ4iqei?=
 =?Windows-1252?Q?PkMbUDo5yf1gJcv2d4RdjZ8fwPB8+wI+zaPUW7WjszznUt9W7Ft91iPv?=
 =?Windows-1252?Q?Sehrht640Ll8WjvjXmDcioZwgW2Ck3/YZIwxf1GnZaeKz6cqaWuNcQnn?=
 =?Windows-1252?Q?ylt7o/i+dWAXTHOgq6BY6GinTM0qwAD7MBermcPwYgu0tu13LK8xwApy?=
 =?Windows-1252?Q?Ff0fqHkOm8n1/ONTWS1qDjfrcJ5ST06SFyxnKFWew3OPasn8t9rTxOEq?=
 =?Windows-1252?Q?Cw3g04vid1kR/mqKXdBe7L2URNz8joHktgF/7OffTXsDXW5qsSAOFLcB?=
 =?Windows-1252?Q?sth3Qg61yFdD4xhbfMkODxIIOTLwn4ALo9wIvGXVDZC59FKMG6CeKYGB?=
 =?Windows-1252?Q?nEK0bf8d476jf4yQfesGKLcWb0qN67KNotjkVNdQ2VQqQ0YgxQ4pjj+h?=
 =?Windows-1252?Q?0qV83aIjMxm9JSu9hiCOvpM/tcEmzTo5c6Szs5pT?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-49ed2.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1527.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5042ce11-47dc-4500-f1be-08dbdedab60f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 15:11:54.1325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB2029

https://git-scm.com/docs/gitattributes#_eol=0A=
=0A=
claims that:=0A=
=0A=
---=0A=
Set to string value "crlf"=0A=
=0A=
    This setting converts the file=92s line endings in the working director=
y to CRLF when the file is checked out.=0A=
Set to string value "lf"=0A=
=0A=
    This setting uses the same line endings in the working directory as in =
the index when the file is checked out.=0A=
---=0A=
=0A=
I don't think this explanation is sufficient for files stored on Windows ma=
chines. A file might be stored with CRLF in the index. What happens then? A=
nd what happens when a file is added to the index with `core.autocrlf=3Dinp=
ut` on Windows machines?=
