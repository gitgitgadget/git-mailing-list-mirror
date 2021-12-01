Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76D6C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 01:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241146AbhLABqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 20:46:24 -0500
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net ([209.97.182.222]:48504
        "HELO zg8tmja5ljk3lje4mi4ymjia.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1345425AbhLABqW (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 Nov 2021 20:46:22 -0500
Received: from mailtech.cn (unknown [10.12.1.20])
        by hzbj-icmmx-2 (Coremail) with SMTP id AQAAfwDnZdYm06Zhga1ZBg--.56902S2;
        Wed, 01 Dec 2021 09:43:22 +0800 (CST)
Received: from pwxu$coremail.cn ( [112.94.4.17] ) by
 ajax-webmail-mailtech_rd (Coremail) ; Wed, 1 Dec 2021 09:42:32 +0800 (CST)
X-Originating-IP: [112.94.4.17]
Date:   Wed, 1 Dec 2021 09:42:32 +0800 (CST)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>
To:     "Elijah Newren" <newren@gmail.com>
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        "Git Mailing List" <git@vger.kernel.org>,
        =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87_=28Aleen=29?= 
        <aleen42@vip.qq.com>,
        "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2021, #07; Mon, 29)
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20211103(a39c0bb8)
 Copyright (c) 2002-2021 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <CABPp-BE4uYBFnb-AgVJhNo6iK4da5hiEFEBhd=7Ea3Ov=4K4zw@mail.gmail.com>
References: <xmqqzgpm2xrd.fsf@gitster.g>
 <CABPp-BE4uYBFnb-AgVJhNo6iK4da5hiEFEBhd=7Ea3Ov=4K4zw@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <d95f092.3f.17d73a85761.Coremail.pwxu@coremail.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AgIMCgC3ihEI06ZhcAIAAA--.82W
X-CM-SenderInfo: psz03q5fruvzxdlohubq/1tbiAQcDCFGCdORg5AAAsK
Authentication-Results: hzbj-icmmx-2; spf=neutral smtp.mail=pwxu@corem
        ail.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoW7GrWkXw1kXr4kKFyUCr17Wrg_yoWDJFXEk3
        WktFnrtwsFy3yUtr43AFs8JFZrJrW8urWqyryrXrW7Z34kJrs5GF1vkryIvFyxWw45Krn8
        XFs3tr4j9r17ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
        Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
        UUUU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBQbGVhc2UgZG9uJ3QsIGF0IGxlYXN0IG5vdCB0aGlzIHZlcnNpb24uICBUaGVyZSBoYXZlIGJl
ZW4gbmV3ZXIKPiBzdWJtaXNzaW9ucyB3aXRoIHRocmVlIGNvbW1pdHMuCj4gCj4gSSBhbHNvIHN0
aWxsIGZpbmQgdGhlIHdvcmQgJ2RpZScgY29uZnVzaW5nLCBzaW5jZSB0byBtZSBpdCBzdWdnZXN0
cwo+IGFib3J0aW5nIHRoZSB3aG9sZSBhbSBvcGVyYXRpb24sIGFuZCB0aGUgZG9jdW1lbnRhdGlv
biBkb2VzIG5vdCBkaXNwZWwKPiB0aGF0IGNvbmNlcm4uICBFdmVuIGlmIHlvdSBkb24ndCBsaWtl
ICdhc2snIChmb3IgY29uc2lzdGVuY3kgd2l0aAo+IGdpdC1yZWJhc2UpLCBJIHRoaW5rICdzdG9w
JyBvciAnaW50ZXJydXB0JyB3b3VsZCBiZSBtdWNoIGJldHRlcgo+IG9wdGlvbnMgdGhhbiAnZGll
Jy4gIElmIHlvdSByZWFsbHkgd2FudCBpdCB0byBiZSAnZGllJywgSSB0aGluayB0aGUKPiBiZWhh
dmlvciBuZWVkcyB0byBiZSBleHBsYWluZWQgaW4gdGhlIGRvY3VtZW50YXRpb24sIHJhdGhlciB0
aGFuIGp1c3QKPiBhc3N1bWVkIHRoYXQgdXNlcnMgd2lsbCB1bmRlcnN0YW5kIGl0IChiZWNhdXNl
IEkgZGlkbid0IHVuZGVyc3RhbmQgaXQKPiB1bnRpbCBJIHJlYWQgdGhlIGNvZGUpLgoKRGVhcnMg
TmV3cmVuLAoKICAgIEkgZG9uJ3QgdGhpbmsgJ3N0b3AnIGFuZCAnaW50ZXJydXB0JyB3b3JkcyBh
cmUgYmV0dGVyIHRvIGV4cGxhaW4gbW9yZSB0aGFuICdkaWUnCiAgICBiZWNhdXNlIHRoZXkgc3Rp
bGwgaW5kaWNhdGUgdGhhdCBpdCB3aWxsIHN0b3Agb3IgaW50ZXJydXB0IHRoZSB3aG9sZSBhbSBz
ZXNzaW9uLAogICAgcmF0aGVyIHRoYW4gc3RvcCBpbiB0aGUgbWlkZGxlIG9mIGl0LiBJdCBtYXkg
YmUgYSBnb29kIGNob2ljZSB0byBqdXN0IGFkZCBhbgogICAgYWRkaXRpb25hbCBkZXNjcmlwdGlv
biBhYm91dCB0aGUgYmVoYXZpb3VyIHdoZW4gbm90IHBhc3NpbmcgdGhlICctLWVtcHR5JyBvcHRp
b24KICAgIG9yIHBhc3NpbmcgJy0tZW1wdHk9ZGllJy4KCkFsZWVu

