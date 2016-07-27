Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7A55203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 15:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756731AbcG0PEE (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 11:04:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:55127 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753179AbcG0PEB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 11:04:01 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LufbI-1bJSB20obY-00zovB; Wed, 27 Jul 2016 17:03:48
 +0200
Date:	Wed, 27 Jul 2016 17:03:38 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Stephen Morton <stephen.c.morton@gmail.com>
cc:	Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git cherry-pick conflict error message is deceptive when
 cherry-picking multiple commits
In-Reply-To: <CAH8BJxFvyEDuj-mm=N=ca3kxysopaBpro-HsuL-HZehqE_nxDA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607271649120.14111@virtualbox>
References: <CAH8BJxGZW8eNQogksZ416sVaBkpQ78uYkV7FtN6wxGafzNwjAg@mail.gmail.com> <CAGZ79kaop1HB4tQAKxOcq8ZNEc+6VMPB1suwA9jra2BoXc27cw@mail.gmail.com> <20160726203041.GA4675@sigill.intra.peff.net> <CAH8BJxH0_RhmDaHWBkFg6QP7WWucUtPSQfsAemdVWkTzN42MPw@mail.gmail.com>
 <CAH8BJxFvyEDuj-mm=N=ca3kxysopaBpro-HsuL-HZehqE_nxDA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iuDvQdNkwEmIaZUURjLZFXrMq8e5j90WGxSSEJPDvUIsz/D7F3o
 rGW14UmZsMgCJlISe3uQ48sgTNXSCLdHvve8vT/PX8BvxrYTPUMN48WbEg900Im6hxEWJW3
 amymEMix0qt6D9oRWuNrecTctSiLD2aXJkCIHCxeyjBIzMaSeCWposEr0ObH63227zJ3vjL
 y1pn3fWXjmQ+XQjq8pVAA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:r1I1Ek6BIRo=:5FPUIY4i+CatboG0JHKCz5
 co/wN9trGfIISI83zJd0IKJUHlps5xTi3leDzRoPTE/r6ABoXKrimPDsj32aHgEf3lz/hKN0q
 czl5BTby9Jmv9zs3C0HGAZovfqlmLk3S8L5tQwuXvoPThbOS1tfsLTsfcHBpMW6LCYUVJPRmM
 TvmGDE6orRq1+AUmtgrsrbH2zP7M9WbaX68AwPnWS/MzqodoX9liWLIpCRmS8G4jMZzYSXLBe
 lbUSElblD9wHl/+SpJYYA4sZD0qiQFVF/owgvWXlEMZnCdnrcOOOpdzx7ge2buSRHc0IUOABk
 COCrr7Kdilll/i/z/BosmHiXDu4Go3TvRrm5V8fcY5hSv4UvMNBloRlLWkXIeRDd6Y34vm1Eg
 5kcFWmDqDpWArML9rhfs7v+Nb/z4TNhuP/ggbWkEQXzb2ad6W9JVW0A/G8zSqImEgauuiEhXL
 CpS2c5EvAjCJzuzT2dCWPZYQWPMukV0HHfSstTOD+jbURS0ctQllEgGMH9kM3rR+taBAdhVcD
 GMOY2mwQZWNJJUvfUrzh9tT4MWjijvYidZrixFp0Nh0KTcVjRd3DiwGwIYFqyDEWZxPTgbUUb
 wZ3jmB+DwkYG+wZck4EqCQiPfBU4SKJtYAQ0G5KyX/kJuNoFPVnXNb3x/YvHvwcjERFrd0w7Z
 ozfWVVivxHs1GeSO/uZ8ZGMZBd59WElBFhEG54Sf96Q0Il0bFKtYoB0OExqnRaWkShG4ZHfnT
 iU02vPTWIhBA0j6NN1Zpt2sTd/QxYqKLOH4mrNQmbjH8UVkdx6PWHP5MHj+Xy8Je/LWQgFbDa
 qCQ5shH
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Stephen,

On Wed, 27 Jul 2016, Stephen Morton wrote:

> Here is my patch then. (Personally, I would add some capitalization and
> punctuation, but I didn't see much of that in the existing code.) I'm
> not a regular pull-requester, do I do that, or can somebody else handle
> that for me?

The process of the patch submission is described in
Documentation/SubmittingPatches (yes, it is a bit involved, and it is
slightly easier when you use http://submitgit.herokuapp.com/, but please
note that this process has served us well over one decade).

Please also note that top-posting is highly discouraged on this list:

A: Because it messes up the order in which people normally read text.
>Q: Why is top-posting such a bad thing?
>>A: Top-posting.
>>>Q: What is the most annoying thing in e-mail?

Now to your patch:

> diff --git a/sequencer.c b/sequencer.c
> index cdfac82..ce06876 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -176,7 +176,8 @@ static void print_advice(int show_hint, struct
> replay_opts *opts)
>                 else
>                         advise(_("after resolving the conflicts, mark
> the corrected paths\n"
>                                  "with 'git add <paths>' or 'git rm <paths>'\n"
> -                                "and commit the result with 'git commit'"));
> +                                "then continue the %s with 'git %s
> --continue'\n"
> +                                "or cancel the %s operation with 'git
> %s --abort'" ),  action_name(opts), action_name(opts),
> action_name(opts), action_name(opts));

That is an awful lot of repetition right there, with an added
inconsistency that the action is referred to by its name alone in the
"--continue" case, but with "operation" added in the "--abort" case.

And additionally, in the most common case (one commit to cherry-pick), the
advice now suggests a more complicated operation than necessary: a simply
`git commit` would be enough, then.

Can't we have a test whether this is the last of the commits to be
cherry-picked, and if so, have the simpler advice again?

Ciao,
Johannes
