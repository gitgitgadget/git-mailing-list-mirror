Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEF491F42E
	for <e@80x24.org>; Fri,  4 May 2018 08:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbeEDI3p (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 04:29:45 -0400
Received: from ironport.klsmartin.com ([212.211.191.11]:50792 "EHLO
        ironport.klsmartin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbeEDI3o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 04:29:44 -0400
X-IronPort-AV: E=Sophos;i="5.49,361,1520895600"; 
   d="scan'208";a="16216763"
Received: from unknown (HELO ares.klsmartin.com) ([172.30.5.65])
  by ironport.klsmartin.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 May 2018 10:29:38 +0200
Received: from SUMMAIL01.UMK.KLS.zentral ([172.25.1.63])
        by ares.klsmartin.com (8.14.3/8.13.1/SuSE Linux 0.7) with ESMTP id w448TXPD004326;
        Fri, 4 May 2018 10:29:37 +0200
Received: from SUMMBX01.UMK.KLS.zentral ([172.25.1.64]) by
 SUMMAIL01.UMK.KLS.zentral ([172.25.1.63]) with mapi id 14.03.0351.000; Fri, 4
 May 2018 10:29:33 +0200
From:   "Middelschulte, Leif" <Leif.Middelschulte@klsmartin.com>
To:     "hvoigt@hvoigt.net" <hvoigt@hvoigt.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller@google.com" <sbeller@google.com>,
        "jacob.keller@gmail.com" <jacob.keller@gmail.com>
Subject: Re: git merge banch w/ different submodule revision
Thread-Topic: git merge banch w/ different submodule revision
Thread-Index: AQHT3UxIUeHy1QVy7UGFBG3KFIVVC6QTM84AgABAJgCAAAk9AIAF8LqAgAKD5oCAAi1+AIABCJ2A
Date:   Fri, 4 May 2018 08:29:32 +0000
Message-ID: <1525422571.2175.52.camel@klsmartin.com>
References: <1524739599.20251.17.camel@klsmartin.com>
         <CAGZ79kZA_R-5bA6mPdoHkVW-C21pNn_0x6FayhuuXqnOTrmjWw@mail.gmail.com>
         <CA+P7+xrUwq0G2YySC3SLKqyihhPnFPCiQnQpoVVa89+=W9O9+w@mail.gmail.com>
         <CAGZ79kaub2k-q-Mcj3H5o6ekyZ8ZZzG7+r5sHt5Ne25Nc3_nPQ@mail.gmail.com>
         <20180430170229.GA775@book.hvoigt.net>
         <1525246025.2176.12.camel@klsmartin.com>
         <20180503164226.GB23564@book.hvoigt.net>
In-Reply-To: <20180503164226.GB23564@book.hvoigt.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.2.97]
x-kse-serverinfo: SUMMAIL01.UMK.KLS.zentral, 9
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 04.05.2018 05:11:00
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DBC47240499B94B9197E6DD6DCD3E18@klsmartin.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGksDQpBbSBEb25uZXJzdGFnLCBkZW4gMDMuMDUuMjAxOCwgMTg6NDIgKzAyMDAgc2NocmllYiBI
ZWlrbyBWb2lndDoNCj4gSGksDQo+IA0KPiBPbiBXZWQsIE1heSAwMiwgMjAxOCBhdCAwNzozMDoy
NUFNICswMDAwLCBNaWRkZWxzY2h1bHRlLCBMZWlmIHdyb3RlOg0KPiA+IEFtIE1vbnRhZywgZGVu
IDMwLjA0LjIwMTgsIDE5OjAyICswMjAwIHNjaHJpZWIgSGVpa28gVm9pZ3Q6DQo+ID4gPiBPbiBU
aHUsIEFwciAyNiwgMjAxOCBhdCAwMzoxOTozNlBNIC0wNzAwLCBTdGVmYW4gQmVsbGVyIHdyb3Rl
Og0KPiA+ID4gPiBTdGVmYW4gd3JvdGU6DQo+ID4gPiA+ID4gU2VlIGh0dHBzOi8vZ2l0aHViLmNv
bS9naXQvZ2l0L2NvbW1pdC82OGQwM2U0YTZlNDQ4YWE1NTdmNTJhZGVmOTI1OTVhYzRkNmNkNGJk
DQo+ID4gPiA+ID4gKDY4ZDAzZTRhNmUgKEltcGxlbWVudCBhdXRvbWF0aWMgZmFzdC1mb3J3YXJk
IG1lcmdlIGZvciBzdWJtb2R1bGVzLCAyMDEwLTA3LTA3KQ0KPiA+ID4gPiA+IHRvIGV4cGxhaW4g
dGhlIHNpdHVhdGlvbiB5b3UgZW5jb3VudGVyLiAoc3BlY2lmaWNhbGx5IG1lcmdlX3N1Ym1vZHVs
ZQ0KPiA+ID4gPiA+IGF0IHRoZSBlbmQgb2YgdGhlIGRpZmYpDQo+ID4gPiA+IA0KPiA+ID4gPiAr
Y2MgSGVpa28sIGF1dGhvciBvZiB0aGF0IGNvbW1pdC4NCj4gPiA+IA0KPiA+ID4gSW4gdGhhdCBj
b21taXQgd2UgdHJpZWQgdG8gYmUgdmVyeSBjYXJlZnVsIGFib3V0LiBJIGRvIG5vdCB1bmRlcnN0
YW5kDQo+ID4gPiB0aGUgc2l0dWF0aW9uIGluIHdoaWNoIHRoZSBjdXJyZW50IHN0cmF0ZWd5IHdv
dWxkIGJlIHdyb25nIGJ5IGRlZmF1bHQuDQo+ID4gPiANCj4gPiA+IFdlIG9ubHkgbWVyZ2UgaWYg
dGhlIGZvbGxvd2luZyBhcHBsaWVzOg0KPiA+ID4gDQo+ID4gPiAgKiBUaGUgY2hhbmdlcyBpbiB0
aGUgc3VwZXJwcm9qZWN0IG9uIGJvdGggc2lkZXMgcG9pbnQgZm9yd2FyZCBpbiB0aGUNCj4gPiA+
ICAgIHN1Ym1vZHVsZS4NCj4gPiA+IA0KPiA+ID4gICogT25lIHNpZGUgaXMgY29udGFpbmVkIGlu
IHRoZSBvdGhlci4gQ29udGFpbmVkIGZyb20gdGhlIHN1Ym1vZHVsZQ0KPiA+ID4gICAgcGVyc3Bl
Y3RpdmUuIFNpZGVzIGZyb20gdGhlIHN1cGVycHJvamVjdCBtZXJnZSBwZXJzcGVjdGl2ZS4NCj4g
PiA+IA0KPiA+ID4gU28gaW4gY2FzZSBvZiB0aGUgbWVudGlvbmVkIHJld2luZCBvZiBhIHN1Ym1v
ZHVsZTogT25seSBvbmUgc2lkZSBvZiB0aGUNCj4gPiA+IDMtd2F5IG1lcmdlIHdvdWxkIHBvaW50
IGZvcndhcmQgYW5kIHRoZSBtZXJnZSB3b3VsZCBmYWlsLg0KPiA+ID4gDQo+ID4gPiBJIGNhbiBp
bWFnaW5lLCB0aGF0IGluIGNhc2Ugb2YgYSB0ZW1wb3JhcnkgcmV2ZXJ0IG9mIGEgY29tbWl0IGlu
IHRoZQ0KPiA+ID4gc3VibW9kdWxlIHRoYXQgeW91IHdvdWxkIG5vdCB3YW50IHRoYXQgbWVyZ2Vk
IGludG8gc29tZSBvdGhlciBicmFuY2guDQo+ID4gPiBCdXQgdGhhdCB3b3VsZCBiZSB0aGUgc2Ft
ZSB3aXRob3V0IHN1Ym1vZHVsZXMuIElmIHlvdSBtZXJnZSBhIHRlbXBvcmFyeQ0KPiA+ID4gcmV2
ZXJ0IGZyb20gYW5vdGhlciBicmFuY2ggeW91IHdpbGwgbm90IGdldCBhbnkgY29uZmxpY3QuDQo+
ID4gPiANCj4gPiA+IFNvIG1heWJlIHNvbWVvbmUgY2FuIGV4cGxhaW4gdGhlIHVzZSBjYXNlIGlu
IHdoaWNoIG9uZSB3b3VsZCBnZXQgdGhlDQo+ID4gPiByZXN1bHRzIHRoYXQgc2VlbSB3cm9uZz8N
Cj4gPiANCj4gPiBJbiBhbiBpZGVhbCB3b3JsZCwgd2hlcmUgdGhlcmUgYXJlIG5vIHJlZ3Jlc3Np
b25zIGJldHdlZW4gcmV2aXNpb25zLCBhDQo+ID4gZmFzdC1mb3J3YXJkIGlzIGFwcHJvcHJpYXRl
LiBIb3dldmVyLCB3ZSBtaWdodCBoYXZlIHJlZ3Jlc3Npb25zIHdpdGhpbg0KPiA+IHN1Ym1vZHVs
ZXMuDQo+ID4gDQo+ID4gU28gdGhlIHVzZWNhc2UgaXMgdGhlIGZvbGxvd2luZzoNCj4gPiANCj4g
PiBFbnZpcm9ubWVudDoNCj4gPiAtIFdlIGhhdmUgYSBiYXNlIGxpYnJhcnkgTCB0aGF0IGlzIGRl
dmVsb3BlZCBieSBzb21lIHRlYW0gKFRlYW0gQikuDQo+ID4gLSBBbm90aGVyIHRlYW0gKFRlYW0g
QSkgZGV2ZWxvcGVzIGEgcHJvZHVjdCBQIGJhc2VkIG9uIHRob3NlIGxpYnJhcmllcyB1c2luZyBn
aXQtZmxvdy4NCj4gPiANCj4gPiBDYXNlOg0KPiA+IFRoZSBwcm9ibGVtIG9jY3Vycywgd2hlbiBh
IGRldmVsb3BlciAoRCkgb2YgVGVhbSBBIHRyaWVzIHRvIGhhdmUgYSBmZWF0dXJlDQo+ID4gdGhh
dCBoZSBkZXZlbG9wZWQgb24gYSBicmFuY2ggYWNjZXB0ZWQgYnkgYSBjb3JlIGRldmVsb3BlciBv
ZiBQOg0KPiA+IElmIGEgY29yZSBkZXZlbG9wZXIgb2YgUCBhZHZhbmNlZCB0aGUgcmVmZXJlbmNl
IG9mIEwgd2l0aGluIFAgKGxpbmVhciBoaXN0b3J5KSwgaGUgbWlnaHQNCj4gPiBkZWVtIHRoZSB3
b3JrIEQgaW5zdWZmaWNpZW50LiBOb3QgYmVjYXVzZSBvZiB0aGUgYWN0dWFsIHdvcmsgYnkgRCwg
YnV0IHJlZ3Jlc3Npb25zDQo+ID4gdGhhdCBzbnVjayBpbnRvIEwuIFRoZSBjb3JlIGRldmVsb3Bl
ciB3aWxsIG5vdCBiZSBpbmZvcm1lZCBhYm91dCB0aGUgbWlzc21hdGNoaW5nDQo+ID4gcmV2aXNp
b25zIG9mIEwuDQo+ID4gDQo+ID4gU28gaXQgd291bGQgYmUgbmljZSBpZiB0aGVyZSB3YXMgc29t
ZSBraW5kIG9mIHN3aXRjaCBvciBhdCBsZWFzdCBzb21lIHRyaWdnZXIuDQo+IA0KPiBJIHN0aWxs
IGRvIG5vdCB1bmRlcnN0YW5kIGhvdyB0aGUgY3VycmVudCBiZWhhdmlvdXIgaXMgbWlzbWF0Y2hp
bmcgd2l0aA0KPiB1c2VycyBleHBlY3RhdGlvbnMuIExldCdzIGFzc3VtZSB0aGF0IHlvdSBkaXJl
Y3RseSB0cmFja2VkIHRoZSBmaWxlcyBvZg0KPiBMIGluIHlvdXIgcHJvZHVjdCByZXBvc2l0b3J5
IFAsIHdpdGhvdXQgYW55IHN1Ym1vZHVsZSBib3VuZGFyeS4gSG93DQo+IHdvdWxkIHRoZSBiZWhh
dmlvciBiZSBkaWZmZXJlbnQ/IFdvdWxkIGl0IGJlPyBJZiBEIHN0YXJ0ZWQgb24gYW4gb2xkZXIN
Cj4gcmV2aXNpb24gYW5kIGdldHMgbWVyZ2VkIGludG8gYSBuZXdlciByZXZpc2lvbiwgdGhlcmUg
Y2FuIGFsd2F5cyBiZQ0KPiByZWdyZXNzaW9ucyBldmVuIHdpdGhvdXQgc3VibW9kdWxlcy4NCj4g
DQo+IFdoeSB3b3VsZCB0aGUgY29yZSBkZXZlbG9wZXIgbmVlZCB0byBiZSBpbmZvcm1lZCBhYm91
dCBtaXNtYXRjaGluZw0KPiByZXZpc2lvbnMgaWYgaGUgaGltc2VsZiBhZHZhbmNlZCB0aGUgc3Vi
bW9kdWxlPw0KSW4gdGhhdCBjYXNlIHlvdSdkIGJlIHJpZ2h0LiBJIHNob3VsZCBoYXZlIHBpY2tl
ZCBteSBleGFtcGxlIG1vcmUgd2lzZWx5Lg0KQXNzdW1lIHJpZ2h0IGhlcmUgdGhhdCBub3QgYSBj
b3JlIGRldmVsb3BlciwgYnV0IGFub3RoZXIgZGV2ZWxvcGVyIGFkdmFuY2VkDQp0aGUgc3VibW9k
dWxlIChhbHNvIHZpYSBmZWF0dXJlIGJyYW5jaCArIG1lcmdlKS4NCj4gDQo+IEl0IHNlZW1zIHRv
IG1lIHRoYXQgeW91IGRvIG5vdCB3YW50IHRvIG1peCBpbnRlZ3JhdGlvbiB0ZXN0aW5nIGFuZA0K
PiB0ZXN0aW5nIG9mIHRoZSBmZWF0dXJlIGl0c2VsZi4gDQpUaGF0J3Mgb24gcG9pbnQuIFRoYXQn
cyB3aHkgaXQgd291bGQgYmUgbmljZSBpZiBnaXQgKmF0IGxlYXN0KiB3YXJuZWQgYWJvdXQgdGhl
IGRpZmZlcmVudCByZXZpc2lvbnMgd3J0IHN1Ym1vZHVsZXMuDQoNCkJ1dCwgSSBndWVzcywgSSBs
ZWFybmVkIHNvbWV0aGluZyBhYm91dCBzdWJtb2R1bGVzOg0KSSB1c2VkIHRvIHRoaW5rIG9mIHN1
Ym1vZHVsZXMgYXMgbWVhbnMgdG8gcGluIGRvd24gYSBzcGVjaWZpYyByZXZpc2lvbiBsaWtlOiBg
dmVyID09IHhgLg0KTm93IEknbSBsZWFybmluZyB0aGF0IHN1Ym1vZHVsZXMgYXJlIHRyZWF0ZWQg
YXMgYHZlciA+PSB4YCBkdXJpbmcgYSBtZXJnZS4NCg0KPiBIb3cgYWJvdXQganVzdCB0ZXN0aW5n
L3Jldmlld2luZyBvbiB0aGUNCj4gYnJhbmNoIHRoZW4/IFlvdSB3b3VsZCBzdGlsbCBnZXQgdGhl
IHN1Ym1vZHVsZSByZXZpc2lvbiBEIHdhcyB3b3JraW5nIG9uDQo+IGFuZCB0aGVuIGluIGEgbGF0
ZXIgc3RhZ2UgY2hlY2sgaWYgaW50ZWdyYXRpb24gd2l0aCBldmVyeXRoaW5nIGVsc2UNCj4gd29y
a3MuDQpTdXJlLiBCdXQgaWYgdGhlIGJlaGF2aW9yIGRldmlhdGVzIGFmdGVyIGEgbWVyZ2UgdGhl
IG1lcmdpbmcgZGV2ZWxvcGVyIGlzIGN1cnJlbnRseSBub3QNCmF3YXJlIHRoYXQgaXQgKm1pZ2h0
KiBoYXZlIHRvIGRvIHdpdGggZGlmZmVyZW50IHN1Ym1vZHVsZSByZXZpc2lvbnMgdXNlZCwgbm90
IHRoZSAiYWN0dWFsIiBjb2RlIG1lcmdlZC4NCg0KTGlrZSBub3QgZXZlbiAiYmV3YXJlOiB0aGUg
KGZlYXR1cmUpIGJyYW5jaCB5b3UndmUgbWVyZ2VkIHVzZWQgYW4gJ29sZGVyJyByZXZpc2lvbiBv
ZiBYIg0KDQo+IA0KPiBDaGVlcnMgSGVpa28NCg0KQ2hlZXJzLA0KDQpMZWlm
