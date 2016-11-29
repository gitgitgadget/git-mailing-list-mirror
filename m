Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51DBA1FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 18:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756516AbcK2SnZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 13:43:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:23793 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934361AbcK2SnT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 13:43:19 -0500
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP; 29 Nov 2016 10:43:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,570,1473145200"; 
   d="scan'208";a="197077846"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga004.fm.intel.com with ESMTP; 29 Nov 2016 10:43:16 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.166]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.62]) with mapi id 14.03.0248.002;
 Tue, 29 Nov 2016 10:43:15 -0800
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     "gitster@pobox.com" <gitster@pobox.com>,
        "jacob.keller@gmail.com" <jacob.keller@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>
Subject: Re: [PATCH 0/2] add format specifiers to display trailers
Thread-Topic: [PATCH 0/2] add format specifiers to display trailers
Thread-Index: AQHSRBv5TQ3bd5hvxEipMRQhv1G/2KDw3sWA
Date:   Tue, 29 Nov 2016 18:43:15 +0000
Message-ID: <1480444993.3154.3.camel@intel.com>
References: <20161118230825.20952-1-jacob.e.keller@intel.com>
         <xmqq8tsgl5o4.fsf@gitster.mtv.corp.google.com>
         <CA+P7+xrQEBYQQhqJQQCpLrs+4WOJOvH1X27w5Ou=2VPT=FegGQ@mail.gmail.com>
         <xmqqwpfwkar2.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqwpfwkar2.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.3.116]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C0442389BB8444ABC5A6D67565A3A35@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gTW9uLCAyMDE2LTExLTIxIGF0IDA5OjIzIC0wODAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gSmFjb2IgS2VsbGVyIDxqYWNvYi5rZWxsZXJAZ21haWwuY29tPiB3cml0ZXM6DQo+IA0KPiA+
ID4gV2UgaGF2ZSAlcyBhbmQgJWIgc28gdGhhdCB3ZSBjYW4gcmVjb25zdHJ1Y3QgdGhlIHdob2xl
IHRoaW5nIGJ5DQo+ID4gPiB1c2luZyBib3RoLsKgwqBJdCBpcyB1bmNsZWFyIGhvdyAlYlQgZml0
cyBpbiB0aGlzIHBpY3R1cmUuwqDCoEkNCj4gPiA+IHdvbmRlcg0KPiA+ID4gaWYgd2UgYWxzbyBu
ZWVkIGFub3RoZXIgcGxhY2Vob2xkZXIgdGhhdCBleHBhbmRzIHRvIHRoZSBib2R5IG9mDQo+ID4g
PiB0aGUNCj4gPiA+IG1lc3NhZ2Ugd2l0aG91dCB0aGUgdHJhaWxlci0tLW90aGVyd2lzZSB0aGUg
d2hvbGUgc2V0IHdvdWxkDQo+ID4gPiBiZWNvbWUNCj4gPiA+IGluY29oZXJlbnQsIG5vPw0KPiA+
IA0KPiA+IEknbSBub3QgZW50aXJlbHkgc3VyZSB3aGF0IHRvIGRvIGhlcmUuIEkganVzdCB3YW50
ZWQgYSB3YXkgdG8NCj4gPiBlYXNpbHkNCj4gPiBmb3JtYXQgImp1c3QgdGhlIHRyYWlsZXJzIiBv
ZiBhIG1lc3NhZ2UuIFdlIGNvdWxkIGFkZCBzb21ldGhpbmcNCj4gPiB0aGF0DQo+ID4gZm9ybWF0
cyBqdXN0IHRoZSBub24tdHJhaWxlcnMsIHRoYXQncyBub3QgdG9vIGRpZmZpY3VsdC4gTm90IHJl
YWxseQ0KPiA+IHN1cmUgd2hhdCBJJ2QgY2FsbCBpdCB0aG91Z2guDQo+IA0KPiBJIHdhcyB3b25k
ZXJpbmcgaWYgJShsb2c6PG5hbWUgb2YgYSBwYXJ0Pikgd2FzIGEgYmV0dGVyIHdheSB0byBnby4N
Cj4gDQo+ICUobG9nOnRpdGxlKSBhbmQgJShsb2c6Ym9keSkgd291bGQgYmUgZXF1aXZhbGVudHMg
b2YgdHJhZGl0aW9uYWwgJXMNCj4gYW5kICViLCBhbmQgJShsb2c6Ym9keSkgaW4gdHVybiB3b3Vs
ZCBiZSBhIHNob3J0ZXIgd2F5IHRvIHdyaXRlDQo+ICUobG9nOmRlc2NyaXB0aW9uKSUrKGxvZzp0
cmFpbGVyKSwgaS5lLiBzaG93IHRoZSBtZXNzYWdlIGJvZHksIGFuZA0KPiBpZiB0aGVyZSBpcyBh
IHRyYWlsZXIgYmxvY2ssIGFkZCBpdCBhZnRlciBhZGRpbmcgYSBibGFuayBsaW5lLg0KPiANCj4g
T3Igc29tZXRoaW5nIGxpa2UgdGhhdD8NCg0KVGhhdCB3b3VsZCB3b3JrIGZvciBtZS4NCg0KVGhh
bmtzLA0KSmFrZQ==
