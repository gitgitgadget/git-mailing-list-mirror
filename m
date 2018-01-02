Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BFA01F406
	for <e@80x24.org>; Tue,  2 Jan 2018 11:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeABLK2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 06:10:28 -0500
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:15520
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751458AbeABLK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 06:10:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=YouGet.onmicrosoft.com; s=selector1-youget-com0i;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=c8cbOfka+DXGqKSErRpnP2r2z32dg5AQ0QY7xf3kwq0=;
 b=0kv0Gk3ufCjXycXqNUogn0ZqLmQUcJciBpGE/puymH2ObqRFcsecrFJzVlq0k9sKHwrFrhjxyzwsEWFpdYBAI3UFO0PwZxpE2Rmc9ZdqOFd5VddOex4rDkSUag0uFyl+Dxmmi23etm6+pZsKRNGi2y/+XA2rI/1FqyyINWwmCiE=
Received: from DB3PR0402MB3754.eurprd04.prod.outlook.com (52.134.71.13) by
 DB3PR0402MB3753.eurprd04.prod.outlook.com (52.134.71.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.366.8; Tue, 2 Jan 2018 11:10:24 +0000
Received: from DB3PR0402MB3754.eurprd04.prod.outlook.com
 ([fe80::953b:d177:8870:2877]) by DB3PR0402MB3754.eurprd04.prod.outlook.com
 ([fe80::953b:d177:8870:2877%13]) with mapi id 15.20.0366.009; Tue, 2 Jan 2018
 11:10:25 +0000
From:   Stephan Janssen <sjanssen@you-get.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git removes existing folder when cancelling clone
Thread-Topic: Git removes existing folder when cancelling clone
Thread-Index: AQHTg7pJR37dI64ZGEO1dkzH60kMew==
Date:   Tue, 2 Jan 2018 11:10:24 +0000
Message-ID: <FE0E0877-B77D-4BD6-A513-435C251D920A@you-get.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sjanssen@you-get.com; 
x-originating-ip: [213.84.128.18]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3753;7:KdAc7wDX/XK/mDcuJ3gBuYA25V0/1lW/7uEofxNhG8KA+pGeudoyFwm+Qbp2ne5QXK4dVE7/RGgCAzxesJN+GtVcaO1Co1zJAgfaXSjEh83W1+9gp3Lpmvtlo8F7O/Y4o4LwgQxKcttnUbPSuh9gx5EgcpDFUjnpE9xHqHq6hR0A2Crh9rZUaan70VNYxsklEvMj/k9nYtTxdy3z3xr9bJD3ZZCt9/crBk5OUt3NjVLDjN+7Im7WylHdofRPx4vZ
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 29a69684-6d69-404d-b996-08d551d16c50
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4603075)(4627115)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060);SRVR:DB3PR0402MB3753;
x-ms-traffictypediagnostic: DB3PR0402MB3753:
x-microsoft-antispam-prvs: <DB3PR0402MB37535C15B65226B468D265DF90190@DB3PR0402MB3753.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040470)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231023)(944501075)(3002001)(6041268)(20161123562045)(2016111802025)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:DB3PR0402MB3753;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:DB3PR0402MB3753;
x-forefront-prvs: 0540846A1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(346002)(366004)(39380400002)(376002)(396003)(189003)(199004)(53936002)(59450400001)(6506007)(66066001)(3280700002)(3660700001)(25786009)(6512007)(316002)(82746002)(36756003)(99286004)(86362001)(33656002)(97736004)(6916009)(5660300001)(551544002)(2501003)(2900100001)(2351001)(106356001)(14454004)(102836004)(6436002)(105586002)(2906002)(68736007)(6486002)(305945005)(5250100002)(8676002)(7736002)(83716003)(3846002)(6116002)(81166006)(478600001)(1730700003)(81156014)(8936002)(5640700003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3753;H:DB3PR0402MB3754.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: you-get.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mP4006PsnUVsgK4lGdejyCajI8mBxcHvu4c/zIwTWzb9eKldHjJJWGqyJjq2bnuumHvg5RESpVZ6N4E7Wwjrqg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5544C613B5538A45A3C82361E4672FAE@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: you-get.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a69684-6d69-404d-b996-08d551d16c50
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2018 11:10:24.9256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 610838bb-f22c-49d7-9807-94061a9f68f4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3753
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGksDQoNCkkgaG9wZSB0aGlzIG1haWxpbmcgbGlzdCBpcyB0aGUgcmlnaHQgd2F5IHRvIGNvbW11
bmljYXRlIHRoaXMuDQoNCkkganVzdCBub3RpY2VkIHRoZSBmb2xsb3dpbmcgYmVoYXZpb3VyIG9u
IG1hY09TIDEwLjEzLjIgcnVubmluZyBHaXQgdjIuMTUuMDoNCg0KMS4gYG1rZGlyIG5ldy1mb2xk
ZXJgDQoyLiBgbHNgIC0gc2hvd3MgbmV3LWZvbGRlcg0KMy4gYGdpdCBjbG9uZSBbcmVwb10gbmV3
LWZvbGRlcmANCjQuIEdpdCBhc2tzIGZvciBwYXNzd29yZA0KNS4gSSBjYW5jZWwgYnkgcHJlc3Np
bmcgY3RybCtjDQoNClJlc3VsdDoNCmBsc2Agbm8gbG9uZ2VyIHNob3dzIG5ldy1mb2xkZXIuDQoN
CkV4cGVjdGVkIHJlc3VsdDoNCmBsc2Agc2hvd3MgbmV3LWZvbGRlcg0KDQpJ4oCZbSBub3Qgc3Vy
ZSB3aGV0aGVyIHRoaXMgbWlnaHQgYmUgYSBjYXNlIG9mIOKAmHdvcmtzIGFzIGludGVuZGVk4oCZ
LCBidXQgaXTigJlzIG5vdCB3aGF0IEnigJlkIGV4cGVjdC4NCg0KS2luZCByZWdhcmRzLA0KU3Rl
cGhhbiBKYW5zc2Vu
