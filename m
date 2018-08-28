Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86F871F404
	for <e@80x24.org>; Tue, 28 Aug 2018 20:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeH2AfY (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 20:35:24 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:42019 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH2AfY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 20:35:24 -0400
Received: by mail-ed1-f46.google.com with SMTP id r10-v6so2331788edp.9
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 13:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iv3DQVl/XiGfSftYylvkknBkGdVhm6+xVBYEedXKD6Y=;
        b=vE02Jwsq2Pp3F8DgfqghGVEgqVzXbvOmpke3b5LcC7D1oOtheFHks9pkUP3PFaN+ky
         xj2YIDq9Smqtxh+/pv2MIOeqxuEidrmFhVjGafI0Fk4TeJ9t0+MWEMCRzXfeEAfvMD/3
         gMQ1Z7Rt67GoFL2teAeWohgXVY8yg8vPEAd5bf0qdgozzOU37n6Hg10Ygtbgsl5egRhg
         h7lJRjf0RVdYi/mYHdBLE/1ieC7ghaGD+a9N6PuNcDxfcn5JQKIFeSKCSl2d9tPUn7qf
         xn7FUOg7IGrkJ4lwa2ScVa3C1eC7vcWyPVxNMsejkJAkyaCYoZNQLSl8kMcCz8e9JVfc
         /Fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iv3DQVl/XiGfSftYylvkknBkGdVhm6+xVBYEedXKD6Y=;
        b=XZKpyq8a7LtAFApHJ62HqZrRjqlvjNWXI6aVO0+pRtiRnxgQgdGScOVoGMEYnk5yRF
         MaYN3SGLy1IZas1CUT8GEDTMFb8TTwIh4SmQahp96aMWNeDjeABWLG0q30l+i4y94hvp
         owaY8kmicS8KGv1CDXjqKmpcbMc0yDAIAIj0boVQ1p5NXq48V7EZ831TcpvvwE5D1DNv
         inepRoYWHmoKbCprM67dXVgo6/Wr6UEi+HTObXYKHaRctH+T0NdhfFMdoSTDMT+6BOm2
         noRmLDlXzLqcdDzGTSUvGYWCV7Nk2LIQTIoDNdhNcT897ylcbis75WXbnTr934fgXcc7
         l+fg==
X-Gm-Message-State: APzg51AuImdwyqI8RnSx3d7R5MgLcHbj5rEIyeCcC0awJadOoksA6T1H
        uKBLdjI5VtfKBfXL/Rotvy73S3HRCbZgmkV4lOJTnw==
X-Google-Smtp-Source: ANB0VdbzDmCkuShVr5SyQVddaACk9Z7SAIifNq29VsmjfvXJtnfocZIip20nERPAYoeXvpwC36wwx34ISbitJ3rJIqE=
X-Received: by 2002:a50:ad0f:: with SMTP id y15-v6mr4311091edc.78.1535488922030;
 Tue, 28 Aug 2018 13:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.26.git.gitgitgadget@gmail.com> <85d02ac8d8c9a8950ce1a9760a541ff506945de0.1535488400.git.gitgitgadget@gmail.com>
In-Reply-To: <85d02ac8d8c9a8950ce1a9760a541ff506945de0.1535488400.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 28 Aug 2018 13:41:50 -0700
Message-ID: <CAGZ79kbsJXF=X7tzpdogAY7LdLd87YkPY0euiYaa3uQKQPoZuQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] commit-graph: define GIT_TEST_COMMIT_GRAPH
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 28, 2018 at 1:33 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The commit-graph feature is tested in isolation by
> t5318-commit-graph.sh and t6600-test-reach.sh, but there are many
> more interesting scenarios involving commit walks. Many of these
> scenarios are covered by the existing test suite, but we need to
> maintain coverage when the optional commit-graph structure is not
> present.
>
> To allow running the full test suite with the commit-graph present,
> add a new test environment variable, GIT_TEST_COMMIT_GRAPH. Similar
> to GIT_TEST_SPLIT_INDEX, this variable makes every Git command try
> to load the commit-graph when parsing commits, and writes the
> commit-graph file after every 'git commit' command.
>
> There are a few tests that rely on commits not existing in
> pack-files to trigger important events, so manually set
> GIT_TEST_COMMIT_GRAPH to false for the necessary commands.

So the plan is to turn on the commit graph for the whole test suite
excluding these selected tests?


> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index 4984ca583d..73d5284a91 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -181,7 +181,7 @@ test_expect_success 'rev-list stops traversal at missing and promised commit' '
>
>         git -C repo config core.repositoryformatversion 1 &&
>         git -C repo config extensions.partialclone "arbitrary string" &&
> -       git -C repo rev-list --exclude-promisor-objects --objects bar >out &&
> +       GIT_TEST_COMMIT_GRAPH=0 git -C repo rev-list --exclude-promisor-objects --objects bar >out &&


> +               GIT_TEST_COMMIT_GRAPH=0 &&
> +               test_must_fail git merge -m final G

This could go on the same line without the && in between, setting the
variable as a prefix.
