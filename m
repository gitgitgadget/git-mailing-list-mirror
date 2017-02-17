Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 866D020136
	for <e@80x24.org>; Fri, 17 Feb 2017 16:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934228AbdBQQEY (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 11:04:24 -0500
Received: from sp-internet-ext-ply.uhc.com ([198.203.175.175]:44675 "EHLO
        mail25.uhc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934037AbdBQQEX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 11:04:23 -0500
X-IronPort-AV: E=Sophos;i="5.35,172,1484028000"; 
   d="scan'208";a="854100369"
Received: from irmctc26.uhc.com (HELO mail25.uhc.com) ([10.123.233.74])
  by mail27.uhc.com with ESMTP; 17 Feb 2017 10:04:22 -0600
X-IronPort-AV: E=Sophos;i="5.35,172,1484028000"; 
   d="scan'208";a="854100362"
X-CONF-FOOTER: True
Received: from apsep00629.ms.ds.uhc.com ([10.86.24.46])
  by mail25.uhc.com with ESMTP; 17 Feb 2017 10:04:21 -0600
Received: from apswp0428.ms.ds.uhc.com ([fe80::7cb7:a560:d0b0:bc2d]) by
 APSEP00629.ms.ds.uhc.com ([fe80::250:56ff:feb7:7634%12]) with mapi id
 14.03.0279.002; Fri, 17 Feb 2017 10:04:22 -0600
From:   "Vanderhoof, Tzadik" <tzadik.vanderhoof@optum360.com>
To:     Duy Nguyen <pclouds@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: new git-diff switch to eliminate leading "+" and "-" characters
Thread-Topic: new git-diff switch to eliminate leading "+" and "-" characters
Thread-Index: AdKGTR6IIA548fKLReSKxHY4yrqMsADEtIkAAAov0OA=
Date:   Fri, 17 Feb 2017 16:04:20 +0000
Message-ID: <2C8817BDA27E034F8E9A669458E375EF11888CB3@APSWP0428.ms.ds.uhc.com>
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
X-CFilter-Loop: Reflected
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBGcm9tOiBEdXkgTmd1eWVuIFttYWlsdG86cGNsb3Vkc0BnbWFpbC5jb21dDQo+IFNlbnQ6IEZy
aWRheSwgRmVicnVhcnkgMTcsIDIwMTcgNjo1NCBBTQ0KPiBUbzogVmFuZGVyaG9vZiwgVHphZGlr
DQo+IENjOiBnaXRAdmdlci5rZXJuZWwub3JnDQo+IA0KPiBPbiBUdWUsIEZlYiAxNCwgMjAxNyBh
dCA2OjAxIEFNLCBWYW5kZXJob29mLCBUemFkaWsNCj4gPHR6YWRpay52YW5kZXJob29mQG9wdHVt
MzYwLmNvbT4gd3JvdGU6DQo+ID4gVGhlIG91dHB1dCBvZiBnaXQtZGlmZiBpbmNsdWRlcyBsaW5l
cyBiZWdpbm5pbmcgd2l0aCAiKyIgYW5kICItIiB0byBpbmRpY2F0ZQ0KPiBhZGRlZCBhbmQgZGVs
ZXRlZCBsaW5lcy4gIEEgc29tZXdoYXQgY29tbW9uIHRhc2sgKGF0IGxlYXN0IGZvciBtZSkgaXMg
dG8NCj4gd2FudCB0byBjb3B5IG91dHB1dCBmcm9tIGEgImRpZmYiICh1c3VhbGx5IHRoZSBkZWxl
dGVkIGxpbmVzKSBhbmQgcGFzdGUgaXQgYmFjaw0KPiBpbnRvIG15IGNvZGUuDQo+ID4NCj4gPiBU
aGlzIGlzIHF1aXRlIGluY29udmVuaWVudCBiZWNhdXNlIG9mIHRoZSBsZWFkaW5nICIrIiBhbmQg
Ii0iIGNoYXJhY3RlcnMuICBJDQo+IGtub3cgdGhlcmUgYXJlIHNoZWxsIGFuZCBJREUgLyBlZGl0
b3Igd29ya2Fyb3VuZHMgYnV0IGl0IHdvdWxkIGJlIG5pY2UgaWYNCj4gdGhlcmUgd2FzIGEgc3dp
dGNoIHRvIGdpdC1kaWZmIHRvIG1ha2UgaXQgbGVhdmUgb3V0IHRob3NlIGNoYXJhY3RlcnMsIGVz
cGVjaWFsbHkNCj4gc2luY2UgIi0tY29sb3IiIGtpbmQgb2YgbWFrZXMgdGhvc2UgbGVhZGluZyBj
aGFyYWN0ZXJzIG9ic29sZXRlLg0KPiANCj4gQ29sb3Igd291bGRuJ3Qgc2hvdyB5b3UgbmV3L29s
ZCBlbXB0eSBsaW5lcyB0aG91Z2ggKHVubGVzcyB5b3UgdXNlDQo+IGRpZmZlcmVudCBiYWNrZ3Jv
dW5kIGNvbG9yLCBidXQgSSBkb3VidCB0aGF0IGxvb2tzIHJlYWRhYmxlKS4NCj4gDQo+ID4gV291
bGQgaXQgbWFrZSBzZW5zZSB0byBkZXZlbG9wIHN1Y2ggYSBzd2l0Y2ggb3IgaGFzIHRoZXJlIGJl
ZW4gd29yayBvbg0KPiB0aGF0IGFscmVhZHk/DQo+IA0KPiBJIGZhY2UgdGhpcyAicHJvYmxlbSIg
ZXZlcnkgZGF5LCBidXQgbW9zdCBlZGl0b3JzIG5vd2FkYXlzIGhhdmUgYmxvY2stDQo+IGJhc2Vk
IGVkaXRpbmcgdGhhdCB3b3VsZCBhbGxvdyB5b3UgdG8gcmVtb3ZlIGEgY29sdW1uIG9mICIrLy0i
DQo+IGVhc2lseS4gQXQgbGVhc3QgaXQgaGFzIG5vdCBib3RoZXJlZCBtZSB0byB0aGluayBvZiBp
bXByb3ZpbmcgaXQuDQoNCldvdWxkIGEgcGF0Y2ggYmUgd2VsY29tZT8NCg0KVHphZGlrDQoNCj4g
LS0NCj4gRHV5DQoNCgpUaGlzIGUtbWFpbCwgaW5jbHVkaW5nIGF0dGFjaG1lbnRzLCBtYXkgaW5j
bHVkZSBjb25maWRlbnRpYWwgYW5kL29yCnByb3ByaWV0YXJ5IGluZm9ybWF0aW9uLCBhbmQgbWF5
IGJlIHVzZWQgb25seSBieSB0aGUgcGVyc29uIG9yIGVudGl0eQp0byB3aGljaCBpdCBpcyBhZGRy
ZXNzZWQuIElmIHRoZSByZWFkZXIgb2YgdGhpcyBlLW1haWwgaXMgbm90IHRoZSBpbnRlbmRlZApy
ZWNpcGllbnQgb3IgaGlzIG9yIGhlciBhdXRob3JpemVkIGFnZW50LCB0aGUgcmVhZGVyIGlzIGhl
cmVieSBub3RpZmllZAp0aGF0IGFueSBkaXNzZW1pbmF0aW9uLCBkaXN0cmlidXRpb24gb3IgY29w
eWluZyBvZiB0aGlzIGUtbWFpbCBpcwpwcm9oaWJpdGVkLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCB0
aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUKc2VuZGVyIGJ5IHJlcGx5aW5n
IHRvIHRoaXMgbWVzc2FnZSBhbmQgZGVsZXRlIHRoaXMgZS1tYWlsIGltbWVkaWF0ZWx5Lgo=

