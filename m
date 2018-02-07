Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD8C51F576
	for <e@80x24.org>; Wed,  7 Feb 2018 09:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753733AbeBGJSw (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 04:18:52 -0500
Received: from mail-eopbgr30079.outbound.protection.outlook.com ([40.107.3.79]:42583
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753734AbeBGJSt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 04:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ercogmbh.onmicrosoft.com; s=selector1-erco-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Dbtyo/Zw7CsehTqPPfD4b+0r5hbBiCdi6QVgA2qIShs=;
 b=DfE5QlrCViVOhXFQ+gJW7K4xjFhzp+2TI+uMlrgzwWDFiEggVA+B6QqOS0pkwhcFLSNXA5t5qRnL099gpJ6u+0XF3i4ltno/oZnt0afjuZtEpdtUccVzywSLKh1M/Z7tEt95hD1QO6PuALo0Qz15N4HAheTQHZV/z66v5Vn9HE8=
Received: from AM6PR0402MB3464.eurprd04.prod.outlook.com (52.133.19.33) by
 AM6PR0402MB3574.eurprd04.prod.outlook.com (52.133.20.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.464.11; Wed, 7 Feb 2018 09:18:46 +0000
Received: from AM6PR0402MB3464.eurprd04.prod.outlook.com
 ([fe80::1842:5191:fe23:6817]) by AM6PR0402MB3464.eurprd04.prod.outlook.com
 ([fe80::1842:5191:fe23:6817%13]) with mapi id 15.20.0485.009; Wed, 7 Feb 2018
 09:18:46 +0000
From:   "Ehrt, Michael" <m.ehrt@erco.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Windows: mintty.exe classified as exploit by AV software
Thread-Topic: Windows: mintty.exe classified as exploit by AV software
Thread-Index: AdOf836w8dLtsE8ESyarVOoffI6Gdg==
Date:   Wed, 7 Feb 2018 09:18:46 +0000
Message-ID: <AM6PR0402MB34640AF9BB8DD9DB1BB2241CE6FC0@AM6PR0402MB3464.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=m.ehrt@erco.com; 
x-originating-ip: [193.158.86.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3574;7:efFwAef9RwLlizeBo1X40uCUQvZ34K0zyT/ipsbWwCgVX9YWSpRh/DRgM6Gs7SyyVQxWKoDUBqYfCubtwK9DWNTt3o+EgdOYadLwSDP2dFDOIRVFCLp1wF6LWDy0AxZYJbijUXlIQHMDIiKoIeWolsJBx7hOv9yAj0GkZxM5bs6wt2ifOaQ1TYcT6DJpR7jdDwkK9diOUhFumTVE+2kk0OBoCj/3NKBSQ1rM8NRX7T3ELpcyvS5g5uW3qeDe6yjx
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 7370c234-9d60-4a06-41c3-08d56e0bcab2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:AM6PR0402MB3574;
x-ms-traffictypediagnostic: AM6PR0402MB3574:
x-microsoft-antispam-prvs: <AM6PR0402MB35746920BF8B7992836AB738E6FC0@AM6PR0402MB3574.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705)(67617419657146);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(10201501046)(3002001)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:AM6PR0402MB3574;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3574;
x-forefront-prvs: 0576145E86
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39380400002)(39850400004)(366004)(53754006)(199004)(189003)(5660300001)(55016002)(6436002)(25786009)(8676002)(106356001)(2351001)(6306002)(2900100001)(9686003)(105586002)(53936002)(2906002)(81166006)(81156014)(8936002)(1730700003)(186003)(3280700002)(3660700001)(5640700003)(68736007)(6116002)(3846002)(6916009)(316002)(102836004)(97736004)(86362001)(6506007)(59450400001)(74316002)(305945005)(7736002)(7696005)(26005)(99286004)(33656002)(14454004)(2501003)(966005)(478600001)(5250100002)(66066001)(460985005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3574;H:AM6PR0402MB3464.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: erco.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wgRgxsjc1ITLVijk1KZro69nDpkD2ua/bkN37auGti73tuq7RWiNLQCGF5JEWHG3l1/LOuObyuxJgGa3kf3OwQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: erco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7370c234-9d60-4a06-41c3-08d56e0bcab2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2018 09:18:46.6699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 16350171-e77d-4924-83a3-94b4b29cf63e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3574
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

a few days ago I installed version 2.16.1.2, downloaded from https://git-sc=
m.com/download/win on my Windows 7 system. The OS is Windows 7 Enterprise 6=
4bit, Build 7601/SP1, in case it matters. This is a first time install, not=
 an upgrade.

Our current virus protection software is Cylance, from https://www.cylance.=
com/en_us/home.html

During install, several executions of=20
C:\Program Files\Git\usr\bin\bash.exe
were blocked, the violation being given as "Stack Pivot". Our admins then t=
emporarily lifted some rules for my device so that I could properly install=
 it.

But now, when I start ...
"C:\Program Files\Git\git-bash.exe" --cd-to-home
... Cylance classifies it as an Exploit, and blocks execution with the foll=
owing messages:
Category: Exploit
Event: Blocked
Details: Violation: StackProtect; Application: C:\Program Files\Git\usr\bin=
\mintty.exe
(Screenshot available if needed)

If I start ...
C:\Program Files\Git\usr\bin\mintty.exe
directly, and choose the 64 bit version from the dialog, it is allowes to s=
tart without getting blocked.

My current problem is that the security guys don't want to see this softwar=
e installed on my machine because of this.
And as Cylance is not a pattern-based AV, it's not something that will go a=
way by waiting for the next daily update ...

Any ideas about this?

Thanks

Michael

