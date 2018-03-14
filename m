Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07B991F404
	for <e@80x24.org>; Wed, 14 Mar 2018 23:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeCNXLb (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 19:11:31 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38844 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbeCNXL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 19:11:29 -0400
Received: by mail-wr0-f193.google.com with SMTP id l8so6416867wrg.5
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 16:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hk6hq9TfRGE+mt4r8k2+DOGZt68F9mX4KqQy+LL1ZAY=;
        b=WN0PypVk3TDn5iKrwO4MVP3BnSJbUI417jEJ0RSE13riT+VDrY9xvy9Gv6Ao0Dnh6G
         kzchDd6GD2We642fot6+QhGi3qgf+y3+dOPxA2fqxE2FcA/+DZpbWGwe98jPyyH29Mlr
         3SxcTFZqd8u94wnD6FyfDHMLR3fbC6/fV3EEZCw0ZTcaHiNJ2goNwkZhkzbJYbw6QuOC
         291w64j6UlB2FB0OrOuwczBKRM1XdIPjrdSfqbCEuSy10kJKsyMpOq1Y5UjfmLBhK+d7
         TjfOkeGu9VJw1+URVyTX+R2fQ1apTi8IDuBdGFPYNQDjG9R7h/6vYwrrFKudrLoXAoCi
         YWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hk6hq9TfRGE+mt4r8k2+DOGZt68F9mX4KqQy+LL1ZAY=;
        b=sCcQOKvSG61vk3cqO5t7AMqP5mS9ynmbNAcDU+7//yZyAkoUIlMiqjbsDaCY1K+Ddk
         q1tY8tRQT4IQRPN2dT33ZDUbY5SIhJI2p2B5O1lzyfpe2KZIz4a6gdToC3qg9AgX9k7/
         kzRe97cugjD9YO/CCvVHBn75t0LZ7MIRunbr5zjLOuXzMbJlfiZnV4n+9Bjy9VtaTye3
         oNFjLkGd/PSqXA+ls5gNU2Zu/X+SpHDyBGf9Rex5QDhb4xz5Z/ScPe+s6d1hPWN0B9nW
         oHgBHcqwuvWnQ2pESaNrb7yJDGjmz4usmmjaWMe7fNGgs0wRw/UnCmDQD6E46pPjMrNH
         3Low==
X-Gm-Message-State: AElRT7GGiDCLgR3KGSdKwYDqudDW8dvMy3HQ0jVujhEF1Vwdr3G/Or6J
        3/3k2/3/MuFZk05R6/figTE=
X-Google-Smtp-Source: AG47ELsHa2GL5+PRLnA3kWD5Ic0o88y48VgXk9LPMv6n48L5YocL01v3ClM/2kDP0qG/0f8cIV8vmw==
X-Received: by 10.223.187.199 with SMTP id z7mr5516484wrg.58.1521069088552;
        Wed, 14 Mar 2018 16:11:28 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id j6sm3601936wmg.14.2018.03.14.16.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Mar 2018 16:11:27 -0700 (PDT)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
To:     Sergey Organov <sorganov@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
 <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
 <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
 <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
 <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
 <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
 <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
 <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <2749ce78-8917-c821-6116-0c8d67b5e16e@gmail.com> <87vadyd9az.fsf@javad.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <d5e68db4-8006-2c0e-bc21-0b136503edd9@gmail.com>
Date:   Thu, 15 Mar 2018 00:11:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87vadyd9az.fsf@javad.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/03/2018 15:24, Sergey Organov wrote:
> 
> > > Second side note: if we can fast-forward, currently we prefer that, and I
> > > think we should keep that behavior with -R, too.
> >
> > I agree.
> 
> I'm admittedly somewhat lost in the discussion, but are you talking
> fast-forward on _rebasing_ existing merge? Where would it go in any of
> the suggested algorithms of rebasing and why?
> 
> I readily see how it can break merges. E.g., any "git merge --ff-only
> --no-ff" merge will magically disappear. So, even if somehow supported,
> fast-forward should not be performed by default during _rebasing_ of a
> merge.

Hmm, now that you brought this up, I can only agree, of course.

What I had in my mind was more similar to "no-rebase-cousins", like 
if we can get away without actually rebasing the merge but still 
using the original one, do it. But I guess that`s not what Johannes 
originally asked about.

This is another definitive difference between rebasing (`pick`?) and 
recreating (`merge`) a merge commit - in the case where we`re rebasing, 
of course it doesn`t make sense to drop commit this time (due to 
fast-forward). This does make sense in recreating the merge (only).

> > > If the user wants to force a new merge, they simply remove that -R
> > > flag.

And this sounds wrong now, too, because we actually have _three_
possible behaviors here - (1) rebase merge commit, which should 
always do what its told (so no fast-forwarding, otherwise the whole 
concept of rebasing a merge commit doesn`t make sense), and recreate 
merge commit, which should (2) by default use fast-forward where 
possible (or whatever the settings say), but (3) also be possible to 
force a new merge as well (through standard `--no-ff`, I guess, or 
something).

> Alternatively, they'd replace 'pick' with 'merge', as they already do
> for other actions. "A plurality is not to be posited without necessity".
> 
> Please, _please_, don't use 'merge' command to 'pick' merge commits!
> It's utterly confusing!

I agree here, as previously discussed[1], but let`s hear Johannes.

> Thinking about it I've got an idea that what we actually need is
> --no-flatten flag that, when used alone, will just tell "git rebase" to
> stop flattening history, and which will be implicitly imposed by
> --recreate-merges (and --preserve-merges).
> 
> Then the only thing the --recreate-merges will tune is to put 'merge'
> directives into the todo list for merge commits, exactly according to
> what its name suggests, while the default behavior will be to put 'pick'
> with suitable syntax into the todo. And arguments to the
> --recreate-merge will specify additional options for the 'merge'
> directive, obviously.

This seem to basically boil down to what I mentioned previously[2] 
through use of new `--rebase-merges` alongside `--recreate-merges`, just 
that you named it `--no-flatten` here, but the point is the same - and 
not something Johannes liked, "polluting" rebase option space further.

I would agree with him, and settling onto `--rebase-merges` _instead_ of 
`--recreate-merges` seems as a more appropriate name, indeed, now that 
default behavior is actually merge commit rebasing and not recreating 
(recreating still being possible through user editing the todo list).

Now, the only thing left seems to be agreeing on actual command to 
use to rebase the merge commit, to `pick` it, so to say... ;)

Regards, Buga

[1] https://public-inbox.org/git/77b695d0-7564-80d7-d9e6-70a531e66eda@gmail.com/
[2] https://public-inbox.org/git/b329bb98-f9d6-3d51-2513-465aad2fa37a@gmail.com/
