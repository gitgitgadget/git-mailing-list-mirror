Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B95C1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 12:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbeJLTdS (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 15:33:18 -0400
Received: from mout.gmx.net ([212.227.15.18]:58349 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbeJLTdS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 15:33:18 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQQzk-1g5Wlo0rls-00Tn3O; Fri, 12
 Oct 2018 14:01:04 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQQzk-1g5Wlo0rls-00Tn3O; Fri, 12
 Oct 2018 14:01:04 +0200
Date:   Fri, 12 Oct 2018 14:01:03 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 00/18] builtin rebase options
In-Reply-To: <xmqqmusuz9ql.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810121345160.561@tvgsbejvaqbjf.bet>
References: <20180808152140.14585-1-predatoramigo@gmail.com> <pull.33.v2.git.gitgitgadget@gmail.com> <xmqqmusuz9ql.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8qc4drnD0qU6khp6BLgPzrMLCd1I6+2vN7+I78kOTVWHzMIJwDl
 Gy/EQwjlzYVMgZx9wSegkX8mqxymRH85Lo22IXjrBQBkkj8i8wv7Fp85rIU9lFUZMbtZcrQ
 I1vl1deeli83OwAMOxJdmAb83aNIIYL8j/2GwK47ggIeXtqsaobKPb4XpXxQ4qS223wThCe
 9awN4CHPlFW9dK1L/zmDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CNgA+zkjIrk=:2rzDAgi38UDvPll6mN1cHf
 H803GQX27FKOw2gYBlcmfIutOmsTGYH293yln9bB67mfqNMBKZFU2cgonivclec8ynG1e58iD
 Uh2kjOkYtSQbBwQ9PY+mQsx1kftGw4jh/diG5cXbH9ldYikWwDaWzhci1f9gsMwAClpwnNph5
 UL7W3w8vjKm75T8fjn5Qs+xJtGQD7gzwTRDyi3DSVfLLru5uI8bM8nC7wvWHlCmbGE2NXbnhZ
 cLJX+8lwkQaGxhXIXGvBy5CTCjvSAbtz991b7ClRzOUTtRi+FAC6+iXdtNUT1MrzShgN2jMQg
 6XS7LG2T9tjBiRrM64+A/FQvNAzHO9pdNjWXwWSVVnqOBkPV0S+Hym11LrTU7sDswa2dy6Q88
 98CqwZgRiwjX18m4vxrVQ8Y6EPgB2LDmm5ucNFKS0FDBPeSThLuVpideaSfwUZNEpHBB94CAM
 JuQ7PmDFfbfFEBL9t+KNkaW/9C6L+JMmNPVYxuOrkn08BLna2UzG8x1B+39wjUXWH9mT/RlrR
 FBEA39AFNWDwpgn6ogoKY7AcYLBWO9LZb9rdALnRzpC4Az52ChFkjyUjZ9mUINkwVSpY2mb8/
 BVGprC5DOF0h4uJXy4fTMlttRszD7Qi7Ok9IQcf0pzuTphOOqIdvw7BzN50jJiH7GwUIiArst
 1OMHkW6T9JQ/nzv79B1qXrCGlM1zeaeL0dIS1CrqScV8swdbOLvHZ2GB36DalFTNyRDwgQsCW
 sEEKaOHcAqGuD+mDA1sX+7Ud0QgyppOgfNqwjiyEhk/e3FtoJZwSPB1N1qCsnsQeNTxYAttxB
 /KArj6hpTBn4hE7CKjZVOVgWhzp37YPHEoWEglpfIlJ2FWPDMI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 6 Sep 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > This patch series completes the support for all rebase options in the
> > builtin rebase, e.g. --signoff, rerere-autoupdate, etc.
> >
> > It is based on pk/rebase -in-c-3-acts.
> 
> ... which in turn was based on pk/rebase-in-c-2-basic that just got
> rerolled, so I would assume that you want pk/rebase-in-c-3-acts I
> have rebased on top of the result of applying the updated 2-basic
> series.
> 
> I've rebuilt the collection of topics up to pk/rebase-in-c-6-final
> with these two updated series twice, once doing it manually, like I
> did the last time, and another using "rebase -i -r" on top of the
> updated pk/rebase-in-c-4-opts.  The resulting trees match, of
> course.
> 
> I did it twice to try out how it feels to use "rebase -i -r" because
> I wanted to make sure what we are shipping in 'master' behaves
> sensibly ;-)
> 
> Two things I noticed about the recreation of the merge ...
> 
> 	Reminder to bystanders.  We need to merge ag/rebase-i-in-c
> 	topic on top of pk/reabse-in-c-5-test topic before applying
> 	a patch to adjust rebase to call rebase-i using the latter's
> 	new calling convention.  The topics look like
> 
> 	- pk/rebase-in-c has three patches on master
> 	- pk/rebase-in-c-2-basic builds on it, and being replaced
> 	- pk/rebase-in-c-3-acts builds on 2-basic (no update this time)
> 	- pk/rebase-in-c-4-opts builds on 3-acts, and being replaced
> 	- pk/rebase-in-c-5-test builds on 4-opts (no update this time)
> 	- js/rebase-in-c-5.5 builds on 5-test and merges ag/rebase-in-c
> 	  topic before applying one patch on it (no update this time)
> 	- pk/rebase-in-c-6-final builds on 5.5 (no update this time)
> 
> 	and we are replacing 2-basic with 11 patches and 4-opts with
> 	18 patches.
> 
> ... using "rebase -i -r" are that 
> 
>  (1) it rebuilt, or at least offered to rebuild, the entire side
>      branch, even though there is absolutely no need to.  Leaving
>      "pick"s untouched, based on the correct fork point, resulted in
>      all picks fast forwarded, but it was somewhat alarming.

