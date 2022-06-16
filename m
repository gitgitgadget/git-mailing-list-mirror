Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9097EC433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 15:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377875AbiFPPL1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 11:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377470AbiFPPL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 11:11:26 -0400
Received: from mail4.tencent.com (mail12.tencent.com [61.241.47.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08660403D0
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 08:11:12 -0700 (PDT)
Received: from EX-SZ020.tencent.com (unknown [10.28.6.40])
        by mail4.tencent.com (Postfix) with ESMTP id 1320564B21;
        Thu, 16 Jun 2022 23:11:10 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1655392270;
        bh=deyIigC9JCjegOgLo1Oa3bahfxsJDED329wZ/CSqZuY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=HZOVLDcc9pf0XibV7KMfBm6pivx97l2+i7FALIFGs4lBNFiccq4bgMNXetwSQx1F4
         b9JoD2lBp4xDRDOl/maDgUUvhtQaTUscmg0aJ8fU/KmJQFU+vtZwCy7vPP+X5QI4u4
         JlYy6EpOpz7BVaxupCCLzofOJQei0g+BQmhiTn/Q=
Received: from EX-SZ066.tencent.com (10.28.6.18) by EX-SZ020.tencent.com
 (10.28.6.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 16 Jun
 2022 23:11:09 +0800
Received: from EX-SZ066.tencent.com (10.28.6.18) by EX-SZ066.tencent.com
 (10.28.6.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 16 Jun
 2022 23:11:09 +0800
Received: from EX-SZ066.tencent.com ([fe80::2186:e8b5:166c:c4ab]) by
 EX-SZ066.tencent.com ([fe80::2186:e8b5:166c:c4ab%6]) with mapi id
 15.01.2242.008; Thu, 16 Jun 2022 23:11:09 +0800
From:   =?utf-8?B?a3lsZXpoYW8o6LW15p+v5a6HKQ==?= <kylezhao@tencent.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [Internet]Re: [PATCH v2] send-pack.c: add config push.useBitmaps
Thread-Topic: [Internet]Re: [PATCH v2] send-pack.c: add config push.useBitmaps
Thread-Index: AQHYgYinu/izvWG5KES3VvhQEWA6P61SGe60
Date:   Thu, 16 Jun 2022 15:11:09 +0000
Message-ID: <be5afab25a5b44b3af797c0c8b75f5e6@tencent.com>
References: <pull.1263.git.1655291320433.gitgitgadget@gmail.com>
 <pull.1263.v2.git.1655350617442.gitgitgadget@gmail.com>,<220616.86fsk4ww69.gmgdl@evledraar.gmail.com>
In-Reply-To: <220616.86fsk4ww69.gmgdl@evledraar.gmail.com>
Accept-Language: en-AS, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.17.147]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBBbmQgc2luY2UgdGhpcyBpcyBsaW5raW5nIHRvIHRoYXQgb2xkIHRocmVhZCBJIHN0YXJ0ZWQg
aW4gMjAxOSBJIHJlYWxseQ0KPnRoaW5rIHRoZSBjb21taXQgbWVzc2FnZSBzaG91bGQgYmUgZXhw
bG9yaW5nIGFuZCBqdXN0aWZ5aW5nIHdoeSB0aGlzDQo+IG1pZ2h0IGJlIHNsb3dlciBpbiBhbGwg
Y2FzZXMsIG9yIGF0IGxlYXN0IGEgc3VmZmljaWVudCBudW1iZXIgb2YgY2FzZXMNCj4gdG8gZmxp
cCB0aGUgZGVmYXVsdC4NCj4gDQo+IGlmIGl0J3Mgbm90IGFyZSB3ZSB0aHJvd2luZyBvdXQgYSBn
ZW5lcmFsbHkgdXNlZnVsIG9wdGltaXphdGlvbiAoYnkNCj4gZGVmYXVsdCkgZHVlIHRvIHNvbWUg
ZWRnZSBjYXNlcyB3ZSd2ZSBmb3VuZD8NCg0KSSdtIG5vdCBzdXJlIGlmIGl0J3MgYW4gZWRnZSBj
YXNlLg0KSG93ZXZlciwgaWYgYSBnaXQgcmVwbyBoYXMgdGhpcyBwcm9ibGVtLCBpdCdzICJnaXQg
cHVzaCIgd2lsbCBhbHdheXMgYmUgdmVyeSBzbG93DQppbnN0ZWFkIG9mIGdvaW5nIGZhc3QgYW5k
IHNsb3cuDQoNCj4gRS5nLiBoYXZlIHlvdSB0cmllZCB0byBmb2xsb3ctdXAgb24gdGhpcyBjb21t
ZW50IGJ5IEplZmYgS2luZz8NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvZ2l0LzIwMTkwNTIz
MTEzMDMxLkdBMTc0NDhAc2lnaWxsLmludHJhLnBlZmYubmV0Lw0KDQpOb3QgeWV0LCBJJ2xsIHRy
eSBpdCBsYXRlci4NCg0KPiBBdCB0aGUgdGltZSBJIGRpZG4ndCwgYmVjYXVzZSBhcyBub3RlZCBp
biBhIGZvbGxvdy11cCBJJ2QgbG9zdCBteSB0ZXN0DQo+IGNhc2UgYnkgdGhlIHRpbWUgSSByZWFk
IHRoYXQsIGJ1dCBpdCBzZWVtcyB5b3UgaGF2ZW4ndCwgYW5kIGhhdmUgYQ0KPiBjdXJyZW50IHRl
c3QgY2FzZS4NCg0KSSB0cmllZCB0byBmaW5kIGEgdGVzdCBjYXNlIGluIG9wZW4tc291cmNlIHBy
b2plY3RzLCBhbmQgZmluYWxseSBmb3VuZCBvbmUuDQokIGdpdCBjbG9uZSBodHRwczovL2dpdGh1
Yi5jb20vSmV0QnJhaW5zL2ludGVsbGlqLWNvbW11bml0eS5naXQgLS1iYXJlDQokIGNkIGludGVs
bGlqLWNvbW11bml0eS5naXQNCiQgZ2l0IHJlcGFjayAtYWRiDQokIEdJVF9UUkFDRT0xIGdpdCBw
dXNoIC4gbWFzdGVyOnRlc3QxDQoNClRoZW4gaXQgd291bGQgZ2V0IHN0dWNrIGluICJnaXQgcGFj
ay1vYmplY3RzIiBmb3IgYWJvdXQgMTBzLiAoT1M6IFdpbmRvd3MpDQpBZnRlciBJIGRlbGV0ZWQg
dGhlIGJpdG1hcCwgImdpdCBwdXNoIiB0b29rIGxlc3MgdGhhbiAxcy4NCg0KDQo+IEkgdGhpbmsg
YSByZWFsbHkgZ29vZCBzdGFydCB3b3VsZCBiZSB0byBjb21lIHVwIHdpdGggc29tZSBiZW5jaG1h
cmtzIGZvcg0KPiBhIGZldyBjb21tb24gY2FzZXMsIGUuZy4gaG93IGRvIGJpdG1hcHMgZG8gaWYg
d2UgaGF2ZSBhIGJpZyByZXBvIGJ1dCBmZXcNCj4gcmVmcywgaG93IGFib3V0IGEgbG90IG9mIHJl
ZnM/IERvZXMgdGhlaXIgc3RhbGUtbmVzcyBtYWtlIGEgZGlmZmVyZW5jZQ0KPiBvciBub3QgKHBl
ciBwcmV2aW91cyBkaXNjdXNzaW9ucykgZXRjLiBldGMuDQoNCkFjY29yZGluZyB0byBteSBvYnNl
cnZhdGlvbiwgdGhlIHByb2JsZW0gYWx3YXlzIG9jY3VyIG9uIGdpdCByZXBvcyB3aGljaCBoYXZl
IA0KYSBsb3Qgb2YgcmVmcyBhbmQgb2JqZWN0cy4NCkFsc28sICJnaXQgcHVzaCIgIHRha2VzIG11
Y2ggdGltZSBvbiAiZmluZCBfb2JqZWN0cyguLikgZm9yIGhhdmVzX2JpdG1hcCIuDQoNCkhvcGUg
dGhlIGluZm9ybWF0aW9uIGFib3ZlIGNhbiBoZWxwIGZpbmQgdGhlIGNhdXNlIG9mIHRoZSBwcm9i
bGVtLg0KDQpUaGFua3MsDQotIEt5bGUNCg0K
