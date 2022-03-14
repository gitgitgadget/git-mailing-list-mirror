Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0681FC433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 16:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242900AbiCNQOj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 12:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiCNQOi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 12:14:38 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324D436323
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 09:13:28 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id 11so13542247qtt.9
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 09:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DqHBTKEnmu4Da9JCxsVinwdIsj6SCj4Rz6eYfBoVScE=;
        b=Xde38MiLCqKpvDpx5yYmn50vVn8fT7Zo7kD03d8QPZII2zsBgaRidSZDUpJRjw+ZSu
         QkkCYPD2PGE1jjkCWAy0Mv19O8FKUYI3lvO53v9fSEX0BElvxj1p9KutLjO4kjAUCxr5
         dRV0OctyWPAVFoXL01H74Sua01bJ4R67dSSFN1vJQbZp++FJ1cZv/PKeSUb0MjqK8MDQ
         CXx5PheFiK3Uaa2HcoQN6wVGWCpTwdLvOrhxI2KtwZ3UxGhdTH4f3DNrESaxQErHqg6O
         AIw48GHkJGbmMsepgu+Hdz6e9/sYZ1/LIg6PPtiNr4xBlZbkddO6m9u6vOTWz+0zEy61
         11+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DqHBTKEnmu4Da9JCxsVinwdIsj6SCj4Rz6eYfBoVScE=;
        b=g2UUz8vW+AMkACZvwkg59Kll4dHc9nrLDus7AuWWVych9kVesCLbZreOF+A3T+jbkl
         OlFTxHzKy0y8zU8OyTCFJrs+E0el8wUqB4rSJ5RSH42iCgWLETfgHavLdD2LuzqiRj+i
         f4DXqOiTw47b1DmP46zeMsx1LyjIBncmCbZLp/ibMlSm2R3ODgxtMwn8fZRwwtigGyi5
         cbapBJGY9/sFz9QtQlFGAZ9JatWbmOiPALTL/1IKqfRFB1phuvk18z0vuMtITiCcg15L
         6N7+KmamAL82faE5Jnpi2RGTHV3lO1v9btAi4KxSPnMf8d++yAiXpxfPNpmp+6uMYy7E
         eixg==
X-Gm-Message-State: AOAM530TrbKY9HiVynly4qJdcEzzVlFUHH9mZh4sbXNBTjY5LKIzgjyk
        m6a1JWihXhKmM3wV0vEX49xPzrh5aqGv
X-Google-Smtp-Source: ABdhPJy7BcdtylLcj8hnxiWU+XW2QkrZtdVrbVv7T17evg37c888wmGEXei8aX00Be6iIQEo2czmwg==
X-Received: by 2002:a05:622a:134d:b0:2e1:ce33:5d2d with SMTP id w13-20020a05622a134d00b002e1ce335d2dmr5898197qtk.407.1647274407150;
        Mon, 14 Mar 2022 09:13:27 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id g200-20020a379dd1000000b0067d76e714f5sm5272510qke.35.2022.03.14.09.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 09:13:12 -0700 (PDT)
Message-ID: <307ac60d-b0a1-ea90-8118-a4e02b809102@github.com>
Date:   Mon, 14 Mar 2022 12:13:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/1] Documentation/git-sparse-checkout.txt: add an
 OPTIONS section
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     bagasdotme@gmail.com, git@vger.kernel.org, newren@gmail.com,
        vdye@github.com
References: <20220311132141.1817-1-shaoxuan.yuan02@gmail.com>
 <20220314065659.82029-1-shaoxuan.yuan02@gmail.com>
 <20220314065659.82029-2-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220314065659.82029-2-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/14/2022 2:56 AM, Shaoxuan Yuan wrote:
> Add an OPTIONS section to the manual and move the descriptions about
> these options from COMMANDS to the section.
> 
> Helped-by: Derrick Stolee <derrickstolee@github.com>
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>

Thank you for reorganizing the COMMANDS and OPTIONS. I still think
there is some improvement to be made here.

>  the 'set' subcommand are stored in the worktree-specific sparse-checkout
>  file. See linkgit:git-worktree[1] and the documentation of
>  `extensions.worktreeConfig` in linkgit:git-config[1] for more details.

Just to provide some extra context to the review, here is the content
of the 'set' command up to this point:

'set'::
	Enable the necessary sparse-checkout config settings
	(`core.sparseCheckout`, `core.sparseCheckoutCone`, and
	`index.sparse`) if they are not already set to the desired values,
	populate the sparse-checkout file from the list of arguments
	following the 'set' subcommand, and update the working directory to
	match.
+
To ensure that adjusting the sparse-checkout settings within a worktree
does not alter the sparse-checkout settings in other worktrees, the 'set'
subcommand will upgrade your repository config to use worktree-specific
config if not already present. The sparsity defined by the arguments to
the 'set' subcommand are stored in the worktree-specific sparse-checkout
file. See linkgit:git-worktree[1] and the documentation of
`extensions.worktreeConfig` in linkgit:git-config[1] for more details.


