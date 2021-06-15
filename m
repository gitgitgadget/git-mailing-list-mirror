Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182E1C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 21:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC327613B1
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 21:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFOVGz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 17:06:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:54985 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229898AbhFOVGy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 17:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623791084;
        bh=T6Efy2uIGm5n064yu/bu3xLBflA36+bNo5aiqF66z64=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fWbTXOJnCibv9bvuz5wMIPIQqWeb5EoWlWKejQor6JmMgGCo7qtghRARPmHcnngYe
         V2Ejw3AMTjbCICTT+rlI/Ui1KWmrVp7RdokXYAndpO72QvBnROyGw+d6DOIFr6TWQy
         zGj/x+nFpT6MuB73aDf5tagZIMZd5529XrUfZl3g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.214.113]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfHAH-1lMfRY35ND-00gorr; Tue, 15
 Jun 2021 23:04:43 +0200
Date:   Tue, 15 Jun 2021 23:04:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Julian Verdurmen via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org,
        Julian Verdurmen <julian.verdurmen@outlook.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add support for C# record types
In-Reply-To: <pull.971.git.git.1614646689506.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2106152130590.57@tvgsbejvaqbjf.bet>
References: <pull.971.git.git.1614646689506.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yBbOVV6aXAEUX8ak3b3mEHaeW4zPFweocRLOv2xj0Eouv7ris2Z
 sRvlYnKS/agtWgEqBGl6SnYwj1NBr15Ui9CfDDbfJ/MbpGkO+pd61MFukbraoaAfhiRo/m5
 19dVaPAn89w+96YpzNWurWgUzSO/8Yncu3sOihGyIF9NQBmoCghJx3JQY8aL831wzZB134y
 FjydOfwrg95SC7Q6rwzhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zt2mBF747gs=:j8MD11BtdR3b1w8GfqbXst
 C1PQbvS2w7XuRuFOApyJi+WjKSyho8tquK7KxxjF1+KQpWR2Q1X5BxZ7NInlUz6jhoN0233qB
 h0jk/p2WQFUJcLShoQMxrNPj1opgIbnoDELq612zQh8stvSSqoAlc3oQ9/OOrvICyyUCIVyvH
 t6I9rMPcGy6Nd8xEuRupa/fxWoUH5+OlU7f+cYkyTLsyfG1MN57dFIkoUMm4mifMkBHn1ELBb
 IJcsQCOncbuZU5cxXZXLvAp1wdK2FVNFsmaqOJ5rQVvoZwn1OXc5YKI4f++sNwKy7B6hcaPMI
 wl1tCtYD0qpGLpTWswKMcOhVjNFlvw6PkBUi9UK8K1y87hOLZL3+2QdkPURmQGGHLPy6f8j4x
 fix5DuUPJEaMNiuPabe/+QE1v5DlaCLbCsyesdrApghovN83miTepFijYhRstNEPfT1JGbTUP
 IRP91eJ0aIpLgM1XgMVCeKlMDHyIEDMb2iqQw+xpJ21h7hrkysGG2f31+gNPUnCKXs9FUQWGW
 qIQAz13hsnj7LzVhjjFjku6pO9BCokWayeI3xzpKfrPU2JVkyvvHGlZ5wzkEzvuHKfu7a31+Y
 Z1YenvFLJP0iw5/s6RD2bayd7pet5caaKnF0Iw4IzE8V6ohMhgYFJoZO5+a/U1T1YKtRrHU82
 eDZGCu3NEvsgboHnQsn6XKv/J4p7mOOdWhTvXF0TAzwhAh41J7+E5j903tVYyB7Anzd+e686Q
 hWvDmZoVJIBMmIFZ4kiUs3uGHyZfZWnb5BGcXpMf0zXyzCyA+zxWt2Pm9p4RzHR7VPIPUxyvH
 Pmcot/0MYmNDj0kBTfxL9+M8fQ62dqVpGHs3Upq9afTKYtkchc+R0PhcFjPAMdDqieQq90JG6
 sbVzvjHBi403sLwA5LsZe73tHSuszE27KjXU1gzGaWSs33BicReKflwxcvox1KhITEDROE313
 fs1QpnTKURYa5OQLBtceCJNeMXXkADshO9hrgUd3snCv3MXpCBfGBXsjpYnGjGxhgRoxw07wv
 CmrWQBLoc+ew3zfd1JLvZa7i3Duqc+wa5BgRcv3121/X/L3QSHBtQXEER2OUdBPO4JgyjThGd
 unCz6OEcLsqKMmahyK9j9mpqKSxUqZmJNyJfVgLp0jd4nX8B47eg3XaiQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Julian,

On Tue, 2 Mar 2021, Julian Verdurmen via GitGitGadget wrote:

> From: Julian Verdurmen <julian.verdurmen@outlook.com>
>
> Records are added in C# 9
>
> Code example :
>
>     public record Person(string FirstName, string LastName);
>
> For more information, see:
> * https://docs.microsoft.com/en-us/dotnet/csharp/whats-new/csharp-9
>
> Signed-off-by: Julian Verdurmen <julian.verdurmen@outlook.com>

I am not precisely a C# _expert_, but from what I understand this patch
and commit message look good to me.

Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks,
Dscho

> ---
>     userdiff.c: Added support for record types in C#
>
>     Support for C# 9 records. See
>     https://docs.microsoft.com/en-us/dotnet/csharp/tutorials/exploration=
/records
>
>     I will try to use gitgitgadget [https://gitgitgadget.github.io/]
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-97=
1%2F304NotModified%2Fcsharp-record-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-971/3=
04NotModified/csharp-record-v1
> Pull-Request: https://github.com/git/git/pull/971
>
>  userdiff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/userdiff.c b/userdiff.c
> index 3f81a2261c5e..2803683c3117 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -212,7 +212,7 @@ PATTERNS("csharp",
>  	 /* Properties */
>  	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|seale=
d|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*=
$\n"
>  	 /* Type definitions */
> -	 "^[ \t]*(((static|public|internal|private|protected|new|unsafe|sealed=
|abstract|partial)[ \t]+)*(class|enum|interface|struct)[ \t]+.*)$\n"
> +	 "^[ \t]*(((static|public|internal|private|protected|new|unsafe|sealed=
|abstract|partial)[ \t]+)*(class|enum|interface|struct|record)[ \t]+.*)$\n=
"
>  	 /* Namespace */
>  	 "^[ \t]*(namespace[ \t]+.*)$",
>  	 /* -- */
>
> base-commit: 328c10930387d301560f7cbcd3351cc485a13381
> --
> gitgitgadget
>
>
