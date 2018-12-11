Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5939820A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 02:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbeLKCZu (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 21:25:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20697 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727485AbeLKCZu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 21:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com; s=selector; t=1544495147; h=from:from:sender:reply-to:subject:subject:date:date: message-id:message-id:to:to:cc:cc:mime-version:mime-version: content-type:content-type: content-transfer-encoding:content-transfer-encoding: in-reply-to:in-reply-to:references:references; bh=cIGRW46fH3+/1LbACxvsycsi1ntXkckK9T+S31gBlw4=; b=LQIK3Rknhy1q2pU+0+5h/VE0JlPL678OtNzb8JvXWiHkjIGGtWes05M4jzyPuGIvSxENKU5kXrxBtaoqG8fM5gVu8nWdtnKV4QB9dsybfUuOJFgEKkzYiLsYlypuMJ5QwWuoNv+kLBIG0UxajKAzPriHJ6kDyUniOVl+cJe3tZM=
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03lp2057.outbound.protection.outlook.com [104.47.40.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-2olz6fTAPbiv2gONqwByaw-1; Mon, 10 Dec 2018 21:25:45 -0500
Received: from CY4PR19MB1526.namprd19.prod.outlook.com (10.172.179.23) by
 CY4PR19MB1352.namprd19.prod.outlook.com (10.173.65.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Tue, 11 Dec 2018 02:25:42 +0000
Received: from CY4PR19MB1526.namprd19.prod.outlook.com
 ([fe80::c99e:94f:64f9:b41b]) by CY4PR19MB1526.namprd19.prod.outlook.com
 ([fe80::c99e:94f:64f9:b41b%10]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 02:25:42 +0000
From:   Owen Ofiesh <oofiesh@maxlinear.com>
To:     Bryan Turner <bturner@atlassian.com>
CC:     Git Users <git@vger.kernel.org>
Subject: RE: Git clone fails with fatal: the remote end hung up unexpectedly
Thread-Topic: Git clone fails with fatal: the remote end hung up unexpectedly
Thread-Index: AdSQ60uDLF+dQT1fTw62id5DJduh2AAA8Y+AAACso2A=
Date:   Tue, 11 Dec 2018 02:25:41 +0000
Message-ID: <CY4PR19MB152668FA1C3E592CA123E3E5ADA60@CY4PR19MB1526.namprd19.prod.outlook.com>
References: <CY4PR19MB1526704FC790724C2DC68465ADA60@CY4PR19MB1526.namprd19.prod.outlook.com>
 <CAGyf7-HHnwJyEu8G4p4A0RxJELJkEaJGMVj5nNznhWthAgS19g@mail.gmail.com>
In-Reply-To: <CAGyf7-HHnwJyEu8G4p4A0RxJELJkEaJGMVj5nNznhWthAgS19g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [207.43.172.140]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR19MB1352;6:SCI1auWpaOPgulSz1dqYpjLXbA//yYhzorTDuy6Bu5Q8ZF13SVqI7juPNIYn6EIkBSene00aott8vVdD7+dYAonoJWwgLO2ZEzcd2A+fB6eXGn/jfk22AUlCmX4ENhd0fi7JELxOkm9eBkjGC6nr51i73iEjnwStzNGeCutehr6yJKcYtJx+1POo0wdAhYu3yk+SWsM6CbFHG9+wrsczEJ/Qsz8EhV0we/jJDXOgd6HaJoQK9f1U5SHrKSMaIUZGCpBJPqbAi4euZCgLcUbHZZyOjFz12v19XouTQP9fYud/V5icWmHZ2wobyCuSMq5SsT1VsA3WJN3ORHKhdSnhD6ihHdJRMU/j2hdeGQs7uaGVFLuYvxzahEQRCCd4tIsKaHHkL69tbgEB1VGRLEHOgvq9DPskXkagnDV3132UMq9/d25eyUXTk2Omfpjm64HD1JeqUG5wjantG6CZpk+hOg==;5:SmNSVadJSrIuSR0h37ccCVasT3a1AAw6Tm1kB1h0HgBaNb/Ua0A/AiI1oFKSVLTWeIfvbYLEIAkN1OOlZULgLyRTlDYtau5xR/QC8lJZnMearFJKtLZLZdgtHhRlAY0kJLLHDgdENuwVSXPeh9Hq4+916qbab/JYlzxZy47Qu8M=;7:etUnx1PKoCZVr8bW08R1cyvAw+SnhAPH0OrOBY5R18nRYim7/hvhQHosDfw95wOrFGGGVUrdaDwpKYHBms9CvuI7pjK7hqQ6EPIaF9fRttLvGzrXd1rop7M64Ej9Th/FdY3W8QHOPP0/t7t2Y6wTyg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3aba2ec9-a281-4b90-f812-08d65f0ff2c7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR19MB1352;
x-ms-traffictypediagnostic: CY4PR19MB1352:
x-microsoft-antispam-prvs: <CY4PR19MB1352B50C5447C5806DE3087DADA60@CY4PR19MB1352.namprd19.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231455)(999002)(944501520)(4982022)(52105112)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:CY4PR19MB1352;BCL:0;PCL:0;RULEID:;SRVR:CY4PR19MB1352;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39850400004)(366004)(136003)(346002)(376002)(189003)(199004)(102836004)(186003)(229853002)(8936002)(81166006)(6116002)(3846002)(81156014)(4326008)(5660300001)(6306002)(53936002)(9686003)(7696005)(446003)(256004)(66066001)(14444005)(25786009)(6506007)(97736004)(486006)(6246003)(53546011)(86362001)(7736002)(305945005)(14454004)(33656002)(6916009)(68736007)(316002)(2906002)(966005)(6436002)(106356001)(74316002)(99286004)(105586002)(71200400001)(76176011)(11346002)(8676002)(55016002)(71190400001)(478600001)(26005)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR19MB1352;H:CY4PR19MB1526.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: X+FkJFRA+4LLBIRiNf2fcCN76JKkccjLdHOzy4W9/i+ZsgkDHeI2iWcBOH89/knXgi2lsY1YdPhhRX7BW6KG+qCDCUE9UCROVMIGKIUyz8jQh/EiwaNGqaAjZyVYVGR4bxvn382sFxzjgI3qeSwgo6UxKtExLTsRoDnd2VEKcRYrYm9lR5oGOCvYp0NZarrSgIkosvr+LRI3Jt4Xsf9RIrKzQ2ZOy7UBxQl2OyZ3kuQ3Hi8gxyvjoZAnKmi4i1FM+9Rpq9lKjrKsjtlkvSu6LjGAGgioylAM7NIsDpAnxCTAoKizP0XNLe35NK/UPX5C
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aba2ec9-a281-4b90-f812-08d65f0ff2c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 02:25:42.0342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR19MB1352
X-MC-Unique: 2olz6fTAPbiv2gONqwByaw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgQnJ5YW4sIGFsbCwNCg0KPiBGcm9tOiBCcnlhbiBUdXJuZXIgW21haWx0bzpidHVybmVyQGF0
bGFzc2lhbi5jb21dIA0KPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDEwLCAyMDE4IDU6MTYgUE0N
Cj4gVG86IE93ZW4gT2ZpZXNoIDxvb2ZpZXNoQG1heGxpbmVhci5jb20+DQo+IENjOiBHaXQgVXNl
cnMgPGdpdEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBHaXQgY2xvbmUgZmFpbHMg
d2l0aCBmYXRhbDogdGhlIHJlbW90ZSBlbmQgaHVuZyB1cCB1bmV4cGVjdGVkbHkNCj4gDQo+IE9u
IE1vbiwgRGVjIDEwLCAyMDE4IGF0IDQ6NTUgUE0gT3dlbiBPZmllc2ggPG1haWx0bzpvb2ZpZXNo
QG1heGxpbmVhci5jb20+IHdyb3RlOg0KPiA+DQo+ID4gV2UgYXJlIHNlZWluZyBhbiBpc3N1ZSB3
aGVyZSBnaXQgY2xvbmUgaW4gTGludXggVWJ1bnR1IDE0LjA0LjUgTFRTIGZhaWxzDQo+ID4gd2l0
aCB0aGUgZm9sbG93aW5nIGVycm9yIHVzaW5nIHRoZSBIVFRQIHByb3RvY29sLg0KPiA+DQo+ID4g
VGhlIGVycm9yIG9uIHRoZSBjbGllbnQgaXM6DQo+ID4gZmF0YWw6IHRoZSByZW1vdGUgZW5kIGh1
bmcgdXAgdW5leHBlY3RlZGx5DQo+ID4gZmF0YWw6IGVhcmx5IEVPRg0KPiA+IGZhdGFsOiBpbmRl
eC1wYWNrIGZhaWxlZA0KPiA+DQo+ID4gVGhlIGNsaWVudCBpcyB3cml0aW5nIHRvIGFuIE5GUyB2
b2x1bWUuDQo+IA0KPiBBIGZ1cnRoZXIgZGV0YWlsIG9uIHRoaXMgKE93ZW4gY29ycmVjdCBtZSBp
ZiBJJ20gd3JvbmcpLCBidXQgdGhlIHNhbWUNCj4gY2xvbmUgcGVyZm9ybWVkIHRvIGEgbG9jYWwg
ZGlzaywgcmF0aGVyIHRoYW4gTkZTLCBzdWNjZWVkcy4NCg0KQ29ycmVjdC4gVGhlIGNsb25lIHRv
IGxvY2FsIGRpc2sgc3VjY2VlZHMuDQoNCk9uZSBtb3JlIGRhdGEgcG9pbnQuIEkgdHJpZWQgdGhp
cyB3aXRoIFNTSCBqdXN0IG5vdywgYW5kIHRoZSBiZWhhdmlvcg0KaXMgc29tZXdoYXQgaW1wcm92
ZWQgaW4gdGhhdCBJIGFtIG9ubHkgc2VlaW5nIHRoZSBmYWlsdXJlIG9uIHRoZSBORlMNCnZvbHVt
ZSBzbyBmYXIgd2l0aCAxIGluIDYgY2xvbmUgYXR0ZW1wdHMgKDUgc3VjY2Vzc2Z1bCkuIFdoZXJl
YXMgd2l0aA0KSFRUUCwgd2Ugc2VlIHRoZSBmYWlsdXJlIGV2ZXJ5IHRpbWUuIA0KDQo+ID4NCj4g
PiBUaGUgSFRUUCBQT1NUIGVycm9yIG9uIHRoZSBzZXJ2ZXIgaXM6DQo+ID4gYy5hLnMuaS53LmZp
bHRlcnMuU3RyZWFtR3VhcmRGaWx0ZXIgVGhlIHJlbW90ZSBjbGllbnQgaGFzIGFib3J0ZWQgdGhl
IGNvbm5lY3Rpb24NCj4gPiBjLmEucy5pLncuZmlsdGVycy5TdHJlYW1HdWFyZEZpbHRlciBGYWls
ZWQgdG8gZmx1c2ggYnVmZmVyOyB0aGUgcmVtb3RlIGNsaWVudCBhYm9ydGVkIHRoZSBjb25uZWN0
aW9uDQo+IA0KPiBCaXRidWNrZXQgU2VydmVyIGRldmVsb3BlciBoZXJlLiBJIGp1c3Qgd2FudCB0
byBjbGFyaWZ5IG9uZSB0aGluZw0KPiBoZXJlLCBmb3IgdGhlIGxpc3QuIFRoZSBhYm92ZSBpcyBs
b2dnZWQgd2hlbiB0aGUgY2xvbmluZyBjbGllbnQNCj4gZGlzY29ubmVjdHMgdW5leHBlY3RlZGx5
IGluIHRoZSBtaWRkbGUgb2YgYSBob3N0aW5nIG9wZXJhdGlvbiAocHVzaCBvcg0KPiBwdWxsKS4g
U28sIGZyb20gdGhlIHNlcnZlcidzIHBlcnNwZWN0aXZlLCBldmVyeXRoaW5nIHdhcyBnb2luZyB3
ZWxsDQo+IGFuZCB0aGVuIHRoZSBjbGllbnQgbGVmdCB3aXRob3V0IHNheWluZyBnb29kYnllLg0K
DQpDb3JyZWN0IGluIHRoYXQgd2Ugc2VlIHRoaXMgYmVoYXZpb3Igd2hlbiBjbG9uaW5nLiBTbWFs
bCB1cGRhdGVzDQoocHVzaC9wdWxsKSBzZWVtcyB0byB3b3JrIG9rYXkuIFdlIHRlc3RlZCB0aGlz
IHByZXZpb3VzbHkgYnkgY2xvbmluZyB0bw0KbG9jYWwgZGlzaywgdGhlbiBjb3B5aW5nIHRvIE5G
UywgYW5kIHRoZW4gdHJ5aW5nIHZlcnkgc21hbGwgdXBkYXRlcy4NCg0KPiA+IE91ciBnaXQgcmVw
b3NpdG9yaWVzIGFyZSBtYW5hZ2VkIGJ5IEF0bGFzc2lhbidzIGJpdGJ1Y2tldCBzZXJ2ZXIgdjUu
NS4xLg0KPiA+DQo+ID4gV2Ugc2VlIHRoaXMgd2l0aCB0aGUgTGludXggZ2l0IGNsaWVudCBTVyB2
MS45LjEgYW5kIHYyLjE5LjIgKGRvZXNuJ3Qgc2VlbQ0KPiA+IHRvIG1hdHRlciB0aGUgY2xpZW50
IFNXIHZlcnNpb24pLg0KPiA+DQo+ID4gVGhlIExpbnV4IGdpdCBzZXJ2ZXIgaXMgU1cgdjIuOS41
Lg0KPiA+DQo+ID4gUGVyIGRpc2N1c3Npb25zIGFib3V0IHRoaXMgd2UndmUgdHJpZWQgdGhlIGZv
bGxvd2luZzoNCj4gPiAxLiBXZSBpbmNyZWFzZWQgdGhlIEdJVF9IVFRQX01BWF9SRVFVRVNUX0JV
RkZFUiBzZXR0aW5nIG9uIHRoZSBzZXJ2ZXINCj4gPiAgICB0byAxMDBNQnMuDQo+ID4gMi4gV2Ug
c2V0IHRoZSBodHRwLnBvc3RCdWZmZXIgY2xpZW50IHZhbHVlIHRvIDEwME1Ccy4NCj4gPiBOZWl0
aGVyIG9mIHRoZXNlIGhlbHBlZC4NCj4gPg0KPiA+IEFueSB0aG91Z2h0cyBhYm91dCB0aGlzIHBs
ZWFzZT8NCj4gPg0KPiA+IE5vdGU6DQo+ID4gRm9yIHJlYXNvbnMgSSB3aWxsIG5vdCBlbnRlciBp
bnRvLCB3ZSBjYW5ub3QgdXNlIFNTSCBmb3IgdGhpcy4NCj4gPg0KPiA+IFRoYW5rIHlvdS4NCj4g
Pg0KPiA+IGVuZA0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBPd2VuIE9maWVzaCwgU0NNLCBTb2Z0
d2FyZSBUZXN0IGFuZCBEZXZlbG9wbWVudCBNYW5hZ2VyDQo+ID4gTWF4TGluZWFyLCBJbmMuIHwg
aHR0cDovL3d3dy5tYXhsaW5lYXIuY29tDQo+ID4gNTk2NiBMYSBQbGFjZSBDb3VydCBTdWl0ZSAx
MDAgQ2FybHNiYWQsIENBIDkyMDA4DQo+ID4gUGhvbmU6IDc2MC01MTctMTEwOQ0KPiA+IENlbGw6
IDg1OC0zMzUtMTY5MA0KPiA+IG1haWx0bzpvb2ZpZXNoQG1heGxpbmVhci5jb20NCj4gPg0KPiA+
DQo=

