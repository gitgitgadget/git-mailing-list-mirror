Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F024D1F461
	for <e@80x24.org>; Fri, 30 Aug 2019 14:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfH3OdK (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 10:33:10 -0400
Received: from mxo2.nje.dmz.twosigma.com ([208.77.214.162]:49443 "EHLO
        mxo2.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbfH3OdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 10:33:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTP id 46Khm46Pqxz7t8C;
        Fri, 30 Aug 2019 14:33:08 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id soPNqWS8W8Bl; Fri, 30 Aug 2019 14:33:08 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTPS id 46Khm45kJsz3wZ3;
        Fri, 30 Aug 2019 14:33:08 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1365.1; Fri, 30 Aug 2019 14:33:08 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1365.000; Fri, 30 Aug 2019 14:33:08 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     =?utf-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>
CC:     Git Mailing List <git@vger.kernel.org>
Subject: RE: [PATCH v2] clarify documentation for remote helpers
Thread-Topic: [PATCH v2] clarify documentation for remote helpers
Thread-Index: AQHVXzyMzXR+2+tBi0aDOVVSgpzsXqcTu4Ag
Date:   Fri, 30 Aug 2019 14:33:08 +0000
Message-ID: <5b44a8bd476946b4990bbcb0112757f0@exmbdft7.ad.twosigma.com>
References: <20190830134805.9588-1-dturner@twosigma.com>
 <CAN0heSouGV+0Z+j_Th794u-RNiLLLNNEpJu__nAH38_q_TSuig@mail.gmail.com>
In-Reply-To: <CAN0heSouGV+0Z+j_Th794u-RNiLLLNNEpJu__nAH38_q_TSuig@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.189.105]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFydGluIMOFZ3JlbiA8
bWFydGluLmFncmVuQGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMzAsIDIwMTkg
MTA6MDkgQU0NCj4gVG86IERhdmlkIFR1cm5lciA8RGF2aWQuVHVybmVyQHR3b3NpZ21hLmNvbT4N
Cj4gQ2M6IEdpdCBNYWlsaW5nIExpc3QgPGdpdEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjJdIGNsYXJpZnkgZG9jdW1lbnRhdGlvbiBmb3IgcmVtb3RlIGhlbHBlcnMN
Cj4gDQo+IE9uIEZyaSwgMzAgQXVnIDIwMTkgYXQgMTY6MDAsIERhdmlkIFR1cm5lciA8ZHR1cm5l
ckB0d29zaWdtYS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGF2aWQgVHVy
bmVyIDxkdHVybmVyQHR3b3NpZ21hLmNvbT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9n
aXRyZW1vdGUtaGVscGVycy50eHQgfCA2ICsrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZ2l0cmVtb3RlLWhlbHBlcnMudHh0DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2dpdHJl
bW90ZS1oZWxwZXJzLnR4dA0KPiA+IGluZGV4IDQzZjgwYzgwNjguLmY0YTE2NTM4N2YgMTAwNjQ0
DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9naXRyZW1vdGUtaGVscGVycy50eHQNCj4gPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2dpdHJlbW90ZS1oZWxwZXJzLnR4dA0KPiA+IEBAIC0yOTcsOSArMjk3
LDkgQEAgU3VwcG9ydGVkIGlmIHRoZSBoZWxwZXIgaGFzIHRoZSAib3B0aW9uIiBjYXBhYmlsaXR5
Lg0KPiA+ICAgICAgICAgc2FtZSBiYXRjaCBhcmUgY29tcGxldGUuIE9ubHkgb2JqZWN0cyB3aGlj
aCB3ZXJlIHJlcG9ydGVkDQo+ID4gICAgICAgICBpbiB0aGUgb3V0cHV0IG9mICdsaXN0JyB3aXRo
IGEgc2hhMSBtYXkgYmUgZmV0Y2hlZCB0aGlzIHdheS4NCj4gPiAgKw0KPiA+IC1PcHRpb25hbGx5
IG1heSBvdXRwdXQgYSAnbG9jayA8ZmlsZT4nIGxpbmUgaW5kaWNhdGluZyBhIGZpbGUgdW5kZXIN
Cj4gPiAtR0lUX0RJUi9vYmplY3RzL3BhY2sgd2hpY2ggaXMga2VlcGluZyBhIHBhY2sgdW50aWwg
cmVmcyBjYW4gYmUNCj4gPiAtc3VpdGFibHkgdXBkYXRlZC4NCj4gPiArT3B0aW9uYWxseSBtYXkg
b3V0cHV0IGEgJ2xvY2sgPGZpbGU+JyBsaW5lIGluZGljYXRpbmcgdGhlIGZ1bGwgcGF0aA0KPiA+
ICtvZiBhIGZpbGUgdW5kZXIgJEdJVF9ESVIvb2JqZWN0cy9wYWNrIHdoaWNoIGlzIGtlZXBpbmcg
YSBwYWNrIHVudGlsDQo+ID4gK3JlZnMNCj4gDQo+IEknZCBzdGlsbCBsaWtlIHRvIHN1Z2dlc3Qg
YmFja3RpY2tzOiBgJEdJVF9ESVIvb2JqZWN0cy9wYWNrYA0KPiANCj4gPiArY2FuIGJlIHN1aXRh
Ymx5IHVwZGF0ZWQuICBUaGUgcGF0aCBtdXN0IGVuZCB3aXRoICIua2VlcCIuDQo+ID4gICsNCj4g
PiAgSWYgb3B0aW9uICdjaGVjay1jb25uZWN0aXZpdHknIGlzIHJlcXVlc3RlZCwgdGhlIGhlbHBl
ciBtdXN0IG91dHB1dA0KPiA+ICdjb25uZWN0aXZpdHktb2snIGlmIHRoZSBjbG9uZSBpcyBzZWxm
LWNvbnRhaW5lZCBhbmQgY29ubmVjdGVkLg0KPiANCj4gSGVyZSdzIGhvdyBJIGludGVycHJldCB0
aGUgbW90aXZhdGlvbiBiZWhpbmQgdGhlIHBhdGNoOg0KPiANCj4gICBSZWFkaW5nIHRoZSB0ZXh0
IG9uIHRoZSBvcHRpb25hbCAnbG9jayA8ZmlsZT4nIGxpbmUsIGl0J3MgZWFzeSB0bw0KPiAgIGJl
bGlldmUgdGhhdCB0aGUgZmlsZW5hbWUgc2hvdWxkIGJlIGdpdmVuIHJlbGF0aXZlIHRvDQo+ICAg
JEdJVF9ESVIvb2JqZWN0cy9wYWNrLiBBY3R1YWxseSwgb25lIG5lZWRzIHRvIHByb3ZpZGUgdGhl
IGZ1bGwgcGF0aC4NCj4gICBBbHNvLCB3ZSBmYWlsIHRvIG1lbnRpb24gdGhhdCB0aGUgZmlsZW5h
bWUgbXVzdCBlbmQgd2l0aCAiLnBhY2siLg0KPiANCj4gQnV0IEknZCBoYXZlIHRvIHRha2UgeW91
ciB3b3JkIGZvciB0aGVzZSB0d28gY2xhaW1zLCBzaW5jZSBJIGhhdmVuJ3QgYWN0dWFsbHkNCj4g
dGVzdGVkIG9yIGR1ZyBteXNlbGYuIDstKQ0KDQpJIGRpZCB0ZXN0IGl0LiANCg0KPiBJIGRvIHdv
bmRlci4uLiBJZiB3ZSdyZSBnaXZpbmcgYSBmdWxsIHBhdGggd2hpY2ggcG9pbnRzIG91dHNpZGUg
b2YNCj4gJEdJVF9ESVIvb2JqZWN0cy9wYWNrLCB3aGF0IHdpbGwgaGFwcGVuPyBXaWxsIC9tbnQv
bXktcGFja3MvZm9vLnBhY2sgd29yaw0KPiBqdXN0IGFzIGZpbmU/IElmIHllcywgdGhlbiBJIGRv
bid0IHNlZSBhIHJlYXNvbiB0byBtZW50aW9uICRHSVRfRElSL29iamVjdHMvcGFjaw0KPiBhdCBh
bGwuIElmIG5vLCBpdCBzb3J0IG9mIGJlZ3MgdGhlIHF1ZXN0aW9uIG9mIHdoeSB3ZSBkb24ndCBh
Y2NlcHQgcmVsYXRpdmUNCj4gZmlsZW5hbWVzLiAoT3IgbWFuZGF0ZSB0aGVtLCBidXQgdGhhdCBi
b2F0IGhhcyBvYnZpb3VzbHkgc2FpbGVkLikgRWl0aGVyIHdheSwNCj4gSSdtIHdvbmRlcmluZyBp
ZiB0aGVyZSBpc24ndCBhIGJ1ZyBsZWZ0IGhlcmUuIFdoYXQgZG8geW91IHRoaW5rPw0KDQpJdCAg
ZG9lcyBhcHBlYXIgZnJvbSBjb2RlIGluc3BlY3Rpb24gdGhhdCBpdCB3aWxsIGFjY2VwdCBhIHBh
dGggZnJvbSBhbnl3aGVyZS4gIA0KQW5kIHRoZW4sIEkgdGhpbmssIHRoYXQgcGF0aCBnZXRzIGRl
bGV0ZWQgKGV2ZW4gaWYgaXQgZG9lcyBub3QgZW5kIHdpdGggIi5rZWVwIikuIA0KSXMgdGhpcyBh
ICJidWciPyAgSSBkb24ndCBrbm93LiAgSSBkb24ndCByZWFsbHkgdW5kZXJzdGFuZCB3aGF0IHRo
ZSBmZWF0dXJlIGlzIA0KaW50ZW5kZWQgdG8gYmUgdXNlZCBmb3IuICBTb21ld2hlcmUsIHRoZXJl
IG91Z2h0IHRvIGJlIGFuIGV4cGxhbmF0aW9uIG9mIGhvdw0KZ2l0IGlzIHN1cHBvc2VkIHRvIGhh
bmRsZSByYWNlcyBkdXJpbmcgdmFyaW91cyBwYXJ0cyBvZiBwYWNrIG1hbmlwdWxhdGlvbi4NCkkg
d291bGRuJ3QgZXZlbiBiZSB1c2luZyB0aGlzIGZlYXR1cmUgaWYgSSBjb3VsZCBqdXN0IHBhc3Mg
Y29ubmVjdGl2aXR5LW9rOg0KaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvZ2l0L21zZzM2
NTE1My5odG1sDQoNCldpbGwgd2FpdCB0byBzZWUgaWYgYW55b25lIGhhcyBmdXJ0aGVyIHRob3Vn
aHRzIGJlZm9yZSBJIGZpbGUgdjMuDQo=
