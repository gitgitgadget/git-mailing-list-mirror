Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE8591F859
	for <e@80x24.org>; Sat,  6 Aug 2016 21:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbcHFV7g (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 17:59:36 -0400
Received: from mout.gmx.net ([212.227.15.18]:59056 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625AbcHFV7f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 17:59:35 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LeMWL-1at2Zj327R-00q9qN; Sat, 06 Aug 2016 10:19:54
 +0200
Date:	Sat, 6 Aug 2016 10:19:52 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] nedmalloc: work around overzealous GCC 6 warning
In-Reply-To: <xmqqpopnxkfv.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608061014170.5786@virtualbox>
References: <cover.1470326812.git.johannes.schindelin@gmx.de> <57360f4885bdd5c36e190bea288f1e1f7f706071.1470326812.git.johannes.schindelin@gmx.de> <57A3BA26.5080601@web.de> <xmqqk2fwyx8h.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608051728380.5786@virtualbox>
 <xmqqpopnxkfv.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:g+N/doZtlchBmcpV+NSUsuFPUM5zLp3fiSFt5AnXY8jCmwr09HY
 6cEo8MdKDl372ySs7KCCZdV29uGsnKc+ubkLTpWNUpbIdPd6NI7jG27F+pDJuLrhhW2VPI3
 iTabSvlhVfNzK+sea+WOA6vsJDOiwwvGGZCpJmvJELS++9YydJa+tYIPhcE6wKBnJA3llvi
 kta4s1VYF1iVuNl595gOA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:CCzm8AyGMRE=:gdcyTU49R9Vd/VjRYVD+UW
 LBs0Elz1NmP9bb/IUz3GJOgPjw/zoTFOlr2MikyJ2McjCVaKzU/G2WYmOt6y8m3SSJ7vJNt1P
 Kzf5z8R2RwtPwkpm5mENtTqLUKsAOr2mYh+ys1Xg/vGq5SprkrJBblm3XTv87dHXE/em4yfx+
 30WFHnbungu0uvQXtgK6I82He3+qgGJxBeZDOqyiwPMM+QiFL8aJRVwSfyz8TtODksznJuW67
 ngQ2Roj+GY1yndExzBTdFn3mfMaCGK/1XiPACJ6l4nulga6CYhdEW4/nAvMHmTL0TfNGlO2mS
 PTOgqR08vdhIhyGz7cOMskkvyOm/LC+MWfwmjgARFjHO5UEvLOphe4NXDlu3MYig3o1CWVqnb
 7oPR1YBilYV3M6pMMKAg2y9GbHLSDpFcBedYgTdbbJxh6TC45pVa3h17SVGpcZ3WPfNZfkA2u
 q8kxZrsSyF7gnR2mO0XTLIZvoNEu8ua+Mu8jXpLXFcAVDuevOFIf2lz00t4pzeYspDnqTXgxk
 kSOtYPBETgsI/vWeg1HrbynZiGEs0ILYus6Q9VTTGu1I1UmMEOI1Khnvg+DF5Irl66dJP/00c
 PbmyBBLg/4zQDLFJZhH5+W9sxdDLA52LbgAluZvg0fFBoGvh8U7wOvG+h/6X3tTLsYH4o+vNC
 U8vzx2x1v+fsRrY+X3cj7XP9EyUQH4wXNINjpyKfU8j99g55iyE0A7K9R5+Tj+azI7kNWcJ4Y
 CwB1jo8SS879oJDyFjWfTaoM9UvJ3u5QFVeXm2g/UP8pwezubtV5lA4f6aE7bgMZZsvgZAy4E
 jBRGG0w
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Fri, 5 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > This setup will from now on test next & pu in the Git for Windows SDK, and
> > rebase Git for Windows' current master to git.git's maint, master, next &
> > pu, every morning after a weekday (unless I forget to turn on my laptop,
> > that is).
> 
> Sounds really good.  Thanks.

Report for today:

- `pu` and `next` pass

- rebasing the Windows-specific patches failed because of the merge
  conflicts when trying to apply the GCC-6 pragma, which I have on Git for
  Windows' `master` already.

Note: I fixed said merge conflicts locally, and the way I set this up, the
CI job learns the conflict resolution and will apply it automatically next
time it runs.

So: all greeeeen today.

Ciao,
Dscho
