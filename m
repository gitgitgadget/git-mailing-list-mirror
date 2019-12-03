Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0B3C432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 09:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5AC206EC
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 09:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfLCJZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:25:53 -0500
Received: from cnshjsmin03.alcatel-sbell.com.cn ([116.246.26.71]:59195 "EHLO
        cnshjsmin03.nokia-sbell.com" rhost-flags-OK-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbfLCJZw (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 3 Dec 2019 04:25:52 -0500
X-AuditID: ac189297-57fff7000000639c-dc-5de62a0ab90a
Received: from CNSHPPEXCH1610.nsn-intra.net (Unknown_Domain [135.251.51.110])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by cnshjsmin03.nokia-sbell.com (Symantec Messaging Gateway) with SMTP id D9.5E.25500.A0A26ED5; Tue,  3 Dec 2019 17:25:30 +0800 (HKT)
Received: from CNSHPPEXCH1610.nsn-intra.net (135.251.51.110) by
 CNSHPPEXCH1610.nsn-intra.net (135.251.51.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 3 Dec 2019 17:25:30 +0800
Received: from CNSHPPEXCH1610.nsn-intra.net ([135.251.51.110]) by
 CNSHPPEXCH1610.nsn-intra.net ([135.251.51.110]) with mapi id 15.01.1713.007;
 Tue, 3 Dec 2019 17:25:30 +0800
From:   "Lou, Pengfei (NSB - CN/Hangzhou)" <pengfei.lou@nokia-sbell.com>
To:     Bryan Turner <bturner@atlassian.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: one bug on git
Thread-Topic: one bug on git
Thread-Index: AdWpqKh+Y3gz8IRUTs2wD1ZmDLyXiAACqzigAAAZwpD//4F1AP//d3wQgACPqoD//3ka0A==
Date:   Tue, 3 Dec 2019 09:25:30 +0000
Message-ID: <0b2bd41ca3b34369ba0504e3bd7254ae@nokia-sbell.com>
References: <defeb7be75f54e8483ce529b2571478d@nokia-sbell.com>
 <5e27e2a9f6374742859b4b87d85c56e9@nokia-sbell.com>
 <1af00173f96243bea760baaddeb15777@nokia-sbell.com>
 <CAGyf7-FW_8RjVPEtmKiNFnF5QNZ4f+kqZ_BAGnGu76QcR=F25Q@mail.gmail.com>
 <a755356230794fb58bdd48dd74714aee@nokia-sbell.com>
 <CAGyf7-Fn-XRQhGCLdr+WxBAWKywQH2_s8XCsNUG7Vpgyu2jjUg@mail.gmail.com>
In-Reply-To: <CAGyf7-Fn-XRQhGCLdr+WxBAWKywQH2_s8XCsNUG7Vpgyu2jjUg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [135.251.51.115]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42Jp/22cp8ul9SzW4O0GK4sfl2Qtuq50Mzkw
        eXw88oDV4/MmuQCmKC6blNSczLLUIn27BK6MfYuvsRc8kKmYePoHcwNjg0wXIyeHhICJxNl3
        01m7GLk4hAQOMUnMuHWHDcL5wyixemU7E4SzkVHi7OpfrCAtbAJuEvv/9jKD2CICGhKfb99g
        BLGZBfQlPv05wARiCwtIS/T+3cwOUSMjsffQPhYIO0yi79UlsDiLgIrEspN7weK8AnYSN/6t
        YIFY9ppJ4uCrG0AOBwenQKDEslVxIDWMAmIS30+tYYLYJS5x68l8JogXBCSW7DnPDGGLSrx8
        /I8VpFVCQEmibwMTiMksoCmxfpc+RKeixJTuh+wQWwUlTs58wjKBUWwWkqGzEDpmIemYhaRj
        ASPLKkbp5LzijKzi3Mw8A2O9vPzszETd4qTUnBy95PzcTYzAKFojMWn6DsZjB7wPMQpwMCrx
        8Gb8ehIrxJpYVlyZe4hRgoNZSYR3m8TTWCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8LZMXxgoJ
        pCeWpGanphakFsFkmTg4pRoY99RdrnDiENS7rKEid7aCeXFDVN7eF+EMm3a0feGIm/vu4tKO
        7LVajMtN11uyzPRbxDWl5s3URZ9sTkR8mO389JRP7oTLzMe5uD5bCPh+mhEVzzqr5ttTDZZp
        m5b7WeWnFYmtuRmiay5gbTh32mWWY+Wv/E46sq1Qr50rNfX1Q88bJXbV154qKbEUZyQaajEX
        FScCAOkmPbWeAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSB0aGluayBpdCBzaG91bGQgYmUgbGlrZSBiZWxvdw0KW3BlbG91QGh6bGluZzI5IHRyeV9kZXNd
JCBnaXQgbG9nIC0tcmF3IC0xIC0tbm8td2Fsaz11bnNvcnRlZCA1N2NmNTZiOGMxYWY5MTE1YTdm
OGUxYzFjOGYwN2U0ZDY1N2U4YjE1XiA1N2NmNTZiOGMxYWY5MTE1YTdmOGUxYzFjOGYwN2U0ZDY1
N2U4YjE1DQpjb21taXQgNTdjZjU2YjhjMWFmOTExNWE3ZjhlMWMxYzhmMDdlNGQ2NTdlOGIxNQ0K
QXV0aG9yOiBwZWxvdSA8cGVuZ2ZlaS5sb3VAbm9raWEtc2JlbGwuY29tPg0KRGF0ZTogICBUdWUg
RGVjIDMgMTc6MDA6NDcgMjAxOSArMDgwMA0KDQogICAgMw0KDQo6MTAwNjQ0IDEwMDY0NCA5YTc0
NTZiLi4uIDgxNDhlZjcuLi4gTSAgbHBmDQoNCkJyLCBIZXJjdWxlcw0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IEJyeWFuIFR1cm5lciA8YnR1cm5lckBhdGxhc3NpYW4uY29tPiAN
ClNlbnQ6IDIwMTnlubQxMuaciDPml6UgMTc6MjINClRvOiBMb3UsIFBlbmdmZWkgKE5TQiAtIENO
L0hhbmd6aG91KSA8cGVuZ2ZlaS5sb3VAbm9raWEtc2JlbGwuY29tPg0KQ2M6IGdpdEB2Z2VyLmtl
cm5lbC5vcmcNClN1YmplY3Q6IFJlOiBvbmUgYnVnIG9uIGdpdA0KDQpPbiBUdWUsIERlYyAzLCAy
MDE5IGF0IDE6MDggQU0gTG91LCBQZW5nZmVpIChOU0IgLSBDTi9IYW5nemhvdSkgPHBlbmdmZWku
bG91QG5va2lhLXNiZWxsLmNvbT4gd3JvdGU6DQo+DQo+IEhpDQo+ICAgIFRoYW5rcyBmb3IgeW91
ciBzdXBwb3J0DQo+DQo+ICAgICBCdXQgeW91ciBpZGVhIHdhcyBzdGlsbCBub3Qgd29ya2luZyBh
cyBteSB3YW50ZWQgLCBwbGVhc2UgY2hlY2sgDQo+IHRoZSByZXN1bHQgYmVsb3cNCj4NCj4gW3Bl
bG91QGh6bGluZzI5IHRyeV9kZXNdJCBnaXQgbG9nIC0xIC0tcmF3IC0tbm8td2Fsaz11bnNvcnRl
ZCANCj4gNTdjZjU2YjhjMWFmOTExNWE3ZjhlMWMxYzhmMDdlNGQ2NTdlOGIxNV4gDQo+IDU3Y2Y1
NmI4YzFhZjkxMTVhN2Y4ZTFjMWM4ZjA3ZTRkNjU3ZThiMTUNCj4gY29tbWl0IDlkMDBjYzYwODk5
Mzg0MGUyNGY2NWM3Yjc5YWUxMGY4NWMyZDcyZmYNCj4gQXV0aG9yOiBwZWxvdSA8cGVuZ2ZlaS5s
b3VAbm9raWEtc2JlbGwuY29tPg0KPiBEYXRlOiAgIFR1ZSBEZWMgMyAxNzowMDo0NyAyMDE5ICsw
ODAwDQo+DQo+ICAgICAyDQo+DQo+IDoxMDA2NDQgMTAwNjQ0IGQ0NzRlMWIuLi4gOWE3NDU2Yi4u
LiBNICBscGYNCj4gW3BlbG91QGh6bGluZzI5IHRyeV9kZXNdJCBnaXQgbG9nIC0tcmF3IC0tbm8t
d2Fsaz11bnNvcnRlZCANCj4gNTdjZjU2YjhjMWFmOTExNWE3ZjhlMWMxYzhmMDdlNGQ2NTdlOGIx
NV4gDQo+IDU3Y2Y1NmI4YzFhZjkxMTVhN2Y4ZTFjMWM4ZjA3ZTRkNjU3ZThiMTUNCj4gY29tbWl0
IDlkMDBjYzYwODk5Mzg0MGUyNGY2NWM3Yjc5YWUxMGY4NWMyZDcyZmYNCj4gQXV0aG9yOiBwZWxv
dSA8cGVuZ2ZlaS5sb3VAbm9raWEtc2JlbGwuY29tPg0KPiBEYXRlOiAgIFR1ZSBEZWMgMyAxNzow
MDo0NyAyMDE5ICswODAwDQo+DQo+ICAgICAyDQo+DQo+IDoxMDA2NDQgMTAwNjQ0IGQ0NzRlMWIu
Li4gOWE3NDU2Yi4uLiBNICBscGYNCj4NCj4gY29tbWl0IDU3Y2Y1NmI4YzFhZjkxMTVhN2Y4ZTFj
MWM4ZjA3ZTRkNjU3ZThiMTUNCj4gQXV0aG9yOiBwZWxvdSA8cGVuZ2ZlaS5sb3VAbm9raWEtc2Jl
bGwuY29tPg0KPiBEYXRlOiAgIFR1ZSBEZWMgMyAxNzowMDo0NyAyMDE5ICswODAwDQo+DQo+ICAg
ICAzDQoNCkF0IHRoaXMgcG9pbnQgSSdtIG5vdCBzdXJlIHdoYXQgeW91J3JlIGxvb2tpbmcgZm9y
LiBZb3VyIGZpcnN0IGNvbW1hbmQgaGFzIC0xIG9uIGl0LCBzbyBpdCBvbmx5IHByaW50cyB0aGUg
Y29tbWl0IGZvciA1N2NmNTZiOGMxYWY5MTE1YTdmOGUxYzFjOGYwN2U0ZDY1N2U4YjE1Xiwgd2hp
Y2ggaXMgOWQwMGNjNjA4OTkzODQwZTI0ZjY1YzdiNzlhZTEwZjg1YzJkNzJmZi4gWW91ciBzZWNv
bmQgY29tbWFuZCBvbWl0cyB0aGUgLTEgYW5kIHNvIGl0IHByaW50cyBib3RoIDU3Y2Y1NmI4YzFh
ZjkxMTVhN2Y4ZTFjMWM4ZjA3ZTRkNjU3ZThiMTVeDQooOWQwMGNjNjA4OTkzODQwZTI0ZjY1Yzdi
NzlhZTEwZjg1YzJkNzJmZikgYW5kIDU3Y2Y1NmI4YzFhZjkxMTVhN2Y4ZTFjMWM4ZjA3ZTRkNjU3
ZThiMTUtLWluIHRoZSBvcmRlciB5b3UgYXNrZWQgZm9yIHRoZW0uDQoNCldoYXQgb3V0cHV0IGFy
ZSB5b3UgX2V4cGVjdGluZ18gdG8gc2VlPw0KDQo+DQo+IFNvIHlvdSBtZWFuIGl0IGlzIG5vdCBv
bmUgYnVnIC9pc3N1ZSwgYW5kICBhZGRpbmcgZGVsYXkgd2FzIG1hbmRhdG9yeSBmb3IgdGhpcyBj
YXNlPyBBY3R1YWxseSAsIEkgZm91bmQgaXQgd2FzIHN0aWxsIGJlIGZhaWx1cmUgaWYgdGhlIGRl
bGF5IHdhcyBzZXQgMC41IHNlY29uZHMuDQoNCmdpdCBjb21taXQgcmVjb3JkcyB0aW1lc3RhbXBz
IHdpdGggc2Vjb25kIHByZWNpc2lvbiwgc28gYSBkZWxheSBvZiBoYWxmIGEgc2Vjb25kIG1lYW5z
IHlvdSBjYW4gc3RpbGwgaGF2ZSAyIGNvbW1pdHMgcmVjb3JkZWQgd2l0aCBpZGVudGljYWwgX3Rv
IHRoZSBzZWNvbmRfIHRpbWVzdGFtcHMuDQoNCkJyeWFuDQoNCj4NCj4gdGtzDQo+IEJyLCBIZXJj
dWxlcw0KDQpQLlMuIFBsZWFzZSBkb24ndCB0b3AtcG9zdCBvbiB0aGUgbGlzdC4gUmVzcG9uZCBp
bmxpbmUgYWRqYWNlbnQgdG8gdGhlIHBhcnQgb2YgdGhlIG1lc3NhZ2UgeW91J3JlIHRhbGtpbmcg
YWJvdXQuDQo=
