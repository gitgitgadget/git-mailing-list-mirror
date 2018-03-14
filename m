Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80C951FAE2
	for <e@80x24.org>; Wed, 14 Mar 2018 07:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753350AbeCNHVw (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 03:21:52 -0400
Received: from mail.javad.com ([54.86.164.124]:38971 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750862AbeCNHVu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 03:21:50 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id B208F3E92E;
        Wed, 14 Mar 2018 07:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521012109;
        bh=3hAkfzcOLdspfv1mAQggWGsvTeSS849Ij14PILLhn0M=; l=6213;
        h=Received:From:To:Subject;
        b=QaBnMTHuKihFUCw8fFBO/SjXLmsDLf1xSQyoUvbYhX9flnHcx6Jz37XESXCmIcMp1
         /AYbR7HrZ/DCJ7+FBMy1QIye8WANoiJGJ5d+F/7Y6DNkuKR2cWcC94pFoYQbrgMyRk
         s3hYFmjhrVuEKnRpy09BY5EC4V0nnyFUj8Qz7dfo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521012109;
        bh=3hAkfzcOLdspfv1mAQggWGsvTeSS849Ij14PILLhn0M=; l=6213;
        h=Received:From:To:Subject;
        b=QaBnMTHuKihFUCw8fFBO/SjXLmsDLf1xSQyoUvbYhX9flnHcx6Jz37XESXCmIcMp1
         /AYbR7HrZ/DCJ7+FBMy1QIye8WANoiJGJ5d+F/7Y6DNkuKR2cWcC94pFoYQbrgMyRk
         s3hYFmjhrVuEKnRpy09BY5EC4V0nnyFUj8Qz7dfo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521012109;
        bh=3hAkfzcOLdspfv1mAQggWGsvTeSS849Ij14PILLhn0M=; l=6213;
        h=Received:From:To:Subject;
        b=QaBnMTHuKihFUCw8fFBO/SjXLmsDLf1xSQyoUvbYhX9flnHcx6Jz37XESXCmIcMp1
         /AYbR7HrZ/DCJ7+FBMy1QIye8WANoiJGJ5d+F/7Y6DNkuKR2cWcC94pFoYQbrgMyRk
         s3hYFmjhrVuEKnRpy09BY5EC4V0nnyFUj8Qz7dfo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521012109;
        bh=3hAkfzcOLdspfv1mAQggWGsvTeSS849Ij14PILLhn0M=; l=6213;
        h=Received:From:To:Subject;
        b=QaBnMTHuKihFUCw8fFBO/SjXLmsDLf1xSQyoUvbYhX9flnHcx6Jz37XESXCmIcMp1
         /AYbR7HrZ/DCJ7+FBMy1QIye8WANoiJGJ5d+F/7Y6DNkuKR2cWcC94pFoYQbrgMyRk
         s3hYFmjhrVuEKnRpy09BY5EC4V0nnyFUj8Qz7dfo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521012109;
        bh=3hAkfzcOLdspfv1mAQggWGsvTeSS849Ij14PILLhn0M=; l=6213;
        h=Received:From:To:Subject;
        b=QaBnMTHuKihFUCw8fFBO/SjXLmsDLf1xSQyoUvbYhX9flnHcx6Jz37XESXCmIcMp1
         /AYbR7HrZ/DCJ7+FBMy1QIye8WANoiJGJ5d+F/7Y6DNkuKR2cWcC94pFoYQbrgMyRk
         s3hYFmjhrVuEKnRpy09BY5EC4V0nnyFUj8Qz7dfo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521012109;
        bh=3hAkfzcOLdspfv1mAQggWGsvTeSS849Ij14PILLhn0M=; l=6213;
        h=Received:From:To:Subject;
        b=QaBnMTHuKihFUCw8fFBO/SjXLmsDLf1xSQyoUvbYhX9flnHcx6Jz37XESXCmIcMp1
         /AYbR7HrZ/DCJ7+FBMy1QIye8WANoiJGJ5d+F/7Y6DNkuKR2cWcC94pFoYQbrgMyRk
         s3hYFmjhrVuEKnRpy09BY5EC4V0nnyFUj8Qz7dfo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521012109;
        bh=3hAkfzcOLdspfv1mAQggWGsvTeSS849Ij14PILLhn0M=; l=6213;
        h=Received:From:To:Subject;
        b=QaBnMTHuKihFUCw8fFBO/SjXLmsDLf1xSQyoUvbYhX9flnHcx6Jz37XESXCmIcMp1
         /AYbR7HrZ/DCJ7+FBMy1QIye8WANoiJGJ5d+F/7Y6DNkuKR2cWcC94pFoYQbrgMyRk
         s3hYFmjhrVuEKnRpy09BY5EC4V0nnyFUj8Qz7dfo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521012109;
        bh=3hAkfzcOLdspfv1mAQggWGsvTeSS849Ij14PILLhn0M=; l=6213;
        h=Received:From:To:Subject;
        b=QaBnMTHuKihFUCw8fFBO/SjXLmsDLf1xSQyoUvbYhX9flnHcx6Jz37XESXCmIcMp1
         /AYbR7HrZ/DCJ7+FBMy1QIye8WANoiJGJ5d+F/7Y6DNkuKR2cWcC94pFoYQbrgMyRk
         s3hYFmjhrVuEKnRpy09BY5EC4V0nnyFUj8Qz7dfo=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1ew0jK-0003ax-Jw; Wed, 14 Mar 2018 10:21:46 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Phillip Wood <phillip.wood@talktalk.net>,
        phillip.wood@dunelm.org.uk, Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com>
        <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
        <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
        <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
        <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
        <87606hoflx.fsf@javad.com>
        <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
        <87a7vss6ax.fsf@javad.com>
        <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net>
        <877eqgardi.fsf@javad.com>
        <3f2209e0-c560-5384-c589-3aa83615d688@gmail.com>
Date:   Wed, 14 Mar 2018 10:21:46 +0300
In-Reply-To: <3f2209e0-c560-5384-c589-3aa83615d688@gmail.com> (Igor
        Djordjevic's message of "Wed, 14 Mar 2018 02:12:28 +0100")
Message-ID: <87efkn6s1h.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

> Hi Sergey,
>
> On 13/03/2018 17:10, Sergey Organov wrote:
>> 
>> > Hi Sergey, I've been following this discussion from the sidelines,
>> > though I haven't had time to study all the posts in this thread in
>> > detail. I wonder if it would be helpful to think of rebasing a merge as
>> > merging the changes in the parents due to the rebase back into the
>> > original merge. So for a merge M with parents A B C that are rebased to
>> > A' B' C' the rebased merge M' would be constructed by (ignoring shell
>> > quoting issues)
>> >
>> > git checkout --detach M
>> > git merge-recursive A -- M A'
>> > tree=$(git write-tree)
>> > git merge-recursive B -- $tree B'
>> > tree=$(git write-tree)
>> > git merge-recursive C -- $tree C'
>> > tree=$(git write-tree)
>> > M'=$(git log --pretty=%B -1 M | git commit-tree -pA' -pB' -pC')
>> 
>> I wonder if it's OK to exchange the order of heads in the first merge
>> (also dropped C for brevity):
>
> It should be, being "left" or "right" hand side ("theirs" or "ours") 
> of the three-way merge shouldn`t matter, they`re still both equally 
> compared to the merge-base.
>
>> git checkout --detach A'
>> git merge-recursive A -- A' M
>> tree=$(git write-tree)
>> git merge-recursive B -- $tree B'
>> tree=$(git write-tree)
>> M'=$(git log --pretty=%B -1 M | git commit-tree -pA' -pB')
>> 
>> If so, don't the first 2 lines now read: "rebase (first parent of) M on
>> top of A'"?
>
> Hmm, lol, yes...? :) So basically, this:
>
> (1)	git checkout --detach M
> 	git merge-recursive A -- M A'
> 	tree=$(git write-tree)
> 	...
>
> ... is equivalent to this:
>
> (2)	git checkout --detach A'
> 	git merge-recursive A -- A' M
> 	tree=$(git write-tree)
> 	...
>
> ..., being equivalent to this:
>
> (3)	git checkout --detach A'
> 	git cherry-pick -m 1 M
> 	tree=$(git write-tree)
> 	...
>
> ..., where in all three cases that `$tree` is equivalent to U1' we 
> discussed about so much already :)

