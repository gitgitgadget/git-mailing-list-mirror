Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE86420248
	for <e@80x24.org>; Thu, 14 Mar 2019 14:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfCNOJv (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 10:09:51 -0400
Received: from mout.gmx.net ([212.227.15.19]:37451 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbfCNOJv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 10:09:51 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LeMij-1ghkHR2jPB-00qB6f; Thu, 14
 Mar 2019 15:09:40 +0100
Date:   Thu, 14 Mar 2019 15:09:23 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Subject: separating regression test patches from fixes, was Re: [PATCH 3/3]
 cherry-pick --continue: remember options
In-Reply-To: <xmqqimwm9hh5.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903141432000.41@tvgsbejvaqbjf.bet>
References: <20190313182615.7351-1-phillip.wood123@gmail.com> <20190313182615.7351-3-phillip.wood123@gmail.com> <nycvar.QRO.7.76.6.1903132344350.41@tvgsbejvaqbjf.bet> <xmqqimwm9hh5.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SulJzX8EQ2Gcql42w49qc5emaXOloeDn/Q/hfyY4oYaCjuSZlGE
 t5htASTN7cCF6qoLQwE6egPLQxboQd3+dGj+ANjUqg72mnlnrziFN2+F3tKUkeLFn2dmhYz
 zMq8jho+7t3SdA45v+1gktc+1Km1dlI3ZghIxl54Qsw6orwPOvQXDx91RrEePS0r7fj2RHv
 AP90xNH+AvYK0LIzLcwnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s+88iNRHhng=:lJ7qqRiizZUScU9Oi81D6c
 Cl7bJrdYaQw1sR9jGYPuQe5Fns8MZuIQwrwwvEZk5ErLLpXJgNauODSqevQtS2HnaunGOMif8
 gXRxWxxcjyf4J4BuyneQ329zPRlKioaofdiIkIN08fL+89STVFjlWslCUeXr9/+WvA18tJoSe
 2VcqKB1gNkEzsdYFxkcbAjmsJoLTuJ02KzdHl2uUC4Z+6qA8eth5VJYqah9lm2X1ybxLk6rNV
 8MhONQzduZuo8t1TuWSTGLUZnHHrmTWqmEI45JDaONmhEUWWhf/2jECvCp7vgj02RqNGoOWOg
 pvjuSAVVAke1rZy9x9tiAZLmAeu0uzCYEiUNXAt6fRocQ/0jEvkno23WOc/4ON0deO8WQ1CMu
 W4+SlNxsk63ok8VQ3oweR1mejV5vH9x3VJRvqpBtBYoX1vfi69p+QevJvopFiqRxLa/qwsnS3
 x5HgTQBWG/Ptosr57eUJia49nDSnqPz15ySjr+FSyEmskGDy0MPTdUrLHzL+X+A73DygUD1kL
 F6glKRtSVvcmGO3HP9DmlWFxnQnrg9dkOO7q4O58XJYEQBYJkJhYMn0jFKG0XN1B01YKTvq6f
 jMav8cpRew40GMq3ntHqqYHyYOErRh46/ouJ4Rmw7Cj8WKlq1/qQP+5h1vDDXOg/jkG1OXVj8
 qPCFKKxAOyEOdFyeROBfgo2YzTi/4uG+0BWyiOEgUtJ68s+p+mchQKLSWTm4ehn9Qry6YHQ/P
 kn92Ysrn/XkmzxP9K4zTBKASh2pnL007R+XlqRoa7WzpYXpLo44x/4XS27Y4TI8p5VJL7/qFE
 9KULGnlaL3ziAGZQwHdQyV5QbM8LivhGzpm9PAswwk8jbHCePA6sPpvECI5myW2ad73Phov5z
 gX5Msbeg5w3EV94YDOHi4I/pKGTGP7C2PFDZ9Tj/pFHB5mpsMGi+lSlNxIytbZXwyvtuUpuFj
 y2fjxW+OObg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 14 Mar 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > And it is especially nice that you make it easy to verify that there
> > is a bug in the first place, by separating the concern of
> > demonstrating it from the concern to fix it.
> 
> For a multi-patch series, breaking out the verification test out of the
> fixing patch is OK.  It is a different story for a simple change that
> could be made in a single step to artificially separate the test into a
> separate step.  An early "test_expect_failure" would not stop the test
> when applied to a different codebase as a standalone "does the breakage
> exist in this unrelated version?" even if the "test only" patch might
> appear easier to apply (as opposed to applying only the t/ part of the
> patch that expects success and seeing it actually fail).

This keeps coming up, and I feel that in the past, I have only managed to
upset you, not to convince you that my point of view has at least *some*
merit.

So please let me try again, this time with a cooler head.

As you know, I find it rather cumbersome to review code changes on the Git
mailing list. Unlike others, I do not suffer from issues revolving around
HTML parts and/or mailer issues, and I do try to just work with the
limitations of the medium. But sometimes the diff just does not give
enough context. Or I really would need to look at it with `--color-moved`
or `--color-words` or `--patience` or `-w`. Or yet other advanced diff
options.

So I would like to have the code changes locally, in a branch in my
worktree.

And at least for me, code review often does not end there. I need to dive
into the commit history to see e.g. why a line that a patch wants to
removed was added in the first place, i.e. read the commit message and see
how the surrounding code changed.

So I would like to have not only some re-applied changes locally, but
really a clone of the branch that the contributor themselves had locally.

And as my understanding of code review is first and foremost to ensure the
correctness of the code (which is why I want to leave the more tedious
parts of code review that do not really require a human to review, or even
fix, to automation), in some cases I really need to run the code (or the
regression test) locally, e.g. to see whether it is a Windows-specific
issue, or whether it affects this or that branch.

The necessity for this kind of thing was demonstrated rather well by
Hannes Sixt recently, where he ran a regression test that I added as part
of https://github.com/gitgitgadget/git/pull/96 (mail thread here:
https://public-inbox.org/git/pull.96.git.gitgitgadget@gmail.com/), and
figured out that this regression does not even exist in git.git's `master`
branch. Therefore it don't need no fixing there, either.

So now that we established how important it is to go back to the local Git
worktree for many in-depth reviews, let's see how easy/convenient that is
right now.

In our currently established process, you have to have mutt with your own
custom scripts. Kidding! But it is undeniable that without serious
scripting (that nobody seems to be able to do in a way that can be shared
between reviewers), it is super hard to do anything but a pure diff-based
review (which would not have caught the problem described above).

So how can we make this easier? How can we make it less painful to review
code changes beyond the bare minimum diff-based review which, let's face
it, encourages "white space review", i.e. focusing on problems that can be
seen from the diff, but that are really of little consequence when it
comes to the health of our code base?

What it boils down to: it needs to be easier to pull down patches and to
recreate local branches for them.

It is in this context that I find it much better to separate patches that
add regression test cases from patches that fix the regressions. How often
did I encounter problems to apply the diff from public-inbox? I cannot
count the number that happened/happens to me. And usually the diff does
not apply, many more times in the part that touches libgit.a code than in
the part that touches the test suite.

And how many times did `git am -3` not help me because I lacked the
prerequisite objects? Again, I cannot count that number, it
happend/happens *so* often.

But the regression test patches usually apply cleanly, or if they don't,
chances are that I have the prerequisite objects, because we rarely change
regression tests locally, we only add to them. And even if I do not have
those prerequisite objects, those patches usually *add* code, so it is
easier to resolve the problems.

Note: I sometimes want the regression test locally not so much to verify
that it demonstrates a current bug, but sometimes to look at the code
flow, to see which parts of the code are executed. That is why I like to
have that part locally much more often than I need the actual fix locally.

So yes, the easier I can make that process, the better.

Side note: for some time, our team tried to track all patches (whether
they made their way into a branch at https://github.com/gitster/git or
not) in the form of branches in an internal fork. Stolee drove that
project forward, and it worked for the most part. This might be something
we would actually want in a public fork, maybe even with a simple web app
to find the branch corresponding to a given Message-ID, or some such. But
I digress.

In any case, before we get better tooling to work around these issues, I
still think it makes a ton of sense to encourage proper separation of
concerns: to keep patches that introduce regression tests demonstrating a
breakage separate from patches that fix the breakage. It would certainly
help me (e.g. when staring at a range diff).

It certainly would make it easier for me to justify the time I spend on
reviews, because I could review more patch series in the same amount of
time.

So hopefully we can find some middle ground between your endeavor to keep
the contributions compact, and my desire to separate concerns better (even
at the expense of number of patches; I think commits are cheap, cheaper
than reviewers' time at least, for sure).

Ciao,
Dscho
