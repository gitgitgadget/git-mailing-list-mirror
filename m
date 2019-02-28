Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FC9320248
	for <e@80x24.org>; Thu, 28 Feb 2019 08:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbfB1IQt (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 03:16:49 -0500
Received: from mail.trimma.se.253.68.83.in-addr.arpa ([83.68.253.31]:39870
        "EHLO Triton.ad.trimma.se" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727725AbfB1IQs (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 28 Feb 2019 03:16:48 -0500
Received: from Triton.ad.trimma.se ([fe80::3059:77c9:78ab:1ec0]) by
 Triton.ad.trimma.se ([fe80::3059:77c9:78ab:1ec0%10]) with mapi id
 14.02.0328.009; Thu, 28 Feb 2019 09:16:44 +0100
From:   Linus Nilsson <Linus.Nilsson@trimma.se>
To:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
CC:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [BUG] All files in folder are moved when cherry-picking commit
 that moves fewer files
Thread-Topic: [BUG] All files in folder are moved when cherry-picking commit
 that moves fewer files
Thread-Index: AdTOmod0m3uZbLYAQNuBqsmdOY/9ngABiJgAAAMztoAAAVbgAAABxUwAACCIMfA=
Date:   Thu, 28 Feb 2019 08:16:43 +0000
Message-ID: <67C5CE5D6EC13D4DB8FC51E2F9BD262F022B8B3599@Triton.ad.trimma.se>
References: <67C5CE5D6EC13D4DB8FC51E2F9BD262F022B8B3151@Triton.ad.trimma.se>
 <512993fe-51da-745d-031b-37ea162499fb@gmail.com>
 <CABPp-BGbrWrS0622yfTRUqRzWzNsZ_v9cAWW6ucXBYXqD26qHA@mail.gmail.com>
 <20190227164056.GA2062@sigill.intra.peff.net>
 <CABPp-BGOqQ0P8ywCK_sybPOeASxPnkTq7NXW8678f=345=68-Q@mail.gmail.com>
In-Reply-To: <CABPp-BGOqQ0P8ywCK_sybPOeASxPnkTq7NXW8678f=345=68-Q@mail.gmail.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.150.118]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzIGZvciB0aGUgYW5zd2Vycy4gU28gaXQgc2VlbXMgaXQncyBub3QgYSBidWcsIGJ1dCBt
YXkgbGVhZCB0byBuZXcgbWVyZ2Ugb3B0aW9ucy4gSSB3b3JrZWQgYXJvdW5kIGl0IGFueXdheSwg
c28gaXQgd2FzIG5vdCBhIHJlYWwgcHJvYmxlbS4NCg0KTWVkIHbDpG5saWcgaMOkbHNuaW5nDQpM
aW51cyBOaWxzc29uDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBFbGlqYWgg
TmV3cmVuIDxuZXdyZW5AZ21haWwuY29tPiANClNlbnQ6IFdlZG5lc2RheSwgMjcgRmVicnVhcnkg
MjAxOSAxODozMg0KVG86IEplZmYgS2luZyA8cGVmZkBwZWZmLm5ldD4NCkNjOiBQaGlsbGlwIFdv
b2QgPHBoaWxsaXAud29vZEBkdW5lbG0ub3JnLnVrPjsgTGludXMgTmlsc3NvbiA8TGludXMuTmls
c3NvbkB0cmltbWEuc2U+OyBnaXRAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW0JVR10g
QWxsIGZpbGVzIGluIGZvbGRlciBhcmUgbW92ZWQgd2hlbiBjaGVycnktcGlja2luZyBjb21taXQg
dGhhdCBtb3ZlcyBmZXdlciBmaWxlcw0KDQpPbiBXZWQsIEZlYiAyNywgMjAxOSBhdCA4OjQwIEFN
IEplZmYgS2luZyA8cGVmZkBwZWZmLm5ldD4gd3JvdGU6DQo+DQo+IE9uIFdlZCwgRmViIDI3LCAy
MDE5IGF0IDA4OjAyOjM1QU0gLTA4MDAsIEVsaWphaCBOZXdyZW4gd3JvdGU6DQo+DQo+ID4gPiA+
IEkgaGF2ZSBmb3VuZCB3aGF0IEkgc3VzcGVjdCB0byBiZSBhIGJ1Zywgb3IgYXQgbGVhc3Qgbm90
IA0KPiA+ID4gPiBkZXNpcmFibGUgYmVoYXZpb3IgaW4gbXkgY2FzZS4gSW4gb25lIGJyYW5jaCwg
SSBoYXZlIG1vdmVkIGFsbCANCj4gPiA+ID4gZmlsZXMgaW4gYSBkaXJlY3RvcnkgdG8gYW5vdGhl
ciBkaXJlY3RvcnkuIFRoZSBmaXJzdCBkaXJlY3RvcnkgDQo+ID4gPiA+IGlzIG5vdyBlbXB0eSBp
biB0aGlzIGJyYW5jaCAoSSBoYXZlbid0IHRlc3RlZCB3aGV0aGVyIHRoaXMgaXMgc2lnbmlmaWNh
bnQpLg0KPiA+ID4NCj4gPiA+IEkgc3VzcGVjdCB0aGF0IGJlY2F1c2UgeW91J3ZlIG1vdmVkIGFs
bCB0aGUgZmlsZXMgZ2l0IHRoaW5rcyB0aGUgDQo+ID4gPiBkaXJlY3RvcnkgaGFzIGJlZW4gcmVu
YW1lZCBhbmQgdGhhdCdzIHdoeSBpdCBtb3ZlcyBhL2ZpbGUyIHdoZW4gDQo+ID4gPiBmaXggaXMg
Y2hlcnJ5LXBpY2tlZCBpbiB0aGUgZXhhbXBsZSBiZWxvdy4gSSd2ZSBjYydkIEVsaWphaCBhcyBo
ZSANCj4gPiA+IGtub3dzIG1vcmUgYWJvdXQgaG93IHRoZSBkaXJlY3RvcnkgcmVuYW1lIGRldGVj
dGlvbiB3b3Jrcy4NCj4gPg0KPiA+IFllcywgUGhpbGxpcCBpcyBjb3JyZWN0LiAgSWYgdGhlIGJy
YW5jaCB5b3Ugd2VyZSANCj4gPiBtZXJnaW5nL2NoZXJyeS1waWNraW5nIHN0aWxsIGhhZCBhbnkg
ZmlsZXMgYXQgYWxsIGluIHRoZSBvcmlnaW5hbCANCj4gPiBkaXJlY3RvcnksIHRoZW4gbm8gZGly
ZWN0b3J5IHJlbmFtZSB3b3VsZCBiZSBkZXRlY3RlZC4gIFlvdSBjYW4gcmVhZCANCj4gPiB1cCBt
b3JlIGRldGFpbHMgYWJvdXQgaG93IGl0IHdvcmtzIGF0IA0KPiA+IGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9naXQvZ2l0LmdpdC90cmVlL0RvY3VtZW50YXRpb24vdGVjaG5pDQo+ID4g
Y2FsL2RpcmVjdG9yeS1yZW5hbWUtZGV0ZWN0aW9uLnR4dA0KPg0KPiBJcyB0aGVyZSBhIHdheSB0
byBkaXNhYmxlIGl0IChlaXRoZXIgYnkgY29uZmlnLCBvciBmb3IgYSBzaW5nbGUgcnVuKT8gDQo+
IEkga25vdyB0aGVyZSdzIG1lcmdlLnJlbmFtZXMsIGJ1dCBpdCdzIHBsYXVzaWJsZSBzb21lYm9k
eSBtaWdodCB3YW50IA0KPiBmaWxlLWxldmVsIHJlbmFtZXMgYnV0IG5vdCBkaXJlY3RvcnktbGV2
ZWwgb25lcy4NCj4NCj4gLVBlZmYNCg0KTm90IHlldC4gIEFkZGluZyBzdWNoIGFuIG9wdGlvbiwg
c2ltaWxhciBpbiBuYXR1cmUgdG8gdGhlIGZsYWdzIGZvciB0dXJuaW5nIG9mZiByZW5hbWluZyBk
ZXRlY3Rpb24gZW50aXJlbHkgKG1lcmdlLnJlbmFtZXMsIGRpZmYucmVuYW1lcywNCi1Ybm8tcmVu
YW1lcykgd291bGQgcHJvYmFibHkgbWFrZSBzZW5zZSAoSSBkb24ndCBzZWUgYW4gYW5hbG9neSB0
byAtWHJlbmFtZS10aHJlc2hvbGQ9LCB0aG91Z2gpLiAgSXQgbWlnaHQgbWFrZSBzZW5zZSBhcyBq
dXN0IGFuIGFsdGVybmF0ZSBzZXR0aW5nIG9mIG1lcmdlLnJlbmFtZXMgb3IgZGlmZi5yZW5hbWVz
LCB0aG91Z2ggaXQncyBwb3NzaWJsZSB0aGF0IGNvdWxkIGdldCBjb25mdXNpbmcgd2l0aCAiY29w
eSIgYmVpbmcgYW4gb3B0aW9uLg0KI2xlZnRvdmVyYml0cyBmb3Igc29tZW9uZSB0aGF0IHdhbnRz
IHRvIGZpZ3VyZSBvdXQgd2hhdCB0aGUgb3B0aW9uIG5hbWVzIGFuZCB2YWx1ZXMgc2hvdWxkIGJl
Pw0K
