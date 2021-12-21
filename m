Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F50C4332F
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 17:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240737AbhLURzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 12:55:10 -0500
Received: from mout.web.de ([212.227.15.4]:60409 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240727AbhLURzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 12:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1640109308;
        bh=y5z4SbSspCnakpn7R1wIRhPZMADqVh7JC9HClJdDzLU=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=syh2yqy0KEbbbuPaDekn8qccqgqaZrKbiD3NjAUiKXXWGYR6V/yrdyEL9j+wUjp2f
         RgFySs5pCgbM771bw84p85JgBWKH0pYFvABselica1owxz1KGn0srU1S5dNP31aasr
         5I8jztOPDXs+34pCTcllIC4UvyeA3KTHdV1acc78=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbkWQ-1mTQTF3vW2-00dQNb; Tue, 21
 Dec 2021 18:55:07 +0100
Message-ID: <cf17d437-61cc-6d01-fb12-af420c650e82@web.de>
Date:   Tue, 21 Dec 2021 18:55:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: rebase -S config option
Content-Language: en-US
To:     ?????? ?????? <nekadek457@gmail.com>, git@vger.kernel.org
References: <CAM+a_NM=xTCrNPCjpP49T8d6hPFD26d+Cu06fiSq4TiZB=DzYw@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAM+a_NM=xTCrNPCjpP49T8d6hPFD26d+Cu06fiSq4TiZB=DzYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wADf7r1BUimCT2OzlKd2NOzsCsOZEqHlBKiZ6vjyAE+Ekvu1jfB
 4CUXGbo9pWiXUSOiXFh9aI03TWhcpymJI8ixG2Ya6a/VlXB5A+jEBmds40rcc1qnv5SdNSp
 zujm4nh/j4Kl9nL5eeto15ZJvOjSC3x0r7ZSB4PT5/mCWTO9/UszyJpqKj+8GP0b0I/kHKc
 agM2wVQpChElnt77KJyaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VNpa3Z1tHEQ=:HtvExWc2l6dlj/iBB6bsys
 UsU6DwEkoFYpMQmUvCJT29I9BS25ohlV/ekXEf4nPemLsHuI8raB73Q6IGzzXBIIdbkAHfA21
 WqzF923d62T8fqfORcot/Ke4stU3Gci0oO98SMAg5lPs3JmCvpfrZrF/Mfq3SZLUDRa8u/cni
 v3g0ZT32w725N2PyUqwQcl7AXqRJHpJbRiq1ScD1fmlzgLpeQv8sh6a7bNQSveSSNfu+ldgNa
 GVJwwV3e5d/E2I9qa2nJRGFarmtG14fVX1wqeq4u48m1LiKOG5eWMojD1DOa/b7VMp2anZ2ot
 PhBTHqQt9hNR26/5+oFBv7Uz1Egk+7EMME8mxl1r2xzcQXORLa6MdGdGQDW/tXdqhDX6jrIuU
 eNFU1wxzWg1YgGLArjZ/cZpdk1ZfR5oZ/FrjzssFLkhxJpZkDpATFlEmeeaGskOOYk+tz3Hut
 1yGKsvdwXts8464h6npQeQCjhWXZIGAvrO99eVZ/RnwGg4Mbi0mm6+a2NVTa1ckE0zRpK2vbZ
 OTSiUwCKXZaxTur5vVymuA3AYm7ORguI7TaeVjENn7bqRBoepRfdd+0XvEmrODLArhZepOUDJ
 QFOpBSfi6wAF82jxrL/S4VzJU60IX4+RZY5pQztIQpDhKC78Ap6Du7EWSad6hNFn/EOFy61WQ
 pKfTwE4KQVqngk7XCCoVue6XjXNmLNI8xhvrbr7mvuY7D2ELQ6vdEQu32ygVd29/N7FupjoBz
 s72vZUybQ9lWzTLI02q47oJAx3fdGB6tnZ0gApjePMqA+jp9m7SGLZDzKm7pP+7ozWOM8bYFO
 z4m8aNesPHO3dY9z7fBrysnExBesJGhsVBaNaq6VwtMyISEoCv9CjqiSiUABm+gKYn3TF6fEB
 Iep5qiEUY24B3LDTw2xtFUaEQKgwZBu5bwkq3R2n5TbDzv8KgA97VJboUexvXjlBntX0jPmrm
 q6+TCorOdSvLxck6blGWhEZvPJmaChTfUxkNwbYwxi2jYvIGD2mvs18RPtrWz2Sw9rBMJScN6
 zk92SViPJezOEi0r3o/i4eAd79TDYWepn6Pwy7KLpiDJvNrn+svEXHI7tx3e0ZbpBEaR3M30Y
 haDaW7BLuHfDQ8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

emails are better with a subject; added one.

Am 21.12.21 um 15:44 schrieb ?????? ??????:
> Is it possible to always GPG-sign commits created by rebase operations
> by default without having to specify the -S flag?

Setting the config option =EF=BB=BFcommit.gpgsign to true should do the tr=
ick.

Ren=C3=A9
