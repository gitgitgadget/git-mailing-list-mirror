Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57E141F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 10:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732204AbeKMUL6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 15:11:58 -0500
Received: from mout.gmx.net ([212.227.15.19]:37595 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731878AbeKMUL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 15:11:58 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lw2Sj-1fQPSl3BnB-017m1n; Tue, 13
 Nov 2018 11:14:30 +0100
Date:   Tue, 13 Nov 2018 11:14:30 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/5] built-in rebase --skip/--abort: clean up stale
 .git/<name> files
In-Reply-To: <xmqqlg5xybdg.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811131112580.39@tvgsbejvaqbjf.bet>
References: <pull.75.git.gitgitgadget@gmail.com> <8d1dec51b704c45bf36af24f657cc40f006989e2.1542065154.git.gitgitgadget@gmail.com> <xmqqlg5xybdg.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NCwmn0JR14PZuLgk7ucWRQwpZa40CCWGIDeyaQgP1urnSTkFQNy
 f22SMXCBqJOql/EWu+XXgsi77ekxJVvaHxINH1AhZ/MLf1q56UsqkQ9m0bEU/EW9LJP/q7N
 AHaboaakFlUjvT+khQ1zIRGbDrhoblivGbIAEJ+j9OQd5ZbpluVf+GyvRitnCJx4Lg3458p
 2w+2+iBIqwMH/o2+knFHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Rn6FopggI1s=:SrJ1Q7+YTYUlkMPD5m0GPI
 JGN7tuNxYACnQ90aGHkpUT8n1Xh+NkMUreNkn/RxO8tnEORdu2/kjkscU8qtRGYTltPdn+iIY
 /waxHaA+hPa6GHjOh7TtsBSMv52d7xrllkQSRpYXUgU/kwyjQz1hraLTZ8pbRVIxg+wAZWTV1
 x9lL+17nX2fYsTJITZ4nytbEIr+Md2YGITV7FpHFO+MXYysdR47RttqFP1rU3RqKKZop2icI1
 kCPI9oYirHn1G0kcVZGBJcCTPcG3iZLT4WzOQtoS9PmbVXWN2sFMeKpg6p/wp8GfRBrxdYa3+
 ENwSf8DjHENl2QU0JUhFS9x83GMzxpq0WNDmNkTy1zuDQ7THghXCBhcidQSDbKNgozaUzfMsS
 Qk2F/pYMu1Gnf1q3cCO9HNNUFkCde9c3/9MBeLRqueGAoQ95OKy/MnWjvwjEeZVoEZahdQ2YS
 4hMtd/IAWjAuMYKPymf8lA7tHkYCttaTDzSEfR3Z5exKhPujQClHHIVILI0GxjGs+QEpqr4/p
 TUtREk7q9n9J4FhAbtE8ua7ji43ZXXXZ3KTbunTKl7KHnZQTKZKuV7nJ1OCtjHhKVb2FSV5Aw
 84mtaWjhYkzo/SmZUsGcs9Rab+liQNYj22nBN6ShM36lqmgg/apok/p1ykVHN7DS6edhmKcUK
 haQ4Mnta1nOfMCESW3n/LUr014AZ8iIzeNuGDcoS2cxNNC8um+znO8wItA99mkXliPw/h9YQk
 srERaLbxVzSSwxF1tsypJpdp8nlk9Xnm+TYbZvFXg4EWbo3PJZAT66+e6JpN/GAGv7DsiT1ug
 8EE5hPApRRlgx51zTS7ab6mY8NEzyCDdfBESa0wZ5idPU1jblMmM1bjIgY+uH70CjToI4hAuq
 DDk3fnHVSseXxTm1X2kjkgdNxEcc+P0pwGVTqHxVeRbsKhUF60iyHqSRl/TnhhDl0xDG64+rU
 kKIFDeAH9wQ==
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
> > The scripted version of the rebase used to execute `git reset --hard`
> > when skipping or aborting. When we ported this to C, we did update the
> > worktree and some reflogs, but we failed to imitate `git reset --hard`'s
> > behavior regarding files in .git/ such as MERGE_HEAD.
> >
> > Let's address this oversight.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/rebase.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 0ee06aa363..017dce1b50 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -23,6 +23,7 @@
> >  #include "revision.h"
> >  #include "commit-reach.h"
> >  #include "rerere.h"
> > +#include "branch.h"
> >  
> >  static char const * const builtin_rebase_usage[] = {
> >  	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
> > @@ -1002,6 +1003,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >  
> >  		if (reset_head(NULL, "reset", NULL, 0, NULL, NULL) < 0)
> >  			die(_("could not discard worktree changes"));
> > +		remove_branch_state();
> >  		if (read_basic_state(&options))
> >  			exit(1);
> >  		goto run_rebase;
> > @@ -1019,6 +1021,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >  			       options.head_name, 0, NULL, NULL) < 0)
> >  			die(_("could not move back to %s"),
> >  			    oid_to_hex(&options.orig_head));
> > +		remove_branch_state();
> 
> Hmph.  Among 5 or so callsites of reset_head(), only these two
> places need it, so reset_head() is clearly not a substitute for
> "reset --hard HEAD", and it sometimes used to switch branches or
> something?

Indeed. There is also the `git reset --hard` call in the scripted
version's autostash code path. But that definitely does not need to remove
the branch state, as it is not recovering from a merge or cherry-pick or
revert.

> Perhaps we may need to rename it to avoid confusion but it can wait
> until we actually decide to make it externally available.  Until then,
> it's OK as-is, I would think.

Okay.

Ciao,
Dscho

> 
> >  		ret = finish_rebase(&options);
> >  		goto cleanup;
> >  	}
> 
