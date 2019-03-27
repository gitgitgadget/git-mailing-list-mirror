Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58BE420248
	for <e@80x24.org>; Wed, 27 Mar 2019 17:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfC0RFk (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 13:05:40 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43362 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfC0RFj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 13:05:39 -0400
Received: by mail-vs1-f66.google.com with SMTP id i207so10368190vsd.10
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 10:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GJ6J1faodzbP39Rj6zXEegCaGdoOuJ3RrD3yas00SVw=;
        b=Jh3sH9EhuQLU4Au2TpGAfbqExvTsLBnnR3QMuRwj31Ss9vbJbSN4XsBQ4otrQmBlA4
         hEoGSrZA+iRle3EHKZj+CfdmIMvCJi19fumInkzCWlcDiqtMsM3/FzwPqR9MxA5skTyG
         tT2trR7kZeU/bvWrwhFBvouutb8TqHwzE8mKIcTT8lCfdshEwpJEx+wt08A7q1JfqdYa
         9IoR6V+9mAEPLLYVA/tbOLFLD0f0DNmsbzFjo5qV7FtfT9thWxXkTknZ1sISFQTxrCqU
         8OZe7r1LJOfDgcO4V8L6czOIyGfZ32fW8Ni7tE7rnCDDDKDTvPz2/ThHwwm+5EfZ1hpA
         oHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GJ6J1faodzbP39Rj6zXEegCaGdoOuJ3RrD3yas00SVw=;
        b=JfLtdpcRyk30GVpO8E+Vds3Fuwfym9VHSQNXwyrL12JMsPG0VHuTVQ6Jx7smtZX9U+
         XmPQtBtLLDlY154tefRwH84jSFN0OJ8YF6LAw2YMnBH3yi7trAxRQeqgQ2cW71Huqset
         7rHU/7zLDhkBytun4M0jaGXVpdUU/pyFS/GozmPMCktijEA62DBH+0QlTlUQkULmbPYK
         xVeLXFcvzDth9pPyt+Z67oLXK1gXhW7iGKEixg900dNxNe4CwX22f1MVZ7/Ok8nXuNrU
         peGcmxqzRFLzzD2X1Daseoa7fYhQ1tyK8hzDie4oECt19DJJR6KcwLUKltaMXnfbUNPC
         JSJg==
X-Gm-Message-State: APjAAAUprpu9Fp5WObRfwSqS/rTqX7sZNui2RNhrhK5uR80o2j8HaoPq
        lXzhUZRZcSOBpwWlnAV6ed0irpmi1OMEr2wfPpAAgg==
X-Google-Smtp-Source: APXvYqxg3c6uC+wFx0yIuFdUwkIa9LDEI2bmVlrK7+5SS7Ah4GjKyrAGS9lKGTD67DlB2EcqXZOdGVH7AH2yRsiwi7I=
X-Received: by 2002:a67:df93:: with SMTP id x19mr23336498vsk.116.1553706338711;
 Wed, 27 Mar 2019 10:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <1A5DE2FC-7D94-4785-A915-EA2A71C6C377@m-mooga.com>
In-Reply-To: <1A5DE2FC-7D94-4785-A915-EA2A71C6C377@m-mooga.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 27 Mar 2019 10:05:27 -0700
Message-ID: <CABPp-BE9vNhnN6XdcxnePnXkek0bNogAiA_cKJqZ1-ct=QA2pw@mail.gmail.com>
Subject: Re: [GSoC][PATCH] microporject test_path_is_*
To:     Mooga <contact@m-mooga.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mooga,

On Wed, Mar 27, 2019 at 5:27 AM Mooga <contact@m-mooga.com> wrote:
>
>
> So for example  that is git diff
>
> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index 286bba35d8..fc82965a0f 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -66,7 +66,7 @@ test_expect_success '"add" worktree' '
> test_expect_success '"add" worktree with lock' '
>         git rev-parse HEAD >expect &&
>         git worktree add --detach --lock here-with-lock master &&
> -       test -f .git/worktrees/here-with-lock/locked
> +       test_path_is_file .git/worktrees/here-with-lock/locked
>
> I would like to hear feedback if I should commit

As you noticed from the other thread, there are folks who are now
unsure whether this microproject suggestion is a good idea anymore.
Personally, I like the test_path_is_* slightly better, but the real
issue is that we didn't have that discussion before starting the GSoC
process and putting it up as a suggestion on the microprojects page.
I think the main purpose is getting people familiar with creating and
submitting patches, so I'd go ahead and make this change as well as
others needed in that file and submit it.  Maybe the patch doesn't get
applied but if you've created a correct commit and submitted it as a
patch to the mailing list, I'd still count it as a successful
microproject.
