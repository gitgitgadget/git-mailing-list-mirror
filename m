Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E6B020248
	for <e@80x24.org>; Tue, 26 Mar 2019 14:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbfCZOjI (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 10:39:08 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37868 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731451AbfCZOjH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 10:39:07 -0400
Received: by mail-ed1-f65.google.com with SMTP id v21so10983609edq.4
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=+1cWYuQ3TQPTwZI5bmvKPuKjZ8a1gzHTLE8JKw2iuDc=;
        b=H9cWD+k/n+Bw+T3lekphLvz5dIML6qmcURwx42ThTEh99MVvIHeKabxzVxQdQ6dMUA
         SxGrirXBqgn5H2fmTFnQ8E7Q+ixtDxrv5S9t4Ob1htQ9vhhORsVGvlzhPT/sbjLmaPj/
         wsRMRuUeXcY+7fJMCj7iC8iGuhU1/gRFtVha4QYQvc9TsLeWO1XricG11PzNyCJpFW9V
         5xCST2bNM4BwMcMm8ZN+CiOg6f68RMMBlA+qEluB/9fRfsOWSNovqhyWkcC9xdMhtXYO
         j3m8mb88Q2nV+2dsVpTmgyQ7ilwH7Ejp5PUZ6bkcAls54lJIihCVLL8TgNaSvQaMOzIA
         C/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=+1cWYuQ3TQPTwZI5bmvKPuKjZ8a1gzHTLE8JKw2iuDc=;
        b=Zb6xxDux3ixBFj0z5sxrkdnmiQo31AiMMhdjE/sPr0/bdXg0ZbMtE0+IouG+2rgNwE
         C1Cczs+2YB8ZZKXThEIAAuRHTDeaBZzgeCLnbgsr2V7qJd5QPlz0fjFfKx6UGvWQ9+VD
         UMYKsLALmPXEy48yy9pkTy1PfYwzMqLSRRxzKbwZUA1j/YOxLpW24gt6Zf1hPcryx62z
         eTFw4BezpIrjtZO42C0+r4mZrxA3NzF5qovw9VtlbFFLfpMW429aUrwUQGI6mVbnjtvv
         v6qkeniqvuASMbNKba574RgmzN+VZLNNhG/FdipyG0u/5uh8ugu1mZcBw2NwLhtw126X
         7YSQ==
X-Gm-Message-State: APjAAAX3fmqv3RxU/Cs0zFCQc+/hxcATfCCtZGOAfzv5fqKL1k2SbqTO
        yxK1gdDHHZcc6AAUc3tZRz0=
X-Google-Smtp-Source: APXvYqziyCZoPbV+obTc+kSkGy8P82GT9r16IyWobAUFYNvCTAEPhrvs89Rhofs/8ODPGniKDFeobQ==
X-Received: by 2002:a50:9271:: with SMTP id j46mr20603480eda.184.1553611146186;
        Tue, 26 Mar 2019 07:39:06 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id m30sm6285743eda.84.2019.03.26.07.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 07:39:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/5] docs: do not document the `git remote-testgit` command
References: <pull.162.git.gitgitgadget@gmail.com> <pull.162.v2.git.gitgitgadget@gmail.com> <810d2c5a94b40544652c97ffa644b29e0db8af82.1553550094.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <810d2c5a94b40544652c97ffa644b29e0db8af82.1553550094.git.gitgitgadget@gmail.com>
Date:   Tue, 26 Mar 2019 15:39:03 +0100
Message-ID: <87a7hhbszc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 25 2019, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Since 7ded055401 (build: do not install git-remote-testgit, 2013-06-07),
> we do not install it. Therefore it makes no sense to document it,
> either.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/git-remote-testgit.txt | 30 ----------------------------
>  Documentation/gitremote-helpers.txt  |  2 --
>  2 files changed, 32 deletions(-)
>  delete mode 100644 Documentation/git-remote-testgit.txt
>
> diff --git a/Documentation/git-remote-testgit.txt b/Documentation/git-remote-testgit.txt
> deleted file mode 100644
> index b45bfebba5..0000000000
> --- a/Documentation/git-remote-testgit.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -git-remote-testgit(1)
> -=====================
> -
> -NAME
> -----
> -git-remote-testgit - Example remote-helper
> -
> -
> -SYNOPSIS
> ---------
> -[verse]
> -git clone testgit::<source-repo> [<destination>]
> -
> -DESCRIPTION
> ------------
> -
> -This command is a simple remote-helper, that is used both as a
> -testcase for the remote-helper functionality, and as an example to
> -show remote-helper authors one possible implementation.
> -
> -The best way to learn more is to read the comments and source code in
> -'git-remote-testgit'.
> -
> -SEE ALSO
> ---------
> -linkgit:gitremote-helpers[7]
> -
> -GIT
> ----
> -Part of the linkgit:git[1] suite
> diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
> index 34a3e60d08..2fc4007525 100644
> --- a/Documentation/gitremote-helpers.txt
> +++ b/Documentation/gitremote-helpers.txt
> @@ -513,8 +513,6 @@ linkgit:git-remote-ext[1]
>
>  linkgit:git-remote-fd[1]
>
> -linkgit:git-remote-testgit[1]
> -
>  linkgit:git-fast-import[1]

I wonder if it should be moved into e.g. t/helper or somesuch at this
point...
