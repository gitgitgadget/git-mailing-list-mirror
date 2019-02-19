Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE86A1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 10:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfBSKsK (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 05:48:10 -0500
Received: from mout.gmx.net ([212.227.17.20]:37747 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfBSKsK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 05:48:10 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8mCe-1gmAVX0Y2e-00CBM8; Tue, 19
 Feb 2019 11:48:07 +0100
Date:   Tue, 19 Feb 2019 11:47:51 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v12 18/26] stash: convert push to builtin
In-Reply-To: <20190219002336.GN1622@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com> <a6692eef2ca7c9d9e4701f087269d537248a4941.1545331726.git.ungureanupaulsebastian@gmail.com> <20190208113059.GV10587@szeder.dev> <20190210221712.GA9241@hank.intra.tgummerer.com>
 <20190211011306.GA31807@szeder.dev> <20190212231837.GI6085@hank.intra.tgummerer.com> <20190219002336.GN1622@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2007833076-1550573287=:41"
X-Provags-ID: V03:K1:Gb+6MprF7F3VCREkJi9cfCacDnP98PvI5wYG8nsx2b7nlpWvO4f
 JjZUeOmX0UyGCLDWY7ugnczF07rranjpVRfLf3R1WBw44W2PXkMTTmLbiqL3zVjEHxDgWxw
 ie5RkFg39lv43q0lCvmBxsxvHpz1d0ySxTYYbQJ7O6llxgLNzb1FETNGQm+1Sl1rhvWYyhL
 elbceDwVseLdDNlPh7zgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v343ZZxCcSI=:68s7WhVxCX9KoQ//wP2NAJ
 2PG1cWs7VDGilY8KmDERpIMq/cHq4qFIM9QrEu2/l24+FvbvnVbHm82zpu4ksJNHSkn7fiKlf
 R0Pd9H56cQItnR8O/h/gVjUya2zInXOYo6TMsYpgcb4vb4m4M2FhCwjtMEQxdh4WvQb4Aw1QI
 EpNwvGSBOPPEUzPAVGdDxuEn497qriQQK6Upn01BlPO7PlCeqEdnc1AQfekK6UGrPQw772+/P
 SP9kBpzcbP8XAUQAz7grok9wWelHd0rXRlSp6uHW9P2vlga7xQJJ8B1QtleLc3+2XGkkfnFUG
 akBeRw4gBFubYWF+UYYDtXCnIR06pV/ctQpX6pa5nq+bFJHKgoAHco9QcjCAYdHG8fOgW6+e9
 91qamqsdjBy/6dxJ0isPUmmoJZ830Q3zFC5XdiRBita9Vu+maqwZGyBFvI9dSP2zv3YeWLrfy
 7ooqa0fu8UXrlLNQMLyDyQ3Iv4QQxnSDkMJZ+miiF2S/cyxBqUtFPX3aKKKu44gv15qwypBnS
 h9/oGQjHxu4OKz7bqxvcA3qWCmqsX3ohlYRrAO6j5SVAEWK+5fU722Cb9epKNoNoUXhg6MTTO
 uPFyaPe+70O+V03jyapOIaS490IbRKhcttAyxpcgclxXK8HemCtt8c32K/h5xhe1N/o8ry21c
 02JBaJbkS8Js3pjvD6QWicHDF3N76/pklisreyNFwYaKywbNFzOreZ9caPbCh4sYmlyQuDKuY
 8PVZWPpJwTdmA6nmaybB65c/czOHNyToWj1j8yG5hbgnCQNIT1tGX6EcGsvd+7SmXYisEEI7s
 eQ1zFliHw106h4CScvfKTJeyfYM8zOHlizeoSQOGzyVMMbqjQ/gfJdGYWzp/dsTX7RK4P+r51
 AFx9977WrwkbpJjtHHGok8lt8vMGqs7nJlmG27QRiDWbFqWruptD4HAHUst8uMMXJgBMVvRtu
 MoXArFyx8pw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2007833076-1550573287=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Gábor & Thomas,

On Tue, 19 Feb 2019, SZEDER Gábor wrote:

> On Tue, Feb 12, 2019 at 11:18:37PM +0000, Thomas Gummerer wrote:
> > Thanks.  I still didn't manage to reproduce it locally, but I was now
> > able to test it on Travis CI.
> > 
> > The diff below fixes the issue, but I still need to spend some time to
> > better understand why it does.
> 
> There is nothing like a fix that works, but you have no idea why :)

