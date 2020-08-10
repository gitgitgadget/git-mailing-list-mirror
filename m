Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3274C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 14:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF95C2070B
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 14:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="N/qujlBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgHJOSr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:18:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:40779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbgHJOSr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 10:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597069125;
        bh=ZLEeGQhrjnzUyNZ33ptBGbt7lZqWnFGRJWkBAoGwzoM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=N/qujlBWZQX3UsmISyCUc+uQ0Q3TSoJK1C9HTa77KoQD/Uu3p4mcp3EjPycpiHQxp
         4CMipD0vP3d6WwwbtpbrO+NNuiGUCviqy/XNxpNtnxKLaVs8f7tlatfTtqjMk6niTg
         rjahYi93UIEWb0RV4LBsYuv2WFIgpP1U+Z0RKKp4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.90.36] ([213.196.212.215]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4JmT-1k4rWG01b7-000MHu; Mon, 10
 Aug 2020 16:18:45 +0200
Date:   Mon, 10 Aug 2020 16:18:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] gitworkflows.txt: fix broken subsection underline
In-Reply-To: <20200718201723.10889-1-martin.agren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2008101618130.50@tvgsbejvaqbjf.bet>
References: <20200718201723.10889-1-martin.agren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1172072539-1597069124=:50"
X-Provags-ID: V03:K1:7FbHQfeaEd6FjABtMWKo+1xBKS6KzzaBi7QrY69+byYX/fZDNoX
 Uz7A4vmn7lqRJi4F2wWyknxFaC/iRpH3uPtAZ7XHGWUUOuA36pIvdJf8i5Q3NKPbJfvX7Am
 hiYEO4uhSt4kCXqHAHyZypSvGo/hTCi3suviNGV9EF6xqth0vv82DrAiHrKSrTPCeKyEx/+
 g/5feGwsNG/fM6Fj65F4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WUo7bUD+dNA=:rKSK0EIGceD2frzKv3rPVb
 gjisIbzyo7FIRMXUQHwc6O17haTS42tY85nRYNaIn2j3Wt9ZG1v58mz/SgXzhY0Z/+NQvcR0G
 mmIg2hzNAnBECJhN9yGB4J3h1r9InRIpuNCxrreaZnP0Vk3+43IivPbaznOH6Sa0LvYiBRNQF
 N0RvM1+aMd0s9BNXi5NB1jhppvGg9YvKH07cjeidZzXC8JZyTOvFxY81xYBzqaLNGFhr42s4D
 t7sAtQNJy9r7CwgQGHzOjd8qq6b4DD7uyuSufYr4mQwlLHMVBcbeeI9rv3amjUOpke37C6K38
 2rrKQjiRJbV22QpATcUv6p9Zb5/O2V7reqb9IY1wf5+gYUBc/kvZbmTJdL3/TLO/eooMsDsoK
 XlazJzs4BzhFQvB8o05lvqiBw+QJbhBW+1RYLvcBIN9s5pSGBSm2vEeKmq0wwD9QvUgjMkSTO
 J243yOxPakgeYFujcOQuDSwKTeR0J5sEymMa8Y+bTzmIe32Qkr8RdQfn5bGkjQpaI291b+nGg
 d3Uy44l04qWdwi+wZQYeYVCV6B+wwQmeqkTaCM5m/NrT9Em1AXOHO/WWNwbENEZtjWCiFCCMS
 c3vLxSKSYgEEZJZhwqFdOfxY86+xSPEQZJNEbhBtOKkGD2v66iNthCp8yTGI1PU1Okw+gUYhP
 otIhk5g3y1VA6C26UDjbGjB6sXFrlrdR83pWVOQrqIWwFLR1TfozY0IYjDI3G9uGJghzpdeHF
 kpKtZ29WG6ULpDV2VNjJMLvMobWtYYH6RI+Ihr4s9JmjqUx/ARWjCJ6PpsBqPxiwQ8dLsHthf
 diO8IRIuAHAC6pIldIJBNLhT4W8T+PLmBO5WOMyqHOYz5SFI9gM/H2e2IeUcPHbRrhyNGbX4X
 x71QYo3XKwpGkpsLGhDhnFQJVHOJSQvcQhLoXF+LrwcIZee0TqKVBvIZMwFhLjua8RjDQmfGs
 o0iUMZ9iKEWlQyvKSeF3Zxacemi3Y5HaWmZ6xEZeWvlNlBpbdOkPBh7DTNRgSqL9aHFE36l05
 zB6u/GHgkyaO3Tcis/arx7TISO5VdZy37xJVD0N+JdSt1EwEFOQGoR9KbDbLyVUlDdJCgf+L/
 5H5as///sr0n0xZlj6JlBbnM3FRIs8v7QrZSno2tHd2ULnO+R+ghg13ky/EnrkcNPEpExWXWQ
 FL15hxY2TDiw5aAOD3HtuU6v0JWUO9FeI39iIeZtTOuW8wCHO7U/P1GHiUCoI6v1CY597mliF
 A/2TaIOqt7heD8Fg0PumiQ6Jzq4txiTW2ZuyfXQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1172072539-1597069124=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On Sat, 18 Jul 2020, Martin =C3=85gren wrote:

> AsciiDoctor renders the "~~~~~~~~~" literally. That's not our intention:
> it is supposed to indicate a level 2 subsection. In 828197de8f ("docs:
> adjust for the recent rename of `pu` to `seen`", 2020-06-25), the length
> of this section header grew by two characters but we didn't adjust the
> number of ~ characters accordingly. AsciiDoc handles this discrepancy ok
> and still picks this up as a subsection title, but Asciidoctor is not as
> forgiving.

Thanks for catching that _before_ the release. Much, much appreciated!

Ciao,
Dscho

>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  Documentation/gitworkflows.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows=
.txt
> index 2db7ba7842..47cf97f9be 100644
> --- a/Documentation/gitworkflows.txt
> +++ b/Documentation/gitworkflows.txt
> @@ -292,7 +292,7 @@ described in the previous section.
>
>
>  Branch management for next and seen after a feature release
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>  After a feature release, the integration branch 'next' may optionally b=
e
>  rewound and rebuilt from the tip of 'master' using the surviving
> --
> 2.28.0.rc1
>
>

--8323328-1172072539-1597069124=:50--
