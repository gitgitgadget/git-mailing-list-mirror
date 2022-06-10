Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D14C43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237302AbiFJCim (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiFJCil (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:38:41 -0400
Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com [115.124.28.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ABF117B
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:38:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08711676|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0340052-0.0304909-0.935504;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=lilinchao@oschina.cn;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.O1KgynQ_1654828715;
Received: from Colin(mailfrom:lilinchao@oschina.cn fp:SMTPD_---.O1KgynQ_1654828715)
          by smtp.aliyun-inc.com;
          Fri, 10 Jun 2022 10:38:37 +0800
Date:   Fri, 10 Jun 2022 10:38:38 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Re: [PATCH] remote-curl: send Accept-Language header to server
References: <pull.1251.git.1654678407365.gitgitgadget@gmail.com>, 
        <220609.86leu6thon.gmgdl@evledraar.gmail.com>
X-Priority: 3
X-GUID: 3730B9E8-BACF-431E-AD2D-C416AD5D624C
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
Message-ID: <2022061010332322021051@oschina.cn>
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

U29ycnksIEkgbWlzdGFrZW5seSBzZW50IHRoZSByZXBseSBlbWFpbCB0byB5b3UgeWVzdGVyZGF5
LCBJIHNob3VsZCBjbGljayAiUmVwbHkgYWxsIiBidXR0b24gOigKCj4KPk9uIFdlZCwgSnVuIDA4
IDIwMjIsIExpIExpbmNoYW8gdmlhIEdpdEdpdEdhZGdldCB3cm90ZToKPgo+PiBGcm9tOiBDYWN0
dXNpbmhhbmQgPGxpbGluY2hhb0Bvc2NoaW5hLmNuPgo+Pgo+PiBHaXQgc2VydmVyIGVuZCdzIGFi
aWxpdHkgdG8gYWNjZXB0IEFjY2VwdC1MYW5ndWFnZSBoZWFkZXIgd2FzIGludHJvZHVjZWQKPj4g
aW4gZjE4NjA0YmJmMihodHRwOiBhZGQgQWNjZXB0LUxhbmd1YWdlIGhlYWRlciBpZiBwb3NzaWJs
ZSksIGJ1dCB0aGlzIGlzCj4+IG9ubHkgdXNlZCBieSB2ZXJ5IGVhcmx5IHBoYXNlIG9mIHRoZSB0
cmFuc2ZlciwgdGhhdCdzIEhUVFAgR0VUIHJlcXVlc3QgdG8KPj4gZGlzY292ZXIgcmVmZXJlbmNl
cy4gRm9yIG90aGVyIHBoYXNlcywgbGlrZSBQT1NUIHJlcXVlc3QgaW4gdGhlIHNtYXJ0IEhUVFAK
Pj4gdGhlIHNlcnZlciBzaWRlIGRvbid0IGtub3cgd2hhdCBsYW5ndWFnZSBjbGllbnQgc3BlYWsu
Cj4+Cj4+IFRoaXMgcGF0Y2ggdGVhY2hlcyBnaXQgY2xpZW50IHRvIGxlYXJuIGVuZC11c2VyJ3Mg
cHJlZmVycmVkIGxhbmd1YWdlIGFuZAo+PiB0aHJvdyBhY2NlcHQtbGFuZ3VhZ2UgaGVhZGVyIHRv
IHNlcnZlciBzaWRlLiBPbmNlIHNlcnZlciBnZXQgdGhpcyBoZWFkZXIKPj4gaXQgaGF2ZSBhYmls
aXR5IHRvIHRhbGsgdG8gZW5kLXVzZXIgd2l0aCBsYW5ndWFnZSB0aGV5IHVuZGVyc3RhbmQsIHRo
aXMKPj4gd291bGQgYmUgdmVyeSBoZWxwZnVsIGZvciBtYW55IG5vbi1FbmdsaXNoIHNwZWFrZXJz
Lgo+Cj5JIG1heSBiZSBtaXNzaW5nIHNvbWV0aGluZywgYnV0IHRoaXMgaXMganVzdCB0aGUgIkFj
Y2VwdC1MYW5ndWFnZSIgcGFydAo+b2YgdGhpcyBjaGFuZ2UsIGkuZS4gdGhlcmUgaXMgbm8gInJv
dW5kLXRyaXBwaW5nIiBoZXJlIG9mIGFjdHVhbGx5IGRvaW5nCj50aGUgd29yayBvbiB0aGUgc2Vy
dmVyIG9mIGRvaW5nIHNldGxvY2FsZSgpLCBubz8KWWVzLCDCoGhlcmUgR2l0IGp1c3QgaG9sZHMg
dGhpcyBoZWFkZXIgbWVzc2FnZSwgYW5kIHRoZSBhY3R1YWwgd29yayBkZXBlbmRzCm9uIHRoZSBn
aXQgc2VydmljZSBwcm92aWRlcnMsIGxpa2UgR2l0aHViLCBHaXRsYWIsIG9yIEdpdGVlLsKgCj4K
PkkgdGhpbmsgdGhlIGVuZC1nb2FsIG9mIGhhdmluZyB0aGUgInJlbW90ZTogIiBtZXNzYWdlcyB0
cmFuc2xhdGVkLCBpZgo+cG9zc2libGUsIGlzIHZlcnkgd29ydGh3aGlsZSwgYnV0IEknZCBhbHdh
eXMgaW1hZ2luZWQgd2UnZCBkbyB0aGF0IHdpdGgKPmEgcHJvdG9jb2wgZXh0ZW5zaW9uLCBiZWNh
dXNlIGV2ZW4gaWYgd2UgZG8gdGhpcyB3aXRoIEhUVFAgaGVhZGVycyB3ZQo+d29uJ3QgZ2V0IHRo
ZSBzYW1lIG92ZXIgc3NoL2dpdCB0cmFuc3BvcnRzLgpBcyBmb3Igc3NoIHRyYW5zcG9ydCwgY2Fu
IHdlIHVzZSBzc2ggZW52aXJvbm1lbnQgdG8gcmVhY2ggb3VyIGdvYWw/Cj4KPkJ1dCB0aGVuIGFn
YWluIHdlIGRvbid0IGhhdmUgcHJvdG9jb2wgdjIgcHVzaCB5ZXQgOigKPgo+U28gcGVyZmVjdCBj
ZXJ0YWlubHkgc2hvdWxkbid0IGJlIHRoZSBlbmVteSBvZiB0aGUgZ29vZCBoZXJlLCBJIGp1c3QK
PndvbmRlciB3aGF0IHRoZSBlbmQtZ29hbCBpcyBhbmQgaWYgdGhlcmUncyBhIHBsYW4gdG8gZ2V0
IHRoZXJlLgoKVGhhbmtzLg==