Exactly, and thanks for noticing that it's actually U1', that happens to
soon become rather handy, see below.

> I tested it like this as well, slightly modifying previously sent out 
> script (like this one[1]), and it still seems to be working ;) Nice!

Very nice of you, thanks!

Yet another outcome of this transformation is that the fist step is now
free to (and probably should) utilize all the options (-s, -X, etc.)
that usual rebase has:

git-rebase-first-parent --onto A' M
tree=$(git write-tree)

where 'git-rebase-first-parent' is whatever machinery is currently being
used to rebase simple non-merge commit.

[

Moreover, Phillip's method could further be transformed to what is in
RFC, not that I think it should, see below. Just for the sake of
completeness though, here is the essential missing transformation that
makes Phillip's method symmetric, after which it becomes true special
case of the RFC with particular rebase-first-parent implementation:

git checkout --detach A'
git merge-recursive A -- A' M
tree_U1'=$(git write-tree)
git checkout --detach B'
git merge-recursive B -- B' M
tree_U2'=$(git write-tree)
git merge-recursive M -- $tree_U1' $tree_U2'
tree=$(git write-tree)
M'=$(git log --pretty=%B -1 M | git commit-tree -pA' -pB')

]

>
>> If so, then it could be implemented so that it reduces back to regular
>> rebase of non-merges when applied to a single-parent commit, similar to
>> the method in the RFC, striking out one of advantages of the RFC.
>
> I guess so, but I think it now boils down only to what one finds 
> easier to reason about even more.

