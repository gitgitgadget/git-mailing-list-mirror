Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40238200B9
	for <e@80x24.org>; Mon,  7 May 2018 14:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752376AbeEGOX1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 10:23:27 -0400
Received: from ironport.klsmartin.com ([212.211.191.11]:57351 "EHLO
        ironport.klsmartin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeEGOX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 10:23:26 -0400
X-IronPort-AV: E=Sophos;i="5.49,374,1520895600"; 
   d="scan'208";a="16251679"
Received: from unknown (HELO hera.klsmartin.com) ([172.30.5.66])
  by ironport.klsmartin.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 May 2018 16:23:21 +0200
Received: from SUMMAIL01.UMK.KLS.zentral ([172.25.1.63])
        by hera.klsmartin.com (8.14.3/8.13.1/SuSE Linux 0.7) with ESMTP id w47ENIH1015865;
        Mon, 7 May 2018 16:23:20 +0200
Received: from SUMMBX01.UMK.KLS.zentral ([172.25.1.64]) by
 SUMMAIL01.UMK.KLS.zentral ([172.25.1.63]) with mapi id 14.03.0351.000; Mon, 7
 May 2018 16:23:18 +0200
From:   "Middelschulte, Leif" <Leif.Middelschulte@klsmartin.com>
To:     "newren@gmail.com" <newren@gmail.com>,
        "hvoigt@hvoigt.net" <hvoigt@hvoigt.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller@google.com" <sbeller@google.com>,
        "jacob.keller@gmail.com" <jacob.keller@gmail.com>
Subject: Re: git merge banch w/ different submodule revision
Thread-Topic: git merge banch w/ different submodule revision
Thread-Index: AQHT3UxIUeHy1QVy7UGFBG3KFIVVC6QTM84AgABAJgCAAAk9AIAF8LqAgAKD5oCAAi1+AIABCJ2AgAAekACAAEnKAIAEsXYA
Date:   Mon, 7 May 2018 14:23:16 +0000
Message-ID: <1525702992.2177.3.camel@klsmartin.com>
References: <1524739599.20251.17.camel@klsmartin.com>
         <CAGZ79kZA_R-5bA6mPdoHkVW-C21pNn_0x6FayhuuXqnOTrmjWw@mail.gmail.com>
         <CA+P7+xrUwq0G2YySC3SLKqyihhPnFPCiQnQpoVVa89+=W9O9+w@mail.gmail.com>
         <CAGZ79kaub2k-q-Mcj3H5o6ekyZ8ZZzG7+r5sHt5Ne25Nc3_nPQ@mail.gmail.com>
         <20180430170229.GA775@book.hvoigt.net>
         <1525246025.2176.12.camel@klsmartin.com>
         <20180503164226.GB23564@book.hvoigt.net>
         <1525422571.2175.52.camel@klsmartin.com>
         <20180504101854.GA29828@book.hvoigt.net>
         <CABPp-BGaibCPWuCnaX5Af=sv-2zvyhNcupT+-PkxHDfJBg_Vbw@mail.gmail.com>
In-Reply-To: <CABPp-BGaibCPWuCnaX5Af=sv-2zvyhNcupT+-PkxHDfJBg_Vbw@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.2.97]
x-kse-serverinfo: SUMMAIL01.UMK.KLS.zentral, 9
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 07.05.2018 12:25:00
Content-Type: text/plain; charset="utf-8"
Content-ID: <3702532D68872549A1D7DD8FCFAE1C2A@klsmartin.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGksDQoNCkFtIEZyZWl0YWcsIGRlbiAwNC4wNS4yMDE4LCAwNzo0MyAtMDcwMCBzY2hyaWViIEVs
aWphaCBOZXdyZW46DQo+IE9uIEZyaSwgTWF5IDQsIDIwMTggYXQgMzoxOCBBTSwgSGVpa28gVm9p
Z3QgPGh2b2lndEBodm9pZ3QubmV0PiB3cm90ZToNCj4gPiBIaSwNCj4gPiANCj4gPiBPbiBGcmks
IE1heSAwNCwgMjAxOCBhdCAwODoyOTozMkFNICswMDAwLCBNaWRkZWxzY2h1bHRlLCBMZWlmIHdy
b3RlOg0KPiA+ID4gQW0gRG9ubmVyc3RhZywgZGVuIDAzLjA1LjIwMTgsIDE4OjQyICswMjAwIHNj
aHJpZWIgSGVpa28gVm9pZ3Q6DQo+IA0KPiA8c25pcD4NCj4gPiA+ID4gSXQgc2VlbXMgdG8gbWUg
dGhhdCB5b3UgZG8gbm90IHdhbnQgdG8gbWl4IGludGVncmF0aW9uIHRlc3RpbmcgYW5kDQo+ID4g
PiA+IHRlc3Rpbmcgb2YgdGhlIGZlYXR1cmUgaXRzZWxmLg0KPiA+ID4gDQo+ID4gPiBUaGF0J3Mg
b24gcG9pbnQuIFRoYXQncyB3aHkgaXQgd291bGQgYmUgbmljZSBpZiBnaXQgKmF0IGxlYXN0KiB3
YXJuZWQNCj4gPiA+IGFib3V0IHRoZSBkaWZmZXJlbnQgcmV2aXNpb25zIHdydCBzdWJtb2R1bGVz
Lg0KPiANCj4gVGhlcmUncyBhIGdvb2QgcG9pbnQgaGVyZS4uLg0KPiANCj4gPiBXZWxsIGEgc3Vi
bW9kdWxlIHZlcnNpb24gaXMgcGlubmVkIGRvd24gYXMgbG9uZyBhIHlvdSBkbyBub3QgY2hhbmdl
IGl0DQo+ID4gYW5kIGNvbW1pdCBpdC4gVGhlIHNhbWUgYXMgZmlsZXMgYW5kIHRoZSBnb2FsIGlz
IHRvIG1ha2Ugc3VibW9kdWxlcw0KPiA+IGJlaGF2ZSBhcyBjbG9zZSB0byBub3JtYWwgZmlsZXMg
YXMgcG9zc2libGUuIEFuZCBnaXQgIndhcm5zIiBhYm91dA0KPiA+IGNoYW5nZWQgc3VibW9kdWxl
cyBieSBkaXNwbGF5aW5nIHRoZW0gaW4gdGhlIGRpZmYuDQo+IA0KPiBBY3R1YWxseSwgc3VibW9k
dWxlcyBkbyBiZWhhdmUgZGlmZmVyZW50bHkgdGhhbiBub3JtYWwgZmlsZXMgaW4gYW4NCj4gaW1w
b3J0YW50IHdheSwgd2hpY2ggd2UgbWF5IGJlIGFibGUgdG8gZml4IGFuZCBtYXkgaGVscCBMZWlm
IGhlcmU6DQo+IA0KPiBXaGVuIG1lcmdpbmcgdHdvIHJlZ3VsYXIgZmlsZXMgdGhhdCBoYXZlIGJl
ZW4gbW9kaWZpZWQgb24gYm90aCBzaWRlcw0KPiBvZiBoaXN0b3J5LCBnaXQgYWx3YXlzIHByaW50
cyBhIG1lc3NhZ2UsICJBdXRvLW1lcmdpbmcgJEZJTEUiLiAgV2UNCj4gY291bGQgb21pdCB0aGF0
IGFuZCBkZXBlbmQgb24gdGhlIHVzZXIgdG8gY2hlY2sgdGhlIGRpZmZzdGF0IG9yIHJ1bg0KPiBk
aWZmIGFmdGVyd2FyZHMgb3Igc29tZXRoaW5nLCBidXQgd2UgZG9uJ3QganVzdCByZWx5IG9uIHRo
YXQ7IHdlIGFsc28NCj4gd2FybiB0aGVtIHdpdGggYSBzaW1wbGUgbWVzc2FnZSB0aGF0IHdlIGFy
ZSBkb2luZyBzb21ldGhpbmcgdG8gcmVzb2x2ZQ0KPiB0aGlzIGJvdGgtc2lkZXMtY2hhbmdlZC10
aGlzLXBhdGggKG5hbWVseSBlbXBsb3lpbmcgdGhlIHdlbGwga25vd24NCj4gdGhyZWUtd2F5LWZp
bGUtbWVyZ2UgYWxnb3JpdGhtIHRvIGNvbWUgdXAgd2l0aCBzb21ldGhpbmcpLg0KPiANCj4gSW5z
aWRlIG1lcmdlX3N1Ym1vZHVsZSgpLCB0aGUgZXF1aXZhbGVudCB3b3VsZCBiZSBwcmludGluZyBh
IG1lc3NhZ2UNCj4gd2hlbmV2ZXIgd2UgZGVjaWRlIHRoYXQgb25lIGJyYW5jaCBpcyBhIGZhc3Qt
Zm9yd2FyZCBvZiB0aGUgb3RoZXINCj4gKCJDYXNlICMxIiwgYXMgaXQncyBjYWxsZWQgaW4gdGhl
IGNvZGUpLCB5ZXQgY3VycmVudGx5IGl0IHByaW50cw0KPiBub3RoaW5nLiAgUGVyaGFwcyBpdCBz
aG91bGQuDQo+IA0KPiANCj4gTGVpZiwgd291bGQgeW91IGxpa2UgdG8gdHJ5IHlvdXIgaGFuZCBh
dCBjcmVhdGluZyBhIHBhdGNoIGZvciB0aGlzPw0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2sgYW5k
IHRoZSBhZHZpY2UvZGlyZWN0aW9uLg0KDQpJJ2xsIHRyeSB0byB3b3JrIG9uIGl0IHRoaXMgd2Vl
ayBhbmQgc2VuZCBwYXRjaGVzIHRvIHRoZSBNTCBmb3IgcmV2aWV3Lg0KDQpDaGVlcnMsDQoNCkxl
aWY=
