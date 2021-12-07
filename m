Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A648C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 01:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbhLGCCc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 21:02:32 -0500
Received: from zg8tmty3ljk5ljewns4xndka.icoremail.net ([167.99.105.149]:51630
        "HELO zg8tmty3ljk5ljewns4xndka.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229958AbhLGCC2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Dec 2021 21:02:28 -0500
Received: from mailtech.cn (unknown [10.12.1.20])
        by hzbj-icmmx-2 (Coremail) with SMTP id AQAAfwCXucnqv65hP4GzBg--.2877S2;
        Tue, 07 Dec 2021 09:59:26 +0800 (CST)
Received: from pwxu$coremail.cn ( [112.94.4.17] ) by
 ajax-webmail-mailtech_rd (Coremail) ; Tue, 7 Dec 2021 09:58:36 +0800 (CST)
X-Originating-IP: [112.94.4.17]
Date:   Tue, 7 Dec 2021 09:58:36 +0800 (CST)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Elijah Newren" <newren@gmail.com>,
        "Git Mailing List" <git@vger.kernel.org>,
        =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87_=28Aleen=29?= 
        <aleen42@vip.qq.com>,
        "Aleen via GitGitGadget" <gitgitgadget@gmail.com>,
        "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2021, #07; Mon, 29)
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20211103(a39c0bb8)
 Copyright (c) 2002-2021 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <xmqqa6hdb3sx.fsf@gitster.g>
References: <xmqqzgpm2xrd.fsf@gitster.g>
 <CABPp-BE4uYBFnb-AgVJhNo6iK4da5hiEFEBhd=7Ea3Ov=4K4zw@mail.gmail.com>
 <d95f092.3f.17d73a85761.Coremail.pwxu@coremail.cn>
 <CABPp-BG9jHaJYekDnvZT+8QW_fLGM_bmz-oOqzJswaotyVDFBA@mail.gmail.com>
 <211203.861r2tsfej.gmgdl@evledraar.gmail.com>
 <CABPp-BGE5Ff=adH3nREMDm38DGLEmtRTcPwuJowHw-ckwpbmqQ@mail.gmail.com>
 <211203.86wnklqx05.gmgdl@evledraar.gmail.com>
 <30b4169a.18.17d8d589b6d.Coremail.pwxu@coremail.cn>
 <xmqqilw2i6w1.fsf@gitster.g>
 <6fa17536.18b.17d8e7c7a09.Coremail.pwxu@coremail.cn>
 <xmqqwnkhhck4.fsf@gitster.g>
 <584bbe43.e.17d926d909f.Coremail.pwxu@coremail.cn>
 <xmqqa6hdb3sx.fsf@gitster.g>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1f1d7b66.4a.17d929d357c.Coremail.pwxu@coremail.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AgIMCgD3QGTMv65hoAIAAA--.125W
X-CM-SenderInfo: psz03q5fruvzxdlohubq/1tbiAQcJCFGCdOS0KAABsZ
Authentication-Results: hzbj-icmmx-2; spf=neutral smtp.mail=pwxu@corem
        ail.cn;
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBBZGRpbmcgYW4gb3B0aW9uIHRoYXQgYWJvcnRzIGFuZCB0cmFzaGVzIHRoZSBzdGF0ZSBkaXJl
Y3RvcnkgaXMgbXVjaAo+IHdvcnNlIHRoYW4gbm90IGhhdmluZyBhIGNob2ljZSBvdGhlciB0aGFu
IGRyb3AgYW5kIGtlZXAsIHdoaWNoIGlzIGluCj4gdHVybiBhIGJpdCB3b3JzZSB0aGFuIGhhdmlu
ZyBhIHdheSB0byBjb3VudGVybWFuZCBhbiBvcHRpb24gdGhhdCB3YXMKPiBnaXZlbiBlYXJsaWVy
IG9uIHRoZSBjb21tYW5kIGxpbmUuCgpBbm90aGVyIG9wdGlvbiB0byBjb3VudGVybWFuZCBhbiBv
cHRpb24gaXMgb25seSBtZWFuaW5nZnVsIHdoZW4gaXQgY2FuIGJlCmFwcGxpZWQgYXMgYSByZXN1
bWUgdmFsdWUgYnV0IG5vdCBpbiBzdWNoIGEgY2FzZSwgSSB0aGluay4gIi0tZW1wdHk9PG9wdGlv
bj4iCmlzIG9ubHkga2VwdCBpbiBlYWNoIGFtIHNlc3Npb24sIGFuZCBpdCBzZWVtcyB3ZSBjYW4n
dCBjb3VudGVybWFuZCB0aGUgb3B0aW9uCmFmdGVyIHRoZSBzZXNzaW9uLg==

