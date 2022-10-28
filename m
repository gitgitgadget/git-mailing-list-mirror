Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9F3ECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 12:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJ1MBh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 08:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiJ1MBe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 08:01:34 -0400
X-Greylist: delayed 418 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Oct 2022 05:01:18 PDT
Received: from mail11.tencent.com (mail11.tencent.com [14.18.178.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA827EFDD
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 05:01:15 -0700 (PDT)
Received: from EX-SZ021.tencent.com (unknown [10.28.6.73])
        by mail11.tencent.com (Postfix) with ESMTP id CA101666F5
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 19:54:15 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1666958055;
        bh=oHNNWXzQ4vRHzoOHDStM7zuB+KkD4hA2X6R9a5imwP4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=QQkWQJLmF61mAO8tqmeuER2bFTmQSlOSF/u2DtHp+4RFltXNDGtQ6qqXbeV29RzFM
         PWxeYFvQKLVMrYBYxJjth0YdbYsWdrSgb5oaPSoBq7fP2fC8iWgYuJebTW/DSRvfjk
         v3DPr7jG/+IaXtu6d1LVR3ZEkfTegQGTrH8U2JSw=
Received: from EX-SZ065.tencent.com (10.28.6.17) by EX-SZ021.tencent.com
 (10.28.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 28 Oct
 2022 19:54:15 +0800
Received: from EX-SZ066.tencent.com (10.28.6.18) by EX-SZ065.tencent.com
 (10.28.6.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 28 Oct
 2022 19:54:15 +0800
Received: from EX-SZ066.tencent.com ([fe80::d867:3d3d:29a0:f571]) by
 EX-SZ066.tencent.com ([fe80::d867:3d3d:29a0:f571%6]) with mapi id
 15.01.2242.008; Fri, 28 Oct 2022 19:54:15 +0800
From:   =?gb2312?B?a3lsZXpoYW8o1dS/wtPuKQ==?= <kylezhao@tencent.com>
To:     Elijah Newren <newren@gmail.com>,
        Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Internet]Re: [PATCH] merge-tree.c: add --merge-base=<commit>
 option
Thread-Topic: [Internet]Re: [PATCH] merge-tree.c: add --merge-base=<commit>
 option
Thread-Index: AQHY6qVC3NS/zJ9x00+xw5p0R55C664jsZDm
Date:   Fri, 28 Oct 2022 11:54:15 +0000
Message-ID: <b517c12bef6d45238b1f88f180b51011@tencent.com>
References: <pull.1397.git.1666872761355.gitgitgadget@gmail.com>,<CABPp-BGBFyoY7m+KCA9MTifKmpZ0ccLgsYHahMCgPxuTpuUGPg@mail.gmail.com>
In-Reply-To: <CABPp-BGBFyoY7m+KCA9MTifKmpZ0ccLgsYHahMCgPxuTpuUGPg@mail.gmail.com>
Accept-Language: en-AS, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.16.12]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBOb3RlIHRoYXQgdGhpcyBoYXMgYmVlbiBpbXBsZW1lbnRlZCBwcmV2aW91c2x5LiAgSSBtYXkg
aGF2ZSBpbXBsZW1lbnRlZCBpdCBwcmV2aW91c2x5IGFuZCByaXBwZWQgaXQgb3V0IChhYm91dCBh
IHllYXIgYWdvKSwgb3IgbWF5YmUgSSBqdXN0IGF2b2lkZWQgaXQgb25jZSBJIHJhbiBhY3Jvc3Mg
dGhlIHJlYXNvbnMgYmVsb3cuICBEc2NobyBhbHNvIGltcGxlbWVudGVkIGl0IG92ZXIgYXQgaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvZ2l0L255Y3Zhci5RUk8uNy43Ni42LjIyMDIyMTA5NTY0MzAu
MjY0OTVAdHZnc2JlanZhcWJqZi5iZXQvDQo+DQo+IFlvdSBtYXkgd2FudCB0byB0YWtlIGEgbG9v
ayBhdCBoaXMgY29kZSBmb3IgY29tcGFyaXNvbiwgZXNwZWNpYWxseSB0aGUNCm1lcmdlX2luY29y
ZV9ub25yZWN1cnNpdmUoKSBzdHVmZi4NCg0KVGhhbmtzLiBJJ2xsIHRha2UgYSBsb29rIGxhdGVy
Lg0KDQo+IFRoaXMgY2FwYWJpbGl0eSBpcyBzb21ldGhpbmcgd2UgbWF5IHVsdGltYXRlbHkgd2Fu
dCBmb3IgY29tcGxldGVuZXNzLA0KPiBidXQgaXQgZGVmaW5pdGVseSBzaG91bGQgbm90IGJlIG1h
cmtldGVkIGFzIGEgYnVpbGRpbmcgYmxvY2sgZm9yDQo+IGltcGxlbWVudGluZyBjaGVycnktcGlj
ayBvciByZWJhc2UuICBUaGVyZSBhcmUgc2V2ZXJhbCByZWFzb25zIGZvcg0KPiB0aGF0Og0KPiAN
Cj4gUGVyZm9ybWFuY2UgcmVhc29uczoNCj4gICogaXQncyBhIGRlc2lnbiB3aXRoIGEgc2VwYXJh
dGUgZm9yayBmb3IgZXZlcnkgY29tbWl0IHRvIGJlIHBpY2tlZCwNCj4gLi4uLg0KPiBNYWludGVu
YW5jZSByZWFzb246DQo+ICAgKiBzdWdnZXN0aW5nIHRoaXMgY29kZSBhcyBhIGJhc2lzIGZvciBj
aGVycnktcGljayBvciByZWJhc2UgaXMNCj4gbGlrZWx5IHRvIGxlYWQgdG8geWV0IGFub3RoZXIg
c2hlbGwtc2NyaXB0ZWQgcmViYXNlOyB3ZSd2ZSBiZWVuIHRyeWluZw0KPiB0byBnZW5lcmFsbHkg
bnVrZSBzaGVsbCBzY3JpcHRzIGZyb20gR2l0IGZvciBhIHZhcmlldHkgb2YgcmVhc29ucy4NCj4g
SXQnZCBiZSBzYWQgdG8gcmVncmVzcyBoZXJlLg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgdmVyeSBk
ZXRhaWxlZCBleHBsYW5hdGlvbiwgSSBmZWVsIGxpa2UgSSBoYXZlIGEgZGVlcGVyIHVuZGVyc3Rh
bmRpbmcgb2YgcmViYXNlIGFuZCBjaGVycnktcGljay4NCg0KPiBNeSBhcG9sb2dpZXMgZm9yIGhh
dmluZyB2ZXJ5IGxpbWl0ZWQgZ2l0IHRpbWUgKHdoaWNoIGlzIG9mdGVuIGVudGlyZWx5IHVzZWQg
dXAganVzdCBpbiByZXZpZXdpbmcvcmVzcG9uZGluZyB0byBwYXRjaGVzIGFuZCBvdGhlciBxdWVy
aWVzIG9uIHRoZSBsaXN0IGluc3RlYWQgb2Ygb24gbmV3IGZlYXR1cmVzIGxpa2UgdGhpcywgb3Ig
bWF5YmUgb24gbWFraW5nIHNvbWUgbmljZSBzbGlkZXMgZm9yIGEgY29uZmVyZW5jZSk7IGlmIEkg
aGFkIG1vcmUgdGltZSwgSSB0aGluayBnaXQtcmVwbGF5IGNvdWxkIGhhdmUgZWFzaWx5IGJlZW4g
ZG9uZSBtYW55IG1vbnRocyBhZ28gKG9yIHBlcmhhcHMgZXZlbiBsYXN0IHllYXIpLiAgVGhlbiB5
b3UnZCBoYXZlIHRoZSBoaWdoIGxldmVsIHRvb2wgeW91IG5lZWQgZm9yIHNlcnZlciBzaWRlIGNo
ZXJyeS1waWNraW5nIGFuZCByZWJhc2luZy4gIEJ1dCwgSSBoYXZlbid0IGhhZCBtdWNoIHRpbWUu
ICBTbywgaXQgbWFrZXMgc2Vuc2UgdGhhdCBmb2xrcyBtaWdodCB3YW50IHRvIHVzZSBhbiBpbnRl
cmltIGhhY2sgd2hpbGUgd2FpdGluZyBmb3IgdGhlIG1vcmUgcm9idXN0IHRvb2wgdG8gbWF0ZXJp
YWxpemUuDQoNCmdpdC1yZXBsYXkgc291bmRzIGdyZWF0LCBsb29raW5nIGZvcndhcmQgdG8gaXQg
b25lIGRheS4NCg0KPiBXb3VsZCBpdCBtYWtlIHNlbnNlIHRvIGhhdmUgby0+bWVyZ2VfYmFzZSBi
ZSBhIHN0cnVjdCBjb21taXQgKiwgYW5kIG1vdmUgdGhpcyBsb29rdXAvZGllIGxvZ2ljIG91dCB0
byB0aGUgcGFyc2luZyBsb2dpYyBpbiBjbWRfbWVyZ2VfdHJlZSgpPw0KRG9uZS4NCg0KPiBhbmQg
dGhlIG5leHQgbGluZSBvZiBjb2RlLCBub3Qgc2hvd2luZyBpbiB0aGUgY29udGV4dCBoZXJlLCBp
cyBhIGNhbGwNCj4gdG8gbWVyZ2VfaW5jb3JlX3JlY3Vyc2l2ZSgpLiAgV2hpbGUgdGhhdCB0ZWNo
bmljYWxseSB3b3JrcywgaXQgZG9lc24ndA0KPiBtYWtlIGxvZ2ljYWwgc2Vuc2UuICBZb3UncmUg
bm90IGRvaW5nIGEgcmVjdXJzaXZlIG1lcmdlIHdoZW4geW91IGhhdmUNCj4gYSBzcGVjaWZpZWQg
bWVyZ2UgYmFzZSwgc28gSSB0aGluayB0aGUgY29kZSBzaG91bGQgaW5zdGVhZCBjYWxsDQo+IG1l
cmdlX2luY29yZV9ub25yZWN1cnNpdmUoKSBpbiBzdWNoIGEgY2FzZSAoc2VlIERzY2hvJ3MgY29k
ZSBmb3IgYQ0KPiBjb21wYXJpc29uIGhlcmUpLg0KRG9uZS4gSSd2ZSBjaGFuZ2VkIGl0IHRvIG1l
cmdlX2luY29yZV9yZWN1cnNpdmUoKS4gSXQgd29ya3MsICBidXQgSSBkb24ndCBrbm93IGlmIGl0
J3Mgd3JpdHRlbiBjb3JyZWN0bHksIGVzcGVjaWFsbHkgb3B0LmFuY2VzdG9yLg0KDQo+IFNvLCB0
aGUgTy1BLUIgdGhpbmcgdGhpbmcgd2FzIHRha2VuIGZyb20gdDY0MjM7IGl0IGFwcGVhcnMgSSBk
aWRuJ3QgY29weSB0aGUgY29tbWVudCBhdCB0aGUgdG9wIG9mIHQ2NDIzIG92ZXIgdG8gdDQzMDEg
dG8gZXhwbGFpbiB0aGlzLg0KPiBTb3JyeSBhYm91dCB0aGF0LiAgQW55d2F5LCBmb3IgdGhlc2Ug
dHlwZXMgb2YgY29tbWVudHMgaW4gdGhlc2UgZmlsZXMsIE8gaXMgYWx3YXlzIHRoZSBtZXJnZSBi
YXNlIG9mIGJvdGggQSBhbmQgQiwgYW5kIG5laXRoZXIgQSBub3IgQiBjb250YWluIGVhY2ggb3Ro
ZXIgaW4gdGhlaXIgaGlzdG9yeS4gIEZyb20gdGhhdCBiYXNpcywgeW91ciBkZXNjcmlwdGlvbiBo
ZXJlIG1ha2VzIG5vIHNlbnNlIChBIHdvdWxkIGJlIHRoZSB0aXAgb2Ygc29tZSBicmFuY2gsIG5v
dCB0aGUgcGFyZW50IG9mIGFueXRoaW5nKS4gIEknZCBjYWxsIHlvdXIgY29tbWl0cyBzb21ldGhp
bmcgZWxzZSAobWF5YmUganVzdCBDMSwgQzIsIGFuZCBDMyBvciBzb21ldGhpbmc/KS4NCg0KRG9u
ZS4NCg0KPiBXb3VsZCB0ZXN0X2NvbW1pdCBiZSB1c2VmdWwgaGVyZSwgZ2l2ZW4gdGhhdCB5b3Ug
YXJlbid0IHdvcnJpZWQgYWJvdXQNCj4gdGhlIGV4YWN0IGNvbnRlbnRzIG9mIGZpbGVzPw0KDQpJ
dCdzIHVzZWZ1bCwgd2hpY2ggbWFrZXMgdGhlIHRlc3QgY2xlYXJlci4=
