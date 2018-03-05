Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A37CD1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 05:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751288AbeCEFAx (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 00:00:53 -0500
Received: from mail.javad.com ([54.86.164.124]:48972 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751144AbeCEFAw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 00:00:52 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 6AC87407D0;
        Mon,  5 Mar 2018 05:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520226051;
        bh=1qPnw7DyiJ2QbdjDte3LCAQSTGfnAs7rsxuQM6K2GnA=; l=2845;
        h=Received:From:To:Subject;
        b=s33vNotzQ8i4yQufK8zKN3mcAOLjPHzlCZ7MvsH8BXF/x93EemtPIPUhfhXBamD5B
         QTfg9q4UpXAdOT/4YqPWrG6KHn9zhJnTZdNjXKLgUQGsj1pH6BjBGzL8uZwab/05yc
         UhQ2AWgS5OrBwSMS4ml0N4j1bmRQuB45kNhORBSE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520226051;
        bh=1qPnw7DyiJ2QbdjDte3LCAQSTGfnAs7rsxuQM6K2GnA=; l=2845;
        h=Received:From:To:Subject;
        b=s33vNotzQ8i4yQufK8zKN3mcAOLjPHzlCZ7MvsH8BXF/x93EemtPIPUhfhXBamD5B
         QTfg9q4UpXAdOT/4YqPWrG6KHn9zhJnTZdNjXKLgUQGsj1pH6BjBGzL8uZwab/05yc
         UhQ2AWgS5OrBwSMS4ml0N4j1bmRQuB45kNhORBSE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520226051;
        bh=1qPnw7DyiJ2QbdjDte3LCAQSTGfnAs7rsxuQM6K2GnA=; l=2845;
        h=Received:From:To:Subject;
        b=s33vNotzQ8i4yQufK8zKN3mcAOLjPHzlCZ7MvsH8BXF/x93EemtPIPUhfhXBamD5B
         QTfg9q4UpXAdOT/4YqPWrG6KHn9zhJnTZdNjXKLgUQGsj1pH6BjBGzL8uZwab/05yc
         UhQ2AWgS5OrBwSMS4ml0N4j1bmRQuB45kNhORBSE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520226051;
        bh=1qPnw7DyiJ2QbdjDte3LCAQSTGfnAs7rsxuQM6K2GnA=; l=2845;
        h=Received:From:To:Subject;
        b=s33vNotzQ8i4yQufK8zKN3mcAOLjPHzlCZ7MvsH8BXF/x93EemtPIPUhfhXBamD5B
         QTfg9q4UpXAdOT/4YqPWrG6KHn9zhJnTZdNjXKLgUQGsj1pH6BjBGzL8uZwab/05yc
         UhQ2AWgS5OrBwSMS4ml0N4j1bmRQuB45kNhORBSE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520226050;
        bh=1qPnw7DyiJ2QbdjDte3LCAQSTGfnAs7rsxuQM6K2GnA=; l=2845;
        h=Received:From:To:Subject;
        b=HFN+n8qRqiN8aKq31Nbktn/E559fTvqDctcIO2GMJ4eNIaXk3O5kbEq+1yOWy+9WO
         iqCheTCBh0qYJKCh2sDnHz6DbhQu7/BdyA601jRgVTgCedRuoirdxsFEPJWGjziUzp
         H2rG3Z6SQarcwC4N22/hFCuPfBpfQams0/HuYPKY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520226050;
        bh=1qPnw7DyiJ2QbdjDte3LCAQSTGfnAs7rsxuQM6K2GnA=; l=2845;
        h=Received:From:To:Subject;
        b=HFN+n8qRqiN8aKq31Nbktn/E559fTvqDctcIO2GMJ4eNIaXk3O5kbEq+1yOWy+9WO
         iqCheTCBh0qYJKCh2sDnHz6DbhQu7/BdyA601jRgVTgCedRuoirdxsFEPJWGjziUzp
         H2rG3Z6SQarcwC4N22/hFCuPfBpfQams0/HuYPKY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520226050;
        bh=1qPnw7DyiJ2QbdjDte3LCAQSTGfnAs7rsxuQM6K2GnA=; l=2845;
        h=Received:From:To:Subject;
        b=HFN+n8qRqiN8aKq31Nbktn/E559fTvqDctcIO2GMJ4eNIaXk3O5kbEq+1yOWy+9WO
         iqCheTCBh0qYJKCh2sDnHz6DbhQu7/BdyA601jRgVTgCedRuoirdxsFEPJWGjziUzp
         H2rG3Z6SQarcwC4N22/hFCuPfBpfQams0/HuYPKY=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1esiEy-0005HL-5F; Mon, 05 Mar 2018 08:00:48 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, Git mailing list <git@vger.kernel.org>,
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
        <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com>
Date:   Mon, 05 Mar 2018 08:00:48 +0300
In-Reply-To: <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com> (Igor
        Djordjevic's message of "Sat, 3 Mar 2018 01:29:43 +0100")
Message-ID: <87h8pvm7zz.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Plillip and Igor,

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:
> Hi Phillip,
>
> On 02/03/2018 12:31, Phillip Wood wrote:
>> 
>> > Thinking about it overnight, I now suspect that original proposal had a
>> > mistake in the final merge step. I think that what you did is a way to
>> > fix it, and I want to try to figure what exactly was wrong in the
>> > original proposal and to find simpler way of doing it right.
>> >
>> > The likely solution is to use original UM as a merge-base for final
>> > 3-way merge of U1' and U2', but I'm not sure yet. Sounds pretty natural
>> > though, as that's exactly UM from which both U1' and U2' have diverged
>> > due to rebasing and other history editing.
>> 
>> Hi Sergey, I've been following this discussion from the sidelines,
>> though I haven't had time to study all the posts in this thread in
>> detail. I wonder if it would be helpful to think of rebasing a merge as
>> merging the changes in the parents due to the rebase back into the
>> original merge. So for a merge M with parents A B C that are rebased to
>> A' B' C' the rebased merge M' would be constructed by (ignoring shell
>> quoting issues)
>> 
>> git checkout --detach M
>> git merge-recursive A -- M A'
>> tree=$(git write-tree)
>> git merge-recursive B -- $tree B'
>> tree=$(git write-tree)
>> git merge-recursive C -- $tree C'
>> tree=$(git write-tree)
>> M'=$(git log --pretty=%B -1 M | git commit-tree -pA' -pB' -pC')
>> 
>> This should pull in all the changes from the parents while preserving
>> any evil conflict resolution in the original merge. It superficially
>> reminds me of incremental merging [1] but it's so long since I looked at
>> that I'm not sure if there are any significant similarities.
>> 
>> [1] https://github.com/mhagger/git-imerge
>
> Interesting, from quick test[3], this seems to produce the same 
> result as that other test I previously provided[2], where temporary 
> commits U1' and U2' are finally merged with original M as a base :)

Looks like sound approach and it's interesting if these 2 methods do in
fact always bring the same result. Because if we look at the (now fixed)
original approach closely, it also just gathers the changes in merge
parents into U1' and U2', then merges the changes back into the original
M (=U1=U2=UM).

Overall, this one looks like another implementation of essentially the
same method and confirms that we all have the right thought direction
here.

>
> Just that this looks like even more straight-forward approach...?
>
> The only thing I wonder of here is how would we check if the 
> "rebased" merge M' was "clean", or should we stop for user amendment? 
> With that other approach Sergey described, we have U1'==U2' to test
> with.

That's an advantage of the original, yes.

-- Sergey
