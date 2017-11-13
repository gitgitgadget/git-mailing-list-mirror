Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 749B01F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 21:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbdKMVfM (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 16:35:12 -0500
Received: from mail-bl2nam02on0080.outbound.protection.outlook.com ([104.47.38.80]:14510
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751247AbdKMVfL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 16:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=McGill.onmicrosoft.com; s=selector1-mail-mcgill-ca;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qcZcsso+YqsEsyfMC5DP+iQ9PzlLQCKqRW1GZUR9+g4=;
 b=fXVFFTGIeheAU3dIPviDIFdnawnL+E2oQa1j0x005mMrnHqqS01pOd83hnyhcIN3X8KG6Frzx9CNRpe6bg5prqwYxb+Q1y8eqQw18EsolVL0niYzrJoX7TsbKZTEEiBi+2b6Z+b8tFBiqPppHFzjZFMcZineGhG/rd0K90e8a+k=
Received: from YTXPR0101MB2175.CANPRD01.PROD.OUTLOOK.COM (52.132.40.150) by
 YTXPR0101MB2173.CANPRD01.PROD.OUTLOOK.COM (52.132.40.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.197.13; Mon, 13 Nov 2017 21:35:10 +0000
Received: from YTXPR0101MB2175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b86a:f234:8a3:92d2]) by YTXPR0101MB2175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b86a:f234:8a3:92d2%13]) with mapi id 15.20.0197.024; Mon, 13 Nov 2017
 21:35:10 +0000
From:   Louis Gruand <louis.gruand@mail.mcgill.ca>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: no mountable file systems 
Thread-Topic: no mountable file systems 
Thread-Index: AQHTXMdHgIEGkqUNWUSwleVls4dQ6Q==
Date:   Mon, 13 Nov 2017 21:35:09 +0000
Message-ID: <5EC5A274-E62A-43F2-BAF0-9C83069F94D8@mail.mcgill.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=louis.gruand@mail.mcgill.ca; 
x-originating-ip: [142.157.13.132]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB2173;6:kqEi6hPiT7UhvVSxv0Gtvl184aMHipzddbiSogIRftAXPrJe80g+iS2Dx/DHqrh/U3RvwwnluMqXsEsWNhTIIDCfyUR8zHOydP2zDsn7j8k4oz8tZG/Oeyp50CFcO+ZX6HtTHdP9SDzAYb2ShaOs4MphhSlx3BPQ56Ihllqg96ppvgyxgxW8SRN1nb1zAJclg6JJPcrn3sk9968dFgEpUWowSx3LdOxxHR1THXPBT0VtcaPTt4ll3e9CUd8IbHlEmQ0pls6/+2K/w0IyG+jacWUR/1cpxNj2GrhERxC7WEPl/MNmiT+Fy+NXxMguuJ4U4F+ZyBEyDVNoPdISPneY3JaLJV0Qr61YFnGf/RDGooo=;5:KLpZM0UmNE9ok8Kflz2Oq2xbunJN8w8NMVBGs1cfuasHGjCJeZP2O8xfL5bUjZQVNElh2qIMa7MluQO7NyqFIqBkEYsBjFhac0+JjpyW1dYcs3tFTEZsGl0pz3hkpOmJKKCzrj5KdWyroQvnr5fYf8WsgL/yM1Hj5HleS/nQbXA=;24:QMv430bc38E91RZiFz8ET7ACqQqoXahD6LfawvE9MmzsBU2TTieCzfQGAP4jzbRHcQdrKyCC9Erv5Fof2fuzg2JUplsAhO2BVOI2cwYpAMQ=;7:cQXIteURpCUmwY7B678cMcvWl9E22IbW9+4dZqN31QT4IoZru4FS3n1+WK9e6CnTL89V0allkNRrFquRSxaVE4xap0QKZ4lHMiX/gTq/hTZIfyhvK0HnV8haahKCsmsGn651ujywaLw9liR4f9pyNLZP+GLeZSNkqdktfVhsLMhILSZe4lGKN/3RAyPKa/bBq459ptdbqd7gjSMpZCoRUgA6GGsacuIrUhcP060ZmOxaUrWOAgvoDw+lrTpq9Xj0
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 9f67e5f9-9cc9-4d87-ca2b-08d52ade6a7b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603258);SRVR:YTXPR0101MB2173;
x-ms-traffictypediagnostic: YTXPR0101MB2173:
x-microsoft-antispam-prvs: <YTXPR0101MB21735B68C89390A7ADE6D5EEB82B0@YTXPR0101MB2173.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(3002001)(3231022)(10201501046)(93006095)(93001095)(100000703101)(100105400095)(6041248)(20161123555025)(201703131423075)(201702281528075)(201702281529075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(20161123558100)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:YTXPR0101MB2173;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:YTXPR0101MB2173;
x-forefront-prvs: 0490BBA1F0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(199003)(189002)(40764003)(8936002)(101416001)(3280700002)(3660700001)(8676002)(81156014)(1730700003)(81166006)(305945005)(33656002)(7736002)(2906002)(66066001)(3480700004)(478600001)(14454004)(86362001)(413944005)(74482002)(82746002)(2501003)(2351001)(189998001)(6916009)(5250100002)(5660300001)(42882006)(558084003)(345774005)(106356001)(99286004)(105586002)(4743002)(6486002)(316002)(2900100001)(6512007)(6436002)(83716003)(25786009)(6506006)(786003)(53936002)(50986999)(3846002)(5640700003)(54356999)(6116002)(102836003)(97736004)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:YTXPR0101MB2173;H:YTXPR0101MB2175.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:0;MX:1;LANG:en;
received-spf: None (protection.outlook.com: mail.mcgill.ca does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <20DD968239EE594594514028E2C52FCF@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mail.mcgill.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f67e5f9-9cc9-4d87-ca2b-08d52ade6a7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2017 21:35:09.8209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cd319671-52e7-4a68-afa9-fcf8f89f09ea
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB2173
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RGVhciB0ZWFtLCB3aGVuIGkgZG93bmxvYWQgR2l0IG9uIE1hYyBpdCBzYXlzIOKAnG5vIG1vdW50
YWJsZSBmaWxlIHN5c3RlbXPigJ0gYW5kIGRvZXNudCBvcGVuIGFmdGVyLiBob3cgY2FuIGkgc29s
dmUgdGhpcz8NCg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgaGVscCwNCg0KDQoNCg==
