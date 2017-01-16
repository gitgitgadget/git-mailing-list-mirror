Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E71ED1F89C
	for <e@80x24.org>; Mon, 16 Jan 2017 04:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750848AbdAPEAE (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 23:00:04 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33106 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbdAPEAD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 23:00:03 -0500
Received: by mail-lf0-f43.google.com with SMTP id k86so72695928lfi.0
        for <git@vger.kernel.org>; Sun, 15 Jan 2017 20:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6GetUVWLe0JYAwI3YxaQ6Cq4m/SKH+mSlZXT4GS06jo=;
        b=DpilCROGvdf6Mn26eDmWzgyj9uBFbNCNEmmoITsjQ+29dbrhe8yLnRLy4l//qjQFvE
         ezwZEdYDhFmL6IJMweNZREuCeXz+jItuHIEaXK2XORa/k506eDnVwQSKr0K4Fc1MIpey
         yjYqSgTBwWYsj8NjkFrMTAijJ1aR5gBLirVVw8vTE4kZ1z0LPuBtq2mS0QCQA6n+8iaB
         9tK2QnEMmeUa7dXdcw+OL/kp1rOZX66jRUwm2jwwUVCzAt3/KKGN4wOHMnSr0e6UEUfe
         Ur+4+RWMeGm4W9kwqahzrXAaGvNV2uTX4JDHeUbiyU2u1Q0xVWf/9UFg9BHBWq9e1bgq
         NCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6GetUVWLe0JYAwI3YxaQ6Cq4m/SKH+mSlZXT4GS06jo=;
        b=XtY+DGaiFuqPeqoPenCk5LA9XJhvtaBXa0JbgUS4U3VfxMBlbn/XuIqrvnIO4WUmFJ
         5nbfZcfAf7NcVVX7tsRXoNHTd/rQHJcxE7tqEHl6qFZjDZIQXenJTk3RTyxIJkjZPUYz
         A0Ek0jR9qMkbW8GPWjkZKx7+VtNFRVtiXzOEQO9/pJRb7spgRRTtQOBmHOvEdmH1MpBJ
         ddnD36Mdf3etKol354Dd9ztL1vMVNrnwEiiep4tVSo9bxg5eqPFusAnm1ZMbQ5+11pR/
         Wy2/q2bPkXJzh+6o8rZ0PqFtS9Xwx//t5hJw41YSyI9Q5FZQkZlolr1vakggrNvCI10g
         zxwg==
X-Gm-Message-State: AIkVDXJzNxMKL2JPLhvmk+qmnSbJSEX5oOi91eDIaXtAUJsfeMB3GITP4b2Tk66Vym3/mvHgLPYNIyumFSJsGQ==
X-Received: by 10.46.72.1 with SMTP id v1mr3387959lja.12.1484539201447; Sun,
 15 Jan 2017 20:00:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Sun, 15 Jan 2017 19:59:40 -0800 (PST)
In-Reply-To: <cd784a4e-ee99-564e-81de-9f7f6cc26c67@gmx.net>
References: <cd784a4e-ee99-564e-81de-9f7f6cc26c67@gmx.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 15 Jan 2017 19:59:40 -0800
Message-ID: <CA+P7+xpSRD946UUGdf2Dn+FGDMrTgON7t_WMdQS8z4ReNMZrVg@mail.gmail.com>
Subject: Re: [RFC] stash --continue
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 15, 2017 at 3:56 PM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi,
>
> a git-newbie-ish co-worker uses git-stash sometimes. Last time he used
> "git stash pop", he got into a merge conflict. After he resolved the
> conflict, he did not know what to do to get the repository into the
> wanted state. In his case, it was only "git add <resolved files>"
> followed by a "git reset" and a "git stash drop", but there may be more
> involved cases when your index is not clean before "git stash pop" and
> you want to have your index as before.
>
> This led to the idea to have something like "git stash --continue"[1]
> that would expect the user to "git add" the resolved files (as "git
> status" suggests) but then leads to the expected result, i.e. the index
> being the same as before the conflict, the stash being dropped (if "pop"
> was used instead of "apply"), etc.
>
> Likewise, some "git stash --abort"[2] might be useful in case you did
> "git stash pop" with the wrong stash in mind.
>
> What do you think about that?
>

This sounds like a useful extension to me.

Thanks,
Jake
