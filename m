Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C21FA1FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 14:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752817AbcKROvL (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 09:51:11 -0500
Received: from sp-internet-ext-ply.uhc.com ([198.203.175.175]:13532 "EHLO
        mail5.uhc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752389AbcKROvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 09:51:09 -0500
X-IronPort-AV: E=Sophos;i="5.31,510,1473138000"; 
   d="scan'208";a="649509801"
Received: from irmply48.uhc.com (HELO mail26.uhc.com) ([10.114.170.75])
  by mail7.uhc.com with ESMTP; 18 Nov 2016 08:51:07 -0600
X-IronPort-AV: E=Sophos;i="5.31,510,1473138000"; 
   d="scan'208";a="606385800"
X-CONF-FOOTER: True
Received: from apsep0923.ms.ds.uhc.com ([10.114.192.105])
  by mail26.uhc.com with ESMTP; 18 Nov 2016 08:51:07 -0600
Received: from apswp0428.ms.ds.uhc.com ([fe80::7cb7:a560:d0b0:bc2d]) by
 APSEP0923.ms.ds.uhc.com ([fe80::9dd5:df9:d565:fd31%23]) with mapi id
 14.03.0279.002; Fri, 18 Nov 2016 08:51:07 -0600
From:   "Vanderhoof, Tzadik" <tzadik.vanderhoof@optum360.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
CC:     Mike Rappazzo <rappazzo@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: merge --no-ff is NOT mentioned in help
Thread-Topic: merge --no-ff is NOT mentioned in help
Thread-Index: AQHSQPV6lm+eVlqaTkiiWd+ULmGgt6DeJJwAgACvyIA=
Date:   Fri, 18 Nov 2016 14:51:06 +0000
Message-ID: <2C8817BDA27E034F8E9A669458E375EF2BFC37@APSWP0428.ms.ds.uhc.com>
References: <2C8817BDA27E034F8E9A669458E375EF2BE63B@APSWP0428.ms.ds.uhc.com>
 <CANoM8SX91JAvJ6EAE6=wavPutUG4ZU1BY-A=5EobW=8zrdEcjw@mail.gmail.com>
 <2C8817BDA27E034F8E9A669458E375EF2BE689@APSWP0428.ms.ds.uhc.com>
 <CANoM8SVXeeZsc40xgVqZep_9oT=J2h4mOO0Ksn+kb0g8Ct=KrQ@mail.gmail.com>
 <xmqqr36anibl.fsf@gitster.mtv.corp.google.com>
 <20161117222142.mca6lmhj5mvl4gbp@sigill.intra.peff.net>
In-Reply-To: <20161117222142.mca6lmhj5mvl4gbp@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.204.2.151]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-IP-VFilter-R: R
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBPbiBUaHUsIE5vdiAxNywgMjAxNiBhdCAwOToxMDoyMkFNIC0wODAwLCBKdW5pbyBDIEhhbWFu
byB3cm90ZToNCj4gDQo+ID4gUGVvcGxlIGludGVyZXN0ZWQgbWF5IHdhbnQgdG8gdHJ5IHRoZSBh
dHRhY2hlZCBzaW5nbGUtbGluZXIgcGF0Y2ggdG8gDQo+ID4gc2VlIGhvdyB0aGUgb3V0cHV0IGZy
b20gX0FMTF8gY29tbWFuZHMgdGhhdCB1c2UgcGFyc2Utb3B0aW9ucyBBUEkgDQo+ID4gbG9va3Mg
d2hlbiBnaXZlbiAiLWgiLiAgSXQgY291bGQgYmUgdGhhdCB0aGUgcmVzdWx0IG1heSBub3QgYmUg
dG9vIA0KPiA+IGJhZC4NCj4gDQo+IFRoZSBvdXRwdXQgaXMgbGVzcyB1Z2x5IHRoYW4gSSBleHBl
Y3RlZCwgYnV0IHN0aWxsIGEgYml0IGNsdXR0ZXJlZCBJTUhPLg0KPiBJIHdhcyBzdXJwcmlzZWQg
dGhhdCB0aGUgY29sdW1uLWFkanVzdG1lbnQgZGlkIG5vdCBuZWVkIHR3ZWFrZWQsIGJ1dCB0aGUg
Y29kZSBjb3JyZWN0bHkgaW5jcmVtZW50cyAicG9zIiBmcm9tIHRoZSByZXR1cm4gdmFsdWUgb2Yg
ZnByaW50Ziwgd2hpY2gganVzdCB3b3Jrcy4NCj4gDQo+IExvb2tpbmcgYXQgdGhlIG91dHB1dCBm
b3IgLS1mZiwgdGhvdWdoOg0KPiANCj4gICAgLS1bbm8tXWZmICAgICAgICAgICAgIGFsbG93IGZh
c3QtZm9yd2FyZCAoZGVmYXVsdCkNCj4gDQo+IEkgZG8gbm90IHRoaW5rIGl0J3MgaW1wcm92aW5n
IHRoZSBzaXR1YXRpb24gbmVhcmx5IGFzIG11Y2ggYXMgaWYgd2UgbWFkZSB0aGUgcHJpbWFyeSBv
cHRpb24gIi0tbm8tZmYiIHdpdGggYSBOT05FRyBmbGdhLCBhbmQgdGhlbiBhZGRlZCBiYWNrIGlu
IGEgSElEREVOICItLWZmIi4gSSB0aG91Z2h0IHdlIGhhZCBkb25lIHRoYXQgaW4gb3RoZXIgY2Fz
ZXMsIGJ1dCBJIGNhbid0IHNlZW0gdG8gZmluZCBhbnkuIEJ1dCBpdCB3b3VsZCBtYWtlICItLW5v
LWZmIiB0aGUgcHJpbWFyeSBmb3JtLCB3aGljaCBtYWtlcyBzZW5zZSwgYXMgIi0tZmYiIGlzIGFs
cmVhZHkgdGhlIGRlZmF1bHQuDQo+IA0KPiBBbm90aGVyIG9wdGlvbiB3b3VsZCBiZSB0byB0ZWFj
aCBwYXJzZS1vcHRpb25zIHRvIHNvbWVob3cgdHJlYXQgdGhlIG5lZ2F0ZWQgZm9ybSBhcyBwcmlt
YXJ5IGluIHRoZSBoZWxwIHRleHQuIFRoYXQncyBhIGJpdCBtb3JlIGNvZGUsIGJ1dCBtaWdodCBi
ZSB1c2FibGUgaW4gb3RoZXIgcGxhY2VzLg0KPiANCj4gLVBlZmYNCj4NCg0KV2hhdCBhYm91dCBs
ZWF2aW5nIHRoZSBoZWxwIGFzIGlzLCBidXQgYWRkaW5nIGEgc2VudGVuY2UgYXQgdGhlIGVuZCAo
b3IgYmVnaW5uaW5nPykgbGlrZTogIlRoZSBmb2xsb3dpbmcgb3B0aW9ucyBtYXkgYmUgbmVnYXRl
ZCBieSBhZGRpbmcgJ25vLScgYWZ0ZXIgdGhlIGRvdWJsZSBkYXNoZXMiPw0KClRoaXMgZS1tYWls
LCBpbmNsdWRpbmcgYXR0YWNobWVudHMsIG1heSBpbmNsdWRlIGNvbmZpZGVudGlhbCBhbmQvb3IK
cHJvcHJpZXRhcnkgaW5mb3JtYXRpb24sIGFuZCBtYXkgYmUgdXNlZCBvbmx5IGJ5IHRoZSBwZXJz
b24gb3IgZW50aXR5CnRvIHdoaWNoIGl0IGlzIGFkZHJlc3NlZC4gSWYgdGhlIHJlYWRlciBvZiB0
aGlzIGUtbWFpbCBpcyBub3QgdGhlIGludGVuZGVkCnJlY2lwaWVudCBvciBoaXMgb3IgaGVyIGF1
dGhvcml6ZWQgYWdlbnQsIHRoZSByZWFkZXIgaXMgaGVyZWJ5IG5vdGlmaWVkCnRoYXQgYW55IGRp
c3NlbWluYXRpb24sIGRpc3RyaWJ1dGlvbiBvciBjb3B5aW5nIG9mIHRoaXMgZS1tYWlsIGlzCnBy
b2hpYml0ZWQuIElmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVh
c2Ugbm90aWZ5IHRoZQpzZW5kZXIgYnkgcmVwbHlpbmcgdG8gdGhpcyBtZXNzYWdlIGFuZCBkZWxl
dGUgdGhpcyBlLW1haWwgaW1tZWRpYXRlbHkuCg==

