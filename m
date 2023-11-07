Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCED7FD
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 00:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="cloTeGc+"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2052.outbound.protection.outlook.com [40.92.91.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AFB10D
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 16:23:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMY3TmJe5RZt5VIqWpz98sXpIs+5AUIRyeEJA8M5dfDQQkv+PXQCgZ5oenDndAdGzo6ZnBahT74K1T8jfE87VYEVs1HeT8WoPm1YzpZiRbT6FPnGZiolFuZotIwOP2TaeJbAEl5zH2V+Szd0PZVkUIGpLEDV8+M2FR6j/lbHRQWvt8cLqkXx0V9CdspNeiCdw4o+9rtBBwtsYMdAsnnkIQ+k8NrIztEfQvOSS4Yp+fVYu9+pF3RQEQMK5LqOLJKKJTEvd9O7j6HWxG2Gb2RA/eX5hFfEY93IwnBtEO9qMdGFCxTCV/VDwOAUVLcU8ySDBaMxysefqgR2LhTiUdn54g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b65x66VH9BYkh6jOYSmarjNE5KSlc5cb26Zj0XYIYOw=;
 b=SjFSNGVLsMobuHjuumlDCqmAp1KxZKXI115gjhFMpbMgbstOs5OH71jtxEz/cYkWpZvntZwLh1R3Bx1v95HCDylFKjcNm4dm7d+YVol75T6HlJq3WFyyM7+lUK1jGsx03mFg5xHIrIpu/mk9lPAdWnnlwaKpbRbaQtkUbpilf2vmHV+D3iuAXmK4w4kWRcZ8agsWxsnKdNB1nZoHnVw08G//tg2rBp5QYCvHQGkgjo8zirBdVvb/e4OhD8mSxIKiR54lEV6exySBtJ3joU8aUv6Q1BrTLdeMP2B2FmUxZRSj9Ong2Q4j2WtR75Sbhs+uiFPUtJBwqF9phhEeCXd2LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b65x66VH9BYkh6jOYSmarjNE5KSlc5cb26Zj0XYIYOw=;
 b=cloTeGc+BD41JLDwQzQCEE1IRCk7INpGQmsEXWiJmVA1tjspIr47FtlRi1uXlFGcM5sSirS6+vgMdEMih22ME2H/IKfEBcp2TSyvwT+JJHJmONt71UYKY0XrIMYsPvwmzntYIBGNIE8ZmOFKNYOlfArJrhUy/QoIv4Er0kdCiYifToxc7fmZ05Zqf0AtmNpZjGVUAg4Kyd9pauHhx+gCZAwYAnaDbBGx3Ww17xepffsJT8d6Ikf/HOiVODByPdRRP9akbY+mKp6ssZZaKQhfbWIaBlVR93dKRZZjlcIHYnPAFWs0SaJlnL2yqn+1+U64YQ28296HeVCRDSah0BX70w==
Received: from AS4P195MB1527.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4ba::20)
 by PAWP195MB2227.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:341::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Tue, 7 Nov
 2023 00:23:30 +0000
