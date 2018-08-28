Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2A431F404
	for <e@80x24.org>; Tue, 28 Aug 2018 20:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbeH2Abd (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 20:31:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40837 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeH2Abd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 20:31:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id e19-v6so2333733edq.7
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 13:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pSf3w2a3TPGq1+AFMNrKGXf9vYmx09r0//IIMMHhgE=;
        b=TfbRc/7d8vuJfebVfQsnHSnYHGG4MgijrGfBO36wohpcUu/7Ku24oM61ilZmv6NUVU
         +iKxwfLrEY1QcoZLLtm/KCKbjmbWTd9gOP/Splp3W6Vp2Pl01bk/7VWo+ThKZU51Bk9I
         PHMEqd7t/h9efldqLWOjfyc42/jngncDle93Cma1CFxXQpaq33YZ9fYIbQAHewa3zFFB
         B8zBqVzkwDj4HeQM8fOq6yoZSlVh6wLm+x8GPzxs9X4v96l4YwoVZGPnk8pFVICfoBR7
         PmixDSLll6mShaPi75IXlUXpFZet1p1bO521G0Al3pdMNa/SmOHQAPXrGlmHpt4AL5Td
         uf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pSf3w2a3TPGq1+AFMNrKGXf9vYmx09r0//IIMMHhgE=;
        b=LjKhcTegls4pIoeelyIlqMQ1l8jwYfOmgjqpjq08zciZFpexmsyQ8RD4FtbSf3P5Se
         G4av9RTGl/DhfzACIv2LgckMcv4/dS9H1QQ1ii+ehn6j5Zr+GrKPkro2YjN32MtQ5laL
         rCjk1SMRQaIZZ/XjoMwp9ee5nZisBzObThGl6ZohYAqBU+UqzGlHeC6clsSBaQrI7NHJ
         TxORe7mu733ob8ZT4QmpeioCvce19wPFKJgP0adEmOmz6g/jw4OHg0pH0S/uWnmbFLb1
         A9B62hCxr0s1sISYmlJxTtUgbxK2PhCSvk3Z2VjV9VhOwgCCVauy6DujxaZDBUXNDYaR
         Khdg==
X-Gm-Message-State: APzg51DspNn/RDb+8ndrCJOWj9kffI0gtXSPJqfxwJCu4Bimw7PPa0ak
        o9Onb4nFdt1z+IufmCReyFkc1lfYqMhEbFvDdqhg4w==
X-Google-Smtp-Source: ANB0VdZJ6Lgav39DFtE8lJFaCq6svWSFtghZsJhTQ7QIX4t5SAEY1Ra3l0ZmV5hcovlUKrzkO6w+ga+PEfZixmot1J0=
X-Received: by 2002:a50:d083:: with SMTP id v3-v6mr4169727edd.243.1535488691448;
 Tue, 28 Aug 2018 13:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.26.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.26.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 28 Aug 2018 13:37:59 -0700
Message-ID: <CAGZ79kZ=jsCmxKdcPB+Q1__uO8Z2tXx6OkdyTSM8P3QdNGpKQA@mail.gmail.com>
Subject: Re: [PATCH 0/1] Define GIT_TEST_COMMIT_GRAPH for commit-graph test coverage
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 28, 2018 at 1:33 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> The commit-graph (and multi-pack-index) features are optional data
> structures that can make Git operations faster. Since they are optional, we
> do not enable them in most Git tests. The commit-graph is tested in
> t5318-commit-graph.sh (and t6600-test-reach.sh in ds/reachable), but that
> one script cannot cover the data shapes present in the rest of the test
> suite.
>
> This patch introduces a new test environment variable, GIT_TEST_COMMIT_GRAPH
> . Similar to GIT_TEST_SPLIT_INDEX, it enables the commit-graph and writes it
> with every git commit command.

> Thanks, Duy, for pointing out this direction

Did you mean to cc Duy (instead of me)?
(I'll happily review the patch, too... just asking)

>
> A few tests needed to be modified. These are the same tests that were
> mentioned in my previous example patch [2].
>
> When this merges down, I'll create a CI build in VSTS that runs the test
> suite with this option enabled.
>
> Thanks, -Stolee
>
> [1]
> https://public-inbox.org/git/CACsJy8CKnXVJYkKM_W=N=Vq-TVXf+YCqZP_uP7B-dN_6xddB=g@mail.gmail.com/
> Re: [PATCH 0/9] multi-pack-index cleanups (Discussing test environment
> variables)
>
> [2]
> https://public-inbox.org/git/20180718152244.45513-1-dstolee@microsoft.com/
> [PATCH] DO-NOT-MERGE: write and read commit-graph always
>
> Based-On: ds/commit-graph-with-grafts Cc: jnareb@gmail.com
>
> Derrick Stolee (1):
>   commit-graph: define GIT_TEST_COMMIT_GRAPH
>
>  builtin/commit.c                    |  4 ++++
>  commit-graph.c                      |  5 +++--
>  commit-graph.h                      |  2 ++
>  t/README                            |  4 ++++
>  t/t0410-partial-clone.sh            |  2 +-
>  t/t5307-pack-missing-commit.sh      | 10 ++++++++--
>  t/t6011-rev-list-with-bad-commit.sh | 10 ++++++----
>  t/t6024-recursive-merge.sh          |  9 ++++++---
>  8 files changed, 34 insertions(+), 12 deletions(-)
>
>
> base-commit: 829a321569d8e8f2c582aef9f0c990df976ab842
> Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-26%2Fderrickstolee%2Fshallow%2Ftest-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-26/derrickstolee/shallow/test-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/26
> --
> gitgitgadget
