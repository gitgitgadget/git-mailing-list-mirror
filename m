Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07D06202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 01:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751701AbdF3BNu (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 21:13:50 -0400
Received: from mail-sy3aus01on0099.outbound.protection.outlook.com ([104.47.117.99]:6976
        "EHLO AUS01-SY3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751601AbdF3BNt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 21:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexiom.net;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3B9U2vQfzUFFvYaVlipBG3wFHDI340nzuy7GNmFm7U8=;
 b=CDbDhYqcAJWJB9QsEyirckOSYpIBAYUu3I//hbzcomZTi2ZdGdKyeVPIN/RY6vzjli4sWDWxuUmrvndOQdsnM28XouUIZZChBUCJfHunj45mrqa3Ze1mm8YCHBzdmKBXgaQ2nONs8VC2N9uDXAx2K51AmYkADyHmbXR6CQb4ipc=
Received: from SY3PR01MB0506.ausprd01.prod.outlook.com (10.162.60.151) by
 SY3PR01MB0505.ausprd01.prod.outlook.com (10.162.60.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1199.15; Fri, 30 Jun 2017 01:13:47 +0000
Received: from SY3PR01MB0506.ausprd01.prod.outlook.com ([10.162.60.151]) by
 SY3PR01MB0506.ausprd01.prod.outlook.com ([10.162.60.151]) with mapi id
 15.01.1199.022; Fri, 30 Jun 2017 01:13:47 +0000
From:   Samuel Leslie <sdl@nexiom.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git-gui: Error on restoring defaults
Thread-Topic: git-gui: Error on restoring defaults
Thread-Index: AdLxPdcGiYeFQJ6uTqyQFrkCQHDAlg==
Date:   Fri, 30 Jun 2017 01:13:47 +0000
Message-ID: <SY3PR01MB050601CFAFEFDEFFF51CD26FC8D30@SY3PR01MB0506.ausprd01.prod.outlook.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nexiom.net;
x-originating-ip: [61.69.96.138]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SY3PR01MB0505;7:BwXUHE2U0tRIkUzYMAaBdsjPhJOp6EjPtTdIexgaSXLkh1faMEYcJe0bKBSrzQQ9a6bXRrUqRhzjTD03+S6/WN2n6mcOjegt+bkd3tV1fy/bSy7DzMEtO/4xYPBYQlF06SxkXgqaVCFcodiMCtpaqypVQiHl1Vqt9axXAfRKmMQjokQEctnNf8fgReyMx0ptBxa5DoOq7lrjXLlqXJ+TV69E7rS2Tbrln/j9FLsJ3v/yFxn8B/9y9D7xsFBeHbhU7Ec1fESQzexsllC3XOqb7ErcjN5IDHdVu3qvExX9HmNh8WaIL6cTueR9JMhpJesHo0zmdjeefKFpf9cSMZOr0fhU840OzDtTf74Hh2xA4zv3NZQuNFexEjK9/Lhgvnec7WGOjcQcQhbRZYSfPYBCljxuPs3udUu1L0D6plfakgGrpwwW1fUabdpeIwIO4gFpL1MzPKcwc0L2Ife+x8TBHoJsfeqoxgVmapiY62ee0L1vMfKjHpzQm6bAtd5ZJDD7L/5Rt8KF068DNxo4eSarZLlDZ3CCcvRC4d1tQZFImHVj0hJDYBfSrSSGcMQSn9OCXQgm6RDjKUgAmBHhP0xgijC6p4JNxLgHTj0DIgu9KIKAyiWRyO6RtDNVPGkagUKY19a1vusSh2kunq1K3BFsh1wHfnH2cTVKpnXsF1eZKf22pjJ2k42w2TqC2LzrOXRWoWFAU0JG8YoSSbCrG5ekBK6dWQ+0GD+Fe83Tu//mnO+TjiKbZs7Umj3xKKGq6wRlf+hN0LiLpMhQeAAC7DlA+g/nfXdBT+Tr2kkeXoBbbH0=
x-ms-office365-filtering-correlation-id: fa647130-6fc4-46a8-3e0c-08d4bf55427e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254075)(300000503095)(300135400095)(2017052603031)(201703131423075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:SY3PR01MB0505;
x-ms-traffictypediagnostic: SY3PR01MB0505:
x-microsoft-antispam-prvs: <SY3PR01MB050575601B82827DC99EA20CC8D30@SY3PR01MB0505.ausprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(236129657087228)(225559137633274);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(100000703101)(100105400095)(6041248)(20161123562025)(20161123560025)(20161123564025)(2016111802025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123558100)(6043046)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SY3PR01MB0505;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SY3PR01MB0505;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39450400003)(39830400002)(39410400002)(39400400002)(8676002)(66066001)(110136004)(8936002)(1730700003)(38730400002)(81166006)(7736002)(2900100001)(25786009)(5640700003)(86362001)(478600001)(5660300001)(53936002)(305945005)(3280700002)(2906002)(50986999)(3660700001)(9686003)(2351001)(99286003)(55016002)(3846002)(33656002)(6116002)(7696004)(6916009)(2501003)(189998001)(102836003)(6436002)(74316002)(6506006)(77096006)(54356999)(14454004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SY3PR01MB0505;H:SY3PR01MB0506.ausprd01.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nexiom.net
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2017 01:13:47.3156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3deb19d5-2270-4bec-8e4d-912c52be1b9d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PR01MB0505
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgdGhlcmUsDQoNCldoZW4gc2VsZWN0aW5nIOKAnFJlc3RvcmUgRGVmYXVsdHPigJ0gaW4gdGhl
IE9wdGlvbnMgZGlhbG9ndWUgdmlhIHRoZSBFZGl0IC0+IE9wdGlvbnMgbWVudSB0aGUgZm9sbG93
aW5nIGFwcGxpY2F0aW9uIGVycm9yIGlzIHJlY2VpdmVkOg0KDQp3aW5kb3cgbmFtZSAiIXBhdmlu
ZyIgYWxyZWFkeSBleGlzdHMgaW4gcGFyZW50DQrCoMKgwqAgd2hpbGUgZXhlY3V0aW5nDQoidHRr
OjpmcmFtZSAkdy4hcGF2aW5nIg0KwqDCoMKgIChwcm9jZWR1cmUgInBhdmVfdG9wbGV2ZWwiIGxp
bmUgNCkNCsKgwqDCoCBpbnZva2VkIGZyb20gd2l0aGluDQoicGF2ZV90b3BsZXZlbCAuIg0KwqDC
oMKgIChwcm9jZWR1cmUgImFwcGx5X2NvbmZpZyIgbGluZSAzNykNCsKgwqDCoCBpbnZva2VkIGZy
b20gd2l0aGluDQoiYXBwbHlfY29uZmlnIg0KwqDCoMKgIChwcm9jZWR1cmUgImRvX3Jlc3RvcmVf
ZGVmYXVsdHMiIGxpbmUgMTQpDQrCoMKgwqAgaW52b2tlZCBmcm9tIHdpdGhpbg0KImRvX3Jlc3Rv
cmVfZGVmYXVsdHMiDQrCoMKgwqAgaW52b2tlZCBmcm9tIHdpdGhpbg0KIi5vcHRpb25zX2VkaXRv
ci5idXR0b25zLnJlc3RvcmUgaW52b2tlICINCsKgwqDCoCBpbnZva2VkIGZyb20gd2l0aGluDQoi
Lm9wdGlvbnNfZWRpdG9yLmJ1dHRvbnMucmVzdG9yZSBpbnN0YXRlICFkaXNhYmxlZCB7IC5vcHRp
b25zX2VkaXRvci5idXR0b25zLnJlc3RvcmUgaW52b2tlIH0gIg0KwqDCoMKgIGludm9rZWQgZnJv
bSB3aXRoaW4NCiIub3B0aW9uc19lZGl0b3IuYnV0dG9ucy5yZXN0b3JlIGluc3RhdGUgcHJlc3Nl
ZCB7IC5vcHRpb25zX2VkaXRvci5idXR0b25zLnJlc3RvcmUgc3RhdGUgIXByZXNzZWQ7IC5vcHRp
b25zX2VkaXRvci5idXR0b25zLnJlc3RvcmUgaW5zdGF0ZSAhZGlzYWJsZWQgeyAuLi4iDQrCoMKg
wqAgKGNvbW1hbmQgYm91bmQgdG8gZXZlbnQpDQoNClRlc3RlZCB1c2luZyBHaXQgR3VpIDAuMjEg
YXMgaW5jbHVkZWQgd2l0aCBHaXQgMi4xMy4yIHg2NCBvbiBXaW5kb3dzIHg2NC4gQWxzbyB0ZXN0
ZWQgb24gYSBXaW5kb3dzIFZNIHdpdGggYSBjbGVhbiBpbnN0YWxsIG9mIEdpdC4NCg0KDQpLaW5k
IHJlZ2FyZHMsDQpTYW11ZWwgTGVzbGllDQoNCg==
