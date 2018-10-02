Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58C041F453
	for <e@80x24.org>; Tue,  2 Oct 2018 19:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeJCCV5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 22:21:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37191 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbeJCCV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 22:21:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so3529260wrr.4
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 12:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rJ1L/LgzEp9L1s04jaauxNiCR1HeWFwAoaK9iMr1rAU=;
        b=Ob0jxN1wVkGuCm0O4VuqOnrCwjZxiayNJlaRWytDr5T5OVCg4yO6IO+c8V9tfb+7l9
         G5N7fIxIAYh1nm851MuxYenFdcbpiLdr+E5ojhZd/gNdCCz99CBgs6rd+aShZoDOJaL1
         pAnifkR+McQvLBFiZDfAuUrrc8El1ZJVRkdCGOkUIW6bj0grugVMVPf0dc+BxEzVeaFq
         cfa3IFuCHPYpYqpaA0MeC1Vetfs9S7Hwci3mMzmot52w+FDUKRzK3rCQW3CCvSbwNUDG
         NcfHV8tGLGwMc1I9ZMtpVfNLuiaR6cbrMOLbqlLrtiHt9CVHGIG6XU/0a/GRRHHquaru
         nVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rJ1L/LgzEp9L1s04jaauxNiCR1HeWFwAoaK9iMr1rAU=;
        b=Szx1G304f5UKphfUaWLWSI3NwLVgeJ9u5w0gGfCsUfqtvKr3TQ3i0nPFu4/BottDX0
         5ekZtw6bSqAMNtiGLEwMZD1sRKtN/YiG/egDMREM99H8WfNQ4emRcKOsNxJmH62GUAzH
         dzplA7AEH7nZ22M+KiqSNk5lfNf466aZLYar/WQm3gpVCOmqM0/tzb140gE+zrp2qbW3
         wB1wId+YspU0Xdbco70yMYH/zt3JEVXa83tUl4m/AXEruhqEtMkcWlwZnF9diM6CAZkR
         pFef4wbandsI4KPgIhns5yoAREREIDVXs6yoNO0czTRfdP5/g6Z9hM34TTg/QB1A8hMv
         QXRg==
X-Gm-Message-State: ABuFfogZYRvE3HOFvIE1X2uMCFRzyuMNm74BCKKXhis6Pip0q5M64e6T
        TGTDYvp3xuECcL6trzwGB0nwn2yd
X-Google-Smtp-Source: ACcGV604HiV67ZqGGBIZych9GCsfbFwHlysrCT/O2grm1jU6dqE+O9+rWlSLp/5pZ7PUKxeLpVZ5tw==
X-Received: by 2002:adf:e348:: with SMTP id n8-v6mr11117111wrj.158.1538509018969;
        Tue, 02 Oct 2018 12:36:58 -0700 (PDT)
Received: from localhost ([2.30.92.34])
        by smtp.gmail.com with ESMTPSA id e133-v6sm15960833wma.42.2018.10.02.12.36.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 12:36:57 -0700 (PDT)
Date:   Tue, 2 Oct 2018 20:36:58 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 13/21] stash: mention options in `show` synopsis.
Message-ID: <20181002193658.GG2253@hank.intra.tgummerer.com>
References: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
 <f4df1a271333bcf82c5ea1c5d9604ceb1c0374f8.1537913094.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4df1a271333bcf82c5ea1c5d9604ceb1c0374f8.1537913094.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Subject: stash: mention options in `show` synopsis.

Really minor point, but the '.' in the end should be dropped.

Also as this is fixing a pre-existing problem I would have put this
patch near the beginning of the series, rather than in between
conversions of functions, and just incorporated the bits that changed
in the helper into the patch that converts 'git stash show'.

The rest of the patch looks good to me.

On 09/26, Paul-Sebastian Ungureanu wrote:
> Mention in the usage text and in the documentation, that `show`
> accepts any option known to `git diff`.
> 
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---
>  Documentation/git-stash.txt | 4 ++--
>  builtin/stash--helper.c     | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 7ef8c47911..e31ea7d303 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -9,7 +9,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git stash' list [<options>]
> -'git stash' show [<stash>]
> +'git stash' show [<options>] [<stash>]
>  'git stash' drop [-q|--quiet] [<stash>]
>  'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
>  'git stash' branch <branchname> [<stash>]
> @@ -106,7 +106,7 @@ stash@{1}: On master: 9cc0589... Add git-stash
>  The command takes options applicable to the 'git log'
>  command to control what is shown and how. See linkgit:git-log[1].
>  
> -show [<stash>]::
> +show [<options>] [<stash>]::
>  
>  	Show the changes recorded in the stash entry as a diff between the
>  	stashed contents and the commit back when the stash entry was first
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index 1bc838ee6b..1f02f5f2e9 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -15,7 +15,7 @@
>  
>  static const char * const git_stash_helper_usage[] = {
>  	N_("git stash--helper list [<options>]"),
> -	N_("git stash--helper show [<stash>]"),
> +	N_("git stash--helper show [<options>] [<stash>]"),
>  	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
>  	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
>  	N_("git stash--helper branch <branchname> [<stash>]"),
> @@ -29,7 +29,7 @@ static const char * const git_stash_helper_list_usage[] = {
>  };
>  
>  static const char * const git_stash_helper_show_usage[] = {
> -	N_("git stash--helper show [<stash>]"),
> +	N_("git stash--helper show [<options>] [<stash>]"),
>  	NULL
>  };
>  
> -- 
> 2.19.0.rc0.23.g1fb9f40d88
> 
