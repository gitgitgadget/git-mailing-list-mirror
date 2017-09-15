Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3CDC20281
	for <e@80x24.org>; Fri, 15 Sep 2017 19:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbdIOTdM (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 15:33:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:63062 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751648AbdIOTdL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 15:33:11 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLB89-1dtDTN09WT-000LfL; Fri, 15
 Sep 2017 21:32:56 +0200
Date:   Fri, 15 Sep 2017 21:32:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Michael J Gruber <git@grubix.eu>
cc:     git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 1/2] test-lib: group system specific FIFO tests by
 system
In-Reply-To: <a159230a-d406-c772-13f0-f82a36faf763@grubix.eu>
Message-ID: <alpine.DEB.2.21.1.1709152128000.219280@virtualbox>
References: <alpine.DEB.2.21.1.1709141440510.4132@virtualbox> <4482ae18370f3e759bf98f71e15eaab19fdd009a.1505400392.git.git@grubix.eu> <alpine.DEB.2.21.1.1709150020070.219280@virtualbox> <a159230a-d406-c772-13f0-f82a36faf763@grubix.eu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:L2iNUChHXsFRBjMoHvSa4ldHVgUbhWxayxB+FfRtgKg3eVVgvpB
 RXq4DO825yvfVDugZbu40COxA3p0stGmCIeP+3KPIMyaQFcyBf51uyX8yX2eyMA6S3UqTaI
 p43+Jlc3q2kQ5ZOmtSdnxOcBekZZ7R54n/7s3MU5iGTV98oO7yMADW6d9gG9g8zRlM8FlSj
 bIFUd5N2Zvq8RrAgfBpbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L5l48pey0yA=:oVXeV4fTCh38BFFgwTuPVU
 pqFRv3YMTdfCIzcygfdf3yLzUg1RdDLYKBXHYbMjBGbmitl1sgSIL1WrkDefwE/8EboPJINBb
 th6/+2K42mPexF/YtOzAZRH5KEQa8dFKukA16izb8BUHHcAJd/FMvO+m6X3vMTNdMoaQEEaki
 ymH4Uk/Zg7jmpzIKUwyGEOi2OlP0xQthMNPOoVbDuA0aqYwHo5nuLTclnwg8/ARQFOYT668jv
 1g+WIdKCPsF3yXNIIHQVJbsCUO+gIYmcdtQ0DKt9v6gKb1Sag8b67P/gGBrPJyudPHJpC0A42
 /j9rk0cIyCGge9+awZnTt5uFEf8DO6++DgH+bJnXU6GIizA5eXNISK2uPMvgR0iApgAX37908
 fV0vkrKtghTEaJaEBqfi2U6vGWlH29n5ArIKmlZo93cmyjlFYlpDe1EEIdyewB1WNu2fUdH7l
 zVslDsbf5C0q5aUHobiZ55YT3hiAIreKfGr/lqqnAwBIgumQhbFWQXttfIQUI2odQuTFdwEiD
 YraETARSdsdvj1fqO7AfXZ9Qm41Z3TO9LJt/55CR/BfLPa6miFt3I1GrOSO6HDqD1euWRqzTe
 D2A3nPXJaoAbK87Ss/Rpzicty5I0+suHxTQ4zSDWKIHjJPz57F+hvoeOYyY4v1+uOSNfRryaH
 nqBTW1t8/RdMZg72l0bDmHmt1TiSqJdoWgcxoD7q/DNAxYGcndduGz4WH8awAtjZU0K+bArYG
 7foC3potXu/MiUUdMpE/U9LP70qo7T8flo1iEEmZX/8iD7Z++sN3E4WMQd3KF3Dq4/uZqWGtH
 gWAHU3QqiGr2535nr2Li/7QiM3R4FHeQu9io7/D0URtLA3OPyw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Fri, 15 Sep 2017, Michael J Gruber wrote:

> Johannes Schindelin venit, vidit, dixit 15.09.2017 00:21:
> > 
> > On Thu, 14 Sep 2017, Michael J Gruber wrote:
> > 
> >> test-lib determines whether a file-system supports FIFOs and needs to do
> >> special casing for CYGWIN and MINGW. This separates those system
> >> specific settings from those at more central place.
> >>
> >> Set mkfifo()  to false in the central system specific place so that the
> >> same test works everywhere.
> > 
> > The mkfifo() emulation of Cygwin seems to work, no? I think it works even
> > in MSYS2, but not in MINGW.
> > 
> > So maybe this patch should affect only the MINGW arm?
> 
> I only reorganised the code, so in that sense the patch does not affect
> any system ;)
> 
> If indeed mkfifo works on CYGWIN than a separate patch should remove the
> exclusion of CYGWIN; alas, I can't confirm (I wish MS still had the old
> academic alliance programme).

You don't need an academic license, as there are free VMs available (they
expire after a while, though):

https://developer.microsoft.com/en-us/windows/downloads/virtual-machines

It seems that the current free VM will expire in 4 days. After that,
probably a new one will be available that expires some time later (not
sure about the exact time frame of those VMs).

Alternatively, you can download VMs meant for web testing at
https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/ which
expire after 90 days.

Ciao,
Dscho
