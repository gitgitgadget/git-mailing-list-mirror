Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2B4D1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 19:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbeDJTNd (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 15:13:33 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39782 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752057AbeDJTNc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 15:13:32 -0400
Received: by mail-pl0-f68.google.com with SMTP id e7-v6so6124166plt.6
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 12:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v+VAkj+CKep7LdYacUHJ7rpoSVfAQ6e56AowBhSasTs=;
        b=HpgxFC4M6HzqE5xr0d7Giuxi64+AhyTgU+9cDPdSUfi5Ty6qv9vxAFqf1YEysTP4Uo
         0jrnfOn9mO11rqAZ6B6RhDnN69QVTdDQ1ndSK9koErDz5qypCNKFN1M10l8DOViwJotR
         DmzpmqbbQtiN5C0//tWu1TLbpckPsUvh/nhY0P3W17fQEnWfX0FwTJJPWzRzQbkTFF2R
         EsKqrXI9/m8kbQsPcow2xXT9aNkWIBEmOVXvU86f1LlndvmQvg929TrFMzlH/VH1NjA0
         qnmOKzvwiG8g13KovsPQ0fHWuefFSss0dsHICq85uG+ZT2IZFhvg1XzXUSfskzLmdw7k
         VU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v+VAkj+CKep7LdYacUHJ7rpoSVfAQ6e56AowBhSasTs=;
        b=OUQtUZFC9hCUAu4xbtfjlgFNSLqw06TwH/WBYZ7E6DjCrB+NFloQfFfLtKQsZTPWzQ
         XxKXYmwpyRmEZZQaEnzCsTDPhIgZDCpx+lVnYSaRAfejKrpyQvEl5czZRyA0/0tBuDK/
         zUmdmfvf7dLbQAaSfiO6wa9/f+CACsS2t7VrceMcnJC5ViRacx6PfdJvROyp7kBnae4U
         tqo2LWlWHQzBTb5eIAUPK+BXuYeTWmncBv8kQI9OhB0Fk01XvX1ZN78tKNVwViiXfhG9
         kkw5Z+1V/8VCMYnJnpDJEAT3UXN7N9wMzNxjWZIIzSzT9zR7cSXi71DAW0rZQh0AZGRP
         yizg==
X-Gm-Message-State: ALQs6tAr0GBeGOZB3YwFa8NWpp4o8xLovJmTONogPpf2Tt+0981iLLld
        tR+U38EiuLQ//SN2dUfLcfjPTYEeJ1ECB1SLOLMzgA==
X-Google-Smtp-Source: AIpwx4+aDKQWx5m7mcfQaeHrfkJ4BSW0l5gykYjyHH13Z/4DmbM+dXm7yskFlDOIomfBrr35RcRFSEUJwFSSHnZnT7Y=
X-Received: by 2002:a17:902:7683:: with SMTP id m3-v6mr247716pll.340.1523387611813;
 Tue, 10 Apr 2018 12:13:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.178.66 with HTTP; Tue, 10 Apr 2018 12:13:30 -0700 (PDT)
In-Reply-To: <20180410183224.10780-2-asheiduk@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com> <20180410183224.10780-2-asheiduk@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 10 Apr 2018 21:13:30 +0200
Message-ID: <CAN0heSquxLpMfrLQs2em1amLv77-Uywr+885Viuq4-7DiWYmAQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] doc: fix formatting inconsistency in githooks.txt
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 April 2018 at 20:32, Andreas Heiduk <asheiduk@gmail.com> wrote:
> The section 'post-rewrite' in 'githooks.txt' renders only one command
> using backticks (`git commit`) but the other commands using single quotes
> ('git-rebase'). Align this formatting to use single quotes.
>
> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> ---
>  Documentation/githooks.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index f877f7b7cd..070e745b41 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -417,8 +417,8 @@ to abort.
>  post-rewrite
>  ~~~~~~~~~~~~
>
> -This hook is invoked by commands that rewrite commits (`git commit
> ---amend`, 'git-rebase'; currently 'git-filter-branch' does 'not' call
> +This hook is invoked by commands that rewrite commits ('git commit
> +--amend', 'git-rebase'; currently 'git-filter-branch' does 'not' call
>  it!).  Its first argument denotes the command it was invoked by:
>  currently one of `amend` or `rebase`.  Further command-dependent
>  arguments may be passed in the future.

Hmm, I wonder if that is actually intentional. `git commit --amend`
could be run exactly like that and would do what this paragraph expects
of it. The 'git-rebase' is a Git subcommand name, i.e., not some
copy-paste command-line ready for use. If it were something like `git
rebase -i HEAD~5`, I would expect the backticks.

A second discrepancy is the dash in "git commit" vs "git-rebase" and
"git-ls-remote". That could perhaps be explained by the same reasoning.

Martin
