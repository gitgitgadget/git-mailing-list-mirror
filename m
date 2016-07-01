Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44B3D20FCF
	for <e@80x24.org>; Fri,  1 Jul 2016 10:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758AbcGAKWo (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 06:22:44 -0400
Received: from mout.gmx.net ([212.227.15.19]:49326 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031AbcGAKWl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 06:22:41 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MXZbS-1amSjF20tq-00WYT1; Fri, 01 Jul 2016 12:14:11
 +0200
Date:	Fri, 1 Jul 2016 12:14:10 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 3/9] Prepare the builtins for a libified
 merge_recursive()
In-Reply-To: <xmqqziq33ju2.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607011123550.12947@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <753eabc5193c148c67e64ed5d070b6ff08f51d82.1467199553.git.johannes.schindelin@gmx.de> <xmqqziq33ju2.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KMOOYLN2bgMv21e93D/7BB+zYtsBrei/9bfQeawjNRRUaWIYk0z
 KM4iMEWwXHbsZBp66NVnM6qR0+1vGQbTgPifet6D9uAZH/o8CEly/xDNDCxJNmlxhlt9geS
 Rk1mzO5rCbITW2H7HhPYi5X1eMdIyuKVNJcK8bgEMbSszJM2W9DsvFvtR0T8UhsqhNaP4k4
 IsW6aQ2xVKWjDeXbZRBBg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:JKzgz1VFZko=:CPpELAVnV5CwkRA8s5cehL
 GDpZRND7Q1tYzmcaJLKQIcZp9/jGYxw2iDdhS4l7n4pHgNK/Z43Yw9sJ6B7MlzJiSs7GBG2K6
 TyKHvy8aGSolsRJvVgRSQHie3UUMwjaqbid7taMY459hWMOuVxjmW6lEyMx5BSVkpLMFfO6mx
 ZRCTTdgutq0lr3ePymoTz6ZCxNt03DIrAuF4MhO3PZoXQpsxhOSshJiMjjtuk6cf08+dSbYyI
 o8RiJBMJBbSpqeVXXxHQ+dKxicFoKNvy18BzU1wrvycKckoVMINewlpDi53r1MyyLrdbJJXq2
 lKBl1ZDgcRx7xefXUhM9WFoPYa48dSI5iPODNQ+7c+rKdwzy+uP0M8X0KSxpWQP0L/yzVSrFV
 k9B3617tLsEmGrk5DQ8+Z0bT5ZyJoq0jBTASzrP5WBBOkAGuo6zdEu+7kCP+Y+E4/86UGKlGf
 gmj/1UJLe50ChE13wp43KqgeVeXRYpz43l/q20wCcH+C9IK5hClgAfoXctEWUypR1kLTKahqy
 OY25P/A0XMC4kf+hZDTSblhz8OUbynsTtsIimC8wce3tnaq6Ubw8KxWU4oED8S/fCF1fgirlL
 vb2EAaa1Volwk9WPBSpq9j57EoR9UMH2VMP2Iv8zjoMXWe3o7IIWOxAprUX/EOmfXeYlrWBDf
 MVWUjilecBr1bwqK1x+VUHFnGN7XpgWlxB+qqfEBVFh/R5RcOcI0Vv5HyNaNBPnCUWGu9cr5K
 lR0KuPTmI2LpHhtaWDGogQW0Ziq01Mt8RO4T+OzAMewKb8NzlIq2JD2DBuIpvTjtrmuhooMM8
 vlXJect
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 29 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > A truly libified function does not die() just for fun.
> 
> The sentence is wasting bits.  After all, a helper function in
> run-once-and-exit program does not die() just for fun, either.

Given that I had a hard time when reviewing Christian's apply patches to
drive home the message that it is not okay for library functions to call
die() or exit(), I happen to disagree with your notion that this sentence
is wasting bits.

This sentence does not so much target *you* personally as audience, but
the occasional reader of the log who wonders: "Why don't we just call
die()? We would not have to worry about passing back the return value
through all those long call chains..."

> > As such, the recursive merge will convert all die() calls to return -1
> > instead in the next commits, giving the caller a chance at least to
> > print some helpful message.
> >
> > Let's prepare the builtins for this fatal error condition, even if we do
> > not really do more than imitating the previous die()'s exit(128): this is
> > what callers of e.g. `git merge` have come to expect.
> 
> One thing missing is your design decision and justification.
> 
> For example, the above explanation hints that the original code in
> this hunk expected merge_trees() to die() with some useful message
> when there is an error condition, but merge_trees() is going to be
> improved not to die() itself and return -1 instead to signal an
> error, so that the caller can react more flexibly, and this is a
> step to prepare for the version of merge_trees() that no longer
> dies.

Okay, I will replace the "As such..." paragraph with a modified version of
your paraphrased explanation.

> > -			merge_trees(&o, new->commit->tree, work,
> > +			ret = merge_trees(&o, new->commit->tree, work,
> >  				old->commit->tree, &result);
> > +			if (ret < 0)
> > +				exit(128);
> 
> The postimage of the patch tells us that the caller is now
> responsible for exiting with status 128, but neither the proposed
> log message nor the above hunk tells us where the message the
> original code must have given to the end user from die() inside
> merge_trees().  The updated caller just exits, so a natural guess is
> that the calls to die() have been changed to fprintf(stderr) with
> the patch.

Even more natural is it to guess that the code will call error(), just
like we do almost everywhere else.

But you are right, I do not have to leave the reader guessing. Better to
err on the side of being slightly verbose than to be so concise that
nobody understands what I mean.

> But that does not mesh very well with the stated objective of the
> patch.  The callers want flexibility to do their own error handling,
> including giving their own message, so letting merge_trees() to
> still write the same message to the standard error stream would not
> work well for them.  A caller may want to do merge_trees() just to
> see if it succeeds, without wanting to give _any_ indication of that
> is happening to the user, because it has an alternate/fallback code
> if merge_trees() fails, for example (analogy: "am -3" first tries a
> straight patch application before fallking back to 3-way merge; it
> may not want to show the error from the first attempt).
> 
> The reader _can_ guess that this step ignores the error-message
> issue, and improving it later (or keep ignoring that issue) might be
> OK in the context of this patch series, but it is necessary to be
> upfront to the readers what the design choices were and which one of
> those choices the proposed patch adopted as its design for them to
> be able to evaluate the patch series correctly.

To be honest, I did not even think about the error message issue because
my primary concern is to teach the sequencer to perform rebase -i's grunt
work. And while we usually suppress the output of the commands in rebase
-i, we do show them in case of errors.

It will make things more complex, unfortunately, even if it will be
straight-forward: there is already a strbuf and a flag in struct
merge_options to collect output. The merge_options are simply not passed
through to all of the previously die()ing functions yet.

I won't have time to get this implemented this week, unfortunately. So
please do not expect the next iteration of this patch series before next
week.

I could imagine that you wanted even more fine-grained control, where we
have a range of return values indicating different error conditions.
However, I already spent two weeks' worth of work to get this far, and
would like to defer that task to the developer who will actually need
these fine-grained return values (if we ever will need them).

Ciao,
Dscho

P.S.: For the future, would you mind deleting the quoted remainder of my
patches when there are no further comments? I deleted a footer of 73
unnecessary lines in this mail. It's no big deal if this is too tedious,
but it would make my life easier.
