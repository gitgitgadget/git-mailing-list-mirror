Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 065DE1F462
	for <e@80x24.org>; Tue, 28 May 2019 18:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfE1Sp3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 14:45:29 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:55550 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727367AbfE1Sp2 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 May 2019 14:45:28 -0400
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4SIVSkn008748;
        Tue, 28 May 2019 18:45:21 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 2ssa2y87h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 May 2019 18:45:21 +0000
Received: from G4W9120.americas.hpqcorp.net (g4w9120.houston.hp.com [16.210.21.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2354.austin.hpe.com (Postfix) with ESMTPS id 6702481;
        Tue, 28 May 2019 18:45:20 +0000 (UTC)
Received: from G1W8107.americas.hpqcorp.net (2002:10c1:483b::10c1:483b) by
 G4W9120.americas.hpqcorp.net (2002:10d2:150f::10d2:150f) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 28 May 2019 18:45:19 +0000
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (15.241.52.11) by
 G1W8107.americas.hpqcorp.net (16.193.72.59) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 28 May 2019 18:45:20 +0000
Received: from TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM (10.169.47.13) by
 TU4PR8401MB1312.NAMPRD84.PROD.OUTLOOK.COM (10.169.48.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Tue, 28 May 2019 18:45:18 +0000
Received: from TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6c61:bb5d:e04b:dc38]) by TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6c61:bb5d:e04b:dc38%4]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 18:45:18 +0000
From:   "Vanak, Ibrahim" <ibrahim.vanak@hpe.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: GIT issue while cloning (fatal: pack is corrupted (SHA1
 mismatch)) !!!
Thread-Topic: GIT issue while cloning (fatal: pack is corrupted (SHA1
 mismatch)) !!!
