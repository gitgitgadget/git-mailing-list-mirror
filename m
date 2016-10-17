Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1C1C1F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 15:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933623AbcJQPMq (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 11:12:46 -0400
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:45634 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753104AbcJQPMp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 11:12:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id 56CC0100034;
        Mon, 17 Oct 2016 15:12:44 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 973S6i8Xbiz3; Mon, 17 Oct 2016 15:12:44 +0000 (GMT)
Received: from exmbdft5.ad.twosigma.com (exmbdft5.ad.twosigma.com [172.22.1.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id 4410180035;
        Mon, 17 Oct 2016 15:12:44 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft5.ad.twosigma.com (172.22.1.56) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Mon, 17 Oct 2016 15:12:43 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef]) by
 exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef%17]) with mapi id
 15.00.1156.000; Mon, 17 Oct 2016 15:12:43 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Duy Nguyen' <pclouds@gmail.com>
CC:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Uninitialized submodules as symlinks
Thread-Topic: Uninitialized submodules as symlinks
Thread-Index: AdIgxgX2aZUXw1O6SWms0VMYgKmgtQABm2GAAAG546AB4ffIgAALYhRg
Date:   Mon, 17 Oct 2016 15:12:43 +0000
Message-ID: <a1bad11df5c549a68d6fab1ade5a36b8@exmbdft7.ad.twosigma.com>
References: <fd5bcf57f92944c0b7f6f2f8342c342c@exmbdft7.ad.twosigma.com>
 <CAGZ79ka1rJCks5np9Q__HAHYFDrdGDFLtquhb3fY_iL8q9DEkw@mail.gmail.com>
 <f0c11de1bd4d414d8a9464e6ccc1d58a@exmbdft7.ad.twosigma.com>
 <CACsJy8BAB4sqnv1GBk=K9yUuqVhW4Y=CHdON7mnM9PY08HwdGw@mail.gmail.com>
