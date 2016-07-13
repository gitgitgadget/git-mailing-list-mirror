Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54C231F744
	for <e@80x24.org>; Wed, 13 Jul 2016 11:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbcGMLah (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 07:30:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:58669 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961AbcGMLaf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 07:30:35 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LiWzQ-1apL751iBw-00cfER; Wed, 13 Jul 2016 13:29:35
 +0200
Date:	Wed, 13 Jul 2016 13:29:33 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Duy Nguyen <pclouds@gmail.com>
cc:	Jeff King <peff@peff.net>, Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.9.1
In-Reply-To: <CACsJy8CBGcKyMh9nbCAjZ=0T8TpoY9m98YJtgPFhQztVRPvXhg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607131326160.6426@virtualbox>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com> <87lh17kgdy.fsf@linux-m68k.org> <20160711235417.GA26163@sigill.intra.peff.net> <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607120927410.6426@virtualbox> <mvmtwfve22e.fsf@hawking.suse.de>
 <alpine.DEB.2.20.1607121249390.6426@virtualbox> <mvmh9bvdnae.fsf@hawking.suse.de> <alpine.DEB.2.20.1607121520310.6426@virtualbox> <mvmd1mjdluz.fsf@hawking.suse.de> <20160712134652.GA613@sigill.intra.peff.net>
 <CACsJy8CBGcKyMh9nbCAjZ=0T8TpoY9m98YJtgPFhQztVRPvXhg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GgUpmBrq1Dote1y6VFeHFEefzNWcoxi4Z7xjpbV5oZTD8t74Qpz
 q487mDXIUMpwAA0q7Q2nwP9WAfMgeu5NiXqWQbWcT45K/tGJB/ACAugLXoUqHyFpMi9f6CW
 bHlEKNLd4ODPzBsoEUuhr6KzEq6GaurEeHXE2+8k0Gpjgv4UP3VW2UfQDa33U2FeudzlNDv
 J5uwUUsHyVJfOuFslToxQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:xt5PeYAgY04=:Fgt5VCf881G7kkMCy0z8EZ
 85S7Xd+lSCV4Cw8UAaeHDrro+7yiVdgkpOGLDN7zAXrMb+7J4H0RY8Yi2T/TpMsPN7oFnSmeo
 A9C+Ni5l6UWfbY3XOzurRzwew171ht91aydj01wRdXQpclETtizWhguVDl0jiHes1llurgVVj
 VJfmyh9zFcVPfFjlITcRxBR7V4nQB60/IKfePJ6aVnU2ywtSGBgx1hgzcOQfTm4cXgdeRhklZ
 ynExALDaa+3b0ThAit94WH6xALGu61dMvL8iL+Gf9UMH0IVuBd/KBO0Lyt/sf32K2E+w96pEf
 0f3bCcC2yPNnAef3qH16qYgSrjL+CVr1HrHvUCcp2iuIeIODYaBjO4NZATK401yOdbIAEBJz9
 QvcVZ+L2dj0iN14UMtXvYw6oY+6xojFzYj24hVresnM4gPd/yM63j0w0hpUY4r0gtPVLtBilf
 PbWoQV3pmAFwNIz+6U8AJWNkIK8rbgWRaRuIoRrIjAi6STF3zc+kQYfZNOhp+GW3y4XdyYC52
 zFiN3hYwwEoGD5ie/IagMwCDDuPjSLZaTANVJ2NxAjVmC3sVbhqwYWPA9OEMv+lxW9tl78zRW
 M0e+Tqrabx4EwWHFUOAKhgYZC2qYQEOdPcQVQ5wduff/J3V6sMRrTzODn8gNPchMKXo4J3RX/
 D2c7knREnkzPxMej1hlDtkuweSKM38fw1TCt9YQDqZQfLWuYkjGXYXfvQEYO673BC0mN655a9
 PFWQLFqHfOiGDbPUG+QdqVQVY+9dylJ0btX4XuopwGnosCax0dAT6QOy41v3dOVra7pNFjrPY
 Nb6jPgb
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Duy,

On Tue, 12 Jul 2016, Duy Nguyen wrote:

> On Tue, Jul 12, 2016 at 3:46 PM, Jeff King <peff@peff.net> wrote:
> > On Tue, Jul 12, 2016 at 03:31:00PM +0200, Andreas Schwab wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >>
> >> > On Tue, 12 Jul 2016, Andreas Schwab wrote:
> >> >
> >> >> Johannes Schindelin <schindelin@wisc.edu> writes:
> >> >>
> >> >> >> PRIuMAX isn't compatible with time_t.
> >> >> >
> >> >> > That statement is wrong.
> >> >>
> >> >> No, it isn't.  PRIuMAX is for uintmax_t, and time_t is not uintmax_t
> >> >> (even if they happen to have the same representation).
> >> >
> >> > Sigh.
> >> >
> >> > So if it is wrong, what is right?
> >>
> >> The right thing is to add a cast, of course.
> >
> > In general, I think the right cast for time_t should be to (intmax_t),
> > and the formatting string should be PRIdMAX (which, as an aside, needs
> > an entry in git-compat-util.h).
> 
> Coincidentally, I have the same problem with unsigned long being
> 32-bit and have to switch to off_t in some places. Does anybody know
> what a fallback in git-compat-util for PRIdMAX would look like? I
> guess it's "lld"...

Yes, judging from the existing fallback for PRIuMAX, "lld" would be the
correct thing to do. And then it would be nice to introduce

	#define PRIdMAX "I64d"

next to the PRIuMAX definition in compat/mingw.h, too.

Ciao,
Dscho
