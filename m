Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19537C43334
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 10:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiGEKGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 06:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiGEKGi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 06:06:38 -0400
Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A947BE82
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 03:06:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1490888|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0456005-0.014202-0.940197;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=lilinchao@oschina.cn;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.OKWRorv_1657015584;
Received: from Colin(mailfrom:lilinchao@oschina.cn fp:SMTPD_---.OKWRorv_1657015584)
          by smtp.aliyun-inc.com;
          Tue, 05 Jul 2022 18:06:26 +0800
Date:   Tue, 5 Jul 2022 18:06:25 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Re: [PATCH] remote-curl: send Accept-Language header to server
References: <pull.1251.git.1654678407365.gitgitgadget@gmail.com>, 
        <220609.86leu6thon.gmgdl@evledraar.gmail.com>, 
        <2022061010332322021051@oschina.cn>, 
        <xmqq1qv3m2rf.fsf@gitster.g>
X-Priority: 3
X-GUID: D54D3756-979D-4417-80A8-CF6F29766D9B
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
Message-ID: <202207051804341356418@oschina.cn>
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiJsaWxpbmNoYW9Ab3NjaGluYS5jbiIgPGxpbGluY2hhb0Bvc2NoaW5hLmNuPiB3cml0ZXM6Cj4K
Pj4+SSB0aGluayB0aGUgZW5kLWdvYWwgb2YgaGF2aW5nIHRoZSAicmVtb3RlOiAiIG1lc3NhZ2Vz
IHRyYW5zbGF0ZWQsIGlmCj4+PnBvc3NpYmxlLCBpcyB2ZXJ5IHdvcnRod2hpbGUsIGJ1dCBJJ2Qg
YWx3YXlzIGltYWdpbmVkIHdlJ2QgZG8gdGhhdCB3aXRoCj4+PmEgcHJvdG9jb2wgZXh0ZW5zaW9u
LCBiZWNhdXNlIGV2ZW4gaWYgd2UgZG8gdGhpcyB3aXRoIEhUVFAgaGVhZGVycyB3ZQo+Pj53b24n
dCBnZXQgdGhlIHNhbWUgb3ZlciBzc2gvZ2l0IHRyYW5zcG9ydHMuCj4+Cj4+IEFzIGZvciBzc2gg
dHJhbnNwb3J0LCBjYW4gd2UgdXNlIHNzaCBlbnZpcm9ubWVudCB0byByZWFjaCBvdXIgZ29hbD8K
Pgo+Tm90IHJlYWxseS7CoCBCZWZvcmUgZm9yY2luZyB1cyB0byBpbnZlbnQgY29tcGxldGVseSBz
ZXBhcmF0ZQo+bWVjaGFuaXNtcyBmb3IgZGlmZmVyZW50IHRyYW5zcG9ydHMsIGl0IGlzIGEgdmVy
eSBnb29kIGlkZWEgdG8KPmNvbnNpZGVyIGlmIHdlIGNhbiB1c2UgYSBzaW5nbGUgbWVjaGFuaXNt
IHRoYXQgY2FuIGFwcGx5IHRvIGFsbAo+dHJhbnNwb3J0cy7CoCBBZGRpbmcgc29tZXRoaW5nIGF0
IHRoZSBwcm90b2NvbCBsZXZlbCB3b3VsZCBiZSBhCj5zdGVwIGluIHRoZSByaWdodCBkaXJlY3Rp
b24uCkkgd29uZGVyIGlmIHdlIGNhbiB1c2UgYSBuZXcgcHJvdG9jb2wtY2FwYWJpbGl0eSBsaWtl
IGxvY2FsLWxhbmcgb3LCoApzb21ldGhpbmcgZWxzZSwgdGhlbiBHaXQgY2xpZW50IGFuZCBzZXJ2
ZXIgY2FuIHRlbGwgZWFjaCBvdGhlcidzIGxhbmd1YWdlCmFiaWxpdHkgaW4gdGhlwqBuZWdvdGlh
dGlvbiBzdGFnZS4=