So this mentions that we will "write a set of patterns to the
sparse-checkout file from the list of arguments" but with the
deletions below we lose understanding of how the arguments match with
the patterns.

I think it would be good to insert a paragraph between the two above
paragraphs that briefly touches on the input. Something like:

  By default, the arguments to the `set` command are interpreted as a
  list of directories. The sparse-checkout patterns are set to match
  all files within those directories, recursively, as well as any file
  directly contained in a parent of those directories. See INTERNALS
  -- CONE PATTERN SET below for full details. If --no-cone is specified,
  then the arguments are interpreted as sparse-checkout patterns. See
  INTERNALS -- FULL PATTERN SET below for more information.

We might need to refer to the `set` command input when talking about
the `add` command.

>  'add'::
>  	Update the sparse-checkout file to include additional directories
> @@ -109,11 +71,6 @@ interact with your repository until it is disabled.
>  	cases, it can make sense to run `git sparse-checkout reapply` later
>  	after cleaning up affected paths (e.g. resolving conflicts, undoing
>  	or committing changes, etc.).
> -+
> -The `reapply` command can also take `--[no-]cone` and `--[no-]sparse-index`
> -flags, with the same meaning as the flags from the `set` command, in order
> -to change which sparsity mode you are using without needing to also respecify
> -all sparsity paths.
>  
>  'disable'::
>  	Disable the `core.sparseCheckout` config setting, and restore the
> @@ -139,6 +96,69 @@ paths to pass to a subsequent 'set' or 'add' command.  However,
>  the disable command, so the easy restore of calling a plain `init`
>  decreased in utility.
>  
> +
> +OPTIONS
> +-------
> +'--[no-]cone'::
> +	Use with the `set` and `reapply` commands.
> +	Specify using cone mode or not. The default is to use cone mode.
> ++
> +For `set` command:
> ++
> +By default, the input list is considered a list of directories, matching
> +the output of `git ls-tree -d --name-only`.  This includes interpreting
> +pathnames that begin with a double quote (") as C-style quoted strings.
> +Note that all files under the specified directories (at any depth) will
> +be included in the sparse checkout, as well as files that are siblings
> +of either the given directory or any of its ancestors (see 'CONE PATTERN
> +SET' below for more details).  In the past, this was not the default,
> +and `--cone` needed to be specified or `core.sparseCheckoutCone` needed
> +to be enabled.
> ++
> +When `--no-cone` is passed, the input list is considered a list of
> +patterns.  This mode is harder to use, and unless you can keep the
> +number of patterns small, its design also scales poorly.  It used to be
> +the default mode, but we do not recommend using it.  It does not work
> +with the `--sparse-index` option, and will likely be incompatible with
> +other new features as they are added.  See the "Non-cone Problems"
> +section below and the "Sparse Checkout" section of
> +linkgit:git-read-tree[1] for more details.
> ++

With the recommended change above, this pair of paragraphs can be
condensed. Something like...

  For the `set` command, the option to use cone mode or not changes
  the interpretation of the remaining arguments to either be a list
  of directories or a list of patterns.

> +For `reapply` command:
> ++
> +The `reapply` command can also take `--[no-]cone` and `--[no-]sparse-index`
> +flags, with the same meaning as the flags from the `set` command, in order
> +to change which sparsity mode you are using without needing to also respecify
> +all sparsity paths.

I'm not sure that this mention of `reapply` is necessary, as those
options document themselves further down.

> +
> +'--[no-]sparse-index'::
> +	Use with the `set` and `reapply` commands.
> +	Specify using a sparse index or not. The default is to not use a
> +	sparse index.
> ++
> +Use the `--[no-]sparse-index` option to use a sparse index (the
> +default is to not use it).  A sparse index reduces the size of the
> +index to be more closely aligned with your sparse-checkout
> +definition. This can have significant performance advantages for
> +commands such as `git status` or `git add`.  This feature is still
> +experimental. Some commands might be slower with a sparse index until
> +they are properly integrated with the feature.
> ++
> +**WARNING:** Using a sparse index requires modifying the index in a way
> +that is not completely understood by external tools. If you have trouble
> +with this compatibility, then run `git sparse-checkout init --no-sparse-index`
> +to rewrite your index to not be sparse. Older versions of Git will not
> +understand the sparse directory entries index extension and may fail to
> +interact with your repository until it is disabled.
> +
> +'--stdin'::
> +	Use with the `set` and `add` commands.
> ++
> +When the `--stdin` option is provided, the directories or patterns are
> +read from standard in as a newline-delimited list instead of from the
> +arguments.

These options are excellent.

Thanks,
-Stolee

