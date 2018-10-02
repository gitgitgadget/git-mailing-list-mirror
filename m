Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 584C51F453
	for <e@80x24.org>; Tue,  2 Oct 2018 19:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeJCCUj (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 22:20:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36474 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeJCCUj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 22:20:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id d4-v6so2346090lfa.3
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 12:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tu3LYmxqn+O5CqbfSNq6dcmvDqQVUwObKvfKNv6x/uI=;
        b=r0dHnOmcePyq9Nt3M/WthU99nXm+Kk2p9wH3hRJstElibGSSbw3qvx6xuUyKOJUAPP
         nToD6DICqRFe81gY2m2TGY8skid9rxNNZU6IPQ45JNUrh1SiPI+jKy8gloGChXZrr+Hb
         3ZniKXNlcqhdflToZU/eB3VWLvGGrcOGw3HKD9BYAgpK0VKSVH6MwSOPFaQWhucRZtI1
         0Ai5LouS7XPcK7lGH1ME2IjsVFIptK6JgeHbkTpIy+2qy2UZ+2kX5F2LzfD6eNNn/Agy
         wHVBp8ALdyCQWAEZ9y2XwIxa8abHPaI+iumOcUHjOnRV3jwvBuy9ezvSOYWxvpZjUzix
         J2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tu3LYmxqn+O5CqbfSNq6dcmvDqQVUwObKvfKNv6x/uI=;
        b=D4r+R2lSIyoAbCo7hXpqDB06KPJs6E6muhKtVDL/RC0xwpCvwJ3Jtt4ANUGs/B/tTr
         NEtGiGtFacoVmg0ctrdhO8RFoUW9uvnTrGzM4brGkBy0jAxSoqp25Q1Vp7mWJh7bHknP
         Kgd4f2ZzHLwYAp3YOx3o/N51pqoy/oPbJtKBRey+MyFjOXZ6Pl9Yo5F97TF/VM9c3f2y
         5hqbJA9TXPLA8cdNeD4S0kboJCHHlbxk8wVgq0gP9lst+uP1dr+jm14hbMqp2g1Lkg72
         uyLKCoCRpo+ewE+2jaHSH2QS7pDMg/x3/8NQGGQw67heqWwt0DcycNcf/Viz1jvtSTRZ
         Wlzw==
X-Gm-Message-State: ABuFfoikCcWsLVoxM+QLX6D3CFMp9O023F8ZBfoknCeoD9crtLX4XD3m
        WE7lZhTxl6EurZO9rKbQCAwOHYkCJlFFAigrM4c4ZA==
X-Google-Smtp-Source: ACcGV62/z7r8+F//CSr/MPnGT/XfR4IDTej9Uds/zgY/A+M1qDpAC9hR2Qq390b8TFKfVC/pGbOta616fq9USNRswAE=
X-Received: by 2002:ac2:4257:: with SMTP id m23-v6mr3094023lfl.6.1538508940809;
 Tue, 02 Oct 2018 12:35:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:2e13:0:0:0:0:0 with HTTP; Tue, 2 Oct 2018 12:35:40 -0700 (PDT)
In-Reply-To: <877ej0iuhc.fsf@evledraar.gmail.com>
References: <CAPL8ZivFmHqS2y+WmNR6faRMnuahiqwPVYsV99NiJ1QLHOs9fQ@mail.gmail.com>
 <20181002012326.GA96979@syl> <877ej0iuhc.fsf@evledraar.gmail.com>
From:   Stefan Xenos <sxenos@google.com>
Date:   Tue, 2 Oct 2018 12:35:40 -0700
Message-ID: <CAPL8ZiupaJ0ZoyUzgFWm9cV5QypXXUi6wZkmbOf8OGXJa0ZJQA@mail.gmail.com>
Subject: Re: Git Evolve
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you're curious how the Mercurial absorb command works, here's the code:

https://www.mercurial-scm.org/repo/hg/file/tip/hgext/absorb.py

It's GPL 2:

https://www.mercurial-scm.org/repo/hg/file/tip/COPYING



On Tue, Oct 2, 2018 at 2:11 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, Oct 02 2018, Taylor Blau wrote:
>
>> Hi Stefan,
>>
>> On Sat, Sep 29, 2018 at 04:00:04PM -0700, Stefan Xenos wrote:
>>> Hello, List!
>>>
>>> I'm interested in porting something like Mercurial's evolve command to
>>> Git.
>>
>> Welcome to Git :-). I think that the discussion in this thread is good,
>> but it's not why I'm replying. I have also wanted a Mercurial feature in
>> Git, but a different one than yours.
>>
>> Specifically, I've wanted the 'hg absorb' command. My understanding of
>> the commands functionality is that it builds a sort of flamegraph-esque
>> view of the blame, and then cascades downwards parts of a change. I am
>> sure that I'm not doing the command justice, so I'll defer to [1] where
>> it is explained in more detail.
>>
>> The benefit of this command is that it gives you a way to--without
>> ambiguity--absorb changes into earlier commits, and in fact, the
>> earliest commit that they make sense to belong to.
>>
>> This would simplify my workflow greatly when re-rolling patches, as I
>> often want to rewrite a part of an earlier commit. This is certainly
>> possible by a number of different `git rebase` invocations (e.g., (1)
>> create fixup commits, and then re-order them, or (2) mark points in your
>> history as 'edit', and rewrite them in a detached state, and I'm sure
>> many more).
>>
>> I'm curious if you or anyone else has thought about how this might work
>> in Git.
>
> I've wanted a "git absorb" for a while, but have done no actual work on
> it, I just found out about it.
>
> I think a combination of these two heuristics would probably do the
> trick:
>
>  1. If a change in your "git diff" output has a hunk whose lines overlap
>     with an earlier commit in the @{u}.. range, we do the equivalent of
>     "git add -p", select that hunk, and "git commit --fixup <that
>     commit>". We fixup the most recent commit that matches (otherwise
>     commit>we'd conflict).
>
>  2. Have some mode where we fall back from #1 and consider changes to
>     entire files, if that's unambiguous.
>
> The neat thing about this would be that you could tweak how promiscuous
> #1 would be via the -U option to git-diff, and #2 would just be a
> special case of -U9999999999999 (we should really add a -Uinf...).
>
> Then once you ran this you could run "git rebase -i --autosquash" to see
> how the TODO list would look, and optionally have some "git absorb
> --now" or whatever to do the "git add -p", "git commit --fixup" and "git
> rebase --autosquash" all in one go.
>
>> [1]: http://files.lihdd.net/hgabsorb-note.pdf
