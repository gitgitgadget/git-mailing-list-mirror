Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ED891F859
	for <e@80x24.org>; Thu, 18 Aug 2016 08:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbcHRIiX (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 04:38:23 -0400
Received: from mout.gmx.net ([212.227.15.18]:63093 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752805AbcHRIiV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 04:38:21 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MFMIO-1bLxMj1Meq-00EQ4q; Thu, 18 Aug 2016 10:37:21
 +0200
Date:	Thu, 18 Aug 2016 10:37:20 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git for Windows 2.9.3
In-Reply-To: <xmqqeg5nbehc.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608181022250.4924@virtualbox>
References: <alpine.DEB.2.20.1608131214070.4924@virtualbox> <xmqqshu8u0px.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608171507530.4924@virtualbox> <xmqqeg5nbehc.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6ixC4mlHuEaazHSMR1+zH97p1OC7tAqEoXMl3rwOwIeyDe5R4FO
 Pa/pU7Ru5Jg9Hl72l8bhIDnlayxPgxtb8sO7GOYDRbuEBv4DYBtvmg984iW+ItDMovNvQa4
 kTe6FtuMvIBPqVZ3DOnrUual3lnoqp4tUFJ7lH0zgr06Ke8jfryLJJtseGlAYf+NeDemLLo
 60zoG+lLXwxqA0NNOyXKQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:D8ZUaZeldAo=:zzBvKvcROKs8VLT0U2CdaC
 8v/gJzt+3iFftBW0TOkZuXgw5CXsjV/rg5B5YSAeaZUEcVYnkUu1ePvulVLlMhY31ej5HgoH7
 q7MtLK0vhfT2kgFqlBvVK0xp5cOF0lleNj7ySRwGsWLKTV+tjoTDnE1nNMRMuSxcaz6AEkBi1
 7uqKOjWd4ejBXRI2sgE7qlkurRMviAQWaQdAVi5FAYZYXNzNYottaWf6BacikGtqeJL4aP9IH
 2wdgAYQBN2edGoJ5SyI09xMamnFYWkjh1G16YyNVsyNYsHtlwjPXeQ/iP6fEuuqZP4nujw9GC
 jRwtMFcsoirzIwgt210PvZrsNZ+ucMYtHqAvU1Dvg8hBtaAPmiuYYVYR6U074e7YQkjO1yCpZ
 39VYz8uZmqMzCnHZ0vy/vnGcv5JVYoneL/Yp17whp5vZ34cK7H+ReBjGZmSH+E5ysMIedwEfa
 Q3q+9qdAecyomRYFIrm8DKipZnRYGZWpIHfswg8RU1Ss+D/CIgRmwWe2t0l7UaKavrHDVqJ42
 MLPvYMsdNzdUoMuJY6MBP+tChX24whmuTZu0ISIFLwPgV/D5IsdQ9Nh1CSQz+jMMDK9jYDMdE
 YD9yY2vixIJbDgAUFQKJg5AZ0hr2tr2IrN/tuVfVXCrfcXguy9llo5q/sBNCq8z993umnYdnK
 dJlQ+J3/DQefTFsFG0LV3XNOCUHM5sPGe1pqKkaG0HrXCbv2lTgBAkOZK2EAqCz81jg5AY7YW
 aMLHliip0GD81Y5pLailQA/v7DLc1zbJrRbVkhNyS21jlGQUloZE52Thq0DIx651DtxIEu6fI
 1TMDfIq
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 17 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> And then your "git cat-file" patch can be upstreamed with the option
> >> renamed to (or with an additional synonym) "--filters", which would make
> >> things consistent.
> >
> > Right. I would like to ask for a `--smudge` synonym nevertheless, just
> > because I already use this. On the other hand, it is early enough to tell
> > everybody who knows about this feature to change their invocation (anybody
> > who would know about `--smudge` would be in that 1% of users that have
> > read the release notes, so most likely would read the next release notes,
> > too).
> 
> It is OK if it were your private edition, but you end up hurting
> your users if you need to redo the feature differently.

Unfortunately, this is the situation of Git for Windows from its
beginning: there has not been a single time that Git for Windows could
live with unpatched upstream Git's source code.

Business as usual, though.

> That's the price of your using open source and taking a short-cut.
> Adding a "--smudge" synonym is spreading the same hurt to outside
> your fork.  Let's see if we can avoid doing that.  Perhaps mark that
> "--smudge" as experimental-and-subject-to-change and re-announce?

I do not think so.

I have plenty of experience to deal with the problem caused by Git for
Windows requiring plenty of patches on top of your Git versions. I can
easily deal with this here problem, too.

FYI there have been two very strong reasons why I did not go through the
review on the Git mailing list for the --smudge option: 1) I really needed
this quick, and last time I needed something quick, it did not exactly
work out, now, did it, and 2) as far as I am concerned, the most important
part of developing patches is the practical testing, and this belief was
reinforced by the core.hideDotFiles feature that was well-tested and
well-exercised through years, only to be broken by changes necessitated by
the review on the Git mailing list: despite the best efforts of both you
and me, we managed to worsimprove the patches to a point where they may
look more elegant than before, but unfortunately are also less correct at
the same time.

So I learned my lesson: I will try better to get patches robust and stable
by exercising them and developing them as needed (the --smudge feature,
for example, turned out to be only half of what I need, I developed more
patches on that front), and I will be careful to avoid major modifications
of my patches just to get things upstream. It is better to carry correct
patches in Git for Windows than to upstream incorrect revisions of them.

Ideally, all of the patches I carry in Git for Windows would make it into
git.git eventually, of course. I fully support that. But not at the price
of breakages.

Ciao,
Dscho
