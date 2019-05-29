Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BD9D1F462
	for <e@80x24.org>; Wed, 29 May 2019 09:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfE2JGe (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 05:06:34 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:42154 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725861AbfE2JGe (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 May 2019 05:06:34 -0400
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T91eTB018520;
        Wed, 29 May 2019 09:06:28 GMT
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2ssnm7tdv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 09:06:28 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5009.houston.hpe.com (Postfix) with ESMTPS id 6CE3B65;
        Wed, 29 May 2019 09:06:27 +0000 (UTC)
Received: from G9W8676.americas.hpqcorp.net (16.220.49.23) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 29 May 2019 09:06:20 +0000
Received: from G4W10205.americas.hpqcorp.net (2002:10cf:520f::10cf:520f) by
 G9W8676.americas.hpqcorp.net (2002:10dc:3117::10dc:3117) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Wed, 29 May 2019 09:06:19 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (15.241.52.12) by
 G4W10205.americas.hpqcorp.net (16.207.82.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Wed, 29 May 2019 09:06:19 +0000
Received: from TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM (10.169.47.13) by
 TU4PR8401MB0351.NAMPRD84.PROD.OUTLOOK.COM (10.169.51.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Wed, 29 May 2019 09:06:18 +0000
Received: from TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6c61:bb5d:e04b:dc38]) by TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6c61:bb5d:e04b:dc38%4]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 09:06:18 +0000
From:   "Vanak, Ibrahim" <ibrahim.vanak@hpe.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: GIT issue while cloning (fatal: pack is corrupted (SHA1
 mismatch)) !!!
Thread-Topic: GIT issue while cloning (fatal: pack is corrupted (SHA1
 mismatch)) !!!
Thread-Index: AdUVNK2vOdBL1LuLQeCX2A7XwcsEXwAAGetAAAD4WwAAEw7MAAAF1FgAAA1+/nAABZVi4AAFOOfw
Date:   Wed, 29 May 2019 09:06:18 +0000
Message-ID: <TU4PR8401MB1216339F1E7A378C45DF9B36E11F0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
References: <TU4PR8401MB121664A8A588D799803F1E84E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <20190528093728.GA15106@sigill.intra.peff.net>
 <TU4PR8401MB1216A7B920D40B5063123A94E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <20190528213004.GF24650@sigill.intra.peff.net>
 <TU4PR8401MB12166DBE2156683ADF28E9A4E11F0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [16.242.235.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9586bb56-ded0-4121-780b-08d6e414e94a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TU4PR8401MB0351;
x-ms-traffictypediagnostic: TU4PR8401MB0351:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <TU4PR8401MB0351F1675D07370DADAEC29DE11F0@TU4PR8401MB0351.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39860400002)(396003)(366004)(346002)(13464003)(199004)(189003)(6246003)(6506007)(53546011)(26005)(102836004)(74316002)(4326008)(6916009)(71190400001)(66446008)(64756008)(66556008)(66476007)(25786009)(71200400001)(99286004)(6306002)(2906002)(256004)(478600001)(76116006)(76176011)(66946007)(7696005)(68736007)(73956011)(966005)(8936002)(86362001)(52536014)(81166006)(81156014)(14454004)(7736002)(53936002)(8676002)(5660300002)(186003)(33656002)(229853002)(55016002)(6436002)(9686003)(3846002)(305945005)(316002)(6116002)(66066001)(476003)(486006)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4PR8401MB0351;H:TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RkcwKkOXTB+cnKFJETefC48Mj7KTo5/f3lXIM26o84UThC3wf9EARCc29VOs4WJAk1Urqf6cKOjjoO5qiuwi87wNfLs9B6WgLI8j+O1H0jjuk5PKk1oh8qI8HzWvkq3oZhykcsuBSZt5KJOsRI71IcuqkeaX0nXYLPg7B1GElX1H6uO/CPpOxa15IcsYhK1jaOJMt8zWJfvwBedwo4uMjqkdchZ5mppIG4Z+yKOuV0ofrs8Nmsr+MTVpbtDq6kKnPx2rfJkN5SDQglidPz7UO/LbiBG4jp1ozK8wh9aZjNr6Xvo/GOpfbA6b0AhhyAUnlr3Xc3a+muHNNu2yB/E6RS99n3NLMRns3jKNT9IS3NzYBqF8/wcx/egmwU2eeq2fsVTnmd8kijk23cExoP+xcffknCMJASdeuVELJpbxiyU=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-Network-Message-Id: 9586bb56-ded0-4121-780b-08d6e414e94a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 09:06:18.2032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibrahim.vanak@hpe.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0351
X-OriginatorOrg: hpe.com
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-29_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905290061
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGVsbG8gSmVmZiwNCg0KSnVzdCBzaGFyaW5nIG1vcmUgaW5mb3JtYXRpb24gd2l0aCB5b3Ugb24g
dGhpcyBpc3N1ZToNCg0KQWZ0ZXIgY2xvbmluZyB3aGVuIEkgdHJpZWQgdG8gY2hlY2tvdXQgYSBi
cmFuY2ggb24gSFBVWCBhbmQgTGludXgsIEkgc3RpbGwgc2lnbmlmaWNhbnQgdGltZSBkaWZmZXJl
bmNlIHRoZXJlIGFzIHdlbGwgZXZlbiB0aG91Z2ggbmV0d29yayBpcyBub3QgaW52b2x2ZSBoZXJl
LiBEbyB5b3Ugc3VzcGVjdCBhbnl0aGluZyB3aXRoIEhQVVggT1M/IERvIHlvdSBoYXZlIGFueSBt
ZWNoYW5pc20gdG8gZmluZCBvdXQgd2hvIGlzIHRoZSBjYXVzaW5nIGdpZ2FudGljIGRlbGF5ID8N
Cg0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KQ2hlY2tvdXQgb2Yg
YSBicmFuY2ggb24gSFBVWCBhcyBiZWxvdw0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQ0Kcm9vdEBmaWVuZDYuaW4ucmRsYWJzLmhwZWNvcnAubmV0IyB0aW1lIGdpdCBj
aGVja291dCByZW1vdGVzL29yaWdpbi8xMS4yMy9zZm1fMTEyM19tYWluDQpDaGVja2luZyBvdXQg
ZmlsZXM6IDEwMCUgKDEyOTQ5LzEyOTQ5KSwgZG9uZS4NCk5vdGU6IGNoZWNraW5nIG91dCAncmVt
b3Rlcy9vcmlnaW4vMTEuMjMvc2ZtXzExMjNfbWFpbicuDQoNCllvdSBhcmUgaW4gJ2RldGFjaGVk
IEhFQUQnIHN0YXRlLiBZb3UgY2FuIGxvb2sgYXJvdW5kLCBtYWtlIGV4cGVyaW1lbnRhbA0KY2hh
bmdlcyBhbmQgY29tbWl0IHRoZW0sIGFuZCB5b3UgY2FuIGRpc2NhcmQgYW55IGNvbW1pdHMgeW91
IG1ha2UgaW4gdGhpcw0Kc3RhdGUgd2l0aG91dCBpbXBhY3RpbmcgYW55IGJyYW5jaGVzIGJ5IHBl
cmZvcm1pbmcgYW5vdGhlciBjaGVja291dC4NCg0KSWYgeW91IHdhbnQgdG8gY3JlYXRlIGEgbmV3
IGJyYW5jaCB0byByZXRhaW4gY29tbWl0cyB5b3UgY3JlYXRlLCB5b3UgbWF5DQpkbyBzbyAobm93
IG9yIGxhdGVyKSBieSB1c2luZyAtYiB3aXRoIHRoZSBjaGVja291dCBjb21tYW5kIGFnYWluLiBF
eGFtcGxlOg0KDQrCoCBnaXQgY2hlY2tvdXQgLWIgPG5ldy1icmFuY2gtbmFtZT4NCg0KSEVBRCBp
cyBub3cgYXQgMzliNjExMGYgQ29tbWl0aW5nIHRvIGlzdm4gZm9yIFdFQjEzMDNfMTEyMyBTRk0g
cmVsZWFzZQ0KDQpyZWFswqDCoMKgIDhtMTcuMjM0cw0KdXNlcsKgwqDCoCAwbTcuMDcwcw0Kc3lz
wqDCoMKgwqAgMG0xLjk2MHMNCg0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQ0KQ2hlY2tvdXQgb2YgdGhlIHNhbWUgYnJhbmNoIG9uIExpbnV4IGFzIGJlbG93
Og0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KW3Jvb3RA
Y2hhbmRhbmEgU3lzRmF1bHRNZ210XSMgdGltZSBnaXQgY2hlY2tvdXQgcmVtb3Rlcy9vcmlnaW4v
MTEuMjMvc2ZtXzExMjNfbWFpbg0KQ2hlY2tpbmcgb3V0IGZpbGVzOiAxMDAlICgxMjk0OS8xMjk0
OSksIGRvbmUuDQpOb3RlOiBjaGVja2luZyBvdXQgJ3JlbW90ZXMvb3JpZ2luLzExLjIzL3NmbV8x
MTIzX21haW4nLg0KDQpZb3UgYXJlIGluICdkZXRhY2hlZCBIRUFEJyBzdGF0ZS4gWW91IGNhbiBs
b29rIGFyb3VuZCwgbWFrZSBleHBlcmltZW50YWwNCmNoYW5nZXMgYW5kIGNvbW1pdCB0aGVtLCBh
bmQgeW91IGNhbiBkaXNjYXJkIGFueSBjb21taXRzIHlvdSBtYWtlIGluIHRoaXMNCnN0YXRlIHdp
dGhvdXQgaW1wYWN0aW5nIGFueSBicmFuY2hlcyBieSBwZXJmb3JtaW5nIGFub3RoZXIgY2hlY2tv
dXQuDQoNCklmIHlvdSB3YW50IHRvIGNyZWF0ZSBhIG5ldyBicmFuY2ggdG8gcmV0YWluIGNvbW1p
dHMgeW91IGNyZWF0ZSwgeW91IG1heQ0KZG8gc28gKG5vdyBvciBsYXRlcikgYnkgdXNpbmcgLWIg
d2l0aCB0aGUgY2hlY2tvdXQgY29tbWFuZCBhZ2Fpbi4gRXhhbXBsZToNCg0KwqAgZ2l0IGNoZWNr
b3V0IC1iIDxuZXctYnJhbmNoLW5hbWU+DQoNCkhFQUQgaXMgbm93IGF0IDM5YjYxMTAuLi4gQ29t
bWl0aW5nIHRvIGlzdm4gZm9yIFdFQjEzMDNfMTEyMyBTRk0gcmVsZWFzZQ0KDQpyZWFswqDCoMKg
IDBtNC43MDlzDQp1c2VywqDCoMKgIDBtMy41MzlzDQpzeXPCoMKgwqDCoCAwbTEuMDk4cw0KW3Jv
b3RAY2hhbmRhbmEgU3lzRmF1bHRNZ210XSMNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IFZhbmFrLCBJYnJhaGltIA0KU2VudDogV2VkbmVzZGF5LCBNYXkgMjksIDIwMTkgMTA6
NTkgQU0NClRvOiBKZWZmIEtpbmcgPHBlZmZAcGVmZi5uZXQ+DQpDYzogZ2l0QHZnZXIua2VybmVs
Lm9yZw0KU3ViamVjdDogUkU6IEdJVCBpc3N1ZSB3aGlsZSBjbG9uaW5nIChmYXRhbDogcGFjayBp
cyBjb3JydXB0ZWQgKFNIQTEgbWlzbWF0Y2gpKSAhISENCg0KSGVsbG8gSmVmZiwNCg0KVGhhbmtz
IGFnYWluIGZvciB0aGUgcmVzcG9uc2UuIA0KDQpJIGFtIG5vdCBidWlsZGluZyBHSVQgYW5kIGFs
c28gZG9uJ3Qga25vdyBlaXRoZXIgaG93IHRvIGJ1aWxkLiBJIGFtIGp1c3QgcHVsbGluZyB1cCB0
aGUgYmluYXJpZXMgZnJvbSBodHRwOi8vaHB1eC5jb25uZWN0Lm9yZy51ay8uIA0KDQpCb3RoIEhQ
VVggYW5kIGxpbnV4IG1hY2hpbmUgYXJlIGluIHNhbWUgbmV0d29yay9zdWJuZXQgc28gbmV0d29y
ayBzaG91bGRuJ3QgYmUgYSBwcm9ibGVtIGhlcmUuIHNzaCB0byBIUFVYIGJveCBpcyBzdXBlciBx
dWljayBhbmQgYm94IGlzIGhhdmluZyB2ZXJ5IGhpZ2ggY29uZmlndXJhdGlvbi4gVGhlcmUgaXMg
bm8gTkZTIGludm9sdmVkIGhlcmUuDQoNCkkgYW0gc3VycHJpc2VkIG9uIHNsb3duZXNzLi4uLiBJ
ZiB5b3UgZ2V0IGEgY2hhbmNlIHRvIGxvb2sgbW9yZSBpbnRvIHRoaXMsIHBsZWFzZS4NCg0KVGhh
bmtzICYgUmVnYXJkcywNCklicmFoaW0gVmFuYWsNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IEplZmYgS2luZyBbbWFpbHRvOnBlZmZAcGVmZi5uZXRdDQpTZW50OiBXZWRuZXNk
YXksIE1heSAyOSwgMjAxOSAzOjAwIEFNDQpUbzogVmFuYWssIElicmFoaW0gPGlicmFoaW0udmFu
YWtAaHBlLmNvbT4NCkNjOiBnaXRAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogR0lUIGlz
c3VlIHdoaWxlIGNsb25pbmcgKGZhdGFsOiBwYWNrIGlzIGNvcnJ1cHRlZCAoU0hBMSBtaXNtYXRj
aCkpICEhIQ0KDQpPbiBUdWUsIE1heSAyOCwgMjAxOSBhdCAwNjo0NToxOFBNICswMDAwLCBWYW5h
aywgSWJyYWhpbSB3cm90ZToNCg0KPiBCVVQgc3RpbGwgSSBoYXZlIHNpZ25pZmljYW50IHNsb3du
ZXNzKDUwIHRpbWVzIHNsb3dlciB0aGFuIGNsb25lIG9uIA0KPiBsaW51eCBtYWNoaW5lKSB3aGls
ZSBjbG9uaW5nLiBIUFVYIGJveCBpcyBoYXZpbmcgdmVyeSBnb29kIEgvVyANCj4gY29uZmlndXJh
dGlvbiBhbmQgbmV0d29yayBpcyBhbHNvIHN0YWJsZS4NCg0KRnJvbSB5b3VyIG91dHB1dDoNCg0K
PiBbaHB1eF0NCj4gUmVjZWl2aW5nIG9iamVjdHM6IDEwMCUgKDYzNjI3LzYzNjI3KSwgNjgxLjkw
IE1pQiB8IDExMS4wMCBLaUIvcywgZG9uZS4NCj4gW2xpbnV4XQ0KPiBSZWNlaXZpbmcgb2JqZWN0
czogMTAwJSAoNjM2MjcvNjM2MjcpLCA2ODEuOTAgTWlCIHwgNS41OSBNaUIvcywgZG9uZS4NCg0K
VGhlIG1haW4gdGhpbmdzIGdvaW5nIG9uIHRoZXJlIGFyZToNCg0KwqAgMS4gd2UncmUgZ2V0dGlu
ZyB0aGUgYnl0ZXMgb3ZlciB0aGUgbmV0d29yaw0KDQrCoCAyLiB3ZSdyZSBjb21wdXRpbmcgYSBz
aGExIG9uIHRoZSBzdHJlYW0gd2UncmUgZ2V0dGluZw0KDQrCoCAzLiB3ZSdyZSB6bGliIGluZmxh
dGluZyBhbnkgbm9uLWRlbHRhIG9iamVjdHMgd2UgZmluZCBhbmQgY29tcHV0aW5nDQrCoMKgwqDC
oCB0aGVpciBzaGExDQoNCsKgIDQuIHdlJ3JlIGNoZWNraW5nIHRoZSBmaWxlc3lzdGVtIHRvIHNl
ZSBpZiB3ZSBoYXZlIG90aGVyIGNvcGllcyBvZiBhbnkNCsKgwqDCoMKgIG9mIHRob3NlIG9iamVj
dHMNCg0KRm9yICgyKSBhbmQgKDMpIGl0IGNvdWxkIGJlIHRoYXQgdGhlIHNoYTEgaW1wbGVtZW50
YXRpb24gaXMgbm90IHF1aXRlIGFzIGZhc3QuIEJ1dCA1MHggaXMgbXVjaCBsYXJnZXIgdGhhbiBJ
J2QgZXhwZWN0LiBJZiB5b3UndmUgYnVpbHQgR2l0IGZyb20gc291cmNlLCB5b3UgY291bGQgdHJ5
IHJ1bm5pbmcgInQvaGVscGVyL3Rlc3Qtc2hhMSA8YmlnLWZpbGUiIGFuZCB0aW1pbmcgdGhlIHJl
c3VsdC4gVGhhdCB3b3VsZCBpc29sYXRlIHNoYTEgcGVyZm9ybWFuY2UuwqAgSWYgaXQncyBzbG93
LCB0cnkgYnVpbGRpbmcgd2l0aCAibWFrZSBCTEtfU0hBMT1ZZXMiIG9yICJtYWtlIE9QRU5TU0xf
U0hBMT1ZZXMiIGFuZCBzZWUgaWYgdGhhdCdzIGZhc3Rlci4NCg0KRm9yICg0KSwgd2UnbGwgaGF2
ZSB0byBzdGF0KCkgaW4gLmdpdC9vYmplY3RzIHRvIHNlZSBpZiB3ZSBoYXZlIGEgbG9vc2UgdmVy
c2lvbiBvZiB0aGUgb2JqZWN0LiBUaGF0IGNhbiBiZSBzbG93IGlmIHlvdSBoYXZlIGEgcmVhbGx5
IHRlcnJpYmxlIE5GUyBzZXR1cCwgZm9yIGV4YW1wbGUuIEJ1dCBJIGRvdWJ0IHRoYXQgd291bGQg
c3RpbGwgYmUgc2xvdyBpbiB2Mi4yMS4NClRoZXJlIHdlIHNob3VsZCBiZSB1c2luZyB0aGUgbmV3
IGxvb3NlLWNhY2hlIHdoaWNoIHdpbGwgb25seSByZWFkZGlyKCkgdGhlIG9iamVjdCBkaXJlY3Rv
cmllcyBvbmNlLg0KDQpJZiBuZWl0aGVyIG9mIHRob3NlIHBhbiBvdXQsIGl0IHNlZW1zIGxpa2Ug
dGhlIG5ldHdvcmsgaXMgc2xvdz8gT3IgbWF5YmUgc3NoPyBPciBwaXBlcyBwYXNzaW5nIGRhdGEg
ZnJvbSBjbG9uZSB0byBpbmRleC1wYWNrPw0KDQotUGVmZg0K