In-Reply-To: <CACsJy8BAB4sqnv1GBk=K9yUuqVhW4Y=CHdON7mnM9PY08HwdGw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEdXkgTmd1eWVuIFttYWlsdG86
cGNsb3Vkc0BnbWFpbC5jb21dDQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAxNywgMjAxNiA1OjQ2
IEFNDQo+IFRvOiBEYXZpZCBUdXJuZXINCj4gQ2M6IFN0ZWZhbiBCZWxsZXI7IGdpdEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFVuaW5pdGlhbGl6ZWQgc3VibW9kdWxlcyBhcyBzeW1s
aW5rcw0KPiANCj4gT24gU2F0LCBPY3QgOCwgMjAxNiBhdCAyOjU5IEFNLCBEYXZpZCBUdXJuZXIg
PERhdmlkLlR1cm5lckB0d29zaWdtYS5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogU3RlZmFuIEJlbGxlciBbbWFpbHRv
OnNiZWxsZXJAZ29vZ2xlLmNvbV0NCj4gPj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDA3LCAyMDE2
IDI6NTYgUE0NCj4gPj4gVG86IERhdmlkIFR1cm5lcg0KPiA+PiBDYzogZ2l0QHZnZXIua2VybmVs
Lm9yZw0KPiA+PiBTdWJqZWN0OiBSZTogVW5pbml0aWFsaXplZCBzdWJtb2R1bGVzIGFzIHN5bWxp
bmtzDQo+ID4+DQo+ID4+IE9uIEZyaSwgT2N0IDcsIDIwMTYgYXQgMTE6MTcgQU0sIERhdmlkIFR1
cm5lcg0KPiA+PiA8RGF2aWQuVHVybmVyQHR3b3NpZ21hLmNvbT4NCj4gPj4gd3JvdGU6DQo+ID4+
ID4gUHJlc2VudGx5LCB1bmluaXRpYWxpemVkIHN1Ym1vZHVsZXMgYXJlIG1hdGVyaWFsaXplZCBp
biB0aGUgd29ya2luZw0KPiA+PiA+IHRyZWUgYXMgZW1wdHkgZGlyZWN0b3JpZXMuDQo+ID4+DQo+
ID4+IFJpZ2h0LCB0aGVyZSBoYXMgdG8gYmUgc29tZXRoaW5nLCB0byBoaW50IGF0IHRoZSB1c2Vy
IHRoYXQgY3JlYXRpbmcgYQ0KPiA+PiBmaWxlIHdpdGggdGhhdCBwYXRoIGlzIHByb2JhYmx5IG5v
dCB3aGF0IHRoZXkgd2FudC4NCj4gPj4NCj4gPj4gPiAgV2Ugd291bGQgbGlrZSB0byBjb25zaWRl
ciBoYXZpbmcgdGhlbSBiZSBzeW1saW5rcy4gIFNwZWNpZmljYWxseSwNCj4gPj4gPiB3ZSdkIGxp
a2UgdGhlbSB0byBiZSBzeW1saW5rcyBpbnRvIGEgRlVTRSBmaWxlc3lzdGVtIHdoaWNoDQo+ID4+
ID4gcmV0cmlldmVzIGZpbGVzIG9uIGRlbWFuZC4NCj4gPj4gPg0KPiA+PiA+IFdlJ3ZlIGFjdHVh
bGx5IGFscmVhZHkgZ290IGEgRlVTRSBmaWxlc3lzdGVtIHdyaXR0ZW4sIGJ1dCB3ZSB1c2UgYQ0K
PiA+PiA+IGRpZmZlcmVudCAoc2VtaS1tYW51YWwpIG1lYW5zIHRvIGNvbm5lY3QgaXQgdG8gdGhl
IGluaXRpYWxpemVkDQo+IHN1Ym1vZHVsZXMuDQo+ID4+DQo+ID4+IFNvIHlvdSBjdXJyZW50bHkg
ZG8gYQ0KPiA+Pg0KPiA+PiAgICAgZ2l0IHN1Ym1vZHVsZSBpbml0IDxwYXRoc3BlYz4NCj4gPj4g
ICAgIGN1c3RvbS1zdWJtb2R1bGUgbWFrZS1zeW1saW5rIDxwYXRoc3BlYz4NCj4gPj4NCj4gPj4g
Pw0KPiA+DQo+ID4gV2UgZG8gc29tZXRoaW5nIGxpa2UNCj4gPg0KPiA+IEZvciBlYWNoIGluaXRp
YWxpemVkIHN1Ym1vZHVsZTogc3ltbGluayBpdCBpbnRvIHRoZSByaWdodCBwbGFjZSBpbg0KPiA+
IC4uLi9zb21lZGlyIEZvciBlYWNoIHVuaW5pdGlhbGl6ZWQgc3VibW9kdWxlOiBzeW1saW5rIGZy
b20gdGhlIEZVU0UNCj4gPiBpbnRvIHRoZSByaWdodCBwbGFjZSBpbiAuLi4vc29tZWRpcg0KPiA+
DQo+ID4gU28gLi4uL3NvbWVkaXIgaGFzIHRoZSBzdHJ1Y3R1cmUgb2YgdGhlIGdpdCBtYWluIHJl
cG8sIGJ1dCBpcyBhbGwNCj4gc3ltbGlua3MgLS0gc29tZSBpbnRvIEZVU0UsIHNvbWUgaW50byB0
aGUgZ2l0IHJlcG8uDQo+ID4NCj4gPiBUaGlzIG1lYW5zIHRoYXQgd2hlbiB3ZSBpbml0aWFsaXpl
IChvciBkZWluaXRpYWxpemUpIGEgc3VibW9kdWxlLCB3ZQ0KPiBuZWVkIHRvIHJlLXJ1biB0aGUg
bGlua2luZyBzY3JpcHQuDQo+IA0KPiBEbyAuZ2l0IGZpbGVzIHdvcms/IElmIC5naXQgZmlsZXMg
cG9pbnQgdG8gc29tZXdoZXJlIGluIGZ1c2UsIEkgZ3Vlc3MgeW91DQo+IHN0aWxsIGhhdmUgZmls
ZSByZXRyaWV2YWwgb24gZGVtYW5kLiBJdCBkZXBlbmRzIG9uIHdoYXQgZmlsZXMgdG8gcmV0cmll
dmUNCj4gSSBndWVzcy4gSWYgeW91IHdhbnQgd29ya3RyZWUgZmlsZXMsIG5vdCBvYmplY3QgZGF0
YWJhc2UgdGhlbiAuZ2l0IGZpbGVzDQo+IHdvbid0IHdvcmsgYmVjYXVzZSB3b3JrdHJlZSByZW1h
aW5zIGluIHRoZSBzYW1lIGZpbGVzeXN0ZW0gYXMgdGhlIHN1cGVyDQo+IHJlcG8uDQoNClllcywg
d2Ugd2FudCB3b3JrdHJlZSBmaWxlcyAob3IgZXZlbiB3b3JrdHJlZSBmaWxlcyArIGJ1aWx0IGFy
dGlmYWN0cykuDQo=
