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
	by dcvr.yhbt.net (Postfix) with ESMTP id 09C5F1FAE2
	for <e@80x24.org>; Thu, 15 Mar 2018 07:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbeCOHxA (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 03:53:00 -0400
Received: from mail.javad.com ([54.86.164.124]:41395 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750745AbeCOHw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 03:52:59 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 013243E92E;
        Thu, 15 Mar 2018 07:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521100377;
        bh=ucijrac4r21lijg+cjyKQ4Eah20bfNuqTaWS5vVBaZA=; l=5946;
        h=Received:From:To:Subject;
        b=rR5rjz9d8vSRkBCNc6jVfTbWYRu6BJAPzo9fHLJ+f0OgHvYhlp9xxcB6tDBlS1REe
         30TJph944wA7DRQ4lfpXuoymWAj+n0mA3WBpnqHDcXcsRPCEk+mrL0f57z3ixELLNy
         iWBysf6z+fQtEBEF5WkufAU/htNDMmz0NFrU1MbU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521100377;
        bh=ucijrac4r21lijg+cjyKQ4Eah20bfNuqTaWS5vVBaZA=; l=5946;
        h=Received:From:To:Subject;
        b=rR5rjz9d8vSRkBCNc6jVfTbWYRu6BJAPzo9fHLJ+f0OgHvYhlp9xxcB6tDBlS1REe
         30TJph944wA7DRQ4lfpXuoymWAj+n0mA3WBpnqHDcXcsRPCEk+mrL0f57z3ixELLNy
         iWBysf6z+fQtEBEF5WkufAU/htNDMmz0NFrU1MbU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521100377;
        bh=ucijrac4r21lijg+cjyKQ4Eah20bfNuqTaWS5vVBaZA=; l=5946;
        h=Received:From:To:Subject;
        b=rR5rjz9d8vSRkBCNc6jVfTbWYRu6BJAPzo9fHLJ+f0OgHvYhlp9xxcB6tDBlS1REe
         30TJph944wA7DRQ4lfpXuoymWAj+n0mA3WBpnqHDcXcsRPCEk+mrL0f57z3ixELLNy
         iWBysf6z+fQtEBEF5WkufAU/htNDMmz0NFrU1MbU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521100377;
        bh=ucijrac4r21lijg+cjyKQ4Eah20bfNuqTaWS5vVBaZA=; l=5946;
        h=Received:From:To:Subject;
        b=rR5rjz9d8vSRkBCNc6jVfTbWYRu6BJAPzo9fHLJ+f0OgHvYhlp9xxcB6tDBlS1REe
         30TJph944wA7DRQ4lfpXuoymWAj+n0mA3WBpnqHDcXcsRPCEk+mrL0f57z3ixELLNy
         iWBysf6z+fQtEBEF5WkufAU/htNDMmz0NFrU1MbU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521100377;
        bh=ucijrac4r21lijg+cjyKQ4Eah20bfNuqTaWS5vVBaZA=; l=5946;
        h=Received:From:To:Subject;
        b=rR5rjz9d8vSRkBCNc6jVfTbWYRu6BJAPzo9fHLJ+f0OgHvYhlp9xxcB6tDBlS1REe
         30TJph944wA7DRQ4lfpXuoymWAj+n0mA3WBpnqHDcXcsRPCEk+mrL0f57z3ixELLNy
         iWBysf6z+fQtEBEF5WkufAU/htNDMmz0NFrU1MbU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521100377;
        bh=ucijrac4r21lijg+cjyKQ4Eah20bfNuqTaWS5vVBaZA=; l=5946;
        h=Received:From:To:Subject;
        b=rR5rjz9d8vSRkBCNc6jVfTbWYRu6BJAPzo9fHLJ+f0OgHvYhlp9xxcB6tDBlS1REe
         30TJph944wA7DRQ4lfpXuoymWAj+n0mA3WBpnqHDcXcsRPCEk+mrL0f57z3ixELLNy
         iWBysf6z+fQtEBEF5WkufAU/htNDMmz0NFrU1MbU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521100377;
        bh=ucijrac4r21lijg+cjyKQ4Eah20bfNuqTaWS5vVBaZA=; l=5946;
        h=Received:From:To:Subject;
        b=rR5rjz9d8vSRkBCNc6jVfTbWYRu6BJAPzo9fHLJ+f0OgHvYhlp9xxcB6tDBlS1REe
         30TJph944wA7DRQ4lfpXuoymWAj+n0mA3WBpnqHDcXcsRPCEk+mrL0f57z3ixELLNy
         iWBysf6z+fQtEBEF5WkufAU/htNDMmz0NFrU1MbU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521100377;
        bh=ucijrac4r21lijg+cjyKQ4Eah20bfNuqTaWS5vVBaZA=; l=5946;
        h=Received:From:To:Subject;
        b=rR5rjz9d8vSRkBCNc6jVfTbWYRu6BJAPzo9fHLJ+f0OgHvYhlp9xxcB6tDBlS1REe
         30TJph944wA7DRQ4lfpXuoymWAj+n0mA3WBpnqHDcXcsRPCEk+mrL0f57z3ixELLNy
         iWBysf6z+fQtEBEF5WkufAU/htNDMmz0NFrU1MbU=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1ewNh1-00054w-9q; Thu, 15 Mar 2018 10:52:55 +0300
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
        <87efkn6s1h.fsf@javad.com>
        <de063fba-2882-6194-a889-ad3e9b6b02b9@gmail.com>
Date:   Thu, 15 Mar 2018 10:52:55 +0300
In-Reply-To: <de063fba-2882-6194-a889-ad3e9b6b02b9@gmail.com> (Igor
        Djordjevic's message of "Thu, 15 Mar 2018 01:09:31 +0100")
Message-ID: <87lget7p2g.fsf@javad.com>
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
> On 14/03/2018 08:21, Sergey Organov wrote:
>> 
>> There are still 2 issues about the implementation that need to be
>> discussed though:
>> 
>> 1. Still inverted order of the second merge compared to RFC.
>> 
>> It'd be simple to "fix" again, except I'm not sure it'd be better, and
>> as there is no existing experiences with this step to follow, it
>> probably should be left as in the original, where it means "merge the
>> changes made in B' (w.r.t B) into our intermediate version of the
>> resulting merge".
>> 
>> The original Phillip's version seems to better fit the asymmetry between
>> mainline and side-branch handling.
>> 
>> The actual difference will be only in the order of ours vs theirs in
>> conflicts though, and thus it's not that critical.
>
> Shouldn`t this be easy to solve just by changing the order of <head> 
> and <remote>, on passing to `git merge-recursive`, if needed? (or 
> that`s what you meant by "simple to fix"?)

Yes, that's exactly what I meant, except it looks cleaner as is, so I
don't think the exchange is called for.

>> 2. The U1' == U2' consistency check in RFC that I still think is worth
>> to be implemented.
>
> At the moment, I think we`d appreciate test cases where it actually 
> proves useful, as the general consensus seems to be leaning towards 
> it possibly being annoying (over-paranoid).

As we now have a simple way to actually check it even in this algorithm,
I'd suggest command-line option to either relax or enforce the check,
whatever the default is. For the default, I'd still opt for safety, as
without it we will gather little experience with this new matter.

Honestly, without this check available, I'd likely vote for at least an
option for stopping on every rebased merge, on the ground that if
rebasing a non-merge could be a trouble, rebasing a merge is at least
double-trouble, and it's not that frequent anyway. So the check we
discuss is actually a way to make all the process much less paranoid,
not more.

By the way, nobody yet commented about "rerere" behavior that basically
stops rebasing every time it fires. Do you consider it over-paranoid?

As for test cases, I have none myself, but "-s ours" merge may be an
example of an actual trouble.

If we don't treat it specially, then changes to side branch will be
silently propagated over the merge, that's obviously not what is needed,
provided user keeps his intention to leave the merge "-s ours".

If we do treat it specially, it could be the case that the merge in
question only looks like "-s ours" by pure accident, and thus changes to
the side branch should be propagated.

I don't see how we can safely proceed without stop for user assistance.
Had we already achieved some consensus on this issue?

>
>> In application to the method being discussed, we only need the check if
>> the final merge went without conflicts, so the user was not already
>> involved, and the check itself is then pretty simple:
>> 
>>  "proceed without stop only if $tree = $tree_U1'"
>> 
>> Its equivalence to the U1' == U2' test in the RFC follows from the fact
>> that if M' is non-conflicting merge of U1' and U2', then M' == U1' if
>> and only if U2' == U1'.
>
> Nicely spot! I`m glad there`s still (kind of) former U1' == U2' check 
> in this approach, too, in case it proves useful :)
>
>> Finally, here is a sketch of the implementation that I'd suggest to
>> use:
>> 
>> git-rebase-first-parent --onto A' M
>> tree_U1'=$(git write-tree)
>> git merge-recursive B -- $tree_U1' B'
>> tree=$(git write-tree)
>> M'=$(git log --pretty=%B -1 M | git commit-tree -pA' -pB')
>> [ $conflicted_last_merge = "yes" ] ||
>>   trees-match $tree_U1' $tree || 
>>   stop-for-user-amendment
>
> Yes, in case where we would want the "no-op merge" check (equivalent 
> to U1' == U2' with original approach), this aligns with something I 
> would expect.
>
> Note that all the "rebase merge commit" steps leading to the check 
> will/should probably be observed as a single one from user`s perspective 
> (in worst case ending with nested conflicts we discussed), thus 
> `$conflicted_last_merge` is not related to `merge-recursive` step(s) 
> only, but `rebase-first-parent`, too (just in case this isn`t implied).
>
> Might be easier to reason about simply as `[ $conflicts = "yes" ] || `

No. For this check it's essential to ensure that no tweaking of the
content has been performed under the hood after the user has resolved
conflicts, i.e., after he has been involved last time.

If all this is done in one "huge merge" step from user point of view,
then the check belongs to this merge, as this is the last (and the only)
one. If it's done in steps (and I vote for it), only the last merge
status is essential for the check, preceding merges don't matter.

As I said, putting myself on the user side, I'd prefer entirely separate
first step of the algorithm, exactly as written, with its own conflict
resolution, all running entirely the same way as it does with non-merge
commits. I'm used to it and don't want to learn something new without
necessity. I.e., I'd prefer to actually see it in two separate stages,
like this:

Rebasing mainline of the merge...
[.. possible conflicts resolution ..]
Merging in changes to side branch(es)...
[.. possible conflicts resolution ..]

And if the second stage gives non-trivial conflicts, I'd like to have a
simple way to just do "merge -s ours <heads>" on top of already rebased
mainline of the merge and go with it. Note that the latter is
significantly different than re-merging everything from scratch, that
would be the only choice with "all-in-one" approach, and it essentially
gives me back those simple "rebase first parent and just record other
parents" semantics when needed.

-- Sergey
