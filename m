Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58D161F731
	for <e@80x24.org>; Thu,  8 Aug 2019 16:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390227AbfHHQoo (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 12:44:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33119 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfHHQon (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 12:44:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id p77so4372030wme.0
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 09:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ObJfRokD+eXGWjqsY995rJw+PzoXoD3y5Nl6sLxpHCo=;
        b=EVt9MI3GzizvFy5HvvUl62iJsbVW2P3slMXcea25oACgF6EpFsTSli+yvGCeJ18xfF
         cUd8xWuwMWGqFpPYUBOA8jTGckQlwhhNsUUbmuQ+KvJUVSBfY+6Zj0tuVR2lxQ58tmPs
         E4ych/N7IH9X+NTtcrBW+XIPSo7iTKjXDRah66M79o/pEszWoiLglWWWT3VpB1terW8o
         pzMyS5AgQMWYhMX9Tu3i50jis+3YYycEHykf8iArgI3v3o5z7sR7ATDtjjouAkGMQ8MN
         uToSi5aLuZvijlIqT5fpDjvR4VoXHdRr6p8Fz48ACpSt95i7qulrzzFY4WQw3Y2bxN4B
         j+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ObJfRokD+eXGWjqsY995rJw+PzoXoD3y5Nl6sLxpHCo=;
        b=U8TIadUINbKzKrvUmPNaJq5h7bGnkero0Hl03PAUcUK6NL+yNI7C5EOlBps2ucY9/G
         mqLO0LvXdRZOvyc9DYubR1KhdEGHN3Vl9u8nMAXD++0SGARtbqeqEVE53f38scgJINDw
         dtWKPEyenfBcVSJB9bNjd1LHjJpxLyHhyc8N0puZ6rtXybOoh9xytx4n5GJplihKK9vt
         KIXEfNKZDRP7TSOaABhdi7KSzxzdCd45Oyy2CfQsEXGaYDfK+dw5D9cIg2sfT5a+FErl
         rBEbE4WzjBCujDa6iB7XZ09QQv8aScoaztDXZ4A4QubQZgQasC10xo2fBE+y0jI9kpuF
         vZvQ==
X-Gm-Message-State: APjAAAW3ytD462bEn9W6QIqlepRa37/OG2+0hv/zNOGAds4WBpyminr7
        YML41lhaHFVtqP2Nv0hq914=
X-Google-Smtp-Source: APXvYqzyXQHQG7xExlE6dtU6+8QSBVzNfOKYjftg5BjcslyTCxVUhKthQZVTy+7BlhP7fapLEXx40A==
X-Received: by 2002:a1c:4087:: with SMTP id n129mr5301847wma.3.1565282680404;
        Thu, 08 Aug 2019 09:44:40 -0700 (PDT)
Received: from [192.168.1.18] (host-78-148-43-8.as13285.net. [78.148.43.8])
        by smtp.gmail.com with ESMTPSA id g7sm5236913wmg.8.2019.08.08.09.44.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 09:44:39 -0700 (PDT)
Subject: Re: [GSoC][PATCHl 1/6] rebase -i: add --ignore-whitespace flag
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Junio <gitster@pobox.com>, GIT Mailing List <git@vger.kernel.org>
Cc:     Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>,
        Dscho <Johannes.Schindelin@gmx.de>,
        Martin <martin.agren@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190806173638.17510-2-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <bdd867f3-62d6-eec2-9562-5dbe203f49b5@gmail.com>
Date:   Thu, 8 Aug 2019 17:44:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806173638.17510-2-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-HK
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

On 06/08/2019 18:36, Rohit Ashiwal wrote:
> There are two backends available for rebasing, viz, the am and the
> interactive. Naturally, there shall be some features that are
> implemented in one but not in the other. One such flag is
> --ignore-whitespace which indicates merge mechanism to treat lines
> with only whitespace changes as unchanged. Wire the interactive
> rebase to also understand the --ignore-whitespace flag by
> translating it to -Xignore-space-change.
> 
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
>   Documentation/git-rebase.txt            | 10 +++-
>   builtin/rebase.c                        | 26 ++++++++--
>   t/t3422-rebase-incompatible-options.sh  |  1 -
>   t/t3433-rebase-options-compatibility.sh | 65 +++++++++++++++++++++++++
>   4 files changed, 95 insertions(+), 7 deletions(-)
>   create mode 100755 t/t3433-rebase-options-compatibility.sh
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 5e4e927647..85404fea52 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -371,8 +371,13 @@ If either <upstream> or --root is given on the command line, then the
>   default is `--no-fork-point`, otherwise the default is `--fork-point`.
>   
>   --ignore-whitespace::
> +	This flag is either passed to the 'git apply' program
> +	(see linkgit:git-apply[1]), or to 'git merge' program
> +	(see linkgit:git-merge[1]) as `-Xignore-space-change`,
> +	depending on which backend is selected by other options.

I think it would be better to document the effect of this option rather 
than the implementation detail. It is confusing at the moment as it 
talks about 'git merge' but we don't allow this option with merges.

> +
>   --whitespace=<option>::
> -	These flag are passed to the 'git apply' program
> +	This flag is passed to the 'git apply' program
>   	(see linkgit:git-apply[1]) that applies the patch.
>   +
>   See also INCOMPATIBLE OPTIONS below.
> @@ -520,7 +525,6 @@ The following options:
>    * --committer-date-is-author-date
>    * --ignore-date
>    * --whitespace
> - * --ignore-whitespace
>    * -C
>   
>   are incompatible with the following options:
> @@ -543,6 +547,8 @@ In addition, the following pairs of options are incompatible:
>    * --preserve-merges and --interactive
>    * --preserve-merges and --signoff
>    * --preserve-merges and --rebase-merges
> + * --preserve-merges and --ignore-whitespace
> + * --rebase-merges and --ignore-whitespace
>    * --rebase-merges and --strategy
>    * --rebase-merges and --strategy-option
>   
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index db6ca9bd7d..3c195ddc73 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -79,6 +79,7 @@ struct rebase_options {
>   	int allow_rerere_autoupdate;
>   	int keep_empty;
>   	int autosquash;
> +	int ignore_whitespace;
>   	char *gpg_sign_opt;
>   	int autostash;
>   	char *cmd;
> @@ -97,7 +98,7 @@ struct rebase_options {
>   		.git_format_patch_opt = STRBUF_INIT	\
>   	}
>   
> -static struct replay_opts get_replay_opts(const struct rebase_options *opts)
> +static struct replay_opts get_replay_opts(struct rebase_options *opts)
>   {
>   	struct replay_opts replay = REPLAY_OPTS_INIT;
>   
> @@ -114,6 +115,17 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)

It's a shame this changes the rebase_options that are passed in, this 
function should ideally not modify what is passed in.

>   	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
>   	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
>   	replay.strategy = opts->strategy;
> +
> +	if (opts->ignore_whitespace) {
> +		struct strbuf buf = STRBUF_INIT;
> +
> +		if (opts->strategy_opts)
> +			strbuf_addstr(&buf, opts->strategy_opts);
> +
> +		strbuf_addstr(&buf, " --ignore-space-change");
> +		free(opts->strategy_opts);
> +		opts->strategy_opts = strbuf_detach(&buf, NULL);
> +	}

Instead of modifying opts->strategy_opts perhaps we could just use a 
temporary variable

Best Wishes

Phillip

>   	if (opts->strategy_opts)
>   		parse_strategy_opts(&replay, opts->strategy_opts);
>   
> @@ -511,6 +523,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>   	argc = parse_options(argc, argv, NULL, options,
>   			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
>   
> +	opts.strategy_opts = xstrdup_or_null(opts.strategy_opts);
> +
>   	if (!is_null_oid(&squash_onto))
>   		opts.squash_onto = &squash_onto;
>   
> @@ -954,6 +968,8 @@ static int run_am(struct rebase_options *opts)
>   	am.git_cmd = 1;
>   	argv_array_push(&am.args, "am");
>   
> +	if (opts->ignore_whitespace)
> +		argv_array_push(&am.args, "--ignore-whitespace");
>   	if (opts->action && !strcmp("continue", opts->action)) {
>   		argv_array_push(&am.args, "--resolved");
>   		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
> @@ -1401,9 +1417,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
>   		OPT_BOOL(0, "signoff", &options.signoff,
>   			 N_("add a Signed-off-by: line to each commit")),
> -		OPT_PASSTHRU_ARGV(0, "ignore-whitespace", &options.git_am_opts,
> -				  NULL, N_("passed to 'git am'"),
> -				  PARSE_OPT_NOARG),
>   		OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
>   				  &options.git_am_opts, NULL,
>   				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
> @@ -1411,6 +1424,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
>   		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
>   				  N_("passed to 'git apply'"), 0),
> +		OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
> +			 N_("ignore changes in whitespace")),
>   		OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
>   				  N_("action"), N_("passed to 'git apply'"), 0),
>   		OPT_BIT('f', "force-rebase", &options.flags,
> @@ -1821,6 +1836,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	}
>   
>   	if (options.rebase_merges) {
> +		if (options.ignore_whitespace)
> +			die(_("cannot combine '--rebase-merges' with "
> +			      "'--ignore-whitespace'"));
>   		if (strategy_options.nr)
>   			die(_("cannot combine '--rebase-merges' with "
>   			      "'--strategy-option'"));
> diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
> index a5868ea152..4342f79eea 100755
> --- a/t/t3422-rebase-incompatible-options.sh
> +++ b/t/t3422-rebase-incompatible-options.sh
> @@ -61,7 +61,6 @@ test_rebase_am_only () {
>   }
>   
>   test_rebase_am_only --whitespace=fix
> -test_rebase_am_only --ignore-whitespace
>   test_rebase_am_only --committer-date-is-author-date
>   test_rebase_am_only -C4
>   
> diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
> new file mode 100755
> index 0000000000..e617d3150e
> --- /dev/null
> +++ b/t/t3433-rebase-options-compatibility.sh
> @@ -0,0 +1,65 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2019 Rohit Ashiwal
> +#
> +
> +test_description='tests to ensure compatibility between am and interactive backends'
> +
> +. ./test-lib.sh
> +
> +# This is a special case in which both am and interactive backends
> +# provide the same output. It was done intentionally because
> +# both the backends fall short of optimal behaviour.
> +test_expect_success 'setup' '
> +	git checkout -b topic &&
> +	q_to_tab >file <<-EOF &&
> +	line 1
> +	Qline 2
> +	line 3
> +	EOF
> +	git add file &&
> +	git commit -m "add file" &&
> +	cat >file <<-EOF &&
> +	line 1
> +	new line 2
> +	line 3
> +	EOF
> +	git commit -am "update file" &&
> +	git tag side &&
> +
> +	git checkout --orphan master &&
> +	cat >file <<-EOF &&
> +	line 1
> +	        line 2
> +	line 3
> +	EOF
> +	git add file &&
> +	git commit -m "add file" &&
> +	git tag main
> +'
> +
> +test_expect_success '--ignore-whitespace works with am backend' '
> +	cat >expect <<-EOF &&
> +	line 1
> +	new line 2
> +	line 3
> +	EOF
> +	test_must_fail git rebase main side &&
> +	git rebase --abort &&
> +	git rebase --ignore-whitespace main side &&
> +	test_cmp expect file
> +'
> +
> +test_expect_success '--ignore-whitespace works with interactive backend' '
> +	cat >expect <<-EOF &&
> +	line 1
> +	new line 2
> +	line 3
> +	EOF
> +	test_must_fail git rebase --merge main side &&
> +	git rebase --abort &&
> +	git rebase --merge --ignore-whitespace main side &&
> +	test_cmp expect file
> +'
> +
> +test_done
> 
