Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65B611F404
	for <e@80x24.org>; Wed, 15 Aug 2018 20:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbeHOXUj (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 19:20:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39939 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbeHOXUj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 19:20:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15-v6so2157787wrs.7
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 13:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rsU7X6lc7xYIyfxROJc3NitDMumBTZP2TpjX66uwgMQ=;
        b=jFBtG8hVhy2Ym1duOL2zfjMB1mAfQc9wal5hbeWmS4QpTZjs7U1g27yosB6gZQK6cK
         /1Lm1oXg1YOVbEDia3Ij+2DrGE/UOGq9eKdcaYNgpXtRytDmIumYygaAn1HUE9wywH/A
         tND9R4BxXO1oRsNmOVqo3mQ1I1nHACd6G8tzbb+R3hhyIrWkpAp+5W9wV65ZJH6RUuJd
         aANuS0ZjaSiswz+U18qCo/kYrUHSLRpxnZ3zdFaCihHtv+cA2zgU/LiqbaNgUi/8bp9r
         X4kAcQo7FdhpJQQG4cYiDuDHUW0h6lnqKXeD3ClLeEaPv7mq7dI5YrKQBfIlAYFSdaqv
         aBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rsU7X6lc7xYIyfxROJc3NitDMumBTZP2TpjX66uwgMQ=;
        b=a9ThBR/ccVupaI4sOk+WYxFRAnVO0MPiXy0Ric/RL38BY64Y/Gr43qyU2PJnJEdaL9
         HSfROmHI5a5AZUJ0MDqVtyPd5nzrsiQK1B0Vzz88DfApkIzkvRXYIf+Tl3qLcILbYCwi
         bP4HAtNjv7HXi5/UbYGSpu+G21oUiMBoHkbn6HZjpNiKmBF4dAvti4I0nFOcT4wVIO8W
         yQZbN+NZxuW/+9UM+a5OLe89pPz3CtfK978LSJsdH4qcKLrW8BiuDFEigPIhQd8FdpqU
         GKA17iIGAzOCAtwbrpnUXTUuRKpHyRZrf4Gp8eaONUjay8bu3q5aHmbrVkwdI1PSQ/hG
         0slg==
X-Gm-Message-State: AOUpUlFm6J/0XCCTD5NxP+JI2iDtgx+mepU/OJNONfBLXVPRADVpxSIf
        bZt9FU8UKBQfIV6ts5leiQs=
X-Google-Smtp-Source: AA+uWPxJXLeDvpd+tGw9oo0RO/KZsxLgFiZUN4+Ilj+B2utTCUYne3xbIOm/P3c2dUKIuoVtw4U46Q==
X-Received: by 2002:a5d:4a84:: with SMTP id o4-v6mr14844051wrq.82.1534364816899;
        Wed, 15 Aug 2018 13:26:56 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id 198-v6sm5259916wmm.0.2018.08.15.13.26.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 13:26:56 -0700 (PDT)
Date:   Wed, 15 Aug 2018 21:26:55 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v7 11/26] stash: change `git stash show` usage text
 and documentation
Message-ID: <20180815202655.GM2734@hank.intra.tgummerer.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <5e477e5a62c3e2cc7066487bf6e0a68c922457a5.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e477e5a62c3e2cc7066487bf6e0a68c922457a5.1533753605.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Subject: stash: change `git stash show` usage text and documentation

Another nitpick about commit messages.  "change ... usage text and
documentation" doesn't say much about what the actual change is.
How about something like "stash: mention options in "show" synopsis"
instead?

The change itself looks good to me, thanks!

On 08/08, Paul-Sebastian Ungureanu wrote:
> It is already stated in documentation that it will accept any
> option known to `git diff`, but not in the usage text and some
> parts of the documentation.
> 
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---
>  Documentation/git-stash.txt | 4 ++--
>  builtin/stash--helper.c     | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 7ef8c4791..e31ea7d30 100644
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
> index e764cd33e..0c1efca6b 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -13,7 +13,7 @@
>  
>  static const char * const git_stash_helper_usage[] = {
>  	N_("git stash--helper list [<options>]"),
> -	N_("git stash--helper show [<stash>]"),
> +	N_("git stash--helper show [<options>] [<stash>]"),
>  	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
>  	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
>  	N_("git stash--helper branch <branchname> [<stash>]"),
> @@ -27,7 +27,7 @@ static const char * const git_stash_helper_list_usage[] = {
>  };
>  
>  static const char * const git_stash_helper_show_usage[] = {
> -	N_("git stash--helper show [<stash>]"),
> +	N_("git stash--helper show [<options>] [<stash>]"),
>  	NULL
>  };
>  
> -- 
> 2.18.0.573.g56500d98f
> 