I know why. Now. See below for the analysis.

> FWIW, I'm at a couple of thousands of '--stress' repetitions with your
> patch below, and not a single failure yet.

Good, and yes, there is a problem.

> > I'll hopefully be in a position to
> > send a patch with a proper log message why this is the right fix in
> > the next couple of days.
> > 
> > diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> > index c77f62c895..3dab488bd6 100644
> > --- a/builtin/stash--helper.c
> > +++ b/builtin/stash--helper.c
> > @@ -231,6 +231,7 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
> >  	struct tree *tree;
> >  	struct lock_file lock_file = LOCK_INIT;
> >  
> > +	discard_cache();
> >  	read_cache_preload(NULL);
> >  	if (refresh_cache(REFRESH_QUIET))
> >  		return -1;
> > 

So this is working, but it is not the correct spot for that
`discard_cache()`, as it forces unnecessary cycles on code paths calling
`reset_tree()` (which corresponds to `git read-tree`, admittedly a bit
confusing) with a fully up to date index.

The real fix, I believe, is this:

-- snip --
diff --git a/builtin/stash.c b/builtin/stash.c
index 2d6dfce883..516dee0fa4 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1372,6 +1372,7 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
 			}
 		} else {
 			struct child_process cp = CHILD_PROCESS_INIT;
+			discard_cache();
 			cp.git_cmd = 1;
 			argv_array_pushl(&cp.args, "reset", "--hard", "-q",
 					 NULL);
-- snap --

And the reason this is needed: we spawn a `git reset --hard` here, which
will change the index, but outside of the current process. So the
in-process copy is stale. And when the index' mtime does not help us
detect that, we run into that test breakage.

Now, I seriously believe that we missed the best time to move
ps/stash-in-c into `next` for cooking. The best time would have been just
after Paul submitted the latest patch series: we know for a fact that he
is too busy to really take care of this patch series, so keeping it in
`pu` puts everybody into that awkward spot where nobody wants to step on
Paul's toes messing with his patch series, but where Paul also lacks the
time to push it further, so everything is stuck in a limbo and is *so very
much* not cooking at all. You might say that it has turned bad because we
failed to stoke the fire appropriately.

Since it is now way too late in the v2.21.0 process, this problem is only
exacerbated, because it won't even enter `next` "better late than never".

To address this unfortunate situation, my current plan is to take over
from Paul (we had been chatting about this privately in the past, and he
is okay with this because of University eating all his time).

I will open the whole bag again, most likely squashing the late fixups
into the patches that introduced the problems, re-review with a much finer
comb than the patch series has enjoyed on the Git mailing list (even just
a quick look at `do_apply_stash()` revealed an unnecessary `reset_tree()`
call that *no* reviewer spotted, even I myself, but then, I am hardly
solely responsible for that review), and most likely I'll even take my
sweet little time changing the code to avoid more spawned Git processes.

It will take a long time, and the `stash` project that has been discussed
recently to be given to GSoC students is no longer available, as I will
take care of it before GSoC even starts, and I won't spend much time
reviewing other people's code in the meantime.

I will start that only after v2.21.0 final is out, obviously.

Once I submit a new iteration, it will look quite a bit different from
before, and reviewers will have to re-review *everything*, wasting
everybody's time even more. It will have to be re-reviewed in its entirety
anyway because it has been *such* a long time since the latest review, and
that's just the price we all have to pay for missing the right moment to
advance this to `next`. Thomas, I will ask you to review, and Gábor, I
will expect you to review that iteration, too, as you are now a bit
familiar with the code, and I will really need your help here.

Anyway, that's my plan for now.

Ciao,
Dscho
--8323328-2007833076-1550573287=:41--
