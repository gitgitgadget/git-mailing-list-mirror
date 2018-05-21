Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 196DD1F51C
	for <e@80x24.org>; Mon, 21 May 2018 17:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753545AbeEUR4y (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 13:56:54 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35477 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753476AbeEUR4u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 13:56:50 -0400
Received: by mail-yw0-f196.google.com with SMTP id m8-v6so4734921ywd.2
        for <git@vger.kernel.org>; Mon, 21 May 2018 10:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a054e/xBD4wYaAbULQlzwYBKDt1g5tAyMS+aVFtfWdk=;
        b=h6EmRepDWl7igy20NImcW+tpBQ6Iviw1GJMhLw8ivkmqRmqBCSiVvYR+esHVY8Eld0
         HG4GTd7U2bW7UqIV7dC7QDlgFzdxoOXSafRSBfDGMxNll3KGpPcC7Ft4bq/Bwfi8KwYV
         HQGodzO4c7sto77H5cImaa+jH8zFN4dn/kcipyunUjnhy/JC4HAi9chWyrCfZywWo3TI
         S/QD/JrHhUo3xg9z5aJgghZLz7nNAQQlsG67hYm4yVzhO7ccLTio+QU1x0nSdPu94Ni6
         Y/A9ItKLG28vO6DV1wOD6hH93K6J+Da8RJLLwldSDL4T2VwCCJzW5HGBmG+OgSEZOzR+
         YlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a054e/xBD4wYaAbULQlzwYBKDt1g5tAyMS+aVFtfWdk=;
        b=ffsSnX6YS2vg9PgGIDZf2u5+Lsxj7R/3jU2cZQMUf/deN5vLri8EwAiR6NcaVo96kn
         kULge2yJNt44U84gYWSmVX9mLIrIoLBczmpsbXMd4OWYvX6Jf/xOFuwmDZ0ZTWvF1c4M
         3fJR51eeE4qyLU0Tmllo5pWwenBcsgdYZ/NZSAiDu/yhl1SaN8V0y9FDJd7LUIkESZlU
         Yy2U+Pmo+JUi1x2PtZqqs5GKr/lEywxsFbhTOQll/BpfgTg+LQlzjK2RQGr+cU6Lnl+8
         LamDrHPgQqfyt5vichSycDNRHp9zdTu6bQ4ksysJwUmQCGj5HwyVH5Pd+1FYmBdY2ecm
         d2nw==
X-Gm-Message-State: ALKqPwfoh20feoc3a1PE6CdSju7A7FWFC9fKv1KSx7l8IlnX+I3fNkbW
        Hr0Nyas5lhr73oRycv1kEvpOEhD5NOlcJQAd35ARJA==
X-Google-Smtp-Source: AB8JxZrswJa2B9/S5hM4Iuem5toiM1Zd4zyAxoenMBU7LX8ksdxqOV8EGxEHvd41oECELAUTfORUPWfMQbddvIFMmOc=
X-Received: by 2002:a81:37ce:: with SMTP id e197-v6mr10791581ywa.340.1526925408506;
 Mon, 21 May 2018 10:56:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Mon, 21 May 2018 10:56:47 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1805211153370.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de> <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
 <20180505182631.GC17700@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
 <xmqqk1shsecd.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1805061419530.77@tvgsbejvaqbjf.bet>
 <CAPig+cS0pvdg78fGUu8m2xspDDMHxi=uAMCkbLuthy7R4p3fQw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1805062155120.77@tvgsbejvaqbjf.bet> <20180507074843.GC31170@sigill.intra.peff.net>
 <3cefc6b3-3dbd-9cb1-20d0-193116191726@gmail.com> <nycvar.QRO.7.76.6.1805211153370.77@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 May 2018 10:56:47 -0700
Message-ID: <CAGZ79kYcWuVorfk7eYjUuLi2XeMS8sPrJYE0OQmgiQi2NkuDZA@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

>> (2) git diff --branch topic-v1...topic-v2
>
> From my point of view, `git diff --branch` indicates that I diff
> *branches*. Which is not really something that makes sense, and definitely
> not what this command is about.
>
> We are not comparing branches.
>
> We are comparing versions of the same branch.

I happen to have a messier workflow than you have, as I
develop a "resend" of a topic in a new branch (or I have to
restore the old sent topic from the reflog).

Now that I have the tool I also compare two branches,
namely, the branch that Junio queued
(origin/base..origin/sb/intelligent-name) vs the resend
that I had locally (origin/base..foo).

Next time I might compare Junios queued topic to the
local format-patch'es that I already annotated.

So in a way this diffs different versions of a topic, "diff-topic-versions".

>> It`s all still a comparison between two revisions (pointed to by
>> "topic-v1" and "topic-v2" branch heads in this specific example), but
>> it differs in what we are comparing - (1) set of files contained in
>> endpoints, or (2) set of revisions contained in (or "leading to")
>> endpoints.
>
> It is very much not about comparing *two* revisions.

I wonder if we can make the tool more intelligent to take two revisions
and it figures out the range by finding the base branch itself.
Probably as a follow up.


> It is very much about
> comparing two *ranges of* revisions, and not just any ranges, no. Those
> ranges need to be so related as to contain mostly identical changes.

range-diff, eh?

> Most fellow German software engineers (who seem to have a knack for
> idiotically long variable/function names) would now probably suggest:
>
>         git compare-patch-series-with-revised-patch-series

or short:

  revision-compare
  compare-revs
  com-revs

  revised-diff
  revise-diff
  revised-compare

  diff-revise

> I hope you agree that that is better *and* worse than your suggestions,
> depending from what angle you look at it: it is better because it
> describes what the command is *actually* doing. But it is much worse at
> the same time because it is too long.

btw, you think very much in terms of *patch series*, but there are workflows
without patches (pull requests at Github et Al., changes in Gerrit),
and I would think the output of the tool under discussion would still be
useful.

In [1] Junio gives his use case, it is "before accepting them", which could
be comparing an mbox or patch files against a branch, or first building
up a local history on a detached head (and then wondering if to reset
the branch to the new history), which would be all in Git.

That use case still has 'patches' involved, but these are not the main
selling point for the tool, as you could turn patches into commits before
using this tool.

[1] https://public-inbox.org/git/xmqqvabh1ung.fsf@gitster-ct.c.googlers.com/

Thanks,
Stefan
