Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E66120985
	for <e@80x24.org>; Tue, 13 Sep 2016 16:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932482AbcIMQQF (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 12:16:05 -0400
Received: from sesbmg23.ericsson.net ([193.180.251.37]:49818 "EHLO
        sesbmg23.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932383AbcIMQQE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 12:16:04 -0400
X-AuditID: c1b4fb25-14bff7000000793b-51-57d8263f1d48
Received: from ESESSHC007.ericsson.se (Unknown_Domain [153.88.183.39])
        by  (Symantec Mail Security) with SMTP id 76.AF.31035.F3628D75; Tue, 13 Sep 2016 18:16:02 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (153.88.183.145)
 by oa.msg.ericsson.com (153.88.183.39) with Microsoft SMTP Server (TLS) id
 14.3.301.0; Tue, 13 Sep 2016 18:15:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ericsson.onmicrosoft.com; s=selector1-ericsson-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=lB46q7rFjSYg8HQMPg1BFUwd1bu03+vPcALdTqjJemc=;
 b=Vcx4bXP5umxk4TiiQ/qTbGBixs9NXm98WF9hwf7Qd5ZzlsH2zWpeR95um4+zR6ctvNELA2E1F2XAK62I2o/EzXIEIIoG68owxsvKAaIf6WlOrEcEDzcu0Br6cs50FNmXRmROB9YoiXbNJ28klrWUKjv9sgzPEymzH2BTYbtwhu0=
Received: from DB5PR07MB1448.eurprd07.prod.outlook.com (10.166.4.22) by
 DB5PR07MB1446.eurprd07.prod.outlook.com (10.166.4.20) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.619.10; Tue, 13 Sep 2016 16:15:58 +0000
Received: from DB5PR07MB1448.eurprd07.prod.outlook.com ([10.166.4.22]) by
 DB5PR07MB1448.eurprd07.prod.outlook.com ([10.166.4.22]) with mapi id
 15.01.0619.011; Tue, 13 Sep 2016 16:15:58 +0000
From:   David Bainbridge <david.bainbridge@ericsson.com>
To:     =?utf-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Doug Rathbone <doug@dougrathbone.com>,
        David Bainbridge <david.bainbridge@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "Andrew Ardill" <andrew.ardill@gmail.com>, Eric Wong <e@80x24.org>
Subject: RE: [ANNOUNCE] Git User's Survey 2016
Thread-Topic: [ANNOUNCE] Git User's Survey 2016
Thread-Index: AQHSDS8KgpdtFKOHbUuHckcx4xO+HqB3mW1Q
Date:   Tue, 13 Sep 2016 16:15:57 +0000
Message-ID: <DB5PR07MB14487D7F217ECA53CD712D60E2FE0@DB5PR07MB1448.eurprd07.prod.outlook.com>
References: <de39c03d-e84e-8e45-69cb-a2e01fd25df2@gmail.com>
In-Reply-To: <de39c03d-e84e-8e45-69cb-a2e01fd25df2@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=david.bainbridge@ericsson.com; 
x-originating-ip: [192.75.88.130]
x-ms-office365-filtering-correlation-id: 4ec01522-e076-403f-f006-08d3dbf13f27
x-microsoft-exchange-diagnostics: 1;DB5PR07MB1446;6:Dr3XHckc1FjWo6LiD8JKFhn/UjxgIAKTGx9+KCovtYM84BhvEl9N8CwE3cHo3x1mRNE4yQGOz8rP6nQtmpmcNBBvNwJIUqFDBVHwDoiBkS/wgHsJ2hZwv5UmJp/GMylh2HXafApSBlc1obJumgfL80LwJrC8jKZ4gy77GDsxNdsEKd1GofIfijV/THkiiZfYBW9Wxay65JkCKUF1ThLann+/hT1JBcDwAGfaPEAlWWVuxUBC3+OBt513CzJ0b0/hVmLV8/gLWnTYNKM68QoCCJrKZP4w7SABASq5S+xIVtk=;5:dWQIpOvCnhAQMvyElMdVZjmnpaRDdr69dUMX24fUWTT4s6Joq4JW0Bp1i+ogQPDRL2URqTvKjUkfiiq0tbtO1G+p1p/fb/RrvXmLV6VLXFEHPoXvUzuGDqXTNu9BgO0YeFpMPCZ2efKrlzJYHMLxCw==;24:EAIo33TiQ/icGSv7BV9Qr57ZD1cow2HFTzWmrXEjXbTNrg3Nn/EdwiSWGwSaF0jakGL5RnTlRtX/uJU0ZM6Vjs10NGkk9tmckN/BIe6ktSY=;7:45DmPLs0cRY03tDeNxFmiNkdbLdQBz4IAAxNKlq8EQIG6poGPXoddI4gF4ZojLS/Y/M9GCM3JiDNVHrNfd+VxfsXcB/T8ohINOfHgkmxQeu0S8DMe6+RWcbLEinyralGAfhq0f06rWmihQJhK6/dpaNFbNjWwp/PCREoAHYdWnvm4CNGrWaZxKiaGq2TxhZT1JzztHeQkOfmfr17IyzNn9knMj/7am+j1iiyHv83rl+EfnemUEoWxm2u4kiOlwfy
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:DB5PR07MB1446;
x-microsoft-antispam-prvs: <DB5PR07MB144646A0CA9FD34EBB92A6F0E2FE0@DB5PR07MB1446.eurprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(37575265505322)(9452136761055)(211936372134217)(202460600054446);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046);SRVR:DB5PR07MB1446;BCL:0;PCL:0;RULEID:;SRVR:DB5PR07MB1446;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(7916002)(13464003)(51874003)(189002)(199003)(66654002)(53754006)(5660300001)(3846002)(87936001)(92566002)(68736007)(19580395003)(189998001)(122556002)(2950100001)(6116002)(2900100001)(15974865002)(3280700002)(2906002)(5001770100001)(11100500001)(8936002)(19580405001)(4326007)(16799955002)(9686002)(2501003)(97736004)(102836003)(3660700001)(8676002)(81166006)(7736002)(86362001)(7846002)(81156014)(10400500002)(54356999)(76176999)(50986999)(106356001)(305945005)(77096005)(5002640100001)(76576001)(74316002)(586003)(106116001)(101416001)(33656002)(66066001)(15975445007)(105586002)(7696004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR07MB1446;H:DB5PR07MB1448.eurprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: ericsson.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2016 16:15:58.0033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB1446
X-OriginatorOrg: ericsson.com
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUiTURTHu3uePXscTq5T22mZ5MAkS00LGWSvH2QQwaQPigRt5pOK84VN
        JfsgZq7QrTQ1SRdpoq7M0KblnFkqEiqalQtHIeZbaVqOVqik0rbHoG+/8z//c885916aED7i
        iunUjGxGnaFUSSg+WR3fGRx6ep8t7lB1j5dUN1JISbWWLp70tukaR3q3aYuUllh1HOnDD/cI
        aXv7DfIkT2Z2vOXKema/cmVdNZM8WZ0pR+YwBci5CfzoJEaVmsuow48r+ClV9goqa0F8eW22
        kyhAZeIS5EEDPgKv68eoEsSnhbgVgc6+gNhgEMF8rZ1wuUh8k4DilWg2UcoBa3kDyQb9CMxa
        A8/lonAULJetki72xZfgZ3Mlx2Ui8ACCstLvznNp2geHwSd9JusJh5mmCQ7LkbBkXyDZbkFw
        9aXe3VmAz0PRZ6P7fCGOBqtp2s0e+BiMFBS6axHeCavDLW4msAg+ztVy2N0wNLwYI1j2g8XZ
        LS7rV8CaaXNbD4Q+cxuX5bNgqNtALP+gQP/tDMsx4Gio4LnGB5wGtlcHWTkNnn0pJFwrAjYj
        0Bqebtf6w5hNR7GJcgraut9w2AUYMD7Ruk0+WAyT1mJUhkJq/pu7xtmDwPuh1RLOyoFQqZvm
        1bivwhuGqufIOkQ2Iz8No0lMT448HMaoUy9qNJkZYRlMtgk5P1Bfx58gMxpfPtWPMI0kngIF
        ZYsTcpW5mrx052vRhMRX0OvvlARJyrwrjDrzgjpHxWj60W6alIgEW6MTcUKcrMxm0hgmi1H/
        y3JoD3EBihJ2DYQV23pi8hd/Jzy3ehWZ5aqG3qnNxvvL8tjhzgh8YN3Hwaui8hI6HpOhU+Hp
        4/Ur8nODU9xuy9B86OjRd7f2BFwPESXO0aKWExMqiWnvr/Vgo/eulgfxk5DuafbzX+LvEAuS
        8iNjG8mNmWGxoalq8/2ywqiPskys3imXkJoUZUQIodYo/wKLabNyPAMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgSmFrdWIsDQoNCllvdSBzYWlkOg0KUC5TLiBBdCByZXF1ZXN0IEkgY2FuIG9wZW4gYSBzZXBh
cmF0ZSBjaGFubmVsIGluIHN1cnZleSwgd2l0aCBhIHNlcGFyYXRlIHN1cnZleSBVUkwsIHNvIHRo
YXQgcmVzcG9uc2VzIGZyb20gcGFydGljdWxhciBzaXRlIG9yIG9yZ2FuaXphdGlvbiBjb3VsZCBi
ZSBzZXBhcmF0ZWQgb3V0Lg0KDQpQbGVhc2UgY2FuIHlvdSBvcGVuIGEgY2hhbm5lbCBmb3IgdXNl
IGJ5IEVyaWNzc29uPw0KDQpNYW55IHRoYW5rcw0KDQpEYXZpZA0KDQpEQVZJRCBCQUlOQlJJREdF
DQpQcm9kdWN0IE1hbmFnZXIgU1cgRGV2ZWxvcG1lbnQNClN0cmF0ZWdpYyBQcm9kdWN0IE1hbmFn
ZXIsIENvbmZpZ3VyYXRpb24gYW5kIENvbXBsaWFuY2UgTWFuYWdlbWVudA0KQk5FUCBFSVRURSBT
UCZTIFBsYXRmb3JtcyZJbmZyYXN0cnVjdHVyZQ0KDQpFcmljc3Nvbg0KODUwMCBEZWNhcmllDQpN
b250cmVhbCwgSDRQIDJOMiwgQ2FuYWRhDQpQaG9uZSArMSA1MTQgMzQ1IDc5MDAgeDQyMDE0DQpN
b2JpbGUgKzEgNDM4IDk5MCAyNDUyDQpPZmZpY2UgRUNOIDgxMCA0MjAxNA0KZGF2aWQuYmFpbmJy
aWRnZUBlcmljc3Nvbi5jb20NCnd3dy5lcmljc3Nvbi5jb20NCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IEpha3ViIE5hcsSZYnNraSBbbWFpbHRvOmpuYXJlYkBnbWFpbC5jb21d
IA0KU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMTIsIDIwMTYgMTU6NTENClRvOiBnaXRAdmdlci5r
ZXJuZWwub3JnDQpDYzogRG91ZyBSYXRoYm9uZSA8ZG91Z0Bkb3VncmF0aGJvbmUuY29tPjsgRGF2
aWQgQmFpbmJyaWRnZSA8ZGF2aWQuYmFpbmJyaWRnZUBnbWFpbC5jb20+OyBTdGVmYW4gQmVsbGVy
IDxzYmVsbGVyQGdvb2dsZS5jb20+OyBBbmRyZXcgQXJkaWxsIDxhbmRyZXcuYXJkaWxsQGdtYWls
LmNvbT47IEVyaWMgV29uZyA8ZUA4MHgyNC5vcmc+DQpTdWJqZWN0OiBbQU5OT1VOQ0VdIEdpdCBV
c2VyJ3MgU3VydmV5IDIwMTYNCg0KSGVsbG8gYWxsLA0KDQpXZSB3b3VsZCBsaWtlIHRvIGFzayB5
b3UgYSBmZXcgcXVlc3Rpb25zIGFib3V0IHlvdXIgdXNlIG9mIHRoZSBHaXQgdmVyc2lvbiBjb250
cm9sIHN5c3RlbS4gVGhpcyBzdXJ2ZXkgaXMgbWFpbmx5IHRvIHVuZGVyc3RhbmQgd2hvIGlzIHVz
aW5nIEdpdCwgaG93IGFuZCB3aHkuDQoNClRoZSByZXN1bHRzIHdpbGwgYmUgcHVibGlzaGVkIHRv
IHRoZSBHaXQgd2lraSBvbiB0aGUgR2l0U3VydmV5MjAxNiBwYWdlIChodHRwczovL2dpdC53aWtp
Lmtlcm5lbC5vcmcvaW5kZXgucGhwL0dpdFN1cnZleTIwMTYpIGFuZCBkaXNjdXNzZWQgb24gdGhl
IGdpdCBtYWlsaW5nIGxpc3QuDQoNCg0KVGhlIHN1cnZleSB3b3VsZCBiZSBvcGVuIGZyb20gMTIg
U2VwdGVtYmVyIHRvIDIwIE9jdG9iZXIgMjAxNi4NCg0KDQpQbGVhc2UgZGV2b3RlIGEgZmV3IG1p
bnV0ZXMgb2YgeW91ciB0aW1lIHRvIGZpbGwgdGhpcyBzaW1wbGUgcXVlc3Rpb25uYWlyZSwgaXQg
d2lsbCBoZWxwIGEgbG90IHRoZSBnaXQgY29tbXVuaXR5IHRvIHVuZGVyc3RhbmQgeW91ciBuZWVk
cywgd2hhdCB5b3UgbGlrZSBvZiBHaXQsIGFuZCBvZiBjb3Vyc2Ugd2hhdCB5b3UgZG9uJ3QgbGlr
ZS4NCg0KVGhlIHN1cnZleSBjYW4gYmUgZm91bmQgaGVyZToNCiAgaHR0cHM6Ly90aW55dXJsLmNv
bS9HaXRTdXJ2ZXkyMDE2DQogIGh0dHBzOi8vc3VydnMuY29tL3N1cnZleS9sbW83ZWQzNDM5DQoN
ClRoZXJlIGlzIGFsc28gYWx0ZXJuYXRlIHZlcnNpb24gd2hpY2ggZG9lcyBub3QgcmVxdWlyZSBj
b29raWVzLCBidXQgaXQgZG9lc24ndCBhbGxvdyBvbmUgdG8gZ28gYmFjayB0byByZXNwb25zZSBh
bmQgZWRpdCBpdC4NCiAgaHR0cHM6Ly90aW55dXJsLmNvbS9HaXRTdXJ2ZXkyMDE2LWFub24NCiAg
aHR0cHM6Ly9zdXJ2cy5jb20vc3VydmV5L25hZWVjOGt3ZDgNCg0KDQpQLlMuIEF0IHJlcXVlc3Qg
SSBjYW4gb3BlbiBhIHNlcGFyYXRlIGNoYW5uZWwgaW4gc3VydmV5LCB3aXRoIGEgc2VwYXJhdGUg
c3VydmV5IFVSTCwgc28gdGhhdCByZXNwb25zZXMgZnJvbSBwYXJ0aWN1bGFyIHNpdGUgb3Igb3Jn
YW5pemF0aW9uIGNvdWxkIGJlIHNlcGFyYXRlZCBvdXQuDQoNClBsZWFzZSBzZW5kIG1lIGEgZW1h
aWwgd2l0aCBuYW1lIG9mIGNoYW5uZWwsIGFuZCBJIHdpbGwgcmV0dXJuIHdpdGggYSBzZXBhcmF0
ZSBzdXJ2ZXkgVVJMIHRvIHVzZS4gIE5vdGUgdGhhdCB0aGUgbmFtZSBvZiB0aGUgY2hhbm5lbCB3
b3VsZCBiZSB2aXNpYmxlIHRvIG90aGVycy4NCg0KUC5QLlMuIERpZmZlcmVudCBhbm5vdW5jZW1l
bnRzIHVzZSBkaWZmZXJlbnQgVVJMcyAoZGlmZmVyZW50IGNoYW5uZWxzKSB0byBiZXR0ZXIgdHJh
Y2sgd2hlcmUgb25lIGdvdCBpbmZvcm1hdGlvbiBhYm91dCB0aGlzIHN1cnZleS4NCg0KVGhhbmtz
IGluIGFkdmFuY2UgZm9yIHRha2luZyB0aW1lIHRvIGFuc3dlciB0aGUgc3VydmV5LA0KLS0NCkph
a3ViIE5hcsSZYnNraQ0Kb24gYmVoYWxmIG9mDQpHaXQgRGV2ZWxvcG1lbnQgQ29tbXVuaXR5DQo=
