Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AA2C1F437
	for <e@80x24.org>; Thu, 26 Jan 2017 11:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbdAZLiV (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 06:38:21 -0500
Received: from mout.gmx.net ([212.227.15.15]:59164 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751112AbdAZLiT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 06:38:19 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lx8vJ-1cPdp60Ttp-016d6w; Thu, 26
 Jan 2017 12:37:49 +0100
Date:   Thu, 26 Jan 2017 12:37:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Fixing the warning about warning(""); was: Re: [PATCH] difftool.c:
 mark a file-local symbol with static
In-Reply-To: <546179e0-1d6e-86f7-00cf-e13218b76de1@kdbg.org>
Message-ID: <alpine.DEB.2.20.1701261226220.3469@virtualbox>
References: <20161201040234.3rnuttitneweedn5@sigill.intra.peff.net> <xmqq60n3bjel.fsf@gitster.mtv.corp.google.com> <20161201185056.eso5rhec7izlbywa@sigill.intra.peff.net> <20170122052608.tpr5pihfgafhoynj@gmail.com> <20170124142346.u3d7l6772mtkgpcf@sigill.intra.peff.net>
 <xmqqlgu0ceia.fsf@gitster.mtv.corp.google.com> <20170124230500.h3fasbvutjkkke5h@sigill.intra.peff.net> <alpine.DEB.2.20.1701251135090.3469@virtualbox> <20170125183542.pe5qolexqqx6jhsi@sigill.intra.peff.net> <xmqq7f5iakxw.fsf@gitster.mtv.corp.google.com>
 <20170125220101.et67ebkumsqosaku@sigill.intra.peff.net> <546179e0-1d6e-86f7-00cf-e13218b76de1@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ecwtHSIlb+NoSh9LPhE1farsoemR0Aq+9hnAnZB//IVAu3JTY+7
 hH6AJgXRTS5xkrruVAhZQgQKZ/T6FFy7olt67eADWtZk9kYjucd2vAASsAIt5VUW5U2xNQH
 Q/QB8inBH9ZexH3TdHajnz5EGDTDXKItshWY/4TZ0fNUgGClGlwAZ5G3KCFp8IyQgt5KjZU
 u5lGD1zVTAsE++BTNxYzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sGxF9wmeSx4=:W768mi2mkv6YIpKsXz1G+b
 lj/VgiKrX2LVhSsMV57Sc3jpx1dODfHORtnaRnHEQ3f4OFE3z26yGZXJmjloJQLlzrdGXyKqP
 dEHWFD9Esd3wTD803zncOvxy2XIiVw0Kzf0OI+Yy49+flAAhg9S8uz60n9F12I1AkBfLTR8Yo
 fppo0XDgx/KYP7yoK37HiU6P/9pim1tp59PJzj427oLzRtIbEL2mPWA5dFpH1YYatHl/WW6oV
 V/SvA9qnIeiMvLpySYcdLPLIWMWFvW8rIiaH7qnMciWo//E3Q95uW92YoNmZaNBY/HADG78xY
 vUn2k+ScNoxHSLpuKz5RpWcnjpCEhchfFZRpUC25ocZDqrs9U9WiDnWReinSRIyqjoY+2T0Kz
 1wJBdRcDoZaX7O9ZvKNrV38smKQ2aLhV9mt5C/ZJEAc+MWXI2jtDsrAcYyABg7OOwiSAlyEsV
 aVZeyfrroGI0Z8pDsHmDEUf1FhyNBWIgdHkuhcbbeBAPi+Ri3G3JwH/IzHa+iNbysK2Ul99Us
 8Zv41JBP7CwYOzP12vKcFDnjcxJozvkq5G9iX+UfMGhw9zOr9WzpP9yhAjjTzJL+ciru84loj
 050pf77OQWh206KH4kgtvddSSFUfRxLTa4nAIwb3mOlw2V7UJsq1NrEotRkAiAzRkpaw0hH6s
 qnEalej0cS3qwhQAxWHaY+4JCHxptXayMPpfeEj9B2LEvI75TRGDoZ59uu90ys3pEWwjRp7TB
 Jjb48ybyxqiZdhkJ0TaxWaDYaftEQzahXQnQaOlYpnPZ4bBocDKIWpT2XaolL+Jfsh4+ASTUz
 aWxPlEB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Thu, 26 Jan 2017, Johannes Sixt wrote:

> Am 25.01.2017 um 23:01 schrieb Jeff King:
> > +#pragma GCC diagnostic ignored "-Wformat-zero-length"
> 
> Last time I used #pragma GCC in a cross-platform project, it triggered
> an "unknown pragma" warning for MSVC.

It is starting to become a little funny how many ways we can discuss the
resolution of the GCC compiler warning.

And it starts to show: we try to solve the thing in so many ways, just to
avoid the obviously most-trivial patch to change warning(""); to
warning("%s", "") (the change to warning(" "); would change behavior, but
I would be fine with that, too).

I am not really interested in any of these complicated workarounds. If you
gentle people decide they are better in Git's source code, go ahead. I do
not have to like what you are doing, I just have to work with it.

> (It was the C++ compiler, I don't know if the C compiler would also
> warn.) It would have to be spelled like this:
> 
> #pragma warning(disable: 4068)   /* MSVC: unknown pragma */
> #pragma GCC diagnostic ignored "-Wformat-zero-length"
> 
> Dscho mentioned that he's compiling with MSVC. It would do him a favor.

I am compiling with MSVC, and the idea is to tap into that large number of
Windows developers who Git traditionally has had a really bad time
attracting. From that perspective, I would say it would not only do me a
favor, but anybody who builds Git for Windows using Visual Studio.

But we also have to consider whether it would do anybody a "dis-favor".
#pragma statements are by definition highly dependent on the compiler. I
have no idea whether there are developers out there building Git with
C compilers other than GCC, clang or MSVC (as I did back in the days on
IRIX and HP/UX), but there is quite the potential for problems here [*1*].

To keep Git's source code truly portable, the #pragma would have to be
guarded by a GCC-specific #ifdef ... #endif.

Ciao,
Dscho

Footnote *1*: This is just another instance where a discussion on the Git
mailing list reminds me of
http://thedailywtf.com/articles/The_Complicator_0x27_s_Gloves, as it tries
to avoid an obvious solution by trying to come up with a different
solution that in turn requires additional solutions to additional problems
caused by the alternative solution.
