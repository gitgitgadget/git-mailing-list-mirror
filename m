Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51636C433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 15:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33ED160F70
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 15:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhKLPbb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 10:31:31 -0500
Received: from mout.web.de ([212.227.15.14]:36293 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230308AbhKLPba (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 10:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1636730911;
        bh=8wOqF+fHA6tdFIOe3NbjHC9K9KlSixYsqBFWUrCut+Q=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Q0xhgcvgxVsoyAKoIcVhkfhqZy8Lp/Bb+jqtbSmQhcW96BedPGUajn5LNFx5Ehm6K
         /Sws3vg3zv9MfZ46KBq0R7GqT8bqs1sMEEDSya+hrrFXLx/UaRw7MCMOAradTVhL3F
         0ht/DMOzx8hQ5+ABUE4r7KV1VqfQVlns5UHVOVRc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.20.171]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPKFF-1n4bzO28gX-00Pobg; Fri, 12
 Nov 2021 16:28:31 +0100
Message-ID: <ca9baf51-28ca-048d-ded6-f4834874f7c3@web.de>
Date:   Fri, 12 Nov 2021 16:28:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH 0/2] am: support --always option to am empty commits
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Aleen via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Aleen <aleen42@vip.qq.com>
References: <pull.1076.git.1636693095.gitgitgadget@gmail.com>
 <6da5e984-1dcf-4c55-976c-49ffb8d128bf@web.de> <xmqqy25tj2fi.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqy25tj2fi.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UvrmAKZaPJ+/PF0ctc3RDL+OT/fE0iFBjyVK7aksREWsV0afuWv
 ig8lvV98LyJ6ua2LoOVGx5aHPOsdFcOICfmnPmt2vYjTq2MBMbAsoscW+ZEdeQ+YtE26Y/u
 I0Oz8JMKXtdCenzdNV31IBPBg4HPpSTQpCR0X/vMjaRE/MHuIBarbF7L2euDMocmHr6aj9R
 lxzuXx9f1/sQZsesnDwww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uxWwyVI334I=:JCSGo9UGyRUwB1hFPF3Ou6
 o6OsTeRRcE2dhScPaBK4wkc1KpOMI3y2wPrWqqzhPUi0agzHBFtN+NgxPhMFLeWC6C0QHv3K+
 ii84pLf/qFQ/9T+XA79U2CJNTAmKxSSOkD+RpcC2YAmBe3lmaUGW/hg5RFoXsEZ09onv6ad3f
 elOXpF1MZyUI6neV59q1NuE0DEsAW3auAtIaGsrXESmJGKeDH0Tg70dXY5L4qRL8xT44s8ZlF
 Kwk5ee2pJtrxXROwpb747wCkSrNxJOATzVYg35myMmyNPAQKzpB2FtQXxzSqc26vffwBA5KLP
 OrO0DL/KbtS5vkbo0imVLSViKgovKGbunO3/5hANuDwOaHJrkJP6UFR7sHN3cfmy7pz9liBXl
 DvJtmLmpcIKvuHdZWr9HOJtaXPyZiU5ym6qiT4KLJ4/cCYeISQmGen8v4+VP5bp6jCkj1wQ3s
 JU+lc6DxTUAeREzWxH33rmRUmyLXSFk5gI9AoXpEL+CjgG9IEVv61xFAQuauQWUOYvR3Om1l0
 cHsYKJzCLXEmXJtj+LRJadThWhLBXLTgm+WMtHuRNAESJa80dKBeurcA8NR74gdHTRkaHa5Y+
 cdQwmT5JbnNnPbNArYcJ88WEsVo2DY3ec+y+3OPCWzFyRw1sM/92KCAvzYP/qGg2nmiTiErgq
 cALnBgvigbwIUUCu2Y2N30WCzaqJ6paD+UaA5E6GQ4q/iA0whd0RvLFIogS7yM/EIUl+oC8Ia
 XRkvIGjYSvkDeL95KGBQtMYFP0MDOrXIpHTc5eINGeEGDGcgUw6nYc4aM1S6ZH1gmxUebIdI4
 wPeTaDVkjfmKvYrgDU0Tvbbt19XJRnXbbbKcm8FXcmYbVveI/IDa1xa2uipCDM7xMnDVkomPW
 mRdDwaGPYUBokVk3txAvLQ8fndjFoDYFWn70gl8q5IlKN9+ZlQXKREIcLDKVyo7V6SWTSraJb
 jcWKvDwjY5NKI6zshsCJIX+eyr9oAxK137zC5weJl8NN1S0XsBaqr0kcMO/xwSK+ExfuKulFh
 UFtQllMuODbn3hTU4t4KXhnXl5RWWdlDYYEad2eFvKMHLFiVBaN+Pb56T9js8nhrMQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.11.21 um 07:47 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Am 12.11.21 um 05:58 schrieb Aleen via GitGitGadget:
>>> Since that git has supported the --always option for the git-format-pa=
tch
>>> command to create a patch with empty commit message, git-am should sup=
port
>>> applying and committing with empty patches.
>>
>> The symmetry is compelling, but "always" is quite generic.  I can see
>> e.g. someone expecting "git am --always" to imply --keep-non-patch.
>
> What symmetry?

To have the same option in both producer and consumer.

Ren=C3=A9
