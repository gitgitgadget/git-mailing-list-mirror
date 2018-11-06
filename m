Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D61E71F453
	for <e@80x24.org>; Tue,  6 Nov 2018 02:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeKFLZD (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 06:25:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35390 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeKFLZD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 06:25:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id z16-v6so11692812wrv.2
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 18:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=OlwafW41TdmsjEJjQc48XHnsmAyBVkjwjmoX+o81+9c=;
        b=OTrYfJK486RBgD2sqfkueB+4/CA4z1lj76b1Ttriikb+TXqQOSNfIaVQ5VSh221GY+
         0Y9Vsx7cl6maLon/kYB1Dzhqf4GUhg7x99qrLGh28CA+GjDVn0pBmvM5cvsmY7dU98iq
         M3K9EJUJzbqwCtoajVacWfhET5UWag0VK3HJmFupP8HENDdNibNik/2NcL17T6epDrRh
         AAPmauEwt0zW+cvNEN9iCfGgi56hYE+VQS4w2cY7MwHzV5ngEf8h0hg+mHz8Cz+V4S7s
         FEJh6qrMWIHEw90F92T00MFIf1EuhplhkzAwtmKrtOkdxDaRa+TUfOdMneIOTQ0QTnF4
         t3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=OlwafW41TdmsjEJjQc48XHnsmAyBVkjwjmoX+o81+9c=;
        b=i+R3Fao8U0SesUMQAtUGueu9B36D3Y0Bdj+LLtYmXtlvBAfv9+myW/bLHS2VN2Lah4
         HHeDr8Kzld3BK7qhOvqDO2L17hx9DvTrhgy4UgFt6JDZtEMQ0F4P0ViwzOt3baVzh2uT
         7eFs99RXvfs2DoJ85FtopvtN6ft6KK4/DZ/FXXcZaPCpDSwN1mFqOZBnghb8L7WSzDBJ
         ORbKGIdLGqu0bfzF2SRgbjQvJhkh19Vk18yfvMZjeHQW4h/6MFibzPnt8EvICnUwunE1
         c0yziWrr8t/FJv5UPlX7ivAWnLAd/J++Io79Od04xP00ufjDL4jK+Jm6Md5o19ZBhtMi
         c1Rg==
X-Gm-Message-State: AGRZ1gLDtSI1mtfpHSDHNeH1+U/c12vFFI3PwI3+pQL/+xAETcjVdJ3U
        bz/0ONIx/GdO9NesKW0ZwZU=
X-Google-Smtp-Source: AJdET5c1AlRBFBOg2qf4Ha+Q182WgfM5yzQ5Q8zj19fUN2UebwXq7nXxjgwjMYwmr3GOd9xVtdljSw==
X-Received: by 2002:adf:80ab:: with SMTP id 40-v6mr4090044wrl.158.1541469736890;
        Mon, 05 Nov 2018 18:02:16 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o130-v6sm568937wmd.11.2018.11.05.18.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 18:02:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 01/16] git.c: mark more strings for translation
References: <20181028065157.26727-1-pclouds@gmail.com>
        <20181105192059.20303-1-pclouds@gmail.com>
        <20181105192059.20303-2-pclouds@gmail.com>
Date:   Tue, 06 Nov 2018 11:02:15 +0900
In-Reply-To: <20181105192059.20303-2-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 5 Nov 2018 20:20:44 +0100")
Message-ID: <xmqqftwfgdzs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> One string is slightly updated to keep consistency with the rest:
> die() should with lowercase.

s/should/& begin/, I think, in which case I could locally touch up.


>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  git.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/git.c b/git.c
> index adac132956..5fd30da093 100644
> --- a/git.c
> +++ b/git.c
> @@ -338,27 +338,27 @@ static int handle_alias(int *argcp, const char ***argv)
>  			if (ret >= 0)   /* normal exit */
>  				exit(ret);
>  
> -			die_errno("while expanding alias '%s': '%s'",
> -			    alias_command, alias_string + 1);
> +			die_errno(_("while expanding alias '%s': '%s'"),
> +				  alias_command, alias_string + 1);
>  		}
>  		count = split_cmdline(alias_string, &new_argv);
>  		if (count < 0)
> -			die("Bad alias.%s string: %s", alias_command,
> +			die(_("bad alias.%s string: %s"), alias_command,
>  			    split_cmdline_strerror(count));
>  		option_count = handle_options(&new_argv, &count, &envchanged);
>  		if (envchanged)
> -			die("alias '%s' changes environment variables.\n"
> -				 "You can use '!git' in the alias to do this",
> -				 alias_command);
> +			die(_("alias '%s' changes environment variables.\n"
> +			      "You can use '!git' in the alias to do this"),
> +			    alias_command);
>  		memmove(new_argv - option_count, new_argv,
>  				count * sizeof(char *));
>  		new_argv -= option_count;
>  
>  		if (count < 1)
> -			die("empty alias for %s", alias_command);
> +			die(_("empty alias for %s"), alias_command);
>  
>  		if (!strcmp(alias_command, new_argv[0]))
> -			die("recursive alias: %s", alias_command);
> +			die(_("recursive alias: %s"), alias_command);
>  
>  		trace_argv_printf(new_argv,
>  				  "trace: alias expansion: %s =>",
> @@ -409,7 +409,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>  
>  	if (!help && get_super_prefix()) {
>  		if (!(p->option & SUPPORT_SUPER_PREFIX))
> -			die("%s doesn't support --super-prefix", p->cmd);
> +			die(_("%s doesn't support --super-prefix"), p->cmd);
>  	}
>  
>  	if (!help && p->option & NEED_WORK_TREE)
> @@ -433,11 +433,11 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>  
>  	/* Check for ENOSPC and EIO errors.. */
>  	if (fflush(stdout))
> -		die_errno("write failure on standard output");
> +		die_errno(_("write failure on standard output"));
>  	if (ferror(stdout))
> -		die("unknown write failure on standard output");
> +		die(_("unknown write failure on standard output"));
>  	if (fclose(stdout))
> -		die_errno("close failed on standard output");
> +		die_errno(_("close failed on standard output"));
>  	return 0;
>  }
>  
> @@ -648,7 +648,7 @@ static void execv_dashed_external(const char **argv)
>  	int status;
>  
>  	if (get_super_prefix())
> -		die("%s doesn't support --super-prefix", argv[0]);
> +		die(_("%s doesn't support --super-prefix"), argv[0]);
>  
>  	if (use_pager == -1 && !is_builtin(argv[0]))
>  		use_pager = check_pager_config(argv[0]);
> @@ -760,7 +760,7 @@ int cmd_main(int argc, const char **argv)
>  	if (skip_prefix(cmd, "git-", &cmd)) {
>  		argv[0] = cmd;
>  		handle_builtin(argc, argv);
> -		die("cannot handle %s as a builtin", cmd);
> +		die(_("cannot handle %s as a builtin"), cmd);
>  	}
>  
>  	/* Look for flags.. */
> @@ -773,7 +773,7 @@ int cmd_main(int argc, const char **argv)
>  	} else {
>  		/* The user didn't specify a command; give them help */
>  		commit_pager_choice();
> -		printf("usage: %s\n\n", git_usage_string);
> +		printf(_("usage: %s\n\n"), git_usage_string);
>  		list_common_cmds_help();
>  		printf("\n%s\n", _(git_more_info_string));
>  		exit(1);