I actually think there is more to it. It's incremental asymmetric nature
of the Phillip's approach that I now find rather appealing and worth to
be used in practice.

While the RFC approach, being entirely symmetric, is nice from the POV
of theory and reasoning, yet simple to implement, the actual user
interface of Git is inherently asymmetric with respect to merges (one
merges side-branch(es) to mainline), so asymmetric approach of the
Phillip's method should give smoother user experience, even if only
because of 1 less merge.

There are still 2 issues about the implementation that need to be
discussed though:

1. Still inverted order of the second merge compared to RFC.

It'd be simple to "fix" again, except I'm not sure it'd be better, and
as there is no existing experiences with this step to follow, it
probably should be left as in the original, where it means "merge the
changes made in B' (w.r.t B) into our intermediate version of the
resulting merge".

The original Phillip's version seems to better fit the asymmetry between
mainline and side-branch handling.

The actual difference will be only in the order of ours vs theirs in
conflicts though, and thus it's not that critical.

2. The U1' == U2' consistency check in RFC that I still think is worth
to be implemented.

In application to the method being discussed, we only need the check if
the final merge went without conflicts, so the user was not already
involved, and the check itself is then pretty simple:

 "proceed without stop only if $tree = $tree_U1'"

Its equivalence to the U1' == U2' test in the RFC follows from the fact
that if M' is non-conflicting merge of U1' and U2', then M' == U1' if
and only if U2' == U1'.

Finally, here is a sketch of the implementation that I'd suggest to
use:

git-rebase-first-parent --onto A' M
tree_U1'=$(git write-tree)
git merge-recursive B -- $tree_U1' B'
tree=$(git write-tree)
M'=$(git log --pretty=%B -1 M | git commit-tree -pA' -pB')
[ $conflicted_last_merge = "yes" ] ||
  trees-match $tree_U1' $tree || 
  stop-for-user-amendment

where 'git-rebase-first-parent' denotes whatever machinery is currently
being used to rebase simple non-merge commit. Handy approximation of
which for stand-alone scripting is:

git checkout --detach A' && git cherry-pick -m 1 M

[As an interesting note, observe how, after all, that original Johannes
Sixt's idea of rebasing of merge commit by cherry-picking its first
parent is back there.]

-- Sergey
