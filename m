Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDCC6207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 22:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032173AbdD0WvY (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 18:51:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:58997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423514AbdD0Wu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 18:50:58 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MGB7j-1dHqM7254x-00FCVZ; Fri, 28
 Apr 2017 00:50:44 +0200
Date:   Fri, 28 Apr 2017 00:50:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/26] Address a couple of issues identified by
 Coverity
In-Reply-To: <CAGZ79kbbHshh4=WC2ymG15=W5oq98b3KTV4zxiTx0LgCLeYwfQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1704280010160.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <CAGZ79kbbHshh4=WC2ymG15=W5oq98b3KTV4zxiTx0LgCLeYwfQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Am0JIntzU3DWWYslPV/optZ1evcKuceRI9cPyuekjbPtSH0D5gv
 lWZrpKyCsN+MWi8jpbpH5dIGQT9EqF4s06Vc9qjYR+BD8D/E+2/UaDCQ3iAwz1hYr6d1YZ/
 0nIVncHA7zc6VzOeWRLNFem1TYQSE+6n6gLhChz8zCXTWUOpegGWhMRaZLW1820YHUxceC9
 Wknjj6neLIVmU7GpMm27g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Kc2TaA0tSfU=:GtyjEyXTCvDfmqPL1XVNTm
 v0quOq881TGPTcjhfe3chexB/EeQBy63xwojeZITjtr3zQTCk1eP+VD/+NCCe+cnBPw2GhQ5a
 Jhxe7Uy/gtBANXnriZOijyRpONIRpElKeXnQVc5SwGUOQ96FQV+qsJT3dtZW32KYml3AHydIB
 4ayDM0mOsZtw4Tqam6RtItZ5lnSU6g0lPQR4ixdH8cM49d2h/7BJtzeXAhw5JvWlMokwMRnmE
 aKEbQi6zSBtJE6nhplnwPuE9oTt2hQXpRi3owTLBG8PyhKqR1J2Oq68os0fa7b3bvbkjnEruT
 sIiTspcjSJ6muKkTgM+qGFL/Rkd7xYPgIeSVTnPFk5ZUBjGx9FD+eNA1h3UKssUmrtiQQoji2
 qjweedF9HM449wlrnbDW+49OVW1e6zw7HS/d47y3V8pm7g/95HzWETghfUB1nNEF0SQn/LeiO
 tFIb0IMz2dCzLdh2y+yp4daUMFC2ZuXCLrLHlYKDRUIXP/TSrtzmexSyvn3CMeUpcnCkQus51
 luXRYwGxiFPuBtF5qaL9c7L9b/th+CECfrlNcjr68dQQFLahvgvY9Klgyj2OXuDOhOzdQCewD
 ym3aAF3p8Kbeoo3LH5EhNn1n1aaQZx+Yevsxx9lK7wviUvM4/KKb/FCgGq0eoRj0Os3iuvChR
 n5W4CmBMQVU1UO/wTbCjr0x1qj9lf//uPyU7OPit7KuAuTpVRkNJgeQ5544SYur+vMX+fDyU2
 VZXCE42AVArB5AW06sjMKwOpmdrEFaS4ha1RXmnWO3BBsa5I1UaqSln2bfZtUfJ95AYvClZ4f
 b2O03GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Wed, 26 Apr 2017, Stefan Beller wrote:

> On Wed, Apr 26, 2017 at 1:19 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > I recently registered the git-for-windows fork with Coverity to ensure
> > that even the Windows-specific patches get some static analysis love.
> 
> YAY! How do you trigger the coverity scan?

For starters, I did everything manually. But I already have the grand plan
to use VSTS build (I do not want to advertise this system too blatantly,
but I have to say that I really love working with that system, it is so
much more powerful than Travis or AppVeyor, Jenkins comes closer but not
by far).

As you may have glimpsed in one of my mails, Git for Windows needs a very
special and extensive build setup. I call it the "Git for Windows SDK",
and what it is, in a nutshell, is a custom MSYS2 installation that has all
the packages installed that are needed to build Git for Windows, its most
important dependencies, and to bundle everything in an installer. Think of
MSYS2 as something like Homebrew. But cozier, as it really lives inside
its own directory tree, its /etc/ is not really visible to any other
software, for example.

This makes Continuous Testing a bit of a challenge, as you cannot hammer
the package repository of MSYS2 with tons of fresh full installations all
the time (that package repository is run by a volunteer, and it is
sometimes unreachable, too).

So after talking to a GitHub guy at the Developer Summit during GitMerge
(Patrick asked a couple of questions and then said my plan was okay), I
put two new repositories up that host the initialized Git for Windows
SDKs (one for 32-bit, one for 64-bit).

And of course there is a job to keep them up-to-date, run once every 24h.

Almost all of the VSTS builds I maintain clone or update one or both of
these repositories.

And so will also the Coverity job.

I still have to find the time to figure out one more detail: how to
download and extract the Coverity tool (the .zip archive has a variable
name for the top-level directory), and doing that only every once
in a while, say, only when there is no previously unpacked tool, or it is
already 4 weeks old.

And then I should probably try to figure out a way how to delay subsequent
runs of that job so that we run it at most once every twenty-four hours.

Ciao,
Dscho
