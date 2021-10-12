Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D95C433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 09:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D2D61039
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 09:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbhJLJKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 05:10:37 -0400
Received: from outboundhk.mxmail.xiaomi.com ([207.226.244.123]:46498 "EHLO
        xiaomi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235175AbhJLJKg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 05:10:36 -0400
Received: from BJ-MBX01.mioffice.cn (10.237.8.121) by HK-MBX02.mioffice.cn
 (10.56.8.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.15; Tue, 12 Oct
 2021 17:08:09 +0800
Received: from BJ-MBX01.mioffice.cn (10.237.8.121) by BJ-MBX01.mioffice.cn
 (10.237.8.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.15; Tue, 12 Oct
 2021 17:08:08 +0800
Received: from BJ-MBX01.mioffice.cn ([fe80::a533:b6ba:b457:de9e]) by
 BJ-MBX01.mioffice.cn ([fe80::a533:b6ba:b457:de9e%9]) with mapi id
 15.02.0858.015; Tue, 12 Oct 2021 17:08:08 +0800
From:   =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [External Mail]Re: why git is so slow for a tiny git push?
Thread-Topic: [External Mail]Re: why git is so slow for a tiny git push?
Thread-Index: Ade84mmmstEBXQTRSsexpdzlhc8vnAAVTYYAAAAT7KAAUV7NAAAwVDmA//+FzYD//3VBcA==
Date:   Tue, 12 Oct 2021 09:08:08 +0000
Message-ID: <d8abab7fb5184a94a9e9e5b7c1f28695@xiaomi.com>
References: <c5a8595658d6416684c2bbd317494c49@xiaomi.com>
 <5a6f3e8f29f74c93bf3af5da636df973@xiaomi.com>
 <576b2f3e162e4f86992d8f4e680d0881@xiaomi.com>
 <YWRr9g32cMlIc37V@coredump.intra.peff.net>
 <ef2aa0d3ea8a4d98b910abdfd55191d0@xiaomi.com>
 <YWVJyRJhRTdg39tX@coredump.intra.peff.net>
In-Reply-To: <YWVJyRJhRTdg39tX@coredump.intra.peff.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.8.11]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T2ggbXkgZ29kLg0KSmVzdXMuIEl0IHdvcmtzIGZvciBtZS4gQWZ0ZXIgZGlzYWJsZSB3cml0ZWJp
dG1hcCwgdGltZSBjb3N0IGRlY3JlYXNlIGZyb20gMzMgc2Vjb25kcyB0byAwLjkgc2Vjb25kcy4N
Cg0KQnV0IG5vdyBpdCB0dXJucyBvdXQgdGhhdCwgcmVtb3RlIHNpZGUgdGFrZXMgMTMgc2Vjb25k
cyB0byByZWNlaXZlIHRoZSBwYWNrLCAgc2luY2UgZ2l0IHJlY2VpdmUtcGFjayBpcyB0cmlnZ2Vy
ZWQgYXV0b21hdGljYWxseSBmcm9tIHJlbW90ZSBzaWRlLCBpcyB0aGVyZSBhbnl3YXkgdG8gZW5h
YmxlIEdJVF9UUkFDRTJfUEVSRiBvbiBzZXJ2ZXIgc2lkZT8NCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IEplZmYgS2luZyA8cGVmZkBwZWZmLm5ldD4NClNlbnQ6IFR1ZXNkYXks
IE9jdG9iZXIgMTIsIDIwMjEgNDo0MCBQTQ0KVG86IOeoi+a0iyA8Y2hlbmd5YW5nQHhpYW9taS5j
b20+DQpDYzogZ2l0QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtFeHRlcm5hbCBNYWls
XVJlOiB3aHkgZ2l0IGlzIHNvIHNsb3cgZm9yIGEgdGlueSBnaXQgcHVzaD8NCg0KKlRoaXMgbWVz
c2FnZSBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBYSUFPTUkuIFBsZWFzZSB0cmVhdCB0aGlz
IGVtYWlsIHdpdGggY2F1dGlvbioNCg0KDQpPbiBUdWUsIE9jdCAxMiwgMjAyMSBhdCAwODowNDo0
NEFNICswMDAwLCDnqIvmtIsgd3JvdGU6DQoNCj4gSSBoYXZlIGJpdG1hcCBpbmRlZWQgYmVjYXVz
ZSBteSBtYXN0ZXIgc2VydmVyIGFsc28gc2VydmVzIGFzIGRvd25sb2FkIHNlcnZlci4NCj4gSG93
ZXZlciBJJ20gdXNpbmcgZ2l0IDIuMTcuMCwgYW5kIEkgZGlkbid0IHNldCByZXBhY2sud3JpdGVC
aXRtYXBzDQoNCk9uIHRoYXQgdmVyc2lvbiBhbmQgd2l0aG91dCB0aGUgY29uZmlnLCB0aGVuIHBl
cmhhcHMgeW91IChvciBzb21lYm9keSkgcGFzc2VkICItYiIgdG8gZ2l0LXJlcGFjay4NCg0KPiBC
dXQgd2h5IGJpdG1hcHMgY2FuIGNhdXNlIHB1c2ggdG8gYmUgc2xvdz8gRG8geW91IG1lYW4gdGhh
dCBpZg0KPiB3cml0ZUJpdG1hcHMgaXMgdHJ1ZSwgZXZlcnkgcHVzaCB3aWxsIHJlZ2VuZXJhdGUg
Yml0bWFwIGZpbGU/IElmDQo+IHRoYXQncyB3aGF0IHlvdSBtZWFuLCB3aGF0IEkgc2VlIGlzIHRo
ZSBvbmx5IGJpdG1hcCBmaWxlIGluIG15IHJlcG8NCj4gZGlkbid0IGNoYW5nZSBhY3Jvc3MgdGlt
ZSAodGhlIG1vZGlmeSB0aW1lIGlzIG9uZSBtb250aCBhZ28sIGxvbmcNCj4gYmVmb3JlIEkgcnVu
IHRoZSBleHBlcmltZW50KQ0KDQpObywgaXQgaXMgbm90IHJlZ2VuZXJhdGluZyB0aGUgb24tZGlz
ayBiaXRtYXBzLiBCdXQgd2hlbiBkZWNpZGluZyB0aGUgc2V0IG9mIG9iamVjdHMgdG8gc2VuZCwg
cGFjay1vYmplY3RzIHdpbGwgZ2VuZXJhdGUgYW4gaW50ZXJuYWwgYml0bWFwIHdoaWNoIGlzIHRo
ZSBzZXQgZGlmZmVyZW5jZSBvZiBvYmplY3RzIHJlYWNoYWJsZSBmcm9tIHRoZSBwdXNoZWQgcmVm
cywgbWludXMgb2JqZWN0cyByZWFjaGFibGUgZnJvbSB0aGUgcmVmcyB0aGUgb3RoZXIgdGhlIG90
aGVyIHNpZGUgdG9sZCB1cyB0aGV5IGhhZC4NCg0KSXQgdXNlcyB0aGUgb24tZGlzayBiaXRtYXBz
IGFzIG11Y2ggYXMgcG9zc2libGUsIGJ1dCB0aGVyZSBtYXkgYmUgY29tbWl0cyBub3QgY292ZXJl
ZCBieSBiaXRtYXBzIChlaXRoZXIgYmVjYXVzZSB0aGV5IHdlcmUgcHVzaGVkIHNpbmNlIHRoZSBs
YXN0IHJlcGFjayB3aGljaCBidWlsdCBiaXRtYXBzLCBvciBzaW1wbHkgYmVjYXVzZSBpdCdzIHRv
byBleHBlbnNpdmUgdG8gcHV0IGEgYml0bWFwIG9uIGV2ZXJ5IGNvbW1pdCwgc28gd2Ugc3ByaW5r
bGUgdGhlbSB0aHJvdWdob3V0IHRoZSBjb21taXQgaGlzdG9yeSkuIEluIHRob3NlIGNhc2VzIHdl
IGhhdmUgdG8gdHJhdmVyc2UgcGFydHMgb2YgdGhlIG9iamVjdCBncmFwaCBieSB3YWxraW5nIGNv
bW1pdHMgYW5kIG9wZW5pbmcgdXAgdHJlZXMuIFRoaXMgY2FuIGJlIGV4cGVuc2l2ZSwgYW5kIGlz
IHdoZXJlIHlvdXIgdGltZSBpcyBnb2luZy4NCg0KUmVhY2hhYmlsaXR5IGJpdG1hcHMgX3VzdWFs
bHlfIG1ha2UgdGhpbmdzIGZhc3RlciwgYnV0IHRoZXkgaGF2ZSBzb21lIGNhc2VzIHdoZXJlIHRo
ZXkgbWFrZSB0aGluZ3Mgd29yc2UgKGVzcGVjaWFsbHkgaWYgeW91IGhhdmUgYSB0b24gb2YgcmVm
cywgb3IgaGF2ZW4ndCByZXBhY2tlZCByZWNlbnRseSkuDQoNCklmIGJpdG1hcHMgYXJlIGNhdXNp
bmcgYSBwcm9ibGVtIGZvciB5b3VyIHB1c2gsIHRoZXkgYXJlIGxpa2VseSB0byBiZSBjYXVzaW5n
IHByb2JsZW1zIGZvciBmZXRjaGVzLCB0b28uIEJ1dCBpZiB5b3Ugd2FudCB0byBrZWVwIHRoZW0g
dG8gc2VydmUgZmV0Y2hlcywgYnV0IG5vdCB1c2UgdGhlbSBmb3IgcHVzaCwgeW91IHNob3VsZCBi
ZSBhYmxlIHRvIGRvOg0KDQogIGdpdCAtYyBwYWNrLnVzZWJpdG1hcHM9ZmFsc2UgcHVzaA0KDQot
UGVmZg0KIy8qKioqKirmnKzpgq7ku7blj4rlhbbpmYTku7blkKvmnInlsI/nsbPlhazlj7jnmoTk
v53lr4bkv6Hmga/vvIzku4XpmZDkuo7lj5HpgIHnu5nkuIrpnaLlnLDlnYDkuK3liJflh7rnmoTk
uKrkurrmiJbnvqTnu4TjgILnpoHmraLku7vkvZXlhbbku5bkurrku6Xku7vkvZXlvaLlvI/kvb/n
lKjvvIjljIXmi6zkvYbkuI3pmZDkuo7lhajpg6jmiJbpg6jliIblnLDms4TpnLLjgIHlpI3liLbj
gIHmiJbmlaPlj5HvvInmnKzpgq7ku7bkuK3nmoTkv6Hmga/jgILlpoLmnpzmgqjplJnmlLbkuobm
nKzpgq7ku7bvvIzor7fmgqjnq4vljbPnlLXor53miJbpgq7ku7bpgJrnn6Xlj5Hku7bkurrlubbl
iKDpmaTmnKzpgq7ku7bvvIEgVGhpcyBlLW1haWwgYW5kIGl0cyBhdHRhY2htZW50cyBjb250YWlu
IGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9tIFhJQU9NSSwgd2hpY2ggaXMgaW50ZW5kZWQg
b25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJv
dmUuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55IHdh
eSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xv
c3VyZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRo
YW4gdGhlIGludGVuZGVkIHJlY2lwaWVudChzKSBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2
ZSB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHBob25l
IG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgaXQhKioqKioqLyMNCg==
