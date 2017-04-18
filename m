Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DB82201C2
	for <e@80x24.org>; Tue, 18 Apr 2017 17:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753919AbdDRRwn (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 13:52:43 -0400
Received: from mxo1.nje.dmz.twosigma.com ([208.77.214.160]:59328 "EHLO
        mxo1.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757925AbdDRRwm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 13:52:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTP id 4BC7D1000CB;
        Tue, 18 Apr 2017 17:52:41 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id i_BLsRvn6pce; Tue, 18 Apr 2017 17:52:41 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTPS id 39BAD8002E;
        Tue, 18 Apr 2017 17:52:41 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Tue, 18 Apr 2017 17:52:40 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Tue, 18 Apr 2017 17:52:40 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     =?utf-8?B?J1JlbsOpIFNjaGFyZmUn?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: RE: [PATCH v2] xgethostname: handle long hostnames
Thread-Topic: [PATCH v2] xgethostname: handle long hostnames
Thread-Index: AQHSt+TtawNNi8BI3kWq4xoPnv1kw6HLTAiAgAAcOCA=
Date:   Tue, 18 Apr 2017 17:52:40 +0000
Message-ID: <e1f3ca5df4484496a2e0ab601a940ecb@exmbdft7.ad.twosigma.com>
References: <20170417161748.31231-1-dturner@twosigma.com>
 <xmqq1ssqikc5.fsf@gitster.mtv.corp.google.com>
 <xmqqwpaih4q2.fsf@gitster.mtv.corp.google.com>
 <281d0843-d48a-b7ab-737b-b9528689d44e@web.de>
In-Reply-To: <281d0843-d48a-b7ab-737b-b9528689d44e@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.13]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSZW7DqSBTY2hhcmZlIFttYWls
dG86bC5zLnJAd2ViLmRlXQ0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCAxOCwgMjAxNyAxMjowOCBQ
TQ0KPiBUbzogSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPjsgRGF2aWQgVHVybmVy
DQouLi4gDQo+ID4+IE9mIGNvdXJzZSwgbXlfaG9zdCBpcyBzaXplZCB0byBIT1NUX05BTUVfTUFY
ICsgMSBhbmQgd2UgYXJlIGNvbXBhcmluZw0KPiA+PiBpdCB3aXRoIGxvY2tpbmdfaG9zdCwgc28g
cGVyaGFwcyB3ZSdkIG5lZWQgdG8gdGFrZSB0aGlzIHZlcnNpb24gdG8NCj4gPj4gc2l6ZSBsb2Nr
aW5nX2hvc3QgdG8gYWxzbyBIT1NUX05BTUVfTUFYICsgMSwgYW5kIHRoZW4gc2NhbiB3aXRoICUy
NTVjDQo+ID4+IChidXQgdGhlbiBzaG91bGRuJ3Qgd2Ugc2NhbiB3aXRoICUyNTZjIGluc3RlYWQ/
ICBJIGFtIG5vdCBzdXJlIHdoZXJlDQo+ID4+IHRoZXNlICsxIGNvbWVzIGZyb20pLg0KPiA+DQo+
ID4gVGhhdCBpcywgc29tZXRoaW5nIGFsb25nIHRoaXMgbGluZS4uLg0KPiA+DQo+ID4gICBidWls
dGluL2djLmMgfCA2ICsrKysrLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2J1aWx0aW4vZ2MuYyBiL2J1
aWx0aW4vZ2MuYyBpbmRleCBiZTc1NTA4MjkyLi40Zjg1NjEwZDg3DQo+ID4gMTAwNjQ0DQo+ID4g
LS0tIGEvYnVpbHRpbi9nYy5jDQo+ID4gKysrIGIvYnVpbHRpbi9nYy5jDQo+ID4gQEAgLTI0MCw3
ICsyNDAsMTEgQEAgc3RhdGljIGNvbnN0IGNoYXIgKmxvY2tfcmVwb19mb3JfZ2MoaW50IGZvcmNl
LCBwaWRfdCoNCj4gcmV0X3BpZCkNCj4gPiAgIAkJCQkgICAgICAgTE9DS19ESUVfT05fRVJST1Ip
Ow0KPiA+ICAgCWlmICghZm9yY2UpIHsNCj4gPiAgIAkJc3RhdGljIGNoYXIgbG9ja2luZ19ob3N0
W0hPU1RfTkFNRV9NQVggKyAxXTsNCj4gPiArCQlzdGF0aWMgY2hhciAqc2Nhbl9mbXQ7DQo+ID4g
ICAJCWludCBzaG91bGRfZXhpdDsNCj4gPiArDQo+ID4gKwkJaWYgKCFzY2FuX2ZtdCkNCj4gPiAr
CQkJc2Nhbl9mbXQgPSB4c3RyZm10KCIlcyAlJSVkYyIsICIlIlNDTnVNQVgsDQo+IEhPU1RfTkFN
RV9NQVgpOw0KPiA+ICAgCQlmcCA9IGZvcGVuKHBpZGZpbGVfcGF0aCwgInIiKTsNCj4gPiAgIAkJ
bWVtc2V0KGxvY2tpbmdfaG9zdCwgMCwgc2l6ZW9mKGxvY2tpbmdfaG9zdCkpOw0KPiA+ICAgCQlz
aG91bGRfZXhpdCA9DQo+ID4gQEAgLTI1Niw3ICsyNjAsNyBAQCBzdGF0aWMgY29uc3QgY2hhciAq
bG9ja19yZXBvX2Zvcl9nYyhpbnQgZm9yY2UsIHBpZF90Kg0KPiByZXRfcGlkKQ0KPiA+ICAgCQkJ
ICogcnVubmluZy4NCj4gPiAgIAkJCSAqLw0KPiA+ICAgCQkJdGltZShOVUxMKSAtIHN0LnN0X210
aW1lIDw9IDEyICogMzYwMCAmJg0KPiA+IC0JCQlmc2NhbmYoZnAsICIlIlNDTnVNQVgiICUxMjdj
IiwgJnBpZCwgbG9ja2luZ19ob3N0KQ0KPiA9PSAyICYmDQo+ID4gKwkJCWZzY2FuZihmcCwgc2Nh
bl9mbXQsICZwaWQsIGxvY2tpbmdfaG9zdCkgPT0gMiAmJg0KPiA+ICAgCQkJLyogYmUgZ2VudGxl
IHRvIGNvbmN1cnJlbnQgImdjIiBvbiByZW1vdGUgaG9zdHMgKi8NCj4gPiAgIAkJCShzdHJjbXAo
bG9ja2luZ19ob3N0LCBteV9ob3N0KSB8fCAha2lsbChwaWQsIDApIHx8IGVycm5vDQo+ID09IEVQ
RVJNKTsNCj4gPiAgIAkJaWYgKGZwICE9IE5VTEwpDQo+ID4NCj4gDQo+IEhvdyBpbXBvcnRhbnQg
aXMgaXQgdG8gc2NhbiB0aGUgd2hvbGUgZmlsZSBpbiBvbmUgY2FsbD8gIFdlIGNvdWxkIHNwbGl0
IGl0IHVwIGxpa2UNCj4gdGhpcyBhbmQgdXNlIGEgc3RyYnVmIHRvIGhhbmRsZSBob3N0IG5hbWVz
IG9mIGFueSBsZW5ndGguICBXZSBuZWVkIHRvIGJlDQo+IHBlcm1pc3NpdmUgaGVyZSB0byBhbGxv
dyBtYWNoaW5lcyB3aXRoIGRpZmZlcmVudCB2YWx1ZXMgZm9yIEhPU1RfTkFNRV9NQVgNCj4gdG8g
d29yayB3aXRoIHRoZSBzYW1lIGZpbGUgb24gYSBuZXR3b3JrIGZpbGUgc3lzdGVtLCBzbyB0aGlz
IHdvdWxkIGhhdmUgdG8gYmUgdGhlDQo+IGZpcnN0IHBhdGNoLCByaWdodD8NCg0KSWYgdGhlIHdy
aXRlciBoYXMgdGhlIHNtYWxsZXIgSE9TVF9OQU1FX01BWCwgdGhpcyB3aWxsIHdvcmsgZmluZS4g
IElmIHRoZSByZWFkZXINCmhhcyB0aGUgc21hbGxlciBIT1NUX05BTUVfTUFYLCBhbmQgdGhlIHdy
aXRlcidzIGFjdHVhbCB2YWx1ZSBpcyB0b28gbG9uZywNCnRoZW4gdGhlcmUncyBubyB3YXkgdGhl
IHN0cmNtcCB3b3VsZCBzdWNjZWVkIGFueXdheS4gIFNvIEkgZG9uJ3QgdGhpbmsgd2UgbmVlZA0K
dG8gd29ycnkgYWJvdXQgaXQuDQoNCj4gTkI6IFRoYXQgJiYgY2FzY2FkZSBoYXMgZW5vdWdoIG1l
YXQgZm9yIGEgd2hvbGUgZnVuY3Rpb24uDQoNCisxDQoNCg==
