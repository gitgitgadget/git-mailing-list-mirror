Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD4D91F516
	for <e@80x24.org>; Thu, 28 Jun 2018 16:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935063AbeF1QYY (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 12:24:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:55957 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934824AbeF1QYW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 12:24:22 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M70HF-1gJp7J37eX-00wl6c; Thu, 28
 Jun 2018 18:24:12 +0200
Date:   Thu, 28 Jun 2018 18:23:56 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Makefile: fix the "built from commit" code
In-Reply-To: <20180628132314.GA14026@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1806281809060.73@tvgsbejvaqbjf.bet>
References: <pull.7.git.gitgitgadget@gmail.com> <e0e41d0b88b4104737b9ee80710c1bec91c9d759.1530190395.git.gitgitgadget@gmail.com> <20180628132314.GA14026@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8soMhyYm5/r+dKze1EcAQ2JrmZXDLJpDYjAWEd0yDLMGY8bqb1v
 EEWzWO0WXyHa1vNe9UeUyzdnEvRqh07KrjDJta3sQI7Sz1lDQ2v7j4Brtueh9CcP3xzJWiU
 4jPgWmTobqBjfBVPQ/RusRYjXjPMAV2tjQtsnuj9mTAUp3CtSJqu1OvXpXOtE4awwGZuKSo
 YtOcveWyjUnfNpNQeiNIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ud81PyZjEcM=:miJJGCGpbHZZnsSeTiRf6U
 xzpgaZ+Y4qTqS1QBlsCQqNlfzH7SQ0aTUcz7kGVPeBRfdQZSTQLdLP2K63Xe7wFdftSxjWL2o
 CP3K9zMO1z8OLGDLJiEBcP4wIMYgdefpx1mS2wyBCBSAbUIYANtcEDN2FhuI7nEsHlvuJStS0
 VPDTN4ggxVjk0qP5PQI6kzu41daEOZT269DQwiTIv/y7vimHQMqsjdqEBV/fHFAMajyfsWpT4
 1T5eywAdN+UWrUZf1boqZisVz+qaqAwgvFwoZhAE5vTQUBXWLVJj38og+ApsvOU+lx79ZMQVe
 0fNteahYH2UjEmFGvAAg4b7MpXtymfEX2z4cJAHQSILX/RnfaUpIobArqcUM79BM7bsY4betM
 amnLxXvP4AFPde2XeQENXnJHOFvwxKpM2nwWbjJymIKLwOPfCmlUxXtoSnLU+F0iZqwL+Wcri
 ZKdZ9JybYNgjjjp4Qu+nJBWAjM5rRUaVVHOwcy+SXCACaJ3sfgtlTNLytumOCqOtH618EZfxt
 qoOvFSI8Zg/nD2Zzf48VGyjV7tLNjY6P0y1qmA1CbMxvWLbyzYx6X4Pl8hH5+0b41wpJNflTg
 3WZVDMJLDliV0QyXHKUu2Rh0K69Z/vPEUEWPw3dSz11vIyYBPKqgTM/mgk/JQVGxgPO9SH3gt
 hYd1qaAXP0rOZl20+wMSZwQnSbK29D7K986qyHbiEJ2zQH3tWozW5UDefgoEUl046U9byYDp0
 /7Fu52x7gWDZsLdrZKg1JPcr+VlFueQkfw4AtY2JneB3HNeaJtKrubG+7rXzwp1csxTebpxsR
 Ta1rKvZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 28 Jun 2018, Jeff King wrote:

> On Wed, Jun 27, 2018 at 09:35:23PM +0200, Johannes Schindelin via GitGitGadget wrote:
> 
> > To prevent erroneous commits from being reported (e.g. when unpacking
> > Git's source code from a .tar.gz file into a subdirectory of a different
> > Git project, as e.g. git_osx_installer does), we painstakingly set
> > GIT_CEILING_DIRECTORIES when trying to determine the current commit.
> > 
> > Except that we got the quoting wrong, and that variable therefore does
> > not have the desired effect.
> > 
> > Let's fix that quoting, and while at it, also suppress the unhelpful
> > message
> 
> I had to stare at the code for a bit to figure out what was wrong:

Do you want me to update the commit message?

> > -	'-DGIT_BUILT_FROM_COMMIT="$(shell GIT_CEILING_DIRECTORIES=\"$(CURDIR)/..\" \
> > -		git rev-parse -q --verify HEAD || :)"'
> > +	'-DGIT_BUILT_FROM_COMMIT="$(shell \
> > +		GIT_CEILING_DIRECTORIES="$(CURDIR)/.." \
> > +		git rev-parse -q --verify HEAD 2>/dev/null)"'
> 
> The issue is that the $(shell) is resolved before the output is stuffed
> into the command-line with -DGIT_BUILT_FROM_COMMIT, and therefore is
> _not_ inside quotes. And thus backslashing the quotes is wrong, as the
> quote gets literally inserted into the CEILING_DIRECTORIES variable.
> 
> I thought at first we could not need the quotes in the post-image
> either, because shell variable assignments do not do word-splitting.

> I.e.:
> 
>   FOO='with spaces'
>   BAR=$FOO sh -c 'echo $BAR'
> 
> works just fine.

	$ x="two  spaces"

	$ echo $x
	two spaces

Maybe we should quote a little bit more religiously.

> But $(CURDIR) here is not a shell variable, but rather a Makefile
> variable, so it's expanded before we hit the shell. So we need the
> quotes. And unfortunately it also breaks if $(CURDIR) contains exotic
> metacharacters. If we cared we could use single quotes and $(CURDIR_SQ),
> but I suspect it would be far from the first thing to break in such a
> case.
> 
> Which is a long-winded way of saying the patch looks correct to me.

Thanks ;-)

Ciao,
Dscho
