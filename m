Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02C6C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 04:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7C4661AA7
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 04:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbhKSEUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 23:20:20 -0500
Received: from zg8tmty3ljk5ljewns4xndka.icoremail.net ([167.99.105.149]:51549
        "HELO zg8tmty3ljk5ljewns4xndka.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S231393AbhKSEUT (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Nov 2021 23:20:19 -0500
X-Greylist: delayed 7570 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Nov 2021 23:20:19 EST
Received: from mailtech.cn (unknown [10.12.1.20])
        by hzbj-icmmx-2 (Coremail) with SMTP id AQAAfwAnTMxNJZdhAtXUBQ--.5761S2;
        Fri, 19 Nov 2021 12:17:37 +0800 (CST)
Received: from pwxu$coremail.cn ( [112.94.4.17] ) by
 ajax-webmail-mailtech_rd (Coremail) ; Fri, 19 Nov 2021 12:16:48 +0800 (CST)
X-Originating-IP: [112.94.4.17]
Date:   Fri, 19 Nov 2021 12:16:48 +0800 (CST)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Aleen via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "Phillip Wood" <phillip.wood123@gmail.com>,
        Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v6 0/3] am: support --empty=(die|drop|keep) option to
 handle empty patches
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20211103(a39c0bb8)
 Copyright (c) 2002-2021 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <xmqqilwpuiv4.fsf@gitster.g>
References: <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>
 <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
 <xmqqilwpuiv4.fsf@gitster.g>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <75b05498.16b.17d36694413.Coremail.pwxu@coremail.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AgIMCgCHjFUwJZdhhQQAAA--.224W
X-CM-SenderInfo: psz03q5fruvzxdlohubq/1tbiAgULCFGCc55BmwABsh
Authentication-Results: hzbj-icmmx-2; spf=neutral smtp.mail=pwxu@corem
        ail.cn;
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBBcyBwZXIgaHR0cHM6Ly9naXQtc2NtLmNvbS9kb2NzL1N1Ym1pdHRpbmdQYXRjaGVzI3NpZ24t
b2ZmOgo+IAo+ICAgIFBsZWFzZSBkb27igJl0IGhpZGUgeW91ciByZWFsIG5hbWUuCj4gCj4gSSBz
dXNwZWN0IHlvdXIgcmVhbCBuYW1lIGlzIG5vdCBBbGVlbiwgYnV0IHNvbWV0aGluZyB3aXRoIHgg
YW5kIHcgaW4KPiBpdC4KCkJUVywgZ2l0Z2l0Z2FkZ2V0IGhhcyBkZWZpbmVkIHRoYXQgZGV2ZWxv
cGVycyBzaG91bGQgc2lnbiBvZmYgdGhlIHVzZXIgbmFtZQpvZiB0aGUgR2l0SHViIGFjY291bnQs
IGFuZCBJIGNhbid0IGNoYW5nZSBpdCBhdCBhbGwu

