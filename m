Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFBFD20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 23:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753234AbdASXy5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 18:54:57 -0500
Received: from mail-db5eur01on0136.outbound.protection.outlook.com ([104.47.2.136]:64077
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752734AbdASXy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 18:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mmtdigital.onmicrosoft.com; s=selector1-mmtdigital-co-uk;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZBrJP51KDBZ8FaIwPTJByzuqXbANXVJXy3T+PTohSE4=;
 b=cKcPxggOzB+JwH/uE/u5bKeb9k83cNOjIJdyFRrcjaWOCZr5A7yIYzr4UuUN+OSCOT1Zq8hrHfp5/UJf/xbp0LhPeUf9GrQWTMoLWImtlZ3yHIbWEZTQH9ox8+bGQEvt/Q+Aci+KE/6dU68GvQL88JZY+y62cNjUU28/kcP0fZw=
Received: from AM4PR03MB1715.eurprd03.prod.outlook.com (10.167.88.17) by
 AM4PR03MB1714.eurprd03.prod.outlook.com (10.167.88.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.845.12; Thu, 19 Jan 2017 23:54:38 +0000
Received: from AM4PR03MB1715.eurprd03.prod.outlook.com ([10.167.88.17]) by
 AM4PR03MB1715.eurprd03.prod.outlook.com ([10.167.88.17]) with mapi id
 15.01.0845.021; Thu, 19 Jan 2017 23:54:37 +0000
From:   Ilesh Mistry <ilesh.m@mmtdigital.co.uk>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Post-merge hook
Thread-Topic: Post-merge hook
Thread-Index: AQHScq9kSAvlDE82Rku26qHjr3XHHg==
Date:   Thu, 19 Jan 2017 23:54:37 +0000
Message-ID: <A6C196AD-41F5-4FA3-A2A9-6CBDA473AB6B@mmtdigital.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ilesh.m@mmtdigital.co.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2a02:c7d:5bb3:a200:69ad:e0ed:f650:77f1]
x-ms-office365-filtering-correlation-id: 008acd24-783b-492e-ef00-08d440c6870f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:AM4PR03MB1714;
x-microsoft-exchange-diagnostics: 1;AM4PR03MB1714;7:cqvOuMz7lrMiIrXfqXNPKBMxAV8WlXBbfjiOt8Zu2l7g7Y6k6kQqsKU8+lQpF4xuNqVSNrw4pq8BNXACuDU5Du6UCNFPbTGMpS7uJqDeJNDNLwJ//cHAQ0exNmPQ7fNMbKFGojhunwojLYvZ2ZVJi/SuXFu7Orq4ML6G62NoDdFNEORFDaVKHRIf68+fbnNipe/vXXlr/8uO/wdnz7e8AR4UFkIkU5XmZoAeXsfJiJNLSqwz3mclqPdLg7tS04ovNBVV6pvxwWHVHZIx8fPlY0CVtprnOWJ4VZG0kk6TloK+E6M8DcwB3XCgd136vcGahSWJCvYZxsTLAOSj0/euKxcl3rWDrkiJZ3DN5J/P1W1OcwtYwPrPwlA3oLQVyxV//hddTlzL3sijVh3a+u+/WzCGDvu36Im2G/qaiimF90WtV2vkc1Yx3btDGJl65kNSLRfkrIj0uA04nCl8votBVA==
x-microsoft-antispam-prvs: <AM4PR03MB171497A8BF0E40207290AFA8DE7E0@AM4PR03MB1714.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6041248)(2016111802025)(20161123555025)(20161123562025)(20161123560025)(20161123564025)(6072148)(6043046);SRVR:AM4PR03MB1714;BCL:0;PCL:0;RULEID:;SRVR:AM4PR03MB1714;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(7916002)(39410400002)(39840400002)(39450400003)(189002)(199003)(55885003)(122556002)(3280700002)(2900100001)(6512007)(5660300001)(305945005)(38730400001)(189998001)(107886002)(450100001)(68736007)(99286003)(6306002)(7736002)(6486002)(77096006)(6506006)(25786008)(92566002)(5640700003)(6436002)(86362001)(33656002)(3660700001)(74482002)(81166006)(8936002)(97736004)(3480700004)(5003630100001)(81156014)(1730700003)(8676002)(110136003)(83716003)(54356999)(36756003)(15974865002)(106356001)(2501003)(106116001)(50986999)(105586002)(6916009)(42882006)(53936002)(102836003)(82746002)(2906002)(101416001)(6116002)(2351001)(104396002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR03MB1714;H:AM4PR03MB1715.eurprd03.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: mmtdigital.co.uk does not
 designate permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <143B1C437C541C41A908FA2F0CA0FAA5@mmtdigital.co.uk>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mmtdigital.co.uk
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2017 23:54:37.8262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18d7863a-b360-4417-b5ca-28b1e5e62258
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR03MB1714
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello

I have been looking around for this, but I can't seem to find any examples =
of how to use the git post-merge hook. Can you help me please?

I want to do something really simple in the sense of pulling locally and on=
ce pulled and merged any conflicts (if any) then run a command line code. B=
ut run this code after any merge conflicts are resolved.

Can you help me by pointing me into the right direction on how I can resolv=
e this please?

Thanks
Ilesh

Sent from my iPhone

Ilesh Mistry
Kentico Technical Architect
T 01572 822 278

www.mmtdigital.co.uk <http://www.mmtdigital.co.uk>

RAR Digital Awards Winner 2016: Best Web Development Agency in the UK
RAR Digital Awards Winner 2016: Best Software Development Agency in the UK
RAR Digital Awards Winner 2016: Best Analytics Agency in the UK
RAR Digital Awards Winner 2015: Best Web Design Agency in the UK
Econsultancy 2016 Top 100 Agency
The Drum Digital Census 2015: Elite Agency Top 10


Participation in this email correspondence denotes acceptance of
terms and conditions available on request or from our website,
unless a separate contract has been agreed.

Registered Office: 1A Uppingham Gate, Ayston Road, Uppingham, Rutland, LE15=
 9NY
Company Number: 3681297
VAT Registration: 638 5654 05