Received: from AS4P195MB1527.EURP195.PROD.OUTLOOK.COM
 ([fe80::57a4:cb0a:3694:1a48]) by AS4P195MB1527.EURP195.PROD.OUTLOOK.COM
 ([fe80::57a4:cb0a:3694:1a48%4]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 00:23:29 +0000
From: Hans Meiser <brille1@hotmail.com>
To: =?Windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Explanation of `eol` attribute doesn't seem correct for Windows
 machines
Thread-Topic: Explanation of `eol` attribute doesn't seem correct for Windows
 machines
Thread-Index: AQHaEMLJO+2VIgOO7Ui0hkVqixKkt7BteQ2AgACGNxE=
Date: Tue, 7 Nov 2023 00:23:29 +0000
Message-ID:
 <AS4P195MB1527BC2DF67412D4FF340989E2A9A@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
References:
 <AS4P195MB15272FE283D0CF606A8B074EE2AAA@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
 <20231106162125.GA31375@tb-raspi4>
In-Reply-To: <20231106162125.GA31375@tb-raspi4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [XFDcw6YslmDLB/aE6ssxQ5D3XSx3mkPv]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4P195MB1527:EE_|PAWP195MB2227:EE_
x-ms-office365-filtering-correlation-id: 8eb53d74-ab4f-4a8d-7c78-08dbdf27c4a8
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qMvpZay4rdRIiKGqw4HzDuoXxFS4yLKB8j/t+N/U5enNnqMR+uz7HLT1+7CGX7E2mF/pqy7oBMzhJg4rUZXXNXuz7BkU8vd0MjAi/fjkjler/7jR2HVeHy4y6XqSK4q2NfU00zB6C4958tx/Bp3VNfQjUevhqJHMLCVMlXEd14JCpiXHjawrLBWvA7WI9UzMeUDLSHXU+IZ/cj2LbDvDxFlnvTokwUL1PNOSJeqOqqFJSBuMxSeMBZDcfpHOqd5uHrFAy2QbpfHHTrU8Sa0VYcoYUw6biiFShYisL9JkxdYPY7291oNLe0sh89wiyb5dA6yY3Zhv93HJTrLfoo9HA08FkUDbyjf+kBCQSXX1D04eQONMTpeGUlFicF6oShw/nH7FjCI5lWerppVhFrE/muvu61dWvHT0tLWWWkmPBijUTQ8qmMk3DBtdElfMFiAAin50UtOTbhmiQmzAt03/y9fkDP/W/3IF6fJ5IG3CV31YBlR4YIAFvj6MZMf4ztiKiBt74tZ7JXbz/tV18HV3OI6t/BSiNvW+3w4SMzi8tBMdTDOtKM07/R/Ig1widHaU3h3ls2E1IcWWzaPevYxN03zK0ryeb6Ad2pSTnyKamUo=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?/RypqAnzu32la5TJgfohTmOMw5aoFrHFlN47eacx1wEvPnsKbWYdm6nS?=
 =?Windows-1252?Q?bJ6tu2rr5kzm0cKvyNQb8juM4vc41mC7wz58wJL2/H2g5HAffLxEmm/H?=
 =?Windows-1252?Q?hWblFHAsdElHBg6w0OpGpQAs93iCt75XLvFcJ/1Ze78M+K8JlkEEfbsk?=
 =?Windows-1252?Q?iAmOWQxqPsxJvCFb6FWapXcS8MFb3Jr9eU0ECbMGwcfJ2XRhvMCGdrc5?=
 =?Windows-1252?Q?zmZaJ0kxX9fNv1U7zCidbn/AeMnbLkxAAa5gRCVZqNU3XdwEPUfJCXAi?=
 =?Windows-1252?Q?7wDIWKxYEOMFLyP1hozYvcxEIRkCtcGzldukxJmeNyWmeUH8fFCAhs2D?=
 =?Windows-1252?Q?0Q5LixrAW5AsmwKmNY2KLmcQW+ZCrC6Mz5EvhpAcDVRzYv5xc1DoyL1a?=
 =?Windows-1252?Q?tbw/qxQM1H0cD1Kf1/Je9VB7bP/0D5R8Z8dTw8Mc2aA63LEH3MoTMV0O?=
 =?Windows-1252?Q?VmESXxGuuO3RS2RpoLoWU56OMjiGos4D8UED3Og9HqhVo14P3MfzjQBY?=
 =?Windows-1252?Q?DtXWdZcKIhYojeDL3kFpmOWW5OPDLlHoWVTBjOy2C5t64/saGaWIK2ra?=
 =?Windows-1252?Q?VnS5UsphK3G+2tBPTPZaVqw3ATriyGmBY7MEEckYz5bt6ZIecXStlvuq?=
 =?Windows-1252?Q?+Zg0INVMeddS1aAqYAXn9o7ZvjWu+WMT09ZNClT0RK707fEFpl8FM9PM?=
 =?Windows-1252?Q?fXNQZ9+kN3arWX5Rc+9uuufSWKqppOPPRi+W9uDPZCk9HNMRiDVXLI4n?=
 =?Windows-1252?Q?ZuGYcnp09EHQYaJgfTTr+FZ9+4BT5GmXqZ4uxw9AO8c96V7wBzPqSltN?=
 =?Windows-1252?Q?GDT41hmYihDmWN1eq3xYTNow92T/XL+ExBhUz2kmQfKV075+ap2w9hev?=
 =?Windows-1252?Q?MCEUJmigwhS1EJTErSzxx3JMYD11w9XyPtHm/fObFF/b/jJU+Lwb0519?=
 =?Windows-1252?Q?09dockhLKORpjiaPThP7yw2r5xSiDD0Y7jP7xRnZHhHOq0eMjSQDUWj5?=
 =?Windows-1252?Q?zo7rpsuEQlGLfGjnNxaBCDJdYjEW/6EppZEjcZXdOID2HMHMAQFJl9Tl?=
 =?Windows-1252?Q?TAA9aTC63jLud86zkkpOP7YHw0y1QqIpHEYKSI0oWoXvVAmJecSigIvN?=
 =?Windows-1252?Q?t4d+vnLEmx1CMY0IeKrU3t9za2WB8r+GLaoQI/1p74CzY7SWMEKCOvt1?=
 =?Windows-1252?Q?/AyQrC4V+a5jMbHaCh787nh7KffmqeUXLkLEue97QKUWOJVJuk8bWPlf?=
 =?Windows-1252?Q?E2NZO6lsaoH31iRtYGAbikzf5+V/8aOgrCbDaHBb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb53d74-ab4f-4a8d-7c78-08dbdf27c4a8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 00:23:29.8989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP195MB2227

> > And what happens when a file is added to the index with `core.autocrlf=
=3Dinput` on Windows machines?=0A=
> Do you have a .gitattributes file ? Or not ?=0A=
> Is the file a new one, or does it exist ?=0A=
=0A=
Exactly all these questions/cases should be explained by the documentation,=
 I suppose.=0A=
=0A=
-------=0A=
From: Torsten B=F6gershausen <tboegi@web.de>=0A=
Sent: Monday, November 6, 2023 17:21=0A=
To: Hans Meiser <brille1@hotmail.com>=0A=
Cc: git@vger.kernel.org <git@vger.kernel.org>=0A=
Subject: Re: Explanation of `eol` attribute doesn't seem correct for Window=
s machines =0A=
=A0=0A=
On Mon, Nov 06, 2023 at 03:11:54PM +0000, Hans Meiser wrote:=0A=
> https://git-scm.com/docs/gitattributes#_eol=0A=
>=0A=
> claims that:=0A=
>=0A=
> ---=0A=
> Set to string value "crlf"=0A=
>=0A=
>=A0=A0=A0=A0 This setting converts the file=92s line endings in the workin=
g directory to CRLF when the file is checked out.=0A=
> Set to string value "lf"=0A=
>=0A=
>=A0=A0=A0=A0 This setting uses the same line endings in the working direct=
ory as in the index when the file is checked out.=0A=
> ---=0A=
>=0A=
> I don't think this explanation is sufficient for files stored on Windows =
machines.=0A=
> A file might be stored with CRLF in the index.=0A=
> What happens then?=0A=
=0A=
=A0 >This setting uses the same line endings in the working directory=0A=
=A0 >as in the index when the file is checked out.=0A=
=A0 If you have a file commited with CRLF into the index, it will have CRLF=
 in the working tree.=0A=
=A0 If the file had been commited with LF into the index, it will have LF i=
n the working tree.=0A=
=A0 That is what the documentation tries to say, I think.=0A=
=0A=
However, the above discussion is only valid, when the "text" attribute is d=
efined.=0A=
Otherwise the eol attribute has no effect.=0A=
So you need something like=0A=
* text=3Dauto=0A=
and/or=0A=
*.txt text=0A=
in your .gitattributes file=0A=
=0A=
=0A=
> And what happens when a file is added to the index with `core.autocrlf=3D=
input` on Windows machines?=0A=
Do you have a .gitattributes file ? Or not ?=0A=
Is the file a new one, or does it exist ?=0A=
=0A=
In any way,=0A=
git ls-files --eol=0A=
may help to find out, what is in the index and what is in the workingtree.=
