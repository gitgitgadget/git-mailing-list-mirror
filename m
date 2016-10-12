Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 317E420989
	for <e@80x24.org>; Wed, 12 Oct 2016 09:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932750AbcJLJ1i (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 05:27:38 -0400
Received: from mail-db5eur01on0095.outbound.protection.outlook.com ([104.47.2.95]:13344
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932677AbcJLJ1f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 05:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icl-services.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XM2UCw3W77RaMY+hZ0gHqN38qUwDjas92SZgNkU6Pgc=;
 b=OdSaweEOpDaTZhBCMMEE8aRzylpA9w15ljwfo7NL+mHK/qgrBl1S4m6sknA7RvJI8KWm4eFwHKw0qZ9xIegVaIarqd3a1tLG2fVAMavOjbThCipW9nPM58AhlZqt+1VGjmivB2c76jpLlwp3LZjiOMv6jTF6O9H5rG0fZaxYkUE=
Received: from AM4PR03MB1636.eurprd03.prod.outlook.com (10.165.243.150) by
 AM4PR03MB1633.eurprd03.prod.outlook.com (10.165.243.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.659.11; Wed, 12 Oct 2016 05:51:59 +0000
Received: from AM4PR03MB1636.eurprd03.prod.outlook.com ([10.165.243.150]) by
 AM4PR03MB1636.eurprd03.prod.outlook.com ([10.165.243.150]) with mapi id
 15.01.0659.020; Wed, 12 Oct 2016 05:51:59 +0000
From:   Eduard Egorov <Eduard.Egorov@icl-services.com>
To:     =?utf-8?B?J0pha3ViIE5hcsSZYnNraSc=?= <jnareb@gmail.com>
CC:     'Paul Smith' <paul@mad-scientist.net>,
        "'git@vger.kernel.org'" <git@vger.kernel.org>,
        'Jeff King' <peff@peff.net>
Subject: RE: git merge deletes my changes
Thread-Topic: git merge deletes my changes
Thread-Index: AdIi2gGxW96gMpbvRJCzILaaCvDyAAARRHsjAC4/wgAAHDzzgA==
Date:   Wed, 12 Oct 2016 05:51:58 +0000
Message-ID: <AM4PR03MB1636DC3017FFA1DE57BAABADDBDD0@AM4PR03MB1636.eurprd03.prod.outlook.com>
References: <AM4PR03MB1636BE3423E2BC4F0E998159DBDB0@AM4PR03MB1636.eurprd03.prod.outlook.com>
 <AM4PR03MB1636EA0DEB4C8095F04AB92ADBDB0@AM4PR03MB1636.eurprd03.prod.outlook.com>
 <1476121942.15746.99.camel@mad-scientist.net>
 <94ff5fb3-6957-8983-4aa7-e1d5e2692e82@gmail.com>
In-Reply-To: <94ff5fb3-6957-8983-4aa7-e1d5e2692e82@gmail.com>
Accept-Language: en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eduard.Egorov@icl-services.com; 
x-originating-ip: [91.217.156.154]
x-ms-office365-filtering-correlation-id: da6ea60f-e5dc-4505-8309-08d3f263e1b6
x-microsoft-exchange-diagnostics: 1;AM4PR03MB1633;6:qqDMx9ogPuhyRU543CywA4bueTN4szEvM5SmT5ntqpY/ifz0qumfQCDQkBSx9a0t5YxwKlwS2zbInsfTNEU9paOF+MGy+ziUUcvxZaDmwyJx5fearev1z65eTCAQlTwqv826Osj6XFWVemllpIgnYyMuJAM9cN+d7wANf5hYKpHAhF55/NqZtZ0VdOWXocl2sR5viyBtcQ8MmDq22NyccYt/DaYyjz+4dqzl+wVK6ssFoWEOkvyZpyUTiv0z/PgiWp8Tv7DhGjStlMNuO01vMZ+1i4XERy5xrAEG7EUDJ1eMMtnbLCRonMOd4aD0pyKH;5:kpjvSqYVUpjUIZLOCLkZbS10UIWIsH5I8lBnWjK2ID0p7hGHx0ql1FsOwwJIQ3nUSCyrlXeBdxtrzpsRCcpwdpm6es1+GOkDN2A4DQMBSCtm8qh7UDa9MUiZl48DOunPL1G87q2/76eC0BgpzglNmI54HSFndEV/MVxFe3Kho4Y=;24:MX+hSjCWKLfTbOChpFaA2x+FpsimUor5IGjdALjmBAoXUQGAhSLut51poovBBQiGrtNirFhWfnqcpoclU2CJZz2dZ7ednAvblrn4DPmUvVg=;7:+8gbmdIXyOigcp5V3o6Rjb8Sj9dqyyAznDx/tdK31j7WhmJHm9oDCEiOpI6hTlFQKRaMGEQuRrTv8bJNL1Jbh/bcWHx8C1t+PIm2VjSBBTds1UyvXBt3xj0VoZdQF4Cv7naRRW6sxDpc776wxP1yjBheT5e+J94X9oN/7s0461iXuS+N011Cqw9E4x/jycH3XtVeRBVOlM88M4Wnpe9Qf5V1eGTaM6hZ2VuofciFBEUU7MEnNNMch2RojbdKVZHYvEbwkv53h+YmGjefwign7ZekET0n4KByfl569wP2HFihouGRvcbL6+cXz3vwo4JV/PiZ9kyUxo4GPI3sVOUxzAZQgLjsE+g10SRumMZ9g/o=
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:AM4PR03MB1633;
x-microsoft-antispam-prvs: <AM4PR03MB1633351A7651284AF544A089DBDD0@AM4PR03MB1633.eurprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185212123834332);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046);SRVR:AM4PR03MB1633;BCL:0;PCL:0;RULEID:;SRVR:AM4PR03MB1633;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(7916002)(24454002)(189002)(377424004)(13464003)(199003)(377454003)(6916009)(15975445007)(106356001)(110136003)(5002640100001)(2900100001)(92566002)(4326007)(5660300001)(93886004)(77096005)(2950100002)(7696004)(345774005)(66066001)(76176999)(54356999)(105586002)(8936002)(2906002)(50986999)(33656002)(7846002)(1411001)(101416001)(3280700002)(81156014)(15395725005)(305945005)(74316002)(7736002)(9686002)(19580395003)(81166006)(122556002)(19580405001)(76576001)(68736007)(189998001)(6116002)(86362001)(97736004)(11100500001)(3846002)(102836003)(586003)(10400500002)(3660700001)(4001150100001)(8676002)(87936001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR03MB1633;H:AM4PR03MB1636.eurprd03.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: icl-services.com does not
 designate permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: icl-services.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2016 05:51:58.9718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c6039a2-9be8-4677-87ed-cd9c68a6779e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR03MB1633
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGVsbG8gSmFrdWIsDQoNClRoYW5rIHlvdSBmb3IgYWRkaXRpb24uIEV2ZW50dWFsbHksIEkndmUg
bWVyZ2VkIHlvdXIgZXhwbGFuYXRpb25zIGludG8gc2luZ2xlIGFuc3dlciBwb3N0IChodHRwOi8v
c3RhY2tvdmVyZmxvdy5jb20vcXVlc3Rpb25zLzM5OTU0MjY1L2dpdC1tZXJnZS1zLXN1YnRyZWUt
d29ya3MtaW5jb3JyZWN0bHkvICkuIEkgaG9wZSB0aGlzIHdpbGwgcHJldmVudCBvdGhlciBjb25m
dXNlZCBwZW9wbGUgZnJvbSBkaXN0dXJiaW5nIHlvdSBieSBzaW1pbGFyIGVtYWlscyBvbiB0aGlz
IG1haWxpbmcgbGlzdC4NCg0KVGhpcyBpcyBhbm90aGVyIHRpbWUgSSBjYW4gZXZpZGVuY2UgdGhl
IHBvd2VyIGFuZCBmbGV4aWJpbGl0eSB0aGUgZ2l0IHByb3ZpZGVzLCB0aGFuayB5b3UgYWxsIGZv
ciB5b3VyIGdyZWF0IHdvcmshDQoNCldpdGggYmVzdCByZWdhcmRzDQpFZHVhcmQgRWdvcm92DQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKYWt1YiBOYXLEmWJza2kgW21haWx0
bzpqbmFyZWJAZ21haWwuY29tXSANClNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMTEsIDIwMTYgNjo1
NyBQTQ0KVG86IFBhdWwgU21pdGg7IEVkdWFyZCBFZ29yb3Y7ICdnaXRAdmdlci5rZXJuZWwub3Jn
Jw0KU3ViamVjdDogUmU6IGdpdCBtZXJnZSBkZWxldGVzIG15IGNoYW5nZXMNCg0KVyBkbml1IDEw
LjEwLjIwMTYgbyAxOTo1MiwgUGF1bCBTbWl0aCBwaXN6ZToNCj4gT24gTW9uLCAyMDE2LTEwLTEw
IGF0IDEwOjE5ICswMDAwLCBFZHVhcmQgRWdvcm92IHdyb3RlOg0KPj4gIyB+L2dpdGJ1aWxkL2dp
dC0yLjEwLjEvZ2l0IG1lcmdlIC1zIHN1YnRyZWUgLS1zcXVhc2ggY2VwaF9hbnNpYmxlDQo+Pg0K
Pj4gQ2FuIHNvbWVib2R5IGNvbmZpcm0gdGhpcyBwbGVhc2U/IERvZXNuJ3QgIm1lcmdlIC1zIHN1
YnRyZWUiIHJlYWxseSANCj4+IG1lcmdlcyBicmFuY2hlcz8NCj4gDQo+IEkgdGhpbmsgcG9zc2li
bHkgeW91J3JlIG5vdCBmdWxseSB1bmRlcnN0YW5kaW5nIHdoYXQgdGhlIC0tc3F1YXNoIGZsYWcg
DQo+IGRvZXMuLi4gdGhhdCdzIHdoYXQncyBjYXVzaW5nIHlvdXIgaXNzdWUgaGVyZSwgbm90IHRo
ZSAiLXMiIG9wdGlvbi4NCj4gDQo+IEEgc3F1YXNoIG1lcmdlIHRha2VzIHRoZSBjb21taXRzIHRo
YXQgd291bGQgYmUgbWVyZ2VkIGZyb20gdGhlIG9yaWdpbiANCj4gYnJhbmNoIGFuZCBzcXVhc2hl
cyB0aGVtIGludG8gYSBzaW5nbGUgcGF0Y2ggYW5kIGFwcGxpZXMgdGhlbSB0byB0aGUgDQo+IGN1
cnJlbnQgYnJhbmNoIGFzIGEgbmV3IGNvbW1pdC4uLiBidXQgdGhpcyBuZXcgY29tbWl0IGlzIG5v
dCBhIG1lcmdlIA0KPiBjb21taXQgKHRoYXQgaXMsIHdoZW4geW91IGxvb2sgYXQgaXQgd2l0aCAi
Z2l0IHNob3ciIGV0Yy4gdGhlIGNvbW1pdCANCj4gd2lsbCBoYXZlIG9ubHkgb25lIHBhcmVudCwg
bm90IHR3by0tb3IgbW9yZS0tcGFyZW50cyBsaWtlIGEgbm9ybWFsIA0KPiBtZXJnZSBjb21taXQp
Lg0KPiANCj4gQmFzaWNhbGx5LCBpdCdzIHN5bnRhY3RpYyBzdWdhciBmb3IgYSBkaWZmIHBsdXMg
cGF0Y2ggb3BlcmF0aW9uIHBsdXMgDQo+IHNvbWUgR2l0IGdvb2RuZXNzIHdyYXBwZWQgYXJvdW5k
IGl0IHRvIG1ha2UgaXQgZWFzaWVyIHRvIHVzZS4NCg0KQWN0dWFsbHkgdGhpcyBpcyBmdWxsIG1l
cmdlICsgY29tbWl0IHN1cmdlcnkgKGFzIGlmIHlvdSBkaWQgbWVyZ2Ugd2l0aCAtLW5vLWNvbW1p
dCwgdGhlbiBkZWxldGVkIE1FUkdFX0hFQUQpOyB0aGUgc3RhdGUgb2Ygd29ya3RyZWUgaXMgYXMg
aWYgaXQgd2VyZSBhZnRlciBhIG1lcmdlLg0KDQo+IA0KPiBCdXQgdWx0aW1hdGVseSBvbmNlIHlv
dSdyZSBkb25lLCBHaXQgaGFzIG5vIGlkZWEgdGhhdCB0aGlzIG5ldyBjb21taXQgDQo+IGhhcyBh
bnkgcmVsYXRpb25zaGlwIHdoYXRzb2V2ZXIgdG8gdGhlIG9yaWdpbiBicmFuY2guICBTbyB0aGUg
bmV4dCANCj4gdGltZSB5b3UgbWVyZ2UsIEdpdCBkb2Vzbid0IGtub3cgdGhhdCB0aGVyZSB3YXMg
YSBwcmV2aW91cyBtZXJnZSBhbmQgDQo+IGl0IHdpbGwgdHJ5IHRvIG1lcmdlIGV2ZXJ5dGhpbmcg
ZnJvbSBzY3JhdGNoIHJhdGhlciB0aGFuIHN0YXJ0aW5nIGF0IA0KPiB0aGUgcHJldmlvdXMgY29t
bW9uIG1lcmdlIHBvaW50Lg0KPiANCj4gU28gZWl0aGVyIHlvdSdsbCBoYXZlIHRvIHVzZSBhIG5v
cm1hbCwgbm9uLXNxdWFzaCBtZXJnZSwgb3IgZWxzZSANCj4geW91J2xsIGhhdmUgdG8gdGVsbCBH
aXQgYnkgaGFuZCB3aGF0IHRoZSBwcmV2aW91cyBjb21tb24gbWVyZ2UgcG9pbnQgDQo+IHdhcyAo
YXMgSmVmZiBLaW5nJ3MgZXhjZWxsZW50IGVtYWlsIHN1Z2dlc3RzKS4gIE9yIGVsc2UsIHlvdSds
bCBoYXZlIA0KPiB0byBsaXZlIHdpdGggdGhpcyBiZWhhdmlvci4NCg0KVGhlIGBnaXQgc3VidHJl
ZWAgY29tbWFuZCAoZnJvbSBjb250cmliKSBhbGxvd3MgeWV0IGFub3RoZXIgd2F5OiBpdCBzcXVh
c2hlcyAqaGlzdG9yeSogb2YgbWVyZ2VkIHN1YnByb2plY3QgKGFzIGlmIHdpdGggaW50ZXJhY3Rp
dmUgcmViYXNlICdzcXVhc2gnKSwgdGhlbiBtZXJnZXMgdGhpcyBzcXVhc2ggY29tbWl0Lg0KDQpO
b3cgSSBrbm93IHdoeSB0aGlzIGZlYXR1cmUgaXMgaGVyZS4uLg0KLS0NCkpha3ViIE5hcsSZYnNr
aQ0KDQo=
