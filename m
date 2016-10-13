Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D661F209A9
	for <e@80x24.org>; Fri, 14 Oct 2016 01:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756057AbcJNBfr (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 21:35:47 -0400
Received: from mail-db5eur01on0069.outbound.protection.outlook.com ([104.47.2.69]:27456
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752495AbcJNBfp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 21:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conceptek.onmicrosoft.com; s=selector1-csscorporate-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8QSdUjFJX1Mn2IsWzK7a1nGe6uMQyQT5NkXCCG+GccU=;
 b=cLG3e6NqdQVV76Nwrp83okcb+xMaWU7rzwO11N2uZRDxo1KtibcIR06mY4Conh9BSxuM9UcwOblbL2bNCk3DcpQdA7++gF/POQAKCgQf0S6AjidkHKEZnvZ+3nHD1yz9YB4NxEMvL/CiXqTaeKaSqJOPQimpd0wkphAgkEzaoc4=
Received: from HE1PR0101MB2187.eurprd01.prod.exchangelabs.com (10.168.29.20)
 by HE1PR0101MB1675.eurprd01.prod.exchangelabs.com (10.166.119.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.659.11; Thu, 13
 Oct 2016 15:57:55 +0000
Received: from HE1PR0101MB2187.eurprd01.prod.exchangelabs.com ([10.168.29.20])
 by HE1PR0101MB2187.eurprd01.prod.exchangelabs.com ([10.168.29.20]) with mapi
 id 15.01.0659.018; Thu, 13 Oct 2016 15:57:55 +0000
From:   Daniel Lopez <dlopez@csscorporate.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Francisco Carreira <fcarreira@csscorporate.com>
Subject: Change Default merge strategy options
Thread-Topic: Change Default merge strategy options
Thread-Index: AQHSJWIBGDoUWeiC306sVyf/efipiaCmiegv
Date:   Thu, 13 Oct 2016 15:57:55 +0000
Message-ID: <HE1PR0101MB218771966DAC7634B9735634BDDC0@HE1PR0101MB2187.eurprd01.prod.exchangelabs.com>
References: <HE1PR0101MB2187D29367CB67F42373647CBDDC0@HE1PR0101MB2187.eurprd01.prod.exchangelabs.com>
In-Reply-To: <HE1PR0101MB2187D29367CB67F42373647CBDDC0@HE1PR0101MB2187.eurprd01.prod.exchangelabs.com>
Accept-Language: pt-PT, en-US
Content-Language: pt-PT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dlopez@csscorporate.com; 
x-originating-ip: [25.165.214.132]
x-ms-office365-filtering-correlation-id: b65fe976-e095-40ef-e45a-08d3f381b249
x-microsoft-exchange-diagnostics: 1;HE1PR0101MB1675;7:fRSqiws6r6KTnpUWPDFyTCs7hMJNgbGQHU4OPvlOXL3Qzl53PD1HD5I8lTYNPKRoe77oC6tCNcpful3ifmV06/1q4/UIn0tpEwLtStwgIK21Bz0clwOwOyV2K5SMUrEaOHicbCmN2NuNzSxjB/lI7mSNeEbJ/BlQo5ltf/nmqnBw27AyB2WV1cPJBI41VPmFJbvyPt2RCtk9dgGOsvEr97liCrv/Ukssz7HW5jnRB2XO4yY1JFUGTeIXb/VkNWCCdOBqLGonFkW9bbA3yT+nW/5opMqGEMmVBlayR1rJAmhbqFs99zoJ3HZvElqasLVIVMs34Vpc9PLPeiQpTcnUww0qCY4uXMUZve1l0so3hZI=
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0101MB1675;
x-microsoft-antispam-prvs: <HE1PR0101MB1675BCDA1607F8EAD39832D0BDDC0@HE1PR0101MB1675.eurprd01.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6042046)(6043046);SRVR:HE1PR0101MB1675;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0101MB1675;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(7916002)(252514010)(189002)(199003)(33656002)(6916009)(8676002)(50986999)(10400500002)(15974865002)(2501003)(9686002)(4326007)(7696004)(86362001)(107886002)(81166006)(1730700003)(2906002)(97736004)(66066001)(5660300001)(2900100001)(19580405001)(87936001)(7846002)(54356999)(450100001)(4001430100002)(11100500001)(2950100002)(101416001)(68736007)(7736002)(102836003)(6116002)(74316002)(81156014)(76176999)(5002640100001)(77096005)(122556002)(586003)(3660700001)(3846002)(305945005)(189998001)(110136003)(106116001)(3280700002)(19580395003)(8936002)(229853001)(92566002)(2351001)(105586002)(106356001)(460985005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0101MB1675;H:HE1PR0101MB2187.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: csscorporate.com does not
 designate permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: csscorporate.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2016 15:57:55.5078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e0797f8b-8d5f-4a4e-b4ec-0ee12d07fd55
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0101MB1675
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

How to use 'git config --global' to set default strategy like recursive.


Example:
Currently , when we want to enforce a specific strategic we need to include=
=A0 its reference on the command line :=A0
git.exe merge --strategy=3Drecursive --strategy-option=3Dignore-all-space d=
ev-local


we would like to define it as the default strategic to follow and be able t=
o simplify the command line to:

git.exe merge dev-fix1.3-local=20

Using alias is not an option as the git is being called from TortoiseGit (o=
ur current gui tool).


Daniel Lopez
Concept Developer

Tel: +351 289 100683 | Email:=A0dlopez@csscorporate.com=A0|=A0www.csscorpor=
ate.com=A0|=A0=A0=A0

