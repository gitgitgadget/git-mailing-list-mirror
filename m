Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3BDB202DD
	for <e@80x24.org>; Tue, 24 Oct 2017 08:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbdJXIMz (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 04:12:55 -0400
Received: from mail-eopbgr30119.outbound.protection.outlook.com ([40.107.3.119]:22064
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751606AbdJXIMw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 04:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dnv.onmicrosoft.com;
 s=selector1-dnvgl-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=X2rvfes/fo/VzDsQiyKZGS1zuUUZRDNQicAc8M7dxos=;
 b=txjsmIlHmBfQq83WF3paoDI4ccQC3rwU9N6aEpqyy8/YmykOmligr4GpvyGrZhRa5xAn60iXc3KOKYoGD3jAg/iDMDJ6MRxk7KEYXmwmQRmH8vdQpjR0yyB9tGxctwz0UcWeSxhWxvfuE2XZGfTaNiBC38AQB9vG8Ym6ZaMbyb0=
Received: from DB6PR0202MB2807.eurprd02.prod.outlook.com (10.171.72.12) by
 DB6PR0202MB2808.eurprd02.prod.outlook.com (10.171.72.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.156.4; Tue, 24 Oct 2017 08:12:49 +0000
Received: from DB6PR0202MB2807.eurprd02.prod.outlook.com
 ([fe80::305f:22a8:83ed:a54e]) by DB6PR0202MB2807.eurprd02.prod.outlook.com
 ([fe80::305f:22a8:83ed:a54e%14]) with mapi id 15.20.0156.007; Tue, 24 Oct
 2017 08:12:49 +0000
From:   "Voie, Per Erlend Torbergsen" <Per.Erlend.Voie@dnvgl.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git describe returns tags including 'refs/tags/
Thread-Topic: git describe returns tags including 'refs/tags/
Thread-Index: AdNMndOza6AU2na4SM6pMSoMXdRpkgAAew6g
Date:   Tue, 24 Oct 2017 08:12:49 +0000
Message-ID: <DB6PR0202MB28074CB67408334285264588A4470@DB6PR0202MB2807.eurprd02.prod.outlook.com>
References: <DB6PR0202MB2807FB243E7D7A574D555F16A4470@DB6PR0202MB2807.eurprd02.prod.outlook.com>
In-Reply-To: <DB6PR0202MB2807FB243E7D7A574D555F16A4470@DB6PR0202MB2807.eurprd02.prod.outlook.com>
Accept-Language: nb-NO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Per.Erlend.Voie@dnvgl.com; 
x-originating-ip: [193.161.96.4]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0202MB2808;6:n8EjF+DyYhGZZzBRQ/pExzsA34MfNC5yEB8qaW9bQLLjzY/2z5gGYyezB4WTlTtRj+iN3zCELs7ynbT/SGJnWyRMoCEHbB5BIP77NpXu5fECc+eXg3EhnuNqew66bWStMfbdihRE5GyH69d7eNByVnGCWszqcUryLomKJDjCa6MOOdQFQOqcUuQZHNPo3s+7gfcyA2jTEt6PZo7uuWztymwcnQgNBGzZ9MZFm0xsQL067H6mCAHR2xZy+flFdkujCIlaz/Edh8HIzffh4YcDjpu0EVRYmaCvkJibrrifmexgdqiwxGho7Ta7S2v83gRbQpYJCtHJO6AhTxQsDqAn8w==;5:G4Azmzsq/Kl1Z0wNMdiNtwO/gSGwXGg6pT2N+0OHN1FHtwc2fYYq4fX2t0jPHebt3s6am8QiE921Hes+NbmTVEI4y1MaBW/dOto7FnM5vx109EXLipcWsLejmYfnEQHBGmc4D12Vb7OXrw1KsrDqhQ==;24:56Ya4+nSOBEtRSmXSHZx9d9y82EoIolnMM3jizLsK2xtjCmksKSrbiiXsZbVK39kCJYwnsBIKiH8mZiz8i9TZv2KUqnZiRr8SFgC9gq5cOk=;7:17udmGRhtCTnqTzsqdXg7qIU4b+AX08LvlSRpqqL9Tz7I7E7Semr4zinqU7hmkPerY5FdDppdzIiJJYbWx3+7KOAwOFG0QJW+hzIo/PBjeXG4H12alvZjaI25h7ITEbNL8G2WswsV+9zpYrq62U/axhpw0V8fGURIDm8dSp0sP6siPNOt5BHUnjiKld4qKCiKMAeZJKD+yF/MLAdqNPu8M+FrBD8gNlmeA2yenSyIMg=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: ab816502-d64e-45d0-fad7-08d51ab70460
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627075)(201703031133081)(201702281549075)(48565401081)(2017052603199);SRVR:DB6PR0202MB2808;
x-ms-traffictypediagnostic: DB6PR0202MB2808:
x-exchange-antispam-report-test: UriScan:;
x-microsoft-antispam-prvs: <DB6PR0202MB28089230ACA3266D347BDCCAA4470@DB6PR0202MB2808.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231020)(100000703101)(100105400095)(6055026)(6041248)(20161123562025)(20161123564025)(20161123555025)(20161123560025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DB6PR0202MB2808;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DB6PR0202MB2808;
x-forefront-prvs: 047001DADA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(346002)(39860400002)(376002)(189002)(199003)(74316002)(3660700001)(3280700002)(72206003)(5640700003)(3846002)(8936002)(478600001)(6116002)(102836003)(6506006)(6436002)(7736002)(101416001)(86362001)(2940100002)(189998001)(97736004)(2906002)(305945005)(66066001)(14454004)(5660300001)(76176999)(54356999)(7696004)(2351001)(6916009)(81166006)(106356001)(105586002)(81156014)(1730700003)(33656002)(2950100002)(68736007)(50986999)(2900100001)(9686003)(5250100002)(316002)(5890100001)(25786009)(53936002)(8676002)(55016002)(99286003)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2808;H:DB6PR0202MB2807.eurprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: dnvgl.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dnvgl.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab816502-d64e-45d0-fad7-08d51ab70460
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2017 08:12:49.5876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: adf10e2b-b6e9-41d6-be2f-c12bb566019c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2808
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

I am versioning my python package using git tags and the python-versioneer =
package.

Basically versioneer gets the version number from git tags using the comman=
d "git describe --tags --dirty --always --long --match 'tag_prefix*'". I do=
 not apply a tag prefix, hence tag_prefix=3D''.

Now to the problem. My build breaks because the command above returns tags =
like this "refs/tags/2.12.2" which contains invalid characters. Actually, i=
t seems that executing the command above reconfigured the way git describe =
behaves.

because, before running the above command "git describe --tags --dirty" ret=
urned

2.12.2-17-gd8e62f9

After, "git describe --tags --dirty" returns

warning: tag 'refs/tags/2.12.2' is really '2.12.2' here
refs/tags/2.12.2-17-gd8e62f9

Is it so that "git describe --tags --dirty --always --long --match 'tag_pre=
fix*'" changes the way git describe behave or am I missing something? If it=
 does, how can I reset it?

Thanks
Per

***************************************************************************=
***********
This e-mail and any attachments thereto may contain confidential informatio=
n and/or information protected by intellectual property rights for the excl=
usive attention of the intended addressees named above. If you have receive=
d this transmission in error, please immediately notify the sender by retur=
n e-mail and delete this message and its attachments. Unauthorized use, cop=
ying or further full or partial distribution of this e-mail or its contents=
 is prohibited.
***************************************************************************=
***********
