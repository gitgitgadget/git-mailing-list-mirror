Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA70B1F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 10:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfACKFP (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 05:05:15 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:36090 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfACKFP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 05:05:15 -0500
Received: by mail-it1-f181.google.com with SMTP id c9so42063966itj.1
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 02:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+Ya8SOLquIyDThSDqmzI/ytUqycYeTfbnBa75RrIms=;
        b=ny+7YozKRwF0uil4dHBs+hBxWUShldsJbOpzAWe0595PTv95S6R6lE3jUh81Yq++3c
         Oj3poYCF+24dyA7zavcGZxJ0MdHRtPLvMh2Lw5KswTtiEsRwyBjSM6AJEKg9KMMLOqCC
         mb22X4lwvDuDey3vZa//V+IW6r8YQS3UOQ4S4r4YUqDv/N5z6TiO84EsY3oLQdDax3o2
         FPRx4dAf9p0RuNO2wdh2UgbG5ET2nyu9VCeRRs8vufhp+OLdH9g5NT254XEIIXWSQgFr
         t+UXPn8mK0v89fmHoraqo6z39gUN+s4/RX2OKCaY39dFs+W2RN+2teqtG7qYj6FpNGNk
         G6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+Ya8SOLquIyDThSDqmzI/ytUqycYeTfbnBa75RrIms=;
        b=UqgUbDHVc4EKCCA3HYiXhGwndpWlD5tCXso1Mkjm8iNeMxDdV1zXGCsrcGn5HfUok0
         QIJHYqo9NSNYHXTLQ1NM5r9AXMB9RLiZh44VUnXcxflHNF/EchEzSMHzYLrhrSxV4lUe
         OnEaIxbFIuMZET5UPSBN9jThNod0OS/ivSPw4LLbRM5umdNAKp0lmzRRvI4GKGcSg2qz
         rLpgpulBMuKaC/K0YHkdtX7Fu5v/jomMEu+SO6vIaFg0NoHfCta+Up8qioDd4+wWfCWo
         Jhz8yz6kvZgMH1Amx5EN19wrN4+ixyrIXg9A6M2Ff07fthpjpUMbDfIf3TU74cN2UOL7
         ipAw==
X-Gm-Message-State: AA+aEWbWuyNmNAGgASEGG6tYWn06SIXPrMdBeRBomnNLHK+8N9My75V6
        35naEGDjTBK62kS7tcmj7FHg0VEpgsUGkA2mSaU=
X-Google-Smtp-Source: ALg8bN7f1K1H5tHoIigyxTLFwjexjGGIvrPLDjUfRBaxu8P/NlU7MFhsilclZOxEuE813fL5Ai/wTYDLWwnV08Bjt0E=
X-Received: by 2002:a24:4606:: with SMTP id j6mr25700444itb.10.1546509913179;
 Thu, 03 Jan 2019 02:05:13 -0800 (PST)
MIME-Version: 1.0
References: <CA+dzEB=DH0irkFaRzkKERSjdZ=EJ+mG3Ri2Xeobx9Yu_eDd+jg@mail.gmail.com>
 <CACsJy8B=-V7XY+=5pwwSzg8B6Goa55DPPU3ErgjOEsSJVni18Q@mail.gmail.com> <CA+dzEB=TPxng4YBC4Vfh=ZcctAzRQ+drJ3y2sXwP=JXf+UweSA@mail.gmail.com>
In-Reply-To: <CA+dzEB=TPxng4YBC4Vfh=ZcctAzRQ+drJ3y2sXwP=JXf+UweSA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 3 Jan 2019 17:04:47 +0700
Message-ID: <CACsJy8C=O=ZDvD0ReSJOyAsNDEb5Yz-iFvs7oV5zAXaFf-dw5g@mail.gmail.com>
Subject: Re: Regression `git checkout $rev -b branch` while in a
 `--no-checkout` clone does not check out files
To:     Anthony Sottile <asottile@umich.edu>,
        Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 2, 2019 at 11:18 PM Anthony Sottile <asottile@umich.edu> wrote:
> heated a small room but here's the results of the bisect!
>
> fa655d8411cc2d7ffcf898e53a1493c737d7de68 is the first bad commit
> commit fa655d8411cc2d7ffcf898e53a1493c737d7de68
> Author: Ben Peart <Ben.Peart@microsoft.com>
> Date:   Thu Aug 16 18:27:11 2018 +0000
>
>     checkout: optimize "git checkout -b <new_branch>"

I did test this commit before and could not reproduce. But one thing I
did not notice is I set sparsecheckout on by default. which always
forces this optimization off Turning off sparse checkout, I could
indeed reproduce.

I plan to revert this commit anyway when the new command "git
switch-branch" comes. The optimization will be unconditionally in the
new command without this hack and users are encouraged to use that one
instead of "git checkout".

Meanwhile, let's see if Ben wants to fix this or revert it.

>
>     Skip merging the commit, updating the index and working directory if and
>     only if we are creating a new branch via "git checkout -b <new_branch>."
>     Any other checkout options will still go through the former code path.
>
>     If sparse_checkout is on, require the user to manually opt in to this
>     optimzed behavior by setting the config setting checkout.optimizeNewBranch
>     to true as we will no longer update the skip-worktree bit in the index, nor
>     add/remove files in the working directory to reflect the current sparse
>     checkout settings.
>
>     For comparison, running "git checkout -b <new_branch>" on a large
> repo takes:
>
>     14.6 seconds - without this patch
>     0.3 seconds - with this patch
>
>     Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> :040000 040000 817bfb8ef961545a554005d42967b5ab7cfdb041
> e57e576d0d4fb7f25c12a5dcc7651ef6698e961b M    Documentation
> :040000 040000 c089f91f4532caa2a17e4f10a1a7ed3aa5d2023c
> 7cf16a0aa288f898a880ffefe82ee7506b83bef4 M    builtin
> :040000 040000 adfdb05964a692e03ee07d2e43841f6304d996bd
> 8681416093802b9051599ebea8f63f5a45968e6f M    t
> bisect run success
>
>
> Here's the script and invocations:
>
> ```
> #!/usr/bin/env bash
> set -euxo pipefail
>
> rm -rf "$PWD/prefix"
> make prefix="$PWD/prefix" -j8 install
> export PATH="$PWD/prefix/bin:$PATH"
>
> rm -rf src dest
>
> git --version
>
> git init src
> echo hi > src/a
> git -C src add .
> git -C src commit -m "initial commit"
> rev="$(git -C src rev-parse HEAD)"
>
> git clone --no-checkout src dest
> git -C dest checkout "$rev" -b branch
> test -f dest/a
>
> : 'SUCCESS!'
> ```
>
> ```
> git bisect begin
> git bisect bad HEAD
> git bisect good v2.17.1
> git bisect run ./bisect.sh
> ```
>
> Anthony



-- 
Duy
