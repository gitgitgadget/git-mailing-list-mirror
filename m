Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107D2C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 07:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbiKVHr5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 02:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKVHry (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 02:47:54 -0500
Received: from mail10.tencent.com (mail10.tencent.com [14.18.183.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5343210EE
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 23:47:40 -0800 (PST)
Received: from EX-SZ019.tencent.com (unknown [10.28.6.74])
        by mail10.tencent.com (Postfix) with ESMTP id 835762A1B1;
        Tue, 22 Nov 2022 15:47:37 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1669103257;
        bh=+uH3Zn5jUF9BXmuTGKWsXory5qb6hp1SJRANVRnogzM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=mpBp5E8pJeV3MpE7MPKh31rHvApKnq9QhSQ9YT7kpqEC72cqe68GGKGCEv09R+IbO
         z0dpJWIZWBNJijfm07XvJnMcGDPD6oq2t0LFdJ0lF2TVrbR1uEmU9jtb4Pi0bsCPDW
         E0VVh8jN5qysmgTTK81wBNt/xukEjbYjcGKAi/Iw=
Received: from EX-SZ065.tencent.com (10.28.6.17) by EX-SZ019.tencent.com
 (10.28.6.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 22 Nov
 2022 15:47:37 +0800
Received: from EX-SZ066.tencent.com (10.28.6.18) by EX-SZ065.tencent.com
 (10.28.6.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 22 Nov
 2022 15:47:37 +0800
Received: from EX-SZ066.tencent.com ([fe80::d867:3d3d:29a0:f571]) by
 EX-SZ066.tencent.com ([fe80::d867:3d3d:29a0:f571%6]) with mapi id
 15.01.2242.008; Tue, 22 Nov 2022 15:47:37 +0800
From:   =?utf-8?B?a3lsZXpoYW8o6LW15p+v5a6HKQ==?= <kylezhao@tencent.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: RE: [Internet]Re: Re: [PATCH v7 1/2] merge-tree.c: add
 --merge-base=<commit> option
Thread-Topic: [Internet]Re: Re: [PATCH v7 1/2] merge-tree.c: add
 --merge-base=<commit> option
Thread-Index: AQHY/ire02sdvdb1TkyyCKI8YjptZq5Kbg00gAAYP+A=
Date:   Tue, 22 Nov 2022 07:47:36 +0000
Message-ID: <ea04a44ca4a6475f99619c0fb997ecff@tencent.com>
References: <pull.1397.v6.git.1667472621.gitgitgadget@gmail.com>
        <pull.1397.v7.git.1668210314.gitgitgadget@gmail.com>
        <1cf1c69b8e8e8e81eccc42b5d8efc605a36ab7eb.1668210314.git.gitgitgadget@gmail.com>
        <xmqqsfibsn9o.fsf@gitster.g>    <3e5cdd224d76499bbddf55b0b649439b@tencent.com>
        <xmqqcz9fsjdr.fsf@gitster.g> <xmqqr0xvr1e5.fsf@gitster.g>
In-Reply-To: <xmqqr0xvr1e5.fsf@gitster.g>
Accept-Language: en-AS, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.17.249]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBJIGFtIGEgYml0IHRvcm4gb24gdGhpcywgdGhvdWdoLg0KPiANCj4gQmVjYXVzZSBpdCB1c2Vz
IGxvb2t1cF9jb21taXRfcmVmZXJlbmNlX2J5X25hbWUoKSB0byBvYnRhaW4gYmFzZV9jb21taXQN
Cj4gaW4gYWRkaXRpb24gdG8gcGFyZW50MSBhbmQgcGFyZW50MiwgYW5kIHRoZW4NCj4gZ2V0X2Nv
bW1pdF90cmVlKCkgb24gdGhlbSB0byBnZXQgdGhlaXIgdHJlZXMsIHRoZSByZWFsX21lcmdlKCkg
ZnVuY3Rpb24gaW4gdGhlDQo+IHBvc3RlZCBwYXRjaCBpcyBpbmNhcGFibGUgb2YgYWNjZXB0aW5n
IGEgc2luZ2xlICJwcmV0ZW5kIGFzIGlmIHRoaXMgdHJlZSBvYmplY3QgaXMNCj4gdGhlIGNvbW1v
biBhbmNlc3RvciB0cmVlIiBhbmQgbWVyZ2luZyB0aGUgdHdvIHRyZWUgb2JqZWN0cy4gIEJ1dCBv
bmNlIHRoYXQNCj4gZmxhdyBpcyBmaXhlZCwgdXNpbmcNCj4gbWVyZ2VfaW5jb3JlX25vbnJlY3Vy
c2l2ZSgpIHdpdGggYW4gZXhwbGljaXRseSBnaXZlbiAiYmFzZSIsIHdlIGNhbiBtZXJnZQ0KPiB0
b3RhbGx5IHRyZWVzIHJlZ2FyZGxlc3Mgb2YgaG93IHRoZSBjb21taXRzIHRoZXkgYXJlIGZvdW5k
IGluIGFyZSByZWxhdGVkIGluIHRoZQ0KPiBoaXN0b3J5LCB3aGljaCBpcyBhIHZlcnkgbG9naWNh
bCB0aGluZyB0byBkby4NCj4gQW5kIHdoaWxlIG9wZXJhdGluZyBpbiB0aGF0IG1vZGUsIHRoZXJl
IGlzIG5vIHdheSB0byBhY2NlcHQgbW9yZSB0aGFuIG9uZQ0KPiAiYmFzZSIuDQo+IA0KPiBTbywg
SSB3b3VsZCBiZSBQRVJGRUNUTFkgSEFQUFkgaWYgdGhpcyBuZXcgbW9kZSBvZiBvcGVyYXRpb24g
Y2FuIHRha2Ugb25seQ0KPiBvbmUgImJhc2UiIHRyZWUgb2JqZWN0LCBpZiBpdCBhbGxvd3MgQkFT
RSwgUEFSRU5UMSwgYW5kIFBBUkVOVDIgdG8gYmUgYWxsIHRyZWUNCj4gb2JqZWN0cywgbm90IG5l
Y2Vzc2FyaWx5IGNvbW1pdCBvYmplY3RzLg0KPiANCj4gQnV0IGlmIHdlIGluc2lzdCB0aGF0IFBB
UkVOVDEgYW5kIFBBUkVOVDIgbXVzdCBiZSBjb21taXRzLCB0aGVuIEkgd291bGQgZmluZA0KPiBp
dCB2ZXJ5IHVuc2F0aXNmeWluZyBpZiB3ZSBvbmx5IHRvb2sgYSBzaW5nbGUgQkFTRSB0aGF0IGFs
c28gbXVzdCBiZSBhIGNvbW1pdC4gIElmDQo+IHRoZSBtZXJnZS1iYXNlIGhhcyB0byBiZSBhIHRy
ZWUgb3IgdHJlZXMsIHRoZW4gdGhlcmUgaXMgbm8gd2F5IHRvIHBlcmZvcm0NCj4gcmVjdXJzaXZl
IG1lcmdlIChiZWNhdXNlIHlvdSBjYW5ub3QgY29tcHV0ZSBjb21tb24gYW5jZXN0b3JzIGFjcm9z
cyB0cmVlDQo+IG9iamVjdHMpICwgc28gaXQgaXMgcGVyZmVjdGx5IGp1c3RpZmlhYmxlIHRvIHRh
a2Ugb25seSBhIHNpbmdsZSBiYXNlIChhbmQgZXJyb3Igb3V0DQo+IHVwb24gc2VlaW5nIGEgc2Vj
b25kIC0tbWVyZ2UtYmFzZT1YIG9wdGlvbikuDQo+IA0KPiBCdXQgaXQgaGFzIHRvIGJlIGEgY29t
bWl0LCB0aGVuIHRoZXJlIGlzIG5vIGp1c3RpZmljYXRpb24gdG8gZm9yYmlkIHJlY3Vyc2l2ZQ0K
PiBvcGVyYXRpb24sIGFuZCBJIGRvIG5vdCBzZWUgYSBnb29kIHJlYXNvbiB0byB0YWtlIG9ubHkg
b25lIENPTU1PTiB0aGluZy4NCj4gDQo+IFNvLCBpdCBpcyBlYXN5IHRvIHNheSAibGV0J3MgdGFr
ZSB0aGUgY3VycmVudCBwYXRjaCBhcyBhIGdvb2QgZmlyc3Qgc3RlcCIsIGJ1dCBpdCBpcw0KPiB1
bmNsZWFyIHdoYXQgdGhlIGdvb2Qgc2Vjb25kIHN0ZXAgd291bGQgYmUuDQoNClllYWgsIEkgdGhp
bmsgc28uICANCkluIGZhY3QsIEkgcGxhbm5lZCB0byBpbXBsZW1lbnQgYSB2ZXJzaW9uIHRoYXQg
c3BlY2lmaWVzICpvbmx5IG9uZSogbWVyZ2UtYmFzZQ0KYXQgdGhlIGJlZ2lubmluZyBhbmQgbWFk
ZSB0aGUgZm9ybWF0IG9mIHRoaXMgb3B0aW9uIHdvdWxkIGJlIHBvc3NpYmxlIHRvDQpleHRlbmQg
dG8gc3VwcG9ydCBtdWx0aXBsZSBiYXNlcyBhbmQgb2N0b3B1cyBhdCB0aGUgc2FtZSB0aW1lLg0K
DQo+IA0KPiBXZSBjb3VsZCBjb3JyZWN0IHRoZSBjb2RlIHRvIGFsbG93IFBBUkVOVDEsIFBBUkVO
VDIgYW5kIEJBU0UgdG8gYmUgdHJlZQ0KPiBvYmplY3RzLCBub3QgbmVjZXNzYXJpbHkgY29tbWl0
cywgd2hlbiBvbmx5IGEgc2luZ2xlIG1lcmdlLWJhc2UgaXMgc3BlY2lmaWVkLg0KPiBUaGF0IGNv
cnJlY3RzIHRoZSBjdXJyZW50IGZsYXcgdGhhdCB0cmVlIG9iamVjdHMgY2Fubm90IGJlIHVzZWQu
ICBBbmQgdGhlbiB3aGVuDQo+IG1vcmUgdGhhbiBvbmUgQkFTRSBpcyBnaXZlbiAob3Igbm8gQkFT
RSBpcyBnaXZlbi0tLXdoaWNoIGlzIHRoZSBvcmlnaW5hbCBjb2RlKSwNCj4gd2UgY291bGQgY29y
cmVjdCB0aGUgY29kZSB0byBjYWxsIG1lcmdlX2luY29yZV9yZWN1cnNpdmUoKSBpbnN0ZWFkLg0K
DQpJIHByZWZlciB0aGlzIHNvbHV0aW9uLg0KDQo+IA0KPiBCdXQgdGhlIGFtb3VudCBvZiB0aGUg
ZWZmb3J0IHRvIGdldCB0aGVyZSBmcm9tIHRoZSBjdXJyZW50IGNvZGViYXNlICh3aXRob3V0DQo+
IHlvdXIgcGF0Y2gpIGZlZWxzIG1vcmUgb3IgbGVzcyB0aGUgc2FtZSBiYWxscGFyayBhcyB0aGUg
cGF0Y2ggaW4gcXVlc3Rpb24sIHNvLi4uDQoNCkl0IG1lYW5zIHdlIG5lZWQgdG8gc3VwcG9ydCBz
cGVjaWZ5aW5nIG11bHRpcGxlIGJhc2VzIGluIHRoZSBmaXJzdCB2ZXJzaW9uLCB3aGljaCBtYWtl
cw0KbWVyZ2UtdHJlZSBjb21tYW5kIG1vcmUgY29tcGxldGUuIFNpbmNlIGluZGl2aWR1YWwgbWVy
Z2UtdHJlZSBzdXBwb3J0IG11bHRpcGxlIGJhc2VzLCANCi0tc3RkaW4gbW9kZSBzZWVtcyB0byBu
ZWVkIHRvIHN1cHBvcnQgdGhpcyB0b28uDQoNCkhvd2V2ZXIsIEkgY2FuJ3QgdGhpbmsgb2Ygd2hl
biB0aGUgdXNlciBuZWVkcyB0byBtYW51YWxseSBzcGVjaWZ5IG11bHRpcGxlIGJhc2VzIGZvciBh
IG1lcmdlIDspLg0KSW4gb3RoZXIgd29yZHMsIGRvIHdlIHJlYWxseSBuZWVkIHRvIHN1cHBvcnQg
bXVsdGlwbGUgYmFzZXMgaW4gdGhlIGZpcnN0IHZlcnNpb24/DQoNClRoYW5rcywNCkt5bGUNCg0K
DQoNCg==
