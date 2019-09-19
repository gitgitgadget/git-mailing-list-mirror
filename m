Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 539911F463
	for <e@80x24.org>; Thu, 19 Sep 2019 20:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbfISUqe (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 16:46:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46164 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfISUqe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 16:46:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so3033942pfg.13
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 13:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fY5Tahfocuv9oRzOeBysdBeTUqiJJtx+/Z/pi9hWUlo=;
        b=PBNjHoEQ1W13gczeaL/V74aBJZbRMBSiWuhZkPG5rzT9RlAWU34OZD7665BlkRibWg
         arvgx8/n5ql9poSHG1HGhp0uL7CwK7OBf3bJTAztGR3hrMr6Lf4ETQOpTg9VbKIABIPU
         edEZuSlPX9mZVLIIrO8bYibbyDtK1FDaJY1V3ZaCKF+d8WYsgvHSt/OlksiPMbaPzeFR
         8A6GNkzcbQKxHhuLG5uBxiaK+QrtCR24Qu4B5lllxKefeCVflpKC0Wgc9Puze1oNZRbQ
         IE9I9M/P16vTsVO2iJoQ4sOJJ+DQ+u3nbd57lBBWxpSxEQe19CABdiBhu4YQlePzqw8O
         ObyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fY5Tahfocuv9oRzOeBysdBeTUqiJJtx+/Z/pi9hWUlo=;
        b=Be3LIRcrm9taAOuqmYn6ozvBFO7nrydjpTvYMb2wQzgtgu9RGyaR7jawOrqpZcQiEp
         tftt+eaExt+7+/20KMQ/GcgEbhURyZ4UU7Wd77zq4pjGsAv7gDiVas7tL1+S1Ndypl8Q
         Es4PXVYzjtR4Ey21bVw4lKOyUNnuRY52u1fLIgtm21X3720o1sD7CNtwFsVMiQo6++Hq
         Kn9IaQrVnfOZLuOgqM6XDR81t4cLbeFJIpQ+GUZAdhvaQEgcAzl8jJDZvUSOmdGqQ85a
         TpUvJ2FnT0nNuxA+dxQjfQK98obeLdCnvvvDJGRUze9LKzPxXGp6TUETe+jtSaynqFir
         l01Q==
X-Gm-Message-State: APjAAAVqvfjRnvEvGoF1SEtefuDhZucdWdI1DAfa5s1SzqEMBgdtE+BJ
        vMiSxICybMxYNyl7rqFJHb+J0w==
X-Google-Smtp-Source: APXvYqzR6zEsyvHBiUrYV5U+3pnHATDVzO8LNd8xwL6j6WnIvJfkhV3lNQTgtgroM7TVDggzYttM8A==
X-Received: by 2002:a17:90a:2766:: with SMTP id o93mr5662052pje.40.1568925992403;
        Thu, 19 Sep 2019 13:46:32 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id w189sm12895672pfw.101.2019.09.19.13.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 13:46:31 -0700 (PDT)
Date:   Thu, 19 Sep 2019 13:46:27 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Pedro Sousa <pedroteosousa@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] doc: MyFirstContribution: fix cmd placement instructions
Message-ID: <20190919204627.GB116396@google.com>
References: <20190919184634.8869-1-pedroteosousa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919184634.8869-1-pedroteosousa@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for sending this. I guess I don't know the alphabet very well :)

A different color we could paint the bikeshed would be to write "add a
new line for `psuh` immediately after it" in these places instead. But I
have no preference whatsoever.

 - Emily

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

On Thu, Sep 19, 2019 at 03:46:34PM -0300, Pedro Sousa wrote:
> Using the pull command instead of push is more accurate when giving
> instructions on placing the psuh command in alphabetical order.
> 
> Signed-off-by: Pedro Sousa <pedroteosousa@gmail.com>
> ---
>  Documentation/MyFirstContribution.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
> index f867037..fb15af8 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -97,7 +97,7 @@ int cmd_psuh(int argc, const char **argv, const char *prefix)
>  ----
>  
>  We'll also need to add the declaration of psuh; open up `builtin.h`, find the
> -declaration for `cmd_push`, and add a new line for `psuh` immediately before it,
> +declaration for `cmd_pull`, and add a new line for `psuh` immediately before it,
>  in order to keep the declarations sorted:
>  
>  ----
> @@ -123,7 +123,7 @@ int cmd_psuh(int argc, const char **argv, const char *prefix)
>  }
>  ----
>  
> -Let's try to build it.  Open `Makefile`, find where `builtin/push.o` is added
> +Let's try to build it.  Open `Makefile`, find where `builtin/pull.o` is added
>  to `BUILTIN_OBJS`, and add `builtin/psuh.o` in the same way next to it in
>  alphabetical order. Once you've done so, move to the top-level directory and
>  build simply with `make`. Also add the `DEVELOPER=1` variable to turn on
> @@ -149,7 +149,7 @@ a `cmd_struct` to the `commands[]` array. `struct cmd_struct` takes a string
>  with the command name, a function pointer to the command implementation, and a
>  setup option flag. For now, let's keep mimicking `push`. Find the line where
>  `cmd_push` is registered, copy it, and modify it for `cmd_psuh`, placing the new
> -line in alphabetical order.
> +line in alphabetical order (immediately before `cmd_pull`).
>  
>  The options are documented in `builtin.h` under "Adding a new built-in." Since
>  we hope to print some data about the user's current workspace context later,
> @@ -167,7 +167,7 @@ Check it out! You've got a command! Nice work! Let's commit this.
>  
>  `git status` reveals modified `Makefile`, `builtin.h`, and `git.c` as well as
>  untracked `builtin/psuh.c` and `git-psuh`. First, let's take care of the binary,
> -which should be ignored. Open `.gitignore` in your editor, find `/git-push`, and
> +which should be ignored. Open `.gitignore` in your editor, find `/git-pull`, and
>  add an entry for your new command in alphabetical order:
>  
>  ----
> -- 
> 2.9.3
> 
