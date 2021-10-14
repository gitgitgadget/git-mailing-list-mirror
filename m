Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F9FC4332F
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 06:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CB7F60F21
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 06:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhJNGuE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 02:50:04 -0400
Received: from outboundhk.mxmail.xiaomi.com ([207.226.244.123]:25136 "EHLO
        xiaomi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229619AbhJNGuD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 02:50:03 -0400
Received: from BJ-MBX01.mioffice.cn (10.237.8.121) by HK-MBX01.mioffice.cn
 (10.56.8.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.15; Thu, 14 Oct
 2021 14:47:32 +0800
Received: from BJ-MBX01.mioffice.cn (10.237.8.121) by BJ-MBX01.mioffice.cn
 (10.237.8.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.15; Thu, 14 Oct
 2021 14:47:31 +0800
Received: from BJ-MBX01.mioffice.cn ([fe80::a533:b6ba:b457:de9e]) by
 BJ-MBX01.mioffice.cn ([fe80::a533:b6ba:b457:de9e%9]) with mapi id
 15.02.0858.015; Thu, 14 Oct 2021 14:47:31 +0800
From:   =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [External Mail]Re: why git is so slow for a tiny git push?
Thread-Topic: [External Mail]Re: why git is so slow for a tiny git push?
Thread-Index: Ade84mmmstEBXQTRSsexpdzlhc8vnAAVTYYAAAAT7KAAUV7NAAAwVDmA//+FzYD//3VBcIABZJ+A//1OjJA=
Date:   Thu, 14 Oct 2021 06:47:31 +0000
Message-ID: <5063751fd4b94ccca3987080c96370d8@xiaomi.com>
References: <c5a8595658d6416684c2bbd317494c49@xiaomi.com>
 <5a6f3e8f29f74c93bf3af5da636df973@xiaomi.com>
 <576b2f3e162e4f86992d8f4e680d0881@xiaomi.com>
 <YWRr9g32cMlIc37V@coredump.intra.peff.net>
 <ef2aa0d3ea8a4d98b910abdfd55191d0@xiaomi.com>
 <YWVJyRJhRTdg39tX@coredump.intra.peff.net>
 <d8abab7fb5184a94a9e9e5b7c1f28695@xiaomi.com>
 <YWYAjRfLsDtc1Dkm@coredump.intra.peff.net>
In-Reply-To: <YWYAjRfLsDtc1Dkm@coredump.intra.peff.net>
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

U2VlbXMgdGhhdCBnaXQgcmVjZWl2ZS1wYWNrIG9ubHkgdGFrZXMgMSBzZWNvbmRzLg0KQWZ0ZXIg
dGhhdCwgZ2l0IHJldi1saXN0IHRha2VzIHRoZSBtb3N0IHRpbWUsIEkgZG9uJ3Qga25vdyB3aGF0
IGlzIGl0IGRvaW5nDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKZWZmIEtp
bmcgPHBlZmZAcGVmZi5uZXQ+DQpTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMTMsIDIwMjEgNToz
OSBBTQ0KVG86IOeoi+a0iyA8Y2hlbmd5YW5nQHhpYW9taS5jb20+DQpDYzogZ2l0QHZnZXIua2Vy
bmVsLm9yZw0KU3ViamVjdDogUmU6IFtFeHRlcm5hbCBNYWlsXVJlOiB3aHkgZ2l0IGlzIHNvIHNs
b3cgZm9yIGEgdGlueSBnaXQgcHVzaD8NCg0KKlRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20g
b3V0c2lkZSBvZiBYSUFPTUkuIFBsZWFzZSB0cmVhdCB0aGlzIGVtYWlsIHdpdGggY2F1dGlvbioN
Cg0KDQpPbiBUdWUsIE9jdCAxMiwgMjAyMSBhdCAwOTowODowOEFNICswMDAwLCDnqIvmtIsgd3Jv
dGU6DQoNCj4gSmVzdXMuIEl0IHdvcmtzIGZvciBtZS4gQWZ0ZXIgZGlzYWJsZSB3cml0ZWJpdG1h
cCwgdGltZSBjb3N0IGRlY3JlYXNlDQo+IGZyb20gMzMgc2Vjb25kcyB0byAwLjkgc2Vjb25kcy4N
Cj4NCj4gQnV0IG5vdyBpdCB0dXJucyBvdXQgdGhhdCwgcmVtb3RlIHNpZGUgdGFrZXMgMTMgc2Vj
b25kcyB0byByZWNlaXZlIHRoZQ0KPiBwYWNrLCAgc2luY2UgZ2l0IHJlY2VpdmUtcGFjayBpcyB0
cmlnZ2VyZWQgYXV0b21hdGljYWxseSBmcm9tIHJlbW90ZQ0KPiBzaWRlLCBpcyB0aGVyZSBhbnl3
YXkgdG8gZW5hYmxlIEdJVF9UUkFDRTJfUEVSRiBvbiBzZXJ2ZXIgc2lkZT8NCg0KRm9yIHRoZSBl
bnZpcm9ubWVudCB2YXJpYWJsZSwgaXQgZGVwZW5kcyBvbiB5b3VyIHByb3RvY29sLiBJZiB5b3Ug
Y2FuIHB1c2ggb3ZlciBzc2ggKGFuZCB0aGUgb3RoZXIgc2lkZSBsZXRzIHlvdSBleGVjdXRlIGFy
Yml0cmFyeSBjb21tYW5kcyksDQp0aGVuOg0KDQogIGdpdCBwdXNoIC0tcmVjZWl2ZS1wYWNrPSdH
SVRfVFJBQ0UyX1BFUkY9L3RtcC9mb28udHJhY2UgZ2l0LXJlY2VpdmUtcGFjaycNCg0KT3RoZXJ3
aXNlLCB5b3UgY2FuIGxvb2sgYXQgc2V0dGluZyB0aGUgdHJhY2UyLnBlcmZUYXJnZXQgY29uZmln
IG9wdGlvbiBvbiB0aGUgc2VydmVyIHNpZGUuIEkgaGF2ZW4ndCBwbGF5ZWQgd2l0aCBpdCBteXNl
bGYgYmVmb3JlLg0KDQotUGVmZg0KIy8qKioqKirmnKzpgq7ku7blj4rlhbbpmYTku7blkKvmnInl
sI/nsbPlhazlj7jnmoTkv53lr4bkv6Hmga/vvIzku4XpmZDkuo7lj5HpgIHnu5nkuIrpnaLlnLDl
nYDkuK3liJflh7rnmoTkuKrkurrmiJbnvqTnu4TjgILnpoHmraLku7vkvZXlhbbku5bkurrku6Xk
u7vkvZXlvaLlvI/kvb/nlKjvvIjljIXmi6zkvYbkuI3pmZDkuo7lhajpg6jmiJbpg6jliIblnLDm
s4TpnLLjgIHlpI3liLbjgIHmiJbmlaPlj5HvvInmnKzpgq7ku7bkuK3nmoTkv6Hmga/jgILlpoLm
npzmgqjplJnmlLbkuobmnKzpgq7ku7bvvIzor7fmgqjnq4vljbPnlLXor53miJbpgq7ku7bpgJrn
n6Xlj5Hku7bkurrlubbliKDpmaTmnKzpgq7ku7bvvIEgVGhpcyBlLW1haWwgYW5kIGl0cyBhdHRh
Y2htZW50cyBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9tIFhJQU9NSSwgd2hp
Y2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgd2hvc2UgYWRkcmVz
cyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBo
ZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8sIHRvdGFsIG9y
IHBhcnRpYWwgZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1pbmF0aW9uKSBieSBw
ZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudChzKSBpcyBwcm9oaWJpdGVk
LiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUg
c2VuZGVyIGJ5IHBob25lIG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgaXQhKioqKioq
LyMNCg==
