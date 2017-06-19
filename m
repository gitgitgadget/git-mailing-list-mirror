Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B3AB20401
	for <e@80x24.org>; Mon, 19 Jun 2017 05:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751024AbdFSFY6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 01:24:58 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35920 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbdFSFY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 01:24:56 -0400
Received: by mail-pf0-f194.google.com with SMTP id y7so15002087pfd.3
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 22:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=P6KqbjUqTQGRUl+I7Y/VLPcVLcQJByVip9eb5YZtlVo=;
        b=WSRDhG9Ee7QbxkfaKuCTrwGnU2brlvekh6CDnKttOydSbef09c51N4s8FWIIX5DYHG
         ZwS/gmkIi5rBFzTN0/AI9RpuGPDfoQ8TW0FKgIublOc/ZPsevPuln0B6JlDrW9sWa15T
         OxIiWA1EeRkU2JSviozpLcaOzYuYRwhXzYT63FMPs5rZykUFClDg/suqC7R2Rq4MGTGs
         Aqra1LsdDEZwSPwh7lPTXzMbfZCqJqbh+2ONPBDnVOqf0XiGhVZrnsmlfngy5lnb8Jyr
         LXNe8YgediaQiDZWYXtHDZ7U+IzceJFdmqYoFvMiLD282Dq38YdQ75WDopIWLuhTSPZL
         8czQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=P6KqbjUqTQGRUl+I7Y/VLPcVLcQJByVip9eb5YZtlVo=;
        b=C3FUGraGR9sYpjISn0sDw4q5WdeZyZCVVmZaai+q/z5B66H9/K9fgmelkkf5nlmq8D
         ESNddgw9xmtna5twaW9v75PBPgSuDcjB1FQ5mPHYv90vnYiTlWdkptynQ36O8KfJdslY
         szU9P6UUZScCDmeo26BDpl4cY/aym7k8n7oLe6jsoiYVdodSJg9WhxO5nKPy2sud8htB
         2Da8c+vC4Wa3nOioOL71OzWBsG2Pr+Ya3UpurBrMvG8R8lccXNsoSDSDTWy7BBqO8UpY
         FuVqP04nUrI2/bFfsTMUuwgmrkVRI2b2S9XsliDAgm2U0YZQvwQYu1TAluIJa5IKweXG
         5YxQ==
X-Gm-Message-State: AKS2vOwRn4xi7HgAvR9wunNBnhIY5a5mwf4Ky9wG/JVD/ofnZTT8YnXJ
        HeAXQem9ROYXjw==
X-Received: by 10.98.100.8 with SMTP id y8mr23054832pfb.79.1497849895968;
        Sun, 18 Jun 2017 22:24:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec96:eb20:667b:9e2b])
        by smtp.gmail.com with ESMTPSA id 66sm21112999pgh.59.2017.06.18.22.24.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 18 Jun 2017 22:24:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: Re: [PATCH/RFC] Cleanup Documentation
References: <20170619030518.6712-1-kaarticsivaraam91196@gmail.com>
Date:   Sun, 18 Jun 2017 22:24:54 -0700
In-Reply-To: <20170619030518.6712-1-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Mon, 19 Jun 2017 08:35:18 +0530")
Message-ID: <xmqq1sqgv9ax.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan, this was sent in my way, but I know you are the primary
person who is looking into updating submodule documentation these
days, so I am forwarding it in your way to ask you to give the first
comment.  

Thanks.

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> 1. Remove redundancy from documentation
> 2. Remove unclear reference to alternative
>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>
> The following line seemes unclear and hence was removed for now. Suggest any
> changes that could make it clear.
>
> "This second form is provided to ease creating a new submodule from scratch, 
> and presumes the user will later push the submodule to the given URL."
>
>
>  Documentation/git-submodule.txt | 37 ++++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 74bc6200d..9812b0655 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -63,13 +63,7 @@ add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--dep
>  	to the changeset to be committed next to the current
>  	project: the current project is termed the "superproject".
>  +
> -This requires at least one argument: <repository>. The optional
> -argument <path> is the relative location for the cloned submodule
> -to exist in the superproject. If <path> is not given, the
> -"humanish" part of the source repository is used ("repo" for
> -"/path/to/repo.git" and "foo" for "host.xz:foo/.git").
> -The <path> is also used as the submodule's logical name in its
> -configuration entries unless `--name` is used to specify a logical name.
> +This requires at least one argument: <repository>.
>  +
>  <repository> is the URL of the new submodule's origin repository.
>  This may be either an absolute URL, or (if it begins with ./
> @@ -87,21 +81,22 @@ If the superproject doesn't have a default remote configured
>  the superproject is its own authoritative upstream and the current
>  working directory is used instead.
>  +
> -<path> is the relative location for the cloned submodule to
> -exist in the superproject. If <path> does not exist, then the
> -submodule is created by cloning from the named URL. If <path> does
> -exist and is already a valid Git repository, then this is added
> -to the changeset without cloning. This second form is provided
> -to ease creating a new submodule from scratch, and presumes
> -the user will later push the submodule to the given URL.
> +The optional argument <path> is the relative location for the cloned
> +submodule to exist in the superproject. If <path> is not given, the
> +"humanish" part of the source repository is used ("repo" for
> +"/path/to/repo.git" and "foo" for "host.xz:foo/.git"). If <path>
> +exists and is already a valid Git repository, then this is added
> +to the changeset without cloning. The <path> is also used as the
> +submodule's logical name in its configuration entries unless `--name`
> +is used to specify a logical name.
>  +
> -In either case, the given URL is recorded into .gitmodules for
> -use by subsequent users cloning the superproject. If the URL is
> -given relative to the superproject's repository, the presumption
> -is the superproject and submodule repositories will be kept
> -together in the same relative location, and only the
> -superproject's URL needs to be provided: git-submodule will correctly
> -locate the submodule using the relative URL in .gitmodules.
> +The given URL is recorded into .gitmodules for use by subsequent users
> +cloning the superproject. If the URL is given relative to the
> +superproject's repository, the presumption is the superproject and
> +submodule repositories will be kept together in the same relative
> +location, and only the superproject's URL needs to be provided.
> +git-submodule will correctly locate the submodule using the relative
> +URL in .gitmodules.
>  
>  status [--cached] [--recursive] [--] [<path>...]::
>  	Show the status of the submodules. This will print the SHA-1 of the
