Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8228DC433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 06:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbhLFGuG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 01:50:06 -0500
Received: from azure-sdnproxy.icoremail.net ([207.46.229.174]:49921 "HELO
        azure-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S237921AbhLFGuD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Dec 2021 01:50:03 -0500
Received: from mailtech.cn (unknown [10.12.1.20])
        by hzbj-icmmx-2 (Coremail) with SMTP id AQAAfwD3H9Dnsa1hfiakBg--.6530S2;
        Mon, 06 Dec 2021 14:47:03 +0800 (CST)
Received: from pwxu$coremail.cn ( [112.94.4.17] ) by
 ajax-webmail-mailtech_rd (Coremail) ; Mon, 6 Dec 2021 14:46:32 +0800 (CST)
X-Originating-IP: [112.94.4.17]
Date:   Mon, 6 Dec 2021 14:46:32 +0800 (CST)
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
In-Reply-To: <6fa17536.18b.17d8e7c7a09.Coremail.pwxu@coremail.cn>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <62165e8.18e.17d8e7e7909.Coremail.pwxu@coremail.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AgIMCgBX9f_Isa1hzwUAAA--.12W
X-CM-SenderInfo: psz03q5fruvzxdlohubq/1tbiAQcICFGCdOSm8AABsS
Authentication-Results: hzbj-icmmx-2; spf=neutral smtp.mail=pwxu@corem
        ail.cn;
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAgICAgY2FzZSBFUlJfRU1QVFlfQ09NTUlUOgo+ICAgICAgICAgcHJpbnRmX2xuKF8oIlBhdGNo
IGlzIGVtcHR5LlxuIgo+ICAgICAgICAgICAgICAgICAgICAgIklmIHlvdSB3YW50IHRvIHJlY29y
ZCBpdCBhcyBhbiBlbXB0eSBjb21taXQsIHJ1biBcImdpdCBhbSAtLWFsbG93LWVtcHR5XCIuIikp
Owo+IAlkaWVfdXNlcl9yZXNvbHZlKHN0YXRlKTsKClNvcnJ5IGZvciB0aGUgbWlzc2luZyAiYnJl
YWsiIGhlcmUuCgo+ICAgICBjYXNlIERJRV9FTVBUWV9DT01NSVQ6Cj4gICAgICAgICBhbV9kZXN0
cm95KHN0YXRlKTsKPiAgICAgICAgIGRpZShfKCJQYXRjaCBpcyBlbXB0eS4iKSk7Cj4gICAgICAg
ICBicmVhazsK

