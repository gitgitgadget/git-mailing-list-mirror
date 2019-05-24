Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FAB61F462
	for <e@80x24.org>; Fri, 24 May 2019 14:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391605AbfEXOlY (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 10:41:24 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:56107 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390885AbfEXOlY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 10:41:24 -0400
Received: by mail-wm1-f45.google.com with SMTP id x64so9648684wmb.5
        for <git@vger.kernel.org>; Fri, 24 May 2019 07:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=nGGhu81yV/j2o9MGLG07oWe7S8UXml7lYBRA1q2Aidc=;
        b=cuh5Tz+dLpttTX1pRMMn59XSKRhubmq1WyfiOxItwnNZSdRBcOlUFzdK6uVBY/Go21
         xzeRNppSt/8lOUQH5z0iZSN0fPY4wU0TtwrHlOH3XlGwEyudKLyJOcD1LStlRTw7MCol
         O3dLak+CDrj+LHURR2303qAc9x46fFZ6vp8irGe4j8drtTNF9z2QllUhaNmbo5C42KEI
         Suq4RbIXO8lMvECgaSJejczeLMdJ4ozRZhoxKzUv35GkiR+By3emokiECJpi5Ap3U2gr
         U9Ptp41nMVY0zrEgwYKG4DYa/mdoHVKiDKNm/DF3cOjpUBJWedcgJAocG6A0BstXJEVc
         I99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=nGGhu81yV/j2o9MGLG07oWe7S8UXml7lYBRA1q2Aidc=;
        b=cJrcx7eF2qbFPoSCfinqnOgWWe8pPfm5lnOUJFpxAeBlkZgcnYYPQoJYgsoZlKuo8n
         X2l7C+eBHhIldgEpxwBt1MmrHsu9WrALb91EjeBj42jbnrC+gduxpPCbUE8Gl3C9yYoY
         TehlbfiAK3AR5QrR9lmRCAk0hwgbMsQgtWlZhYIxl348b8n33idKxWaWCgQhydQ5PH5B
         1dg/b0MXJyl/nPE5we6hJn21esGW41du0fHUTpTJjyYGHFteKm8w5AdI4Ex8+iu0tdt4
         4Oo+c7JlZ0lTRWoAMlptaLgPRGgJsatu30hVmtKENsHyivOd9ZZ+jo90Y8TOi0vgEYW4
         YDuQ==
X-Gm-Message-State: APjAAAXDu97qbPuGaTiseDP8bK56PRi9lr4udmzF+gYPyNeV8XFzVmDH
        4n/S5GTdZ294/L6UkL2ZB2n6DTAGk9g=
X-Google-Smtp-Source: APXvYqyP2QijNy27Cn+GO+qNqT/MuZ1SypoGVsnk5dzGhhsoIGFnglHDq7O0gtjy3XbUk+kLWuBIpQ==
X-Received: by 2002:a1c:cf4c:: with SMTP id f73mr127491wmg.118.1558708881770;
        Fri, 24 May 2019 07:41:21 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id e14sm3103211wma.41.2019.05.24.07.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 07:41:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Need help merging unrelated histories
References: <CAHd499AidrL4jCG_WytPJF9yHfJJJvWJ5fpjKN6sGBY5Weu8Hg@mail.gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAHd499AidrL4jCG_WytPJF9yHfJJJvWJ5fpjKN6sGBY5Weu8Hg@mail.gmail.com>
Date:   Fri, 24 May 2019 16:41:20 +0200
Message-ID: <87blzrgbjj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 24 2019, Robert Dailey wrote:

> Everything I'm going to describe is related to this repository:
>
> https://github.com/powervr-graphics/Native_SDK
>
> This repo has several distinct branches. None of them seem to be tied
> to each other. Instead of having a `master` where they branched off
> each of their releases (e.g. 3.1, 3.2, 4.0), it looks like they made a
> copy of previous branches with no ancestry and then continued coding
> on that.
>
> What I'm trying to do is go back and rebase all of the X.X branches
> onto a new `master` branch. I started off with this:
>
> $ git checkout --orphan master
>
> Then I committed a `.gitattributes`. Next, I rebased the first
> (oldest) release branch:
>
> $ git rebase -i --onto master origin/3.0 --root
>
> Then I merged:
>
> $ git checkout master && git merge --no-ff -
>
> Next, I did 3.1:
>
> $ git rebase -i --onto master origin/3.0 origin/3.1 -X theirs
>
> Using interactive mode, Git is smart enough to detect duplicate
> commits and eliminates those, even though the 2 branches do not share
> a merge base. I continued doing this all the way up to rebasing 4.3,
> but that's when things got tough. I see a lot of 'UD', 'UA', 'AU',
> 'AA' merge conflicts. These are obviously due to the fact that the
> branches aren't connected. But I expected was that `-X theirs` would
> always favor what's on the branch being rebased. However, it seems
> this only affects modified conflicts, not adds or deletes.
>
> I was trying to find a way to bulk-resolve these. I mean, if git sees
> a file added on the left AND the right, I want the right one (theirs;
> the one coming from the 4.3 branch). Even though the branches are
> unrelated in terms of their history, I want the net effect of the
> rebase to essentially reflect the files on 4.3 itself. If a file isn't
> present on HEAD, delete it. If a file exists on REBASE_HEAD but not on
> HEAD, then add it. If the same file exists on both, favor the one on
> REBASE_HEAD.
>
> But I don't see a way of doing that. I tried `git checkout --theirs .`
> and `git checkout REBASE_HEAD -- .` but this doesn't work with all
> conflict types.
>
> Can anyone provide some advice on how to properly restructure this
> repository to create some ancestry, as if all along a `master` existed
> and all release branches were based on this in a linear fashion?

We don't have a merge strategy to do this, but should. I had a WIP patch
for this here that I haven't picked up:
https://public-inbox.org/git/87sh7sdtc1.fsf@evledraar.gmail.com/

But you can emulate the same thing with "read-tree" and
"commit". I.e. manually craft a commit with plumbing that diverges from
the "master" branch, then instead of stock "rebase" write some loop
where you keep using "read-tree" to read what you want to stage into the
index from the existing branched commits, then the equivalent of "git
commit -c" etc. to commit it.
