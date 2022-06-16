Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0E7C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 02:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343696AbiFPCNo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 22:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358565AbiFPCNd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 22:13:33 -0400
Received: from mail4.tencent.com (mail12.tencent.com [61.241.47.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC2B2714E
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 19:13:17 -0700 (PDT)
Received: from EX-SZ021.tencent.com (unknown [10.28.6.73])
        by mail4.tencent.com (Postfix) with ESMTP id 0C26B64259;
        Thu, 16 Jun 2022 10:13:15 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1655345595;
        bh=KtvNoHPxzbCHuL4GHtYLz9dMk4J+OgQ9rwGp2bYXI00=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=aKjqOReOFb3Y77JGP6gZ6TrncChUiBgXC4WGjhBm1A1zp4xM0ID6quFp6CQnRIPpj
         JXKBfx53OS5oS0kQU67qsm/ZABSvPLs5vma1aLeuJGB7F8shUnWJZMG7fOY46GZGLg
         5vmKXN0yH1L9Mlpq2e2EnBmT61v/Z9XSG0NCFcHo=
Received: from EX-SZ064.tencent.com (10.28.6.16) by EX-SZ021.tencent.com
 (10.28.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 16 Jun
 2022 10:13:13 +0800
Received: from EX-SZ066.tencent.com (10.28.6.18) by EX-SZ064.tencent.com
 (10.28.6.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 16 Jun
 2022 10:13:13 +0800
Received: from EX-SZ066.tencent.com ([fe80::2186:e8b5:166c:c4ab]) by
 EX-SZ066.tencent.com ([fe80::2186:e8b5:166c:c4ab%6]) with mapi id
 15.01.2242.008; Thu, 16 Jun 2022 10:13:13 +0800
From:   =?utf-8?B?a3lsZXpoYW8o6LW15p+v5a6HKQ==?= <kylezhao@tencent.com>
To:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Derrick Stolee" <derrickstolee@github.com>
CC:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Internet]Re: [PATCH] send-pack.c: add config push.useBitmaps
Thread-Topic: [Internet]Re: [PATCH] send-pack.c: add config push.useBitmaps
Thread-Index: AQHYgPN1IU7/ltTQ30uuE8ytt0o//a1Qdq+AgADNt1s=
Date:   Thu, 16 Jun 2022 02:13:12 +0000
Message-ID: <0c9a4b31a3884fad8b0b88c7892a7071@tencent.com>
References: <pull.1263.git.1655291320433.gitgitgadget@gmail.com>
 <220615.86edzpy9m6.gmgdl@evledraar.gmail.com>,<YqpP0b2zt0sWZD0B@nand.local>
In-Reply-To: <YqpP0b2zt0sWZD0B@nand.local>
Accept-Language: en-AS, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.17.148]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiA+IEknbSBnbGFkIHRoYXQgdGhpcyByZWZlcmVuY2VzIGBwYWNrLnVzZUJpdG1hcHNgLiBJIHdv
bmRlciBpZiB0aGF0IGNvbmZpZyBpcyBzdWZmaWNpZW50IGZvciB5b3VyIHB1cnBvc2VzOiBkbyB5
b3UgZXhwZWN0IHRvIHVzZSB5b3VyIGJpdG1hcHMgdG8gZ2VuZXJhdGUgcGFjay1maWxlcyBpbiBh
bnkgb3RoZXIgd2F5ID4gPiBJIGp1c3Qgd2FudCB0byBiZSBzdXJlIHRoYXQgdXNpbmcgcGFjay51
c2VCaXRtYXBzPWZhbHNlIHdvdWxkIG5vdCBiZSANCj4gPiBzdWZmaWNpZW50IGZvciB5b3VyIHNp
dHVhdGlvbiAoYW5kIHByb2JhYmx5IG1vc3Qgc2l0dWF0aW9ucykuDQo+IA0KPiBJIHRoaW5rIHRo
ZSBvbmx5IG90aGVyIGFmZmVjdGVkIHNjZW5hcmlvIG9uIHRoZSBjbGllbnQgc2lkZSB3b3VsZCBi
ZSByZXBhY2tpbmcuIEFuZCBpbiB0aGVvcnkgbW9zdCBjbGllbnRzIGFyZSByZXBhY2tpbmcgaW4g
dGhlIGJhY2tncm91bmQgYW55d2F5cywgc28gYW55IHNwZWVkLXVwcyBmcm9tIHVzaW5nIGJpdG1h
cHMgd291bGRuJ3QgYmUgbm90aWNlYWJsZSBhbnl3YXkuDQo+IA0KPiBJIHRoaW5rIGp1c3QgcmVs
eWluZyBvbiB0aGUgZXhpc3RpbmcgcGFjay51c2VCaXRtYXBzIGNvbmZpZyBzaG91bGQgYmUgc3Vm
ZmljaWVudCBoZXJlLg0KDQpJbiBmYWN0ICx3ZSBhbHNvIHVzZSAiZ2l0IHB1c2giIG9uIG91ciBz
ZXJ2ZXIgc2lkZS4gDQpFYWNoIGdpdCByZXBvc2l0b3JpZXMgaGF2ZSBtdWx0aXBsZSByZXBsaWNh
cyBvbiBvdXIgc2VydmVycyB0byBpbXByb3ZlIHN5c3RlbSBkaXNhc3RlciB0b2xlcmFuY2UgYW5k
IHJlYWQgcGVyZm9ybWFuY2UuDQoNCkZvciBleGFtcGxlLCBhIGdpdCByZXBvIHdpbGwgYmUgZGlz
dHJpYnV0ZWQgb24gbXVsdGlwbGUgc2VydmVycyAobGlrZSBzZXJ2ZXItMSwgc2VydmVyLTIsIHNl
cnZlci0zKS4NCklmIHVzZXIgcHVzaGVzIHRoZSBwYWNrIHRvIHNlcnZlci0xLCB0aGVuIHNlcnZl
ci0xIHdpbGwgY2FsbCAiZ2l0IHB1c2giIHRvIHRyYW5zZmVyIHRoZSBvYmplY3RzIGRhdGEgdG8g
c2VydmVyLTIgYW5kIHNlcnZlci0zLg0KQW5kIHVzZXJzIGNhbiBjbG9uZSBmcm9tIGFsbCB0aGUg
c2VydmVyIG1lbnRpb25lZCBhYm92ZS4NClVuZGVyIHN1Y2ggYSBwcm9jZXNzLCBvdXIgc3lzdGVt
IHdvcmtzIHdlbGwgbW9zdCBvZiB0aGUgdGltZS4NCg0KSWYgd2Ugc2V0IHBhY2sudXNlQml0bWFw
cz1mYWxzZSwgImdpdCB1cGxvYWQtcGFjayIgd2lsbCBhbHNvIGJlIGFmZmVjdGVkLg0KRm9yIG15
IHNpdHVhdGlvbiwgaXQgd291bGQgYmUgc3VmZmljaWVudCB3aGVuIHNldCBib3RoIHBhY2sudXNl
Qml0bWFwcz10cnVlIGFuZCBwdXNoLnVzZUJpdG1hcHM9ZmFsc2UuDQoNCj4gQnV0IEkgc3VzcGVj
dCB0aGF0IGluIHRoaXMgY2FzZSB0aGUgYml0bWFwcyBhcmUganVzdCBzaW1wbHkgc3RhbGUsIGFu
ZA0KPiB0aGF0IGEgImdpdCByZXBhY2sgLWFkYiIgb3IgbW9yZSBhZ2dyZXNzaXZlIGJhY2tncm91
bmQgbWFpbnRlbmFuY2Ugd291bGQNCj4gbWFrZSB0aGluZ3MgcXVpdGUgYSBiaXQgZmFzdGVyLg0K
DQpJdCBkb2Vzbid0IHNlZW0gdG8gYmUgdGhlIHJlYXNvbi4NCkkgaGF2ZSBhbHJlYWR5IGNhbGxl
ZCAgImdpdCByZXBhY2sgLWFkYiIgaW4gdGhpcyBjYXNlWzFdIGJ1dCB0aGF0IGRpZG4ndCBzZWVt
IHRvIGZpeCB0aGUgcHVzaCBwZXJmb3JtYW5jZSBpc3N1ZS4NCllvdSBjYW4gc2VlIHRoYXQgdGhl
IGdpdCByZXBvIGhhZCBvbmx5IG9uZSBwYWNrIGF0IHRoYXQgdGltZS4NCg0KWzFdIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2dpdC9iOTQwZTcwNWZiZTk0NTQ2ODU3NTdmMmUzMDU1ZTJjZUB0ZW5j
ZW50LmNvbS8NCg0KVGhhbmtzLA0KLSBLeWxl
