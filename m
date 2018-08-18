Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8C841F954
	for <e@80x24.org>; Sat, 18 Aug 2018 16:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeHRT7Z (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 15:59:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41913 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeHRT7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 15:59:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id z96-v6so908316wrb.8
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 09:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+C8iKnf7jj8SinbApIcYpu2Sry8HiG+WzlLK76uTbq4=;
        b=db7AQmn3UZXm7K4hs7FbU+wlvp0qqNLCKp0B9UloNbH8tfwjIN6mM/XUjdSS7NENbH
         PVBbZlDbghdEf0MLaPvVP5cxb+7kxCiaM8HXpGDFSfhfI7zUT3ZI5txCbOhBQVQqaHRc
         o6v5EXeb6NIHd5CibW8mXi7+YVYjY7JcW+u1Ql6HmYSzEnl3Phv6X+mj4bPhYXl33W7S
         u+OAKLtE7M4erduBZv3JH3iS7MCvY9OZaoXXtAxaeWQRyl5YriM6+OmX07RAOzSCBT32
         98SDm6kA7fxSLG15PZiuGf1rgrenWJBM2gg+mQdLpLtnjXNMoL1bt1wEpmciF6yZGPWn
         INdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+C8iKnf7jj8SinbApIcYpu2Sry8HiG+WzlLK76uTbq4=;
        b=UAAwAYIij3GnOgsxQ8OhO0zEFbIgtNePNSgXQp9dL6UnMFys2v6N5rJkvJCLKHGcM5
         JDQOWLCeXceTYfZQetEi7B08SdsdQHPG8todEkzviSToxRf6Hpt9ytD8fxB8sdmMK7Fz
         DWGcURzHnO9zM7tqNelm5a15dsrC2/8Vk4zJCY8fzx4/+mWGSNSwRKH4avMpoqmo66KY
         kos9Ozvamw4c+NrWxcpg8rrEt8RtA/TrblT4GuI8z92GAOyns4iPP8eelmm7xdFepNOD
         xa3fC008XN9y7fnDiKPPKMBa2IzcTZSvhsuyKQH3TBbSFG4UeG/S5iY7c8zKZ4RUKZgR
         0olQ==
X-Gm-Message-State: APzg51D6tdFo4C+2qqeHoIt9ccRM4phFdVPQXVbkiJUFxHN9pO3IYVLq
        pePQJDUXnadNM83gET6SaMzMxEpQ
X-Google-Smtp-Source: ANB0VdYkD4C/pqWdAeKvHWW2UAFNxTDdN/e7XajF3PI15le5/dJWJEGJQZYxD1AZwItixzLb6jqP2w==
X-Received: by 2002:adf:f187:: with SMTP id h7-v6mr1236173wro.214.1534611064078;
        Sat, 18 Aug 2018 09:51:04 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id m68-v6sm16250651wmb.10.2018.08.18.09.51.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 09:51:03 -0700 (PDT)
Date:   Sat, 18 Aug 2018 17:51:02 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v7 23/26] stash: convert `stash--helper.c` into
 `stash.c`
Message-ID: <20180818165102.GF11326@hank.intra.tgummerer.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <c659174b1be950072580ee176d59f85574cdb96c.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c659174b1be950072580ee176d59f85574cdb96c.1533753605.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08, Paul-Sebastian Ungureanu wrote:
> The old shell script `git-stash.sh`  was removed and replaced
> entirely by `builtin/stash.c`. In order to do that, `create` and
> `push` were adapted to work without `stash.sh`. For example, before
> this commit, `git stash create` called `git stash--helper create
> --message "$*"`. If it called `git stash--helper create "$@"`, then
> some of these changes wouldn't have been necessary.
> 
> This commit also removes the word `helper` since now stash is
> called directly and not by a shell script.
> ---
>  .gitignore                           |   1 -
>  Makefile                             |   3 +-
>  builtin.h                            |   2 +-
>  builtin/{stash--helper.c => stash.c} | 132 ++++++++++++-----------
>  git-stash.sh                         | 153 ---------------------------
>  git.c                                |   2 +-
>  6 files changed, 74 insertions(+), 219 deletions(-)
>  rename builtin/{stash--helper.c => stash.c} (91%)
>  delete mode 100755 git-stash.sh
> 
> diff --git a/builtin/stash--helper.c b/builtin/stash.c
> similarity index 91%
> rename from builtin/stash--helper.c
> rename to builtin/stash.c
> index f54a476e3..0ef88408a 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash.c
>
> [...]
>
> @@ -1445,9 +1448,10 @@ static int push_stash(int argc, const char **argv, const char *prefix)
>  		OPT_END()
>  	};
>  
> -	argc = parse_options(argc, argv, prefix, options,
> -			     git_stash_helper_push_usage,
> -			     0);
> +	if (argc)
> +		argc = parse_options(argc, argv, prefix, options,
> +				     git_stash_push_usage,
> +				     0);

