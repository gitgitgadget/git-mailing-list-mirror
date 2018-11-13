Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01FD41F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 10:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbeKMUJs (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 15:09:48 -0500
Received: from mout.gmx.net ([212.227.17.20]:39879 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731708AbeKMUJs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 15:09:48 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVedf-1fzCLk3o7T-00Yx5S; Tue, 13
 Nov 2018 11:12:20 +0100
Date:   Tue, 13 Nov 2018 11:12:18 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/5] rebase -r: demonstrate bug with conflicting merges
In-Reply-To: <xmqqh8glyajx.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811131109360.39@tvgsbejvaqbjf.bet>
References: <pull.75.git.gitgitgadget@gmail.com> <efdd3736a96f90a4ab52acaf2e5efbe3435bcb89.1542065154.git.gitgitgadget@gmail.com> <xmqqh8glyajx.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Q94bA/EPpN/quW5V+vWpJrdG8nMT/wRnIjT5eynWRL7aL1oaaVU
 uaQNSzxwTYpV0OpUkBzBm54jKSwuwTO077h7yCMqeL4AYMvaqLi04H0VHo8Nre7pkI0MKNW
 dfeG6gm2jL0A/UlVPjnqYU0KCXE9O7WAJ7C1frOo5F5D4AnlB8ytFsduCtBaaUGhwyWj685
 pP/3KB4ThGIDx52xea7Zg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DSRyFnzWtqU=:FxkOIr2Z5YApCUlJqR5oLA
 2lXqK7LuVap9yewwE16gt70bEiaHw1Amgxm9i55qZ8jHoPZFGyrqxaqNQm2pssEcIQSpHhjEe
 HMse+ICLOjrDzY8rVkJwUlPcrztMV1jE6ZmZI9fJ5NYOrlLrhBYPNkb5QenNpVwIW20MMXMI6
 CZE1ga7ToGkim4/RfD08oTSah0fVF1YIk6vD6rsBwxFREMy14S6OMMEMLFrCWhhh6M/tXOFh2
 OmVYlctLi46IWW1YCz0Rm0JLcq0XNV4oG08ciJfVfDZKDZjSuGNcghwDzy3qc2FTvN0mOgJat
 HEfBgKInr89jW6XeAmYkTwCk5craM1lyB4rBUontNZVCppozdFmOrkA+lo5O+xEMF8Lc7Yatf
 kFVPMutS2EZJ62ppDOBWTAiyc75KVP4pNGbT1NTZt6aQoLjoJdv2foXSwKOR4YemoHJeH/UPG
 rht53gkPOL2+K1MCV9EGrfATmD3FjjELhhRsRp4CEfMxaA0Wfn4lB8zeSjg1z7B613hF7wUA6
 l+DWEWStv4I4kMNYZxa7B2xA9l0ySEEbLSqh696emjVCR3Pj0G9pEbuTkAPVcas0o/oQwIJp5
 3h0ac1JBwdl+mZtwZOfbvs4Y8Vi98MJhDRCQwDQ/4g+VbXY59ZOOaTeL4n103dqdAdXfMDQLk
 I+ulmXevYdChB8tloV5bj5yFYWvP9C6r6YtrAWWpNNB0Jm2+mvsFOzNC7uHj0UG4Zg+xj3B4w
 hOy5Z8+ndN1oact4PQLt6HzcHx2Gyz1UFEiAMCHt3gccy7Ah0ppAyzCgrw3RysbIc1ziuv7mF
 8z5/mmyoCkdqkbjo5VtlJ+Y2uz2dp8vhFxBQsZvoHwLBQXmQXlLW7LppVA6vJRsqm35Sku00t
 kTkLtnSHxcIgoq6LBonLy1SNOIW9H34pIbSR3rRfGEPxCKkbnjhqGuJj2GbNAhap355PuKpv9
 Awo3u3Q20BA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 13 Nov 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When calling `merge` on a branch that has already been merged, that
> > `merge` is skipped quietly, but currently a MERGE_HEAD file is being
> > left behind and will then be grabbed by the next `pick` (that did
> > not want to create a *merge* commit).
> >
> > Demonstrate this.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/t3430-rebase-merges.sh | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> 
> For a trivially small change/fix like this, it is OK and even
> preferrable to make 1+2 a single step, as applying t/ part only to
> try to see the breakage (or "am"ing everything and then "diff |
> apply -R" the part outside t/ for the same purpose) is easy enough.

I disagree. It helps both development and porting to different branches to
be able to cherry-pick the regression test individually. Please do not ask
me to violate this hard-learned principle.

> Because the patch 2 with your method ends up showing only the test
> set-up part in the context by changing _failure to _success, without
> showing what end-user visible breakage the step fixed, which usually
> comes near the end of the added test piece.  A single patch that
> gives tests that ought to succeed would not force the readers to
> switch between patches 1 and 2 while reading the fix.

That is why I put in a verbose commit message, so that you do not have to
guess. And even the test title talks about this.

Seriously, I am very much opposed to changing the patches in the direction
you suggested. In my mind, they would make the story substantially worse.

Thank you for your review,
Dscho

> 
> Of course, the above would not apply for a more involved case where
> the actual fix to the code needs to span multiple patches.
> 
> Thanks.
> 
> > diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> > index aa7bfc88ec..1f08a33687 100755
> > --- a/t/t3430-rebase-merges.sh
> > +++ b/t/t3430-rebase-merges.sh
> > @@ -396,4 +396,20 @@ test_expect_success 'with --autosquash and --exec' '
> >  	grep "G: +G" actual
> >  '
> >  
> > +test_expect_failure '--continue after resolving conflicts after a merge' '
> > +	git checkout -b already-has-g E &&
> > +	git cherry-pick E..G &&
> > +	test_commit H2 &&
> > +
> > +	git checkout -b conflicts-in-merge H &&
> > +	test_commit H2 H2.t conflicts H2-conflict &&
> > +	test_must_fail git rebase -r already-has-g &&
> > +	grep conflicts H2.t &&
> 
> Is this making sure that the above test_must_fail succeeded because
> of a conflict and not due to any other failure?  I would have used
> "ls-files -u H2.t" to see if the index is unmerged, which probably
> is a more direct way to test what this is trying to test, but if we
> are in the conflicted state, the one side of << == >> has this
> string (the other has "H2" in it, presumably?), so in practice this
> should be good enough.
> 
> > +	echo resolved >H2.t &&
> > +	git add -u &&
> 
> and we resolve to continue.
> 
> > +	git rebase --continue &&
> > +	test_must_fail git rev-parse --verify HEAD^2 &&
> 
> Even if we made an octopus by mistake, the above will catch it,
> which is good.
> 
> > +	test_path_is_missing .git/MERGE_HEAD
> > +'
> > +
> >  test_done
> 
> And from the proposed log message, I am reading that the last two
> things (i.e. resulting tip is a child with a single parent and there
> is no leftover MERGE_HEAD file) fail without the fix.  
> 
> This is enough material to convince me or anybody that the bug is
> worth fixing.  Thanks for being careful noticing a glitch during
> your real (and otherwise unrelated to the bug) work and following
> through.
> 
