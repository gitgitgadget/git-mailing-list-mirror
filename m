Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D8401F453
	for <e@80x24.org>; Tue,  2 Oct 2018 09:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbeJBPxa (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 11:53:30 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:50413 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeJBPxa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 11:53:30 -0400
Received: by mail-wm1-f44.google.com with SMTP id s12-v6so1448872wmc.0
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 02:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=tb+rmRJGkX2slfeKTV/h4i/wbkE9NO2xZWAcJRGT4ew=;
        b=bKsm/KNSDpR5ARyKaDKZuSEuQY7ABgl7yXH47Nw5k2nuVfnRhJqh3aN399M6vMDMCq
         TKckM5uV7IFFkoS3JG3KO0kv7oIYaJkloSo33j6kzHKPIg6XUFkZr4fcIwAnnSvP55aJ
         k09LaKXapAk0yuN8qXFSeoE3VQZ0M8AxhgFfuW4ZMnWrs4VK16lFIo9Qp7/i6UDLAk5g
         iW5E0jhZlYgHk/cPNMxTidpMfAIhG+fVvpnMDrfvH0GvvesUA0/YWRncBHSnZi66J2y3
         hOgCCN0raJzOuqno6SKKNMDcnZwUB2kxB443Vy8UKIxlR9dlyGZ0oHWq8lGl6cwunUAT
         n41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=tb+rmRJGkX2slfeKTV/h4i/wbkE9NO2xZWAcJRGT4ew=;
        b=g8Gg/di2EB6qnzYQsFy7B/5QnkweMHNmOUiE/z5paLWirLzbs1fwlnuv6dsnX1Rcp8
         1lpiRLjN+rsjmFnWrP1M0lJ5dMRz2F55c1HrNibDI6aH4SsqdaYR5YqdPLlJ/6T2dOm9
         8uFJ6k/zo2cjuQ7KKLZmlLf/Q6op54dL1Vf/ACnkYYcgxikgRVmwXo+S70ZyyTrb85hI
         Qh59Xd0MG4WFX+HFIf/PCVkak1VjdhadsmcX/Il3uexM94Q+qz3JdVDun1t7ddDoY/8m
         EcuyBhy0VWhwgcMn1Gb0viWYQf+KUd7kspQ3aZhWyTF09JFI77chZnJI2m/JQu8a2GP3
         yHBA==
X-Gm-Message-State: ABuFfog5cGp6AC6FA6YOsp+7V3c7NS5PT04YyDkOiOfzzZHvy7osmPsQ
        +oPqEFjGPgpiRC/hiTsuJaKGh+Bj
X-Google-Smtp-Source: ACcGV63p/O/WlmbqTw0N+4rHlbGPUHv19SN7ykXzvuiWPUOjLH5XDW/H+9bcP77mhUGfGoeOy+AoRw==
X-Received: by 2002:a1c:c683:: with SMTP id w125-v6mr1175984wmf.117.1538471473146;
        Tue, 02 Oct 2018 02:11:13 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id 200-v6sm24335984wmv.6.2018.10.02.02.11.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 02:11:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Stefan Xenos <sxenos@google.com>, git@vger.kernel.org
Subject: Re: Git Evolve
References: <CAPL8ZivFmHqS2y+WmNR6faRMnuahiqwPVYsV99NiJ1QLHOs9fQ@mail.gmail.com> <20181002012326.GA96979@syl>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181002012326.GA96979@syl>
Date:   Tue, 02 Oct 2018 11:11:11 +0200
Message-ID: <877ej0iuhc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 02 2018, Taylor Blau wrote:

> Hi Stefan,
>
> On Sat, Sep 29, 2018 at 04:00:04PM -0700, Stefan Xenos wrote:
>> Hello, List!
>>
>> I'm interested in porting something like Mercurial's evolve command to
>> Git.
>
> Welcome to Git :-). I think that the discussion in this thread is good,
> but it's not why I'm replying. I have also wanted a Mercurial feature in
> Git, but a different one than yours.
>
> Specifically, I've wanted the 'hg absorb' command. My understanding of
> the commands functionality is that it builds a sort of flamegraph-esque
> view of the blame, and then cascades downwards parts of a change. I am
> sure that I'm not doing the command justice, so I'll defer to [1] where
> it is explained in more detail.
>
> The benefit of this command is that it gives you a way to--without
> ambiguity--absorb changes into earlier commits, and in fact, the
> earliest commit that they make sense to belong to.
>
> This would simplify my workflow greatly when re-rolling patches, as I
> often want to rewrite a part of an earlier commit. This is certainly
> possible by a number of different `git rebase` invocations (e.g., (1)
> create fixup commits, and then re-order them, or (2) mark points in your
> history as 'edit', and rewrite them in a detached state, and I'm sure
> many more).
>
> I'm curious if you or anyone else has thought about how this might work
> in Git.

I've wanted a "git absorb" for a while, but have done no actual work on
it, I just found out about it.

I think a combination of these two heuristics would probably do the
trick:

 1. If a change in your "git diff" output has a hunk whose lines overlap
    with an earlier commit in the @{u}.. range, we do the equivalent of
    "git add -p", select that hunk, and "git commit --fixup <that
    commit>". We fixup the most recent commit that matches (otherwise
    commit>we'd conflict).

 2. Have some mode where we fall back from #1 and consider changes to
    entire files, if that's unambiguous.

The neat thing about this would be that you could tweak how promiscuous
#1 would be via the -U option to git-diff, and #2 would just be a
special case of -U9999999999999 (we should really add a -Uinf...).

Then once you ran this you could run "git rebase -i --autosquash" to see
how the TODO list would look, and optionally have some "git absorb
--now" or whatever to do the "git add -p", "git commit --fixup" and "git
rebase --autosquash" all in one go.

> [1]: http://files.lihdd.net/hgabsorb-note.pdf
