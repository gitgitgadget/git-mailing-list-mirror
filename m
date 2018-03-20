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
	by dcvr.yhbt.net (Postfix) with ESMTP id 549E21F404
	for <e@80x24.org>; Tue, 20 Mar 2018 14:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeCTOnJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 10:43:09 -0400
Received: from mail.javad.com ([54.86.164.124]:34659 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751105AbeCTOnH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 10:43:07 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 8D0D03E966;
        Tue, 20 Mar 2018 14:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521556986;
        bh=iTnu/cHlNCN0U+0h4sAqOtNzipg8sQY7ypb7eEDYHO8=; l=5645;
        h=Received:From:To:Subject;
        b=PGqX0D8+ayZH1fah8auwMakf8jhBgiX/RVdAFuacZnATwfuqeNkdFrwT8BF6001Yv
         YHt4KK/vhrmXq3EdaNqsU4sUWMdbVXtVQP6YOvoTOa8M/Pfu3dvkocOk50Q06NRujo
         79PiDw+bfQQmPuA5BV0qvzgL79bSMeaJnntqdHsQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521556986;
        bh=iTnu/cHlNCN0U+0h4sAqOtNzipg8sQY7ypb7eEDYHO8=; l=5645;
        h=Received:From:To:Subject;
        b=PGqX0D8+ayZH1fah8auwMakf8jhBgiX/RVdAFuacZnATwfuqeNkdFrwT8BF6001Yv
         YHt4KK/vhrmXq3EdaNqsU4sUWMdbVXtVQP6YOvoTOa8M/Pfu3dvkocOk50Q06NRujo
         79PiDw+bfQQmPuA5BV0qvzgL79bSMeaJnntqdHsQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521556986;
        bh=iTnu/cHlNCN0U+0h4sAqOtNzipg8sQY7ypb7eEDYHO8=; l=5645;
        h=Received:From:To:Subject;
        b=PGqX0D8+ayZH1fah8auwMakf8jhBgiX/RVdAFuacZnATwfuqeNkdFrwT8BF6001Yv
         YHt4KK/vhrmXq3EdaNqsU4sUWMdbVXtVQP6YOvoTOa8M/Pfu3dvkocOk50Q06NRujo
         79PiDw+bfQQmPuA5BV0qvzgL79bSMeaJnntqdHsQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521556986;
        bh=iTnu/cHlNCN0U+0h4sAqOtNzipg8sQY7ypb7eEDYHO8=; l=5645;
        h=Received:From:To:Subject;
        b=PGqX0D8+ayZH1fah8auwMakf8jhBgiX/RVdAFuacZnATwfuqeNkdFrwT8BF6001Yv
         YHt4KK/vhrmXq3EdaNqsU4sUWMdbVXtVQP6YOvoTOa8M/Pfu3dvkocOk50Q06NRujo
         79PiDw+bfQQmPuA5BV0qvzgL79bSMeaJnntqdHsQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521556986;
        bh=iTnu/cHlNCN0U+0h4sAqOtNzipg8sQY7ypb7eEDYHO8=; l=5645;
        h=Received:From:To:Subject;
        b=PGqX0D8+ayZH1fah8auwMakf8jhBgiX/RVdAFuacZnATwfuqeNkdFrwT8BF6001Yv
         YHt4KK/vhrmXq3EdaNqsU4sUWMdbVXtVQP6YOvoTOa8M/Pfu3dvkocOk50Q06NRujo
         79PiDw+bfQQmPuA5BV0qvzgL79bSMeaJnntqdHsQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521556986;
        bh=iTnu/cHlNCN0U+0h4sAqOtNzipg8sQY7ypb7eEDYHO8=; l=5645;
        h=Received:From:To:Subject;
        b=PGqX0D8+ayZH1fah8auwMakf8jhBgiX/RVdAFuacZnATwfuqeNkdFrwT8BF6001Yv
         YHt4KK/vhrmXq3EdaNqsU4sUWMdbVXtVQP6YOvoTOa8M/Pfu3dvkocOk50Q06NRujo
         79PiDw+bfQQmPuA5BV0qvzgL79bSMeaJnntqdHsQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521556986;
        bh=iTnu/cHlNCN0U+0h4sAqOtNzipg8sQY7ypb7eEDYHO8=; l=5645;
        h=Received:From:To:Subject;
        b=PGqX0D8+ayZH1fah8auwMakf8jhBgiX/RVdAFuacZnATwfuqeNkdFrwT8BF6001Yv
         YHt4KK/vhrmXq3EdaNqsU4sUWMdbVXtVQP6YOvoTOa8M/Pfu3dvkocOk50Q06NRujo
         79PiDw+bfQQmPuA5BV0qvzgL79bSMeaJnntqdHsQ=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1eyITg-0005KG-DP; Tue, 20 Mar 2018 17:43:04 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution(RoadClear)
References: <87y3jtqdyg.fsf@javad.com>
        <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
        <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
        <87606hoflx.fsf@javad.com>
        <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
        <87a7vss6ax.fsf@javad.com>
        <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
        <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
        <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
        <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
        <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
        <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
        <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
        <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <2749ce78-8917-c821-6116-0c8d67b5e16e@gmail.com>
        <87vadyd9az.fsf@javad.com>
        <d5e68db4-8006-2c0e-bc21-0b136503edd9@gmail.com>
        <d50a4099-9b3a-5aa9-c304-160c62330056@gmail.com>
        <87h8pc1uxr.fsf@javad.com>
        <34e8d563-a035-b09e-e959-748f2b4f4b99@gmail.com>
Date:   Tue, 20 Mar 2018 17:43:04 +0300
In-Reply-To: <34e8d563-a035-b09e-e959-748f2b4f4b99@gmail.com> (Igor
        Djordjevic's message of "Mon, 19 Mar 2018 22:35:09 +0100")
Message-ID: <87r2oevmdj.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

> Hi Sergey,
>
> On 19/03/2018 06:44, Sergey Organov wrote:
>> 
>> > > > > > Second side note: if we can fast-forward, currently we prefer
>> > > > > > that, and I think we should keep that behavior with -R, too.
>> > > > >
>> > > > > I agree.
>> > > >
>> > > > I'm admittedly somewhat lost in the discussion, but are you
>> > > > talking fast-forward on _rebasing_ existing merge? Where would it
>> > > > go in any of the suggested algorithms of rebasing and why?
>> > > >
>> > > > I readily see how it can break merges. E.g., any "git merge
>> > > > --ff-only --no-ff" merge will magically disappear. So, even if
>> > > > somehow supported, fast-forward should not be performed by default
>> > > > during _rebasing_ of a merge.
>> > >
>> > > Hmm, now that you brought this up, I can only agree, of course.
>> > >
>> > > What I had in my mind was more similar to "no-rebase-cousins", like 
>> > > if we can get away without actually rebasing the merge but still 
>> > > using the original one, do it. But I guess that`s not what Johannes 
>> > > originally asked about.
>> > >
>> > > This is another definitive difference between rebasing (`pick`?) and 
>> > > recreating (`merge`) a merge commit - in the case where we`re rebasing, 
>> > > of course it doesn`t make sense to drop commit this time (due to 
>> > > fast-forward). This does make sense in recreating the merge (only).
>> >
>> > Eh, I might take this back. I think my original interpretation (and 
>> > agreement) to fast-forwarding is correct.
>> >
>> > But the confusion here comes from `--no-ff` as used for merging, as 
>> > opposed to `--no-ff` as used for rebasing. I _think_ Johannes meant 
>> > the latter one.
>> >
>> > In rebasing, `--no-ff` means that even if a commit inside todo list 
>> > isn`t to be changed, do not reuse it but create a new one. Here`s 
>> > excerpt from the docs[1]:
>> >
>> >   --no-ff
>> >     With --interactive, cherry-pick all rebased commits instead of 
>> >     fast-forwarding over the unchanged ones. This ensures that the 
>> >     entire history of the rebased branch is composed of new commits.
>> >
>> >     Without --interactive, this is a synonym for --force-rebase.
>> >
>> >
>> > So fast-forwarding in case of rebasing (merge commits as well) is 
>> > something you would want by default, as it wouldn`t drop/lose 
>> > anything, but merely reuse existing commit (if unchanged), instead of 
>> > cherry-picking (rebasing) it into a new (merge) commit anyway.
>> 
>> This sounds like breakage. E.g., it seems to be breaking every "-x ours"
>> merge out there.
>
> Either you are not understanding how rebase fast-forward works, or 
> I`m missing what you are pointing to... Mind explaining how can 
> something that`s left unchanged suddenly become a breakage?

It was misunderstanding on my side indeed, sorry.

>
>> Fast-forwarding existing merge, one way or another, still seems to be
>> wrong idea to me, as merge commit is not only about content change, but
>> also about joint point at particular place in the DAG.
>
> Not sure what this has to do with rebase fast-forwarding, either - 
> nothing changes for fast-forwarded (merge or non-merge) commit in 
> question, both content, joint point and everything else stays exactly 
> the same. If anything changed, then it can`t/won`t be fast-forwarded, 
> being unchanged is a prerequisite.
>
> Let me elaborate a bit. Here`s a starting diagram:

[... detailed explanation skipped for brevity ...]

> Does this settle your concerns, or I`m missing something?

Yes, it does, thank you! Leaving as many leading commits as possible
unchanged during rebase is what fast-forward mean in this case then, and
it's pretty OK with me.

>> As for fast-forwarding re-merge, explicitly requested, I'm not sure. On
>> one hand, it's inline with the default "git merge" behavior, on the
>> other hand, it still feels wrong, somehow.
>
> Regarding fast-forwarding in context of merging, in case where we are 
> recreating merges (not rebasing them), following existing `git merge` 
> logic might make sense, where I would expect rebasing todo list `merge` 
> command to pick-up tricks from `git merge` as needed, like learning 
> to accept `--no-ff` option, for example, thus not fast-forwarding 
> merges (on request) even when possible.
>
> Though, I do agree that in case you want to recreate an existing merge 
> (instead of just rebasing it), `merge` command fast-forwarding might 
> probably not be what you want for the most of the time, but I`m afraid 
> having rebase todo list `merge` command default behavior different than 
> `git merge` default one (in regards to fast-forwarding) would be 
> confusing... or not?
>
> From what I could grasp so far, usually Git commands` default 
> behavior is (explained to be) chosen per "most common use case", so 
> might be non fast-forwarding would be fine as default for rebase todo 
> list `merge` command, even though different than `git merge`
> itself...?

As far as I can tell, fast-forward as default for "git merge" has been
chosen to avoid excessive unintended merges in typical workflows, and
therefore this decision is not actually applicable to rebasing, I think.
I'm inclined to disable merges to fast-forward during history rebasing,
at least by default.

As far as I can tell, current "--preserve-merges" does fast-forward and
breaks "git merge --ff-only --no-ff" merges, among other things it
breaks, and that was my primary concern here. Didn't check
what "--recreate-merges" does though.

-- Sergey