Right. But this is a legacy of our paradigm to script things in Unix shell
script. It not only is slow, error-prone and hard to keep portable, it
also encourages poor design, as you do not have the same expressive power
as C has.

In this case, it harmed us by making it impossible to essentially play out
the rebase in memory and only fall back to writing things into the
worktree upon failure.

However, this is where we want to go. It is still a long way to go,
though, as many code parts are safely in the "we use the worktree to play
out the rebase in its entirety" place.

The "skip_unnecessary_picks" trick is the best we could do so far.

>  (2) "merge -C <original merge commit> ag/rebase-i-in-c" appeared as
>      the insn to merge in the (possibly rebuilt) side branch.  And
>      just like "commit -C", it took the merge message from the
>      original merge commit, which means that the summary of the
>      merged side branch is kept stale.  In this particular case, I
>      did not even want to see ag/rebase-i-in-c topic touched, so I
>      knew I want to keep the original merge summary, but if the user
>      took the offer to rewrite the side branch (e.g. with a "reword"
>      to retitle), using the original merge message would probably
>      disappoint the user.

Right. But the user would then also freely admit that they asked for the
merge commit to be rebased, which is what `--rebase-merges` says.

> I think (1) actually is a feature.  Not everybody is an integrator
> who does not want to touch any commit on the topic branch(es) while
> rebuilding a single-strand-of-pearls that has many commits and an
> occasional merge of the tip of another topic branch.  It's just that
> the feature does not suit the workflow I use when I am playing the
> top-level integrator role.

As I said. The ideal thing would be to invest quite a bit in refactoring
especially the do_pick_commit() function, and then play out the rebase in
memory, where one state variable knows what the "HEAD" is (but the
worktree is left untouched, up until the point when an error occurs, in
which case we want to write out the files). This would also need a major
refactoring of the recursive merge, of course, which conflates the merge
part with the writing of the merge conflicts to disk part.

While I would love to see this happening, I don't think that I can spare
enough time to drive this, at least for a couple of years.

> I am not sure what should be the ideal behaviour for (2).  I would
> imagine that
> 
>  - I do want to keep the original title the merge (e.g. "into
>    <target branch>", if left to "git merge" to come up with the
>    title during "rebase -i" session, would be lost and become "into
>    HEAD", which is not what we want);
> 
>  - I do want to keep the original commentary in the merge (e.g. what
>    you would see in "git log --first-parent master..next" that gives
>    summary of each topic getting merged) so that I can update it as
>    needed; but 
> 
>  - I do want the topic summary fmt-merge-msg produces to be based on
>    the updated side branch.
> 
> I am not sure if the last item can reliably be filtered out of the
> original and replaced with newly generated summary.  If we can do
> so, that would be ideal, I guess.

I think what you want is not the `merge` command, but a custom script that
you can then `exec`.

This could even be automated to some extent, by introducing an option to
`git rebase -i` that lets a script post-process the generated todo list,
something I wanted for a long time.

> Another observation was that after rebuiding pk/rebase-in-c-6^0 on
> top of the updated pk'/rebase-in-c-4 using "rebase -i -r", I of
> course still needed to "branch -f" to update pk/rebase-in-c-5,
> js/reabse-in-c-5.5, and pk/rebase-in-c-6 branches to point at
> appropriate commits.  I do not think it is a good idea to let
> "rebase -i" munge these dependent branches by default, but it might
> be worth considering it as an option.

Yes! Already years ago, I wanted to teach the shears to figure out that a
branch (i.e. a second parent of a merge commit that mentions the branch
name in its oneline) was updated by the rebase, and if the pre-rebase
commit agrees with a local ref of that name, update said ref after the
rebase finished successfully.

There is one big caveat, though: what if one of those branches is checked
out in a worktree?

I think it can be done, and it should be hidden behind an opt-in config
setting.

#leftoverbits?

> Since I want to be more in control of what happens to the tips of topic
> branches, I did not mind at all having to run "branch -f" and having the
> chance to run "diff" before doing so, but at the same time, that means
> doing these manually in steps building 5 on 4, 5.5 on 5 and then 6 on
> 5.5, instead of building 6 on top of 4 using "rebase -i" and then
> tagging the intermediate states, gives me more control without forcing
> me more work.

Sure. This definitely gives you more control.

I am not sure whether you want that control, or whether you *actually*
want more safety guards. If it was me, I would prefer something that can
stop/pause the process when something is obviously going wrong (it could
be a script verifying that, e.g. looking at the length/contents of the
range-diff and ringing an alarm when a commit other than a fixup! was
dropped).

Ciao,
Dscho
