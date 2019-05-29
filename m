Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 522261F462
	for <e@80x24.org>; Wed, 29 May 2019 05:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfE2F3c (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 01:29:32 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:42172 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbfE2F3c (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 May 2019 01:29:32 -0400
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T5Prbe029798;
        Wed, 29 May 2019 05:29:30 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 2ssguam8ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 05:29:30 +0000
Received: from G4W9119.americas.hpqcorp.net (g4w9119.houston.hp.com [16.210.20.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5008.houston.hpe.com (Postfix) with ESMTPS id 7E02D56;
        Wed, 29 May 2019 05:29:29 +0000 (UTC)
Received: from G2W6309.americas.hpqcorp.net (2002:10c5:4033::10c5:4033) by
 G4W9119.americas.hpqcorp.net (2002:10d2:14d6::10d2:14d6) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Wed, 29 May 2019 05:29:29 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (15.241.52.11) by
 G2W6309.americas.hpqcorp.net (16.197.64.51) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Wed, 29 May 2019 05:29:29 +0000
Received: from TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM (10.169.47.13) by
 TU4PR8401MB0688.NAMPRD84.PROD.OUTLOOK.COM (10.169.45.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Wed, 29 May 2019 05:29:27 +0000
Received: from TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6c61:bb5d:e04b:dc38]) by TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6c61:bb5d:e04b:dc38%4]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 05:29:27 +0000
From:   "Vanak, Ibrahim" <ibrahim.vanak@hpe.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: GIT issue while cloning (fatal: pack is corrupted (SHA1
 mismatch)) !!!
Thread-Topic: GIT issue while cloning (fatal: pack is corrupted (SHA1
 mismatch)) !!!
Thread-Index: AdUVNK2vOdBL1LuLQeCX2A7XwcsEXwAAGetAAAD4WwAAEw7MAAAF1FgAAA1+/nA=
Date:   Wed, 29 May 2019 05:29:27 +0000
Message-ID: <TU4PR8401MB12166DBE2156683ADF28E9A4E11F0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
References: <TU4PR8401MB121664A8A588D799803F1E84E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <20190528093728.GA15106@sigill.intra.peff.net>
 <TU4PR8401MB1216A7B920D40B5063123A94E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <20190528213004.GF24650@sigill.intra.peff.net>
In-Reply-To: <20190528213004.GF24650@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [16.242.235.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da7e0818-db31-44c9-eb3d-08d6e3f69e00
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TU4PR8401MB0688;
x-ms-traffictypediagnostic: TU4PR8401MB0688:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <TU4PR8401MB06882CC899B65E1FA517F1EDE11F0@TU4PR8401MB0688.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(13464003)(189003)(26005)(7696005)(68736007)(71190400001)(71200400001)(9686003)(55016002)(8676002)(5660300002)(6506007)(53546011)(99286004)(6116002)(229853002)(4326008)(66066001)(53936002)(3846002)(102836004)(6306002)(6916009)(76176011)(86362001)(6436002)(256004)(6246003)(66946007)(2906002)(66476007)(52536014)(966005)(81156014)(73956011)(33656002)(25786009)(14454004)(478600001)(8936002)(81166006)(316002)(476003)(486006)(64756008)(186003)(74316002)(7736002)(11346002)(76116006)(446003)(66556008)(66446008)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4PR8401MB0688;H:TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GcZu+l/2OnAmcAOIN8elKIWyWm1uxykKLJWFjFlAJU9j0GltAjfwQLTikjF/u/q4U11jZxfKhowPROcY3DZFP0e6TKdU5h1RTatz7Q4ld3re3Nfwr8Sd88eazd6R5Sl7OD98vNPBwdnC/RAReBqvP6z5A+GvsfdS4yRAYLlV1TiCqpoOtGLtNxddFpEtcK+tZkQSxzCr0tAuK4VPUSmd2uQ8V3CxMXzeApzDhoaENTCV+6PoRFI8MySHURDK5nT4K4AAfxqCEr9TnYxrIBQGxdQqYnAqKz1PR/LPZIUdguOZlYaZCm8bB+1G/l/dUpLAjMitNOB5+H/yTZFiSQWunvyGL58113Quq7JzPcOQyZTW4IivqI5OMR/qHSIaRKloM0uBKPty1VJpxg6o08oU+fEZxMQ4iTLkD9LHsNiDYTM=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-Network-Message-Id: da7e0818-db31-44c9-eb3d-08d6e3f69e00
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 05:29:27.1243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibrahim.vanak@hpe.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0688
X-OriginatorOrg: hpe.com
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-29_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=854 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905290036
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGVsbG8gSmVmZiwNCg0KVGhhbmtzIGFnYWluIGZvciB0aGUgcmVzcG9uc2UuIA0KDQpJIGFtIG5v
dCBidWlsZGluZyBHSVQgYW5kIGFsc28gZG9uJ3Qga25vdyBlaXRoZXIgaG93IHRvIGJ1aWxkLiBJ
IGFtIGp1c3QgcHVsbGluZyB1cCB0aGUgYmluYXJpZXMgZnJvbSBodHRwOi8vaHB1eC5jb25uZWN0
Lm9yZy51ay8uIA0KDQpCb3RoIEhQVVggYW5kIGxpbnV4IG1hY2hpbmUgYXJlIGluIHNhbWUgbmV0
d29yay9zdWJuZXQgc28gbmV0d29yayBzaG91bGRuJ3QgYmUgYSBwcm9ibGVtIGhlcmUuIHNzaCB0
byBIUFVYIGJveCBpcyBzdXBlciBxdWljayBhbmQgYm94IGlzIGhhdmluZyB2ZXJ5IGhpZ2ggY29u
ZmlndXJhdGlvbi4gVGhlcmUgaXMgbm8gTkZTIGludm9sdmVkIGhlcmUuDQoNCkkgYW0gc3VycHJp
c2VkIG9uIHNsb3duZXNzLi4uLiBJZiB5b3UgZ2V0IGEgY2hhbmNlIHRvIGxvb2sgbW9yZSBpbnRv
IHRoaXMsIHBsZWFzZS4NCg0KVGhhbmtzICYgUmVnYXJkcywNCklicmFoaW0gVmFuYWsNCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEplZmYgS2luZyBbbWFpbHRvOnBlZmZAcGVm
Zi5uZXRdIA0KU2VudDogV2VkbmVzZGF5LCBNYXkgMjksIDIwMTkgMzowMCBBTQ0KVG86IFZhbmFr
LCBJYnJhaGltIDxpYnJhaGltLnZhbmFrQGhwZS5jb20+DQpDYzogZ2l0QHZnZXIua2VybmVsLm9y
Zw0KU3ViamVjdDogUmU6IEdJVCBpc3N1ZSB3aGlsZSBjbG9uaW5nIChmYXRhbDogcGFjayBpcyBj
b3JydXB0ZWQgKFNIQTEgbWlzbWF0Y2gpKSAhISENCg0KT24gVHVlLCBNYXkgMjgsIDIwMTkgYXQg
MDY6NDU6MThQTSArMDAwMCwgVmFuYWssIElicmFoaW0gd3JvdGU6DQoNCj4gQlVUIHN0aWxsIEkg
aGF2ZSBzaWduaWZpY2FudCBzbG93bmVzcyg1MCB0aW1lcyBzbG93ZXIgdGhhbiBjbG9uZSBvbiAN
Cj4gbGludXggbWFjaGluZSkgd2hpbGUgY2xvbmluZy4gSFBVWCBib3ggaXMgaGF2aW5nIHZlcnkg
Z29vZCBIL1cgDQo+IGNvbmZpZ3VyYXRpb24gYW5kIG5ldHdvcmsgaXMgYWxzbyBzdGFibGUuDQoN
CkZyb20geW91ciBvdXRwdXQ6DQoNCj4gW2hwdXhdDQo+IFJlY2VpdmluZyBvYmplY3RzOiAxMDAl
ICg2MzYyNy82MzYyNyksIDY4MS45MCBNaUIgfCAxMTEuMDAgS2lCL3MsIGRvbmUuDQo+IFtsaW51
eF0NCj4gUmVjZWl2aW5nIG9iamVjdHM6IDEwMCUgKDYzNjI3LzYzNjI3KSwgNjgxLjkwIE1pQiB8
IDUuNTkgTWlCL3MsIGRvbmUuDQoNClRoZSBtYWluIHRoaW5ncyBnb2luZyBvbiB0aGVyZSBhcmU6
DQoNCiAgMS4gd2UncmUgZ2V0dGluZyB0aGUgYnl0ZXMgb3ZlciB0aGUgbmV0d29yaw0KDQogIDIu
IHdlJ3JlIGNvbXB1dGluZyBhIHNoYTEgb24gdGhlIHN0cmVhbSB3ZSdyZSBnZXR0aW5nDQoNCiAg
My4gd2UncmUgemxpYiBpbmZsYXRpbmcgYW55IG5vbi1kZWx0YSBvYmplY3RzIHdlIGZpbmQgYW5k
IGNvbXB1dGluZw0KICAgICB0aGVpciBzaGExDQoNCiAgNC4gd2UncmUgY2hlY2tpbmcgdGhlIGZp
bGVzeXN0ZW0gdG8gc2VlIGlmIHdlIGhhdmUgb3RoZXIgY29waWVzIG9mIGFueQ0KICAgICBvZiB0
aG9zZSBvYmplY3RzDQoNCkZvciAoMikgYW5kICgzKSBpdCBjb3VsZCBiZSB0aGF0IHRoZSBzaGEx
IGltcGxlbWVudGF0aW9uIGlzIG5vdCBxdWl0ZSBhcyBmYXN0LiBCdXQgNTB4IGlzIG11Y2ggbGFy
Z2VyIHRoYW4gSSdkIGV4cGVjdC4gSWYgeW91J3ZlIGJ1aWx0IEdpdCBmcm9tIHNvdXJjZSwgeW91
IGNvdWxkIHRyeSBydW5uaW5nICJ0L2hlbHBlci90ZXN0LXNoYTEgPGJpZy1maWxlIiBhbmQgdGlt
aW5nIHRoZSByZXN1bHQuIFRoYXQgd291bGQgaXNvbGF0ZSBzaGExIHBlcmZvcm1hbmNlLiAgSWYg
aXQncyBzbG93LCB0cnkgYnVpbGRpbmcgd2l0aCAibWFrZSBCTEtfU0hBMT1ZZXMiIG9yICJtYWtl
IE9QRU5TU0xfU0hBMT1ZZXMiIGFuZCBzZWUgaWYgdGhhdCdzIGZhc3Rlci4NCg0KRm9yICg0KSwg
d2UnbGwgaGF2ZSB0byBzdGF0KCkgaW4gLmdpdC9vYmplY3RzIHRvIHNlZSBpZiB3ZSBoYXZlIGEg
bG9vc2UgdmVyc2lvbiBvZiB0aGUgb2JqZWN0LiBUaGF0IGNhbiBiZSBzbG93IGlmIHlvdSBoYXZl
IGEgcmVhbGx5IHRlcnJpYmxlIE5GUyBzZXR1cCwgZm9yIGV4YW1wbGUuIEJ1dCBJIGRvdWJ0IHRo
YXQgd291bGQgc3RpbGwgYmUgc2xvdyBpbiB2Mi4yMS4NClRoZXJlIHdlIHNob3VsZCBiZSB1c2lu
ZyB0aGUgbmV3IGxvb3NlLWNhY2hlIHdoaWNoIHdpbGwgb25seSByZWFkZGlyKCkgdGhlIG9iamVj
dCBkaXJlY3RvcmllcyBvbmNlLg0KDQpJZiBuZWl0aGVyIG9mIHRob3NlIHBhbiBvdXQsIGl0IHNl
ZW1zIGxpa2UgdGhlIG5ldHdvcmsgaXMgc2xvdz8gT3IgbWF5YmUgc3NoPyBPciBwaXBlcyBwYXNz
aW5nIGRhdGEgZnJvbSBjbG9uZSB0byBpbmRleC1wYWNrPw0KDQotUGVmZg0K