This change is a bit surprising here.  Why is this necessary?  I
thought parse_options would handle no arguments just fine?

>  	return do_push_stash(argc, argv, prefix, keep_index, patch_mode,
>  			     include_untracked, quiet, stash_msg);
> @@ -1479,7 +1483,7 @@ static int save_stash(int argc, const char **argv, const char *prefix)
>  	};
>  
>  	argc = parse_options(argc, argv, prefix, options,
> -			     git_stash_helper_save_usage,
> +			     git_stash_save_usage,
>  			     0);
>  
>  	for (i = 0; i < argc; ++i)
> @@ -1491,7 +1495,7 @@ static int save_stash(int argc, const char **argv, const char *prefix)
>  			     include_untracked, quiet, stash_msg);
>  }
>  
> -int cmd_stash__helper(int argc, const char **argv, const char *prefix)
> +int cmd_stash(int argc, const char **argv, const char *prefix)
>  {
>  	pid_t pid = getpid();
>  	const char *index_file;
> @@ -1502,16 +1506,16 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  
>  	git_config(git_default_config, NULL);
>  
> -	argc = parse_options(argc, argv, prefix, options, git_stash_helper_usage,
> +	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
>  			     PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
>  
>  	index_file = get_index_file();
>  	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
>  		    (uintmax_t)pid);
>  
> -	if (argc < 1)
> -		usage_with_options(git_stash_helper_usage, options);
> -	if (!strcmp(argv[0], "apply"))
> +	if (argc == 0)
> +		return !!push_stash(0, NULL, prefix);
> +	else if (!strcmp(argv[0], "apply"))
>  		return !!apply_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "clear"))
>  		return !!clear_stash(argc, argv, prefix);
> @@ -1533,7 +1537,13 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  		return !!push_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "save"))
>  		return !!save_stash(argc, argv, prefix);
> +	if (*argv[0] == '-') {
> +		struct argv_array args = ARGV_ARRAY_INIT;
> +		argv_array_push(&args, "push");
> +		argv_array_pushv(&args, argv);
> +		return !!push_stash(args.argc, args.argv, prefix);
> +	}

This is a bit different than what the current code does.  Currently
the rules for when a plain 'git stash' becomes 'git stash push' are
the following:

- If there are no arguments.
- If all arguments are option arguments.
- If the first argument of 'git stash' is '-p'.
- If the first argument of 'git stash' is '--'.

This is to avoid someone typing 'git stash -q drop' for example, and
then being surprised that a new stash was created instead of an old
one being dropped, which what we have above would do.

For more reasoning about these aliasing rules see also the thread at [1].

[1]: https://public-inbox.org/git/20170213200950.m3bcyp52wd25p737@sigill.intra.peff.net/

>  
>  	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
> -		      git_stash_helper_usage, options);
> +		      git_stash_usage, options);
>  }
> diff --git a/git-stash.sh b/git-stash.sh
> deleted file mode 100755
> index 695f1feba..000000000
> --- a/git-stash.sh
> +++ /dev/null
> @@ -1,153 +0,0 @@
>
> [...]
