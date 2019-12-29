Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2419C2D0C0
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 20:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F5A20748
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 20:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="QdforRQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfL2URh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 15:17:37 -0500
Received: from mout.gmx.net ([212.227.17.20]:56369 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbfL2URh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 15:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577650655;
        bh=w9uxwbSflXLIFZMbDXPrfvLqjt15i3m8SHcJMoKOnBc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QdforRQFlAumt6d85jnvmZzudKmC4zzIZu5lTQeqAn33sMXL2FWdSOZSL7mQfR+kG
         8cz9G/Yjhu/H+7fCIsxYSCFpG4fY9BHX3xgzba8bqG4PYK/Rtrj7tsBpGKMO8VYSg0
         uv1zjR6sy3Q2U9gNM2baSrg3Ds5SnmWGVNVn//AA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIx3C-1j1fgS41pC-00KNsD; Sun, 29
 Dec 2019 21:17:35 +0100
Date:   Sun, 29 Dec 2019 21:17:20 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 10/15] bugreport: add config values from safelist
In-Reply-To: <20191213004312.169753-11-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.1912292115530.46@tvgsbejvaqbjf.bet>
References: <20191213004312.169753-1-emilyshaffer@google.com> <20191213004312.169753-11-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GbamY+dlCreAqa1l6M9HFhU2062Sji/p0lXl2OAACPrHLi9lmB4
 uib5Pphh6nQPjVrsvlAhrfQZnz8GbAa+jTIxeMxeClbgDim0+IRHg1FMH42ZqDvkvDHp2R7
 QH1VWwZoaniDfuUNZYfb4lKZQGLZ6zK8/GCQxA+epneEYP1aNPQfwJr/8m5m1+f7bfOc+/C
 BoFofU7qKLV3LgsxMzQxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RvYCqPuyVYk=:sbjiyTLQvgCbqaauWliwta
 R8uB4Zoriz5j6yFKvqqOKkbwYDuwbg444CkmmVJMBS2JP/Hthh5krgIti9LrUpK0yvFfZdJ/S
 Afs1N7KfpFi+2iwdrgsQmEriSVOlvWq5nH/qyIHd8sRejWgKFgyK32MiYxSBXVTg/ES5QG/an
 rjWZ5A8yMqaopLsyuBk+QINCKS/TgYUFW+us2c4pxOEY+uh0Z/5c6RWt0Qu2ModQ2iTbxdpCB
 06KqnI4ZjMxgqmwObMuUKzeoBIvgv0XGdix24Y3yECREtAgarSjZLF0WVE8HfAaAhL0N13NFS
 SRT5w+t4X4w/MzfZDUYuB0EsY/oPC6zDlbCtyjiUgbksBU/Oea2ki8cDPvI8Z/4apVAZZ/0ux
 2EPF8QkjOyHlxotUXsUvuEho/XJyc4QZHtTgmMbG+SUYLPV1dtkNWsvhcM9Ho7K7S4KBzx2tN
 EFW79DlaSKoC744TFMo4X38SGr5UZgMSfq3GnMbehsTDP2yz1gjsICzAH78ZD5sjYToJV6pXQ
 mbXXN8AR7EQDJXClXP7Bq7HARHF9kt2+o1rm6ArpeFJqk9mn85eBhvItFu992ZnrXOGYbjj01
 pSU5ZGH3KOgXj5ifrsDtyMDLayzpF6e76Pghs5eQm+h5pFK38Jw7GyYJIq8odMTT6HqyH81KY
 1FuLnKthomf+OpEh1rzjLncr/tCxqDltWBAOxopOQ/NCYQ1FbVzpU1c/cHtwPYQBFr/zP4rtc
 Mr9UU2JYh7NWXL1jHtn3CIAX+4L5IJpiy3NCpqgb1Nqlmx/0jHehgkBENHdNwXK/QQHKE5dtg
 PWJUBS+40cW0aEBcpaynleaiIN+hoCma6JMRyduhNUXcTdgQZ1HQ21oNVO1ohTbgVfhuXQtxD
 P+1GrGYVEupvxD/RcLn5WPyJAphqwVsqHbN3CiAdAYoy7lEOUKZ3rZIk2dn7jMv0XbN0hzJHe
 /rwr0N9OnO/++j8QTAtCtnjFB/rTCGQWgXk4seK6VnANlsuo/EWgTusH+sE3x79fcg6TUpAMg
 LU0oJq3XXonqZEb2qYr20W+T1YFyw45dO+v7Pe8+KKs0wxLK9DCCnHbuqSWZEvtFwiOqF72Sg
 8xc/T32U0DkcFi5r/zJ0rnmNc3oOCyTh4GqRrtrEn4JaYvti41LFiI7TVhX9K1pGY7joMMtEn
 lFa8gEyHBToyCyMTgrM1HwJ9v8BGy6wAjcGwakZLlekF4yp+jldzLfvwCY89+1Sy0MWvv10ZS
 Fuf+7JH5yskfek5fgQzuEtzcFOqO52wQvXQCaQExwfPP7mPZU6P/lzgxUX+Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Thu, 12 Dec 2019, Emily Shaffer wrote:

> diff --git a/bugreport.c b/bugreport.c
> index 759cc0b0f8..1fca28f0b9 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -6,6 +6,9 @@
>  #include "help.h"
>  #include <gnu/libc-version.h>
>  #include "run-command.h"
> +#include "config.h"
> +#include "bugreport-config-safelist.h"
> +#include "khash.h"

Seems that this patch makes things fail in the CI build
(https://dev.azure.com/gitgitgadget/git/_build/results?buildId=23830&view=results):

-- snipsnap --
bugreport.c:10:10: fatal error: 'bugreport-config-safelist.h' file not found
#include "bugreport-config-safelist.h"
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.
Makefile:2395: recipe for target 'bugreport.o' failed
make: *** [bugreport.o] Error 1
make: *** Waiting for unfinished jobs....