Thread-Index: AdUVNK2vOdBL1LuLQeCX2A7XwcsEXwAAGetAAAD4WwAAEw7MAA==
Date:   Tue, 28 May 2019 18:45:18 +0000
Message-ID: <TU4PR8401MB1216A7B920D40B5063123A94E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
References: <TU4PR8401MB121664A8A588D799803F1E84E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <20190528093728.GA15106@sigill.intra.peff.net>
In-Reply-To: <20190528093728.GA15106@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.167.17.221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46f61ae0-4d17-4bda-4b87-08d6e39ca1a1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TU4PR8401MB1312;
x-ms-traffictypediagnostic: TU4PR8401MB1312:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <TU4PR8401MB1312D7E820CA4EBA954152DCE11E0@TU4PR8401MB1312.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(376002)(346002)(136003)(199004)(13464003)(189003)(66476007)(229853002)(66556008)(33656002)(73956011)(66946007)(68736007)(55016002)(6306002)(76116006)(256004)(14444005)(6436002)(446003)(476003)(486006)(66446008)(14454004)(66066001)(64756008)(52536014)(66574012)(11346002)(6916009)(71190400001)(316002)(26005)(74316002)(5660300002)(9686003)(99286004)(305945005)(76176011)(6506007)(7736002)(2906002)(7696005)(102836004)(53546011)(4326008)(8936002)(6246003)(186003)(25786009)(6116002)(3846002)(478600001)(81166006)(81156014)(53936002)(86362001)(71200400001)(8676002)(966005)(78486014)(473944003);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4PR8401MB1312;H:TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yB7HbI5jt7Jxvq5RHrsvw73r9k+qX5wBg7vQWDxe01/6HLY3KD1gGBVZ9xZW0j3jTj17hqg6Zl831mvccxW+RHKy1yWCy0YObZ7QP7s6w5Wy79fmEttPul5uf/9kIteZbtx/kvV9uE5B+I/kTnU0w1qXIiPn+2aRqclzNl9Dd/VeLT9V06eLQcGsyVb7N2K8UIa4JI9eQcl2/9NZN7rWb156QKp2GWUyiYN6wlnBvzQjroEcHpxC8lze+kHzdfgiHJg6mGIIQlxhNLF8mb/F1yCBgWKKyMJ6+gI6AReZ5nhFf80eD903X1v4ACHHNl6LxbxAXAlBfRhHJn3shAUJbSwKy3qExKVJTrCrWlojwzjcnF6U/GSZwwIS7OfMg/WYbQaO549ZrurJmO6s1/rD6Bfq3QCnD5wiJc1693C/2e0=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f61ae0-4d17-4bda-4b87-08d6e39ca1a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 18:45:18.4178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibrahim.vanak@hpe.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB1312
X-OriginatorOrg: hpe.com
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 3 URL's were un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905280117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzIGV2ZXJ5b25lIGZvciB0aGUgaW5wdXRzICEhISB1cGdyYWRlIG9mIEdJVCB0byAyLjIx
IHdvcmtlZC4NCg0KQlVUIHN0aWxsIEkgaGF2ZSBzaWduaWZpY2FudCBzbG93bmVzcyg1MCB0aW1l
cyBzbG93ZXIgdGhhbiBjbG9uZSBvbiBsaW51eCBtYWNoaW5lKSB3aGlsZSBjbG9uaW5nLiBIUFVY
IGJveCBpcyBoYXZpbmcgdmVyeSBnb29kIEgvVyBjb25maWd1cmF0aW9uIGFuZCBuZXR3b3JrIGlz
IGFsc28gc3RhYmxlLg0KDQpEbyB5b3UgaGF2ZSBhbnkgaW5wdXRzIG9uIHRoaXMuPw0KDQotSWJy
YWhpbQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmVmZiBLaW5nIFttYWls
dG86cGVmZkBwZWZmLm5ldF0gDQpTZW50OiBUdWVzZGF5LCBNYXkgMjgsIDIwMTkgMzowNyBQTQ0K
VG86IFZhbmFrLCBJYnJhaGltIDxpYnJhaGltLnZhbmFrQGhwZS5jb20NCkNjOiBnaXRAdmdlci5r
ZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogR0lUIGlzc3VlIHdoaWxlIGNsb25pbmcgKGZhdGFsOiBw
YWNrIGlzIGNvcnJ1cHRlZCAoU0hBMSBtaXNtYXRjaCkpICEhIQ0KDQpPbiBUdWUsIE1heSAyOCwg
MjAxOSBhdCAwOToxMDoxMkFNICswMDAwLCBWYW5haywgSWJyYWhpbSB3cm90ZToNCg0KPiBXZSBh
cmUgc2VlaW5nIGlzc3VlIHdpdGggR0lUIDIuMTQgdmVyc2lvbi4gV2hlbiB3ZSB0cnkgdG8gY2xv
bmUgdGhlIA0KPiByZXBvcywgaXQgaXMgdGFraW5nIEhVR0UgYW1vdW50IG9mIHRpbWUgb24gSFBV
WCwgd2hlcmVhcyBvbiB0aGUgbGludXggDQo+IG1hY2hpbmUgd2l0aCBzYW1lIG5ldHdvcmsgY29u
ZmlndXJhdGlvbiwgaXQncyBnZXR0aW5nIGNsb25lZCBpbiBsZXNzIA0KPiB0aGFuIG1pbnMuIFNv
IHdlIHdhbnQgdG8ga25vdyBoYXMgYW55b25lIHJlcG9ydGVkIHRoaXMgaXNzdWU/IFdoYXQgaXMg
DQo+IHRoZSBmaXggZm9yIHRoaXM/IEhhcyB0aGUgZml4IGJlZW4gcmVsZWFzZWQgZm9yIHRoaXM/
IFdob20gc2hvdWxkIHdlIA0KPiBjb250YWN0IGZvciB0aGlzPw0KDQpJIGRvbid0IGtub3cgYWJv
dXQgdGhlIHNsb3duZXNzLCBidXQuLi4NCg0KPiBCZWxvdyBpcyB0aGUgSFBVWCBzeXN0ZW0gd2hl
cmUgd2UgYXJlIHNlZWluZyBpc3N1ZSwgaXQgaXMgdGFraW5nIDEgaHIgNDUgbWlucyBhbmQgbGF0
ZXIgaXQgZmFpbGVkOg0KPiANCj4gcm9vdEBzc3RsMDAyLmluLnJkbGFicy5ocGVjb3JwLm5ldCMg
dW5hbWUgLWEgSFAtVVggc3N0bDAwMiBCLjExLjMxIFUgDQo+IGlhNjQgMDE1ODkzNjAxOSB1bmxp
bWl0ZWQtdXNlciBsaWNlbnNlIA0KPiByb290QHNzdGwwMDIuaW4ucmRsYWJzLmhwZWNvcnAubmV0
IyB0aW1lIGdpdCBjbG9uZSANCj4gZ2l0QGdpdGh1Yi5ocGUuY29tOkhQVVgvU3lzRmF1bHRNZ210
LmdpdA0KPiBDbG9uaW5nIGludG8gJ1N5c0ZhdWx0TWdtdCcuLi4NCj4gcmVtb3RlOiBFbnVtZXJh
dGluZyBvYmplY3RzOiA2MzYyNywgZG9uZS4NCj4gcmVtb3RlOiBUb3RhbCA2MzYyNyAoZGVsdGEg
MCksIHJldXNlZCAwIChkZWx0YSAwKSwgcGFjay1yZXVzZWQgNjM2MjcgDQo+IFJlY2VpdmluZyBv
YmplY3RzOiAxMDAlICg2MzYyNy82MzYyNyksIDY4MS45MCBNaUIgfCAxMTEuMDAgS2lCL3MsIGRv
bmUuDQo+IGZhdGFsOiBwYWNrIGlzIGNvcnJ1cHRlZCAoU0hBMSBtaXNtYXRjaCkNCj4gZmF0YWw6
IGluZGV4LXBhY2sgZmFpbGVkDQoNCkdpdCB2Mi4xNCB1c2VzIHRoZSBzaGExY29sbGlzaW9uLWRl
dGVjdGlvbiBpbXBsZW1lbnRhdGlvbiBvZiBzaGExIGJ5IGRlZmF1bHQuIFRoYXQgaGFzIGEgYnVn
IHRoYXQgd2FzIGZpeGVkIHJlY2VudGx5IHdpdGg6DQoNCiAgY29tbWl0IDQxMjVmNzgyMjI3NDlj
YjhmYzkxMTE1YWJlYzNhYzgzZTVkZmIxOTQNCiAgQXV0aG9yOiDDhnZhciBBcm5masO2csOwIEJq
YXJtYXNvbiA8YXZhcmFiQGdtYWlsLmNvbT4NCiAgRGF0ZTogICBUdWUgTWF5IDE0IDAwOjE3OjAx
IDIwMTkgKzAyMDANCiAgDQogICAgICBzaGExZGM6IHVwZGF0ZSBmcm9tIHVwc3RyZWFtDQogICAg
ICANCiAgICAgIFVwZGF0ZSBzaGExZGMgZnJvbSB0aGUgbGF0ZXN0IHZlcnNpb24gYnkgdGhlIHVw
c3RyZWFtDQogICAgICBtYWludGFpbmVyWzFdLiBTZWUgMDdhMjBmNTY5YiAoIk1ha2VmaWxlOiBm
aXggdW5hbGlnbmVkIGxvYWRzIGluDQogICAgICBzaGExZGMgd2l0aCBVQlNhbiIsIDIwMTktMDMt
MTIpIGZvciB0aGUgbGFzdCB1cGRhdGUuDQogICAgICANCiAgICAgIFRoaXMgZml4ZXMgYW4gaXNz
dWUgd2hlcmUgSFAtVVggSUE2NCB3YXMgd3JvbmdseSBkZXRlY3RlZCBhcyBhDQogICAgICBMaXR0
bGUtZW5kaWFuIGluc3RlYWQgb2YgYSBCaWctZW5kaWFuIHN5c3RlbSwgc2VlIFsyXSBhbmQgWzNd
Lg0KICAgICAgDQogICAgICAxLiBodHRwczovL2dpdGh1Yi5jb20vY3ItbWFyY3N0ZXZlbnMvc2hh
MWNvbGxpc2lvbmRldGVjdGlvbi9jb21taXQvODU1ODI3YzU4M2JjMzA2NDViYTQyNzg4NWNhYTQw
YzViODE3NjRkMg0KICAgICAgMi4gaHR0cHM6Ly9wdWJsaWMtaW5ib3gub3JnL2dpdC82MDM5ODli
ZC1mODZkLWM2MWQtYzZmNS1mYjY3NDhhNjViYTlAc2llbWVucy5jb20vDQogICAgICAzLiBodHRw
czovL2dpdGh1Yi5jb20vY3ItbWFyY3N0ZXZlbnMvc2hhMWNvbGxpc2lvbmRldGVjdGlvbi9wdWxs
LzUwDQoNCndoaWNoIGxvb2tzIGxpa2UgaXQgd291bGQgaW1wYWN0IHlvdXIgc3lzdGVtLiBZb3Ug
Y2FuIGVpdGhlcjoNCg0KICAxLiBUcnkgdjIuMjIuMC1yYzEsIHdoaWNoIHdpbGwgYmUgdGhlIGZp
cnN0IHJlbGVhc2Ugd2l0aCB0aGF0IGZpeC4NCg0KICAyLiBUcnkgY2hlcnJ5LXBpY2tpbmcgdGhl
IHZhcmlvdXMgZml4ZXMgb24gdG9wIG9mIHYyLjE0LjA6DQoNCiAgICAgICBnaXQgY2hlY2tvdXQg
djIuMTQuMA0KICAgICAgIGdpdCBjaGVycnktcGljayAyM2UzN2Y4ZTlkNTk2MWMwYzhkNTJhYzQ4
MTY5M2QzZmNhNTMwOWNlDQogICAgICAgZ2l0IGNoZXJyeS1waWNrIDA3YTIwZjU2OWI0YjE2OTBl
NzE3ZWFhYzA5NTQwMDdhOGVkZmJmYzINCiAgICAgICBnaXQgY2hlcnJ5LXBpY2sgNDEyNWY3ODIy
Mjc0OWNiOGZjOTExMTVhYmVjM2FjODNlNWRmYjE5NA0KDQogIDMuIENvbXBpbGUgd2l0aCBhbm90
aGVyIHNoYTEgaW1wbGVtZW50YXRpb24uIEUuZy46DQoNCiAgICAgICAjIGlmIHlvdSBoYXZlIG9w
ZW5zc2wgYXZhaWxhYmxlOyBvdGhlcndpc2UsDQogICAgICAgIyB0cnkgQkxLX1NIQTENCiAgICAg
ICBlY2hvICdPUEVOU1NMX1NIQTEgPSBZZXMnID5jb25maWcubWFrDQogICAgICAgbWFrZQ0KDQog
ICAgIE5vdGUgdGhhdCB5b3Ugd29uJ3QgYmUgcHJvdGVjdGVkIGZyb20gY29sbGlzaW9uIGF0dGFj
a3MsIGJ1dCB0aG9zZQ0KICAgICBhcmUgc3RpbGwgaW1wcmFjdGljYWxseSBleHBlbnNpdmUgdG8g
bW91bnQgYXQgdGhpcyBwb2ludC4gSXQgbWF5IGJlDQogICAgIGEgZ29vZCB0cmFkZW9mZiB1bnRp
bCB5b3UgY2FuIHVwZ3JhZGUgdG8gYSBtb3JlIHJlY2VudCBHaXQuDQoNCi1QZWZmDQo=
