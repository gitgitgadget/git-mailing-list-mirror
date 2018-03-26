Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60C8E1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 13:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeCZNrR (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 09:47:17 -0400
Received: from mout.gmx.net ([212.227.15.15]:59319 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751127AbeCZNrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 09:47:16 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Luxaj-1ea5nD103l-0105kU; Mon, 26
 Mar 2018 15:47:10 +0200
Date:   Mon, 26 Mar 2018 15:47:09 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Sergey Organov <sorganov@gmail.com>
cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
In-Reply-To: <87vadyd9az.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1803261518390.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com> <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com> <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com> <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
 <87a7vss6ax.fsf@javad.com> <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com> <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org> <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net> <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
 <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com> <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net> <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
 <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <2749ce78-8917-c821-6116-0c8d67b5e16e@gmail.com> <87vadyd9az.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fRiISr3slu3KbxHlT6z3PFzrkvytgvFVJ8TScVYobmY/2R08aDX
 mpfde7o/O7aXLmQ2s1qBL5zPtUqiynyJovhQX0mYBHB2/ean+W2uzgPMt3qCNjEAFE1grrx
 MJ2sLVGMETxgWrVFVs1aTaGKBuac/SWqT0KEMPUbksbBO0TmhE/XEWp1sWHC/iIdqKZPPxX
 ADBlOFyZ3daMiXr4rt8Pw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Zex84Hgl/wc=:H1aLrIMekjAF0nfiq5gY8Z
 Ba5lCZeDLge9BGg+JRVC5UFoT53uzaUmXX+HRGT4plKgWrWtzzjnjQNc6GktrH8mXqgLoyyYL
 o/z0scXs8We8lcB6HmwGedxe+7AGksZpciIbzbDamq/VI3Dgot9QTLKN8++fqihamq6pvNMX0
 9oYa4InZsZOeWAX57tEH3D/2h2Jj2lFj3Fwfsp5N6Lap5A791qLtMjA84+Xac278P8dmg/s9Z
 2twqzEav/WniZcWJ/TZgTa72/FvWBtHV1qf38tiQ+N6qXcSLO80VNOWYyk4HQJtooxGopXqDz
 kpkA6FdReSxvi9ACjzBrE5cmCLnYoYBm8vTEXX7SpzTMtdYA9oSOuUvZzpjbpKPQjCHt/ZUmr
 WHU6RyjQgiBcD5sl1K5Inezx97vh9KMYWtl9TVHL2A+EXR3KsYUGvziMgeIpIY0RE7pKcNdCU
 RCjR18UciPNl2jqO4F/sR+oUNOrmwgErf322iSGuCJc1gZKj4gXJFMCYpR8ED2eSTcomQuMQK
 z7y89pA5R2q8o/zdDfiwWCF6w7jE+jECmV17Uu6iBsGgEJYd/LtRbyv2kdnfVdAS2ghYhb8Ii
 A0773hzoH716C3JMNTZoxRIwtTkYCZdaAqWtqXvhGCBBjnoWRSZRybt6cGAv5UWViiubzLYgP
 U0WvwQ4knMK+CSN780n4TDHREbq+EAnvso3lf786TvNdzy/LB79F0qa3qEhBTX1mUi1GrkOYS
 Jf1Y9UcIJVSGzuZlJSigoG87IWZ1rUgGx8vwwuLh6KffmeHPD4TA0TCCs7ZW159OnR4bTSHzE
 JFDnPbiD1rOAlvaKqqX+AQJgP7/kgOc0aSIPAZpKCvZF2XkpQ2hfGQRTfEXxsCIVJEp7WwW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Wed, 14 Mar 2018, Sergey Organov wrote:

> Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:
> 
> > On 07/03/2018 08:26, Johannes Schindelin wrote:
> 
> [...]
> 
> >> Second side note: if we can fast-forward, currently we prefer that,
> >> and I think we should keep that behavior with -R, too.
> >
> > I agree.
> 
> I'm admittedly somewhat lost in the discussion,

... and cutting so much context does not help...

The "fast-forward" here refers to the thing `git rebase` does unless you
call it with `--force-rebase`: if we are about to `pick` a commit, and
HEAD already points to its parent commit, we do not evey cherry-pick: we
just fast-forward to the original commit.

Likewise, `merge -C <commit>` will simply fast-forward to the specified
commit if HEAD is pointing to its first parent and the specified merge
heads are also identical to the respective original parent commits.

What I said with my comment was that `merge -R -C <commit>` will behave in
exactly the same way.

> but are you talking fast-forward on _rebasing_ existing merge? Where
> would it go in any of the suggested algorithms of rebasing and why?

And this is something I did not talk about yet, but it does come up in
practice: the main use case of rebasing branches is to follow an
"upstream", of course. And guess what? From time to time, some of the
branches get merged upstream (or, in Git's own source code, applied). In
this case, the Git garden shears *do* skip the merge (as the new merge
head is already an ancestor of HEAD). In --recreate-merges, it *will*
create a new merge commit, though, which is a bit annoying.

The best way to handle this would *probably* look similar to how "empty"
commits (i.e. commits whose patch is empty) are handled by rebase. But it
is not yet clear to me how that would look in practice, as `pick <commit>`
is a single operation that can be easily commented out in the todo list
depending on `--allow-empty`, while the `merge -C <commit>` command is not
the entire operation, as there may be `pick` commands in the merge head
that could potentially be skipped due to merge conflicts with
already-applied versions of the same patches.

If this sounds unclear to you, please do ask for clarification. Although
this is currently not my highest priority in the `sequencer-shears` branch
thicket (where `--recreate-merges` is the first part).

> I readily see how it can break merges. E.g., any "git merge --ff-only
> --no-ff" merge will magically disappear.

Did you mean `git merge --no-ff`? Combining `--ff-only` with `--no-ff`
does not make sense.

> So, even if somehow supported, fast-forward should not be performed by
> default during _rebasing_ of a merge.

That statement is too general to be correct.

*If* we detect that the original merge could have been fast-forwarded
instead (and it is very easy to detect that in --make-list), we would have
to handle that similar to afore-mentioned empty commits in conjunction
with `--allow-empty`.

If the original merge could not have been fast-forwarded, but during the
rebase it *can*, we should skip it, as the reason for the merge commit
is clearly no longer there.

This, by the way, is an insight you can really only win by using
--recreate-merges (or the Git garden shears). And using it a *lot*.
Because otherwise, you will not even guess correctly what will, and what
won't, come up in practice.

> >> If the user wants to force a new merge, they simply remove that -R
> >> flag.
> 
> Alternatively, they'd replace 'pick' with 'merge', as they already do
> for other actions. "A plurality is not to be posited without necessity".

No, no, no and no again!

We learned how *wrong* the `pick` approach was with --preserve-merges!
Have you *ever* used --preserve-merges in any real way? If so, you *have*
encountered the problems, and probably directed several lengthy curses my
way for that lousy design.

A pick is a pick is a pick. Of a single patch with metadata such as the
author, commit message and the date.

A merge is not a patch. While a pick introduces a specific change on top
of a single revision, the changes introduced by a merge are ideally
already there. It is conceptually *very* different.

Sure, a merge commit sometimes needs to introduce extra changes on top of
the merged changes, sure, that happens (and is called "evil merge" in Git
parlance). Those *additional* changes should be kept as minimal as
possible, in particular there should only be changes *necessitated* by the
reconciled changes.

So no, a `pick` is not a `merge`. Not at all.

> Please, _please_, don't use 'merge' command to 'pick' merge commits!
> It's utterly confusing!

Please, please, please *work* with branch thickets for a while. And you
will see that it makes a *huge* difference!

For example, within a block of `pick` lines, it is relatively safe to
reorder. You see more or less what changes interact with one another.

Be *very* careful when reordering `merge` lines, in particular when you
have a real-world branch thicket, not just a toy example.

Do *not* use `pick` for merges. Not. Ever.

By the way, let this here discussion serve as Yet Another Example why it
is important to not only consider new features theoretically. Only in
practice do you find out where your theory sounded too good to be actually
true.

> Thinking about it I've got an idea that what we actually need is
> --no-flatten flag that, when used alone, will just tell "git rebase" to
> stop flattening history, and which will be implicitly imposed by
> --recreate-merges (and --preserve-merges).

... and this flag would only make sense if every `git rebase` involved a
todo list.

Which it does not.

Ciao,
Johannes
