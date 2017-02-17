Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD5A620136
	for <e@80x24.org>; Fri, 17 Feb 2017 16:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934744AbdBQQGX (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 11:06:23 -0500
Received: from sp-internet-ext-ply.uhc.com ([198.203.175.175]:16201 "EHLO
        mail16.uhc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934289AbdBQQGW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 11:06:22 -0500
X-IronPort-AV: E=Sophos;i="5.35,172,1484028000"; 
   d="scan'208";a="875112474"
Received: from irmelr25.uhc.com (HELO mail5.uhc.com) ([10.177.105.52])
  by mail18.uhc.com with ESMTP; 17 Feb 2017 10:06:21 -0600
X-IronPort-AV: E=Sophos;i="5.35,172,1484028000"; 
   d="scan'208";a="827804269"
X-CONF-FOOTER: True
Received: from apsep0937.ms.ds.uhc.com ([10.123.233.193])
  by mail5.uhc.com with ESMTP; 17 Feb 2017 10:06:20 -0600
Received: from apswp0428.ms.ds.uhc.com ([fe80::7cb7:a560:d0b0:bc2d]) by
 apsep0937.ms.ds.uhc.com ([fe80::4445:7386:5f5:ba94%20]) with mapi id
 14.03.0279.002; Fri, 17 Feb 2017 10:06:20 -0600
From:   "Vanderhoof, Tzadik" <tzadik.vanderhoof@optum360.com>
To:     Duy Nguyen <pclouds@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: new git-diff switch to eliminate leading "+" and "-" characters
Thread-Topic: new git-diff switch to eliminate leading "+" and "-" characters
Thread-Index: AdKGTR6IIA548fKLReSKxHY4yrqMsADEtIkAAAoQBIA=
Date:   Fri, 17 Feb 2017 16:06:19 +0000
Message-ID: <2C8817BDA27E034F8E9A669458E375EF11888CC1@APSWP0428.ms.ds.uhc.com>
References: <2C8817BDA27E034F8E9A669458E375EF11886C5A@APSWP0428.ms.ds.uhc.com>
 <CACsJy8CTL1GUreqNVBYyu2EqqdiUxj-dOOE9=Rr0ivK6-7yKjw@mail.gmail.com>
In-Reply-To: <CACsJy8CTL1GUreqNVBYyu2EqqdiUxj-dOOE9=Rr0ivK6-7yKjw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.204.2.152]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-IP-VFilter-R: R
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBGcm9tOiBEdXkgTmd1eWVuIFttYWlsdG86cGNsb3Vkc0BnbWFpbC5jb21dDQo+IFNlbnQ6IEZy
aWRheSwgRmVicnVhcnkgMTcsIDIwMTcgNjo1NCBBTQ0KPiBUbzogVmFuZGVyaG9vZiwgVHphZGlr
DQo+IENjOiBnaXRAdmdlci5rZXJuZWwub3JnDQo+IA0KPiA+IFdvdWxkIGl0IG1ha2Ugc2Vuc2Ug
dG8gZGV2ZWxvcCBzdWNoIGEgc3dpdGNoIG9yIGhhcyB0aGVyZSBiZWVuIHdvcmsgb24NCj4gdGhh
dCBhbHJlYWR5Pw0KPiANCj4gSSBmYWNlIHRoaXMgInByb2JsZW0iIGV2ZXJ5IGRheSwgYnV0IG1v
c3QgZWRpdG9ycyBub3dhZGF5cyBoYXZlIGJsb2NrLQ0KPiBiYXNlZCBlZGl0aW5nIHRoYXQgd291
bGQgYWxsb3cgeW91IHRvIHJlbW92ZSBhIGNvbHVtbiBvZiAiKy8tIg0KPiBlYXNpbHkuIEF0IGxl
YXN0IGl0IGhhcyBub3QgYm90aGVyZWQgbWUgdG8gdGhpbmsgb2YgaW1wcm92aW5nIGl0Lg0KDQpX
b3VsZCBhIHBhdGNoIGJlIHdlbGNvbWU/DQoNClR6YWRpaw0KDQo+IC0tDQo+IER1eQ0KDQoKVGhp
cyBlLW1haWwsIGluY2x1ZGluZyBhdHRhY2htZW50cywgbWF5IGluY2x1ZGUgY29uZmlkZW50aWFs
IGFuZC9vcgpwcm9wcmlldGFyeSBpbmZvcm1hdGlvbiwgYW5kIG1heSBiZSB1c2VkIG9ubHkgYnkg
dGhlIHBlcnNvbiBvciBlbnRpdHkKdG8gd2hpY2ggaXQgaXMgYWRkcmVzc2VkLiBJZiB0aGUgcmVh
ZGVyIG9mIHRoaXMgZS1tYWlsIGlzIG5vdCB0aGUgaW50ZW5kZWQKcmVjaXBpZW50IG9yIGhpcyBv
ciBoZXIgYXV0aG9yaXplZCBhZ2VudCwgdGhlIHJlYWRlciBpcyBoZXJlYnkgbm90aWZpZWQKdGhh
dCBhbnkgZGlzc2VtaW5hdGlvbiwgZGlzdHJpYnV0aW9uIG9yIGNvcHlpbmcgb2YgdGhpcyBlLW1h
aWwgaXMKcHJvaGliaXRlZC4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlLW1haWwgaW4gZXJy
b3IsIHBsZWFzZSBub3RpZnkgdGhlCnNlbmRlciBieSByZXBseWluZyB0byB0aGlzIG1lc3NhZ2Ug
YW5kIGRlbGV0ZSB0aGlzIGUtbWFpbCBpbW1lZGlhdGVseS4K

