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
	by dcvr.yhbt.net (Postfix) with ESMTP id E8A3A1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 11:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbfHHL30 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 07:29:26 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:37915 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbfHHL30 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 07:29:26 -0400
Received: by mail-wm1-f52.google.com with SMTP id s15so2049531wmj.3
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 04:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WTJti960Pk3aALhNNDf/WohXbgRllY5Olu7L0BB69EI=;
        b=qK7VmcWE9vmW5cb9qwenStn9oByw+PpV5gWMy6D9pHIc/JtVJ5s75NODRT76z+OHet
         zUZxgnUiJF6695bDkSMuGQ8UlPSU7/mvGfCnLwEWpRghXMuhQiSvyHDOFWNvWJpOqHOh
         Y4v7354Nypwrg9eNKTTeHZ+BTEkD2Q7CmvBe+YpeCobHRWonAIfIoCECtBBhNV8b38KL
         ml2bOGCdJD+L9zx9YRPJt/xBOK23oUWQDI34zqLnNzt/4SMba2K52VI4XlnNRRR7uSI8
         4z004yVccI0S4y4xFuNE2s0dM1DamKfx7s4awcbXpGVqx5QP+8fJAKrwvAFQY4So+TVE
         BZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WTJti960Pk3aALhNNDf/WohXbgRllY5Olu7L0BB69EI=;
        b=DqTltCGcy2fjiD9yz7sscETY7OXPwKfon47bEsyDPJ/D26QCwpD8EgqywKJ2pevJ6D
         jSjAzNmxenUGjktN2QDvfgjrlocE6uQlc4793PWmzpM7RTzfeUBcqtIebxKBbX3IMlBp
         6iN+xWvXh88K8V7AqP/CvT58ZxwHy3md7bmnJE9w1im1xLtCmPKb5hwi99GiIJyh0nNA
         2jmcyRGcPdZmM4ipMne2Y25oTUgK7nxCbnfToxvU4eBKvIwZD/YaKgDNPloZOUG9YHwe
         B1hVr3BfmT8/yo/gndilODBuV2/fgXtlftQoWR3fYGaZFYdiCFvp84pOQf6LeuO/h72z
         hfNg==
X-Gm-Message-State: APjAAAUs8KqS+Isy77bB+9ulqa+Ec+adMbHqBegTINdcwSgUP8QT5YE+
        dsbKXWhBoCR1WLmW9iBw8wI=
X-Google-Smtp-Source: APXvYqx/BxhqZbvwZgoJzQS7Fum2zgdvcjP65O+cDHccCP5e3aXa/T5yHD3fLeGPv8sA9Nle0/INXA==
X-Received: by 2002:a1c:343:: with SMTP id 64mr1189974wmd.0.1565263762462;
        Thu, 08 Aug 2019 04:29:22 -0700 (PDT)
Received: from [192.168.1.18] (host-78-148-43-8.as13285.net. [78.148.43.8])
        by smtp.gmail.com with ESMTPSA id 66sm15378656wrc.83.2019.08.08.04.29.21
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 04:29:21 -0700 (PDT)
Subject: Re: [GSoC][PATCHl 3/6] rebase -i: support
 --committer-date-is-author-date
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Junio <gitster@pobox.com>, GIT Mailing List <git@vger.kernel.org>
Cc:     Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>,
        Dscho <Johannes.Schindelin@gmx.de>,
        Martin <martin.agren@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190806173638.17510-4-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <e2ce49a2-3681-23a8-baad-5dfcea7cbe77@gmail.com>
Date:   Thu, 8 Aug 2019 12:29:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806173638.17510-4-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-HK
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

On 06/08/2019 18:36, Rohit Ashiwal wrote:
> rebase am already has this flag to "lie" about the committer date
> by changing it to the author date. Let's add the same for
> interactive machinery.
> 
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
>   Documentation/git-rebase.txt            |  8 +++-
>   builtin/rebase.c                        | 20 +++++++---
>   sequencer.c                             | 52 ++++++++++++++++++++++++-
>   sequencer.h                             |  1 +
>   t/t3422-rebase-incompatible-options.sh  |  1 -
>   t/t3433-rebase-options-compatibility.sh | 19 +++++++++
>   6 files changed, 91 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 85404fea52..83c5bbe06c 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -383,8 +383,12 @@ default is `--no-fork-point`, otherwise the default is `--fork-point`.
>   See also INCOMPATIBLE OPTIONS below.
>   
>   --committer-date-is-author-date::
> +	Instead of recording the time the rebased commits are
> +	created as the committer date, reuse the author date
> +	as the committer date. This implies --force-rebase.
> +
>   --ignore-date::
> -	These flags are passed to 'git am' to easily change the dates
> +	This flag is passed to 'git am' to change the author date
>   	of the rebased commits (see linkgit:git-am[1]).
>   +
>   See also INCOMPATIBLE OPTIONS below.
> @@ -522,7 +526,6 @@ INCOMPATIBLE OPTIONS
>   
>   The following options:
>   
> - * --committer-date-is-author-date
>    * --ignore-date
>    * --whitespace
>    * -C
> @@ -548,6 +551,7 @@ In addition, the following pairs of options are incompatible:
>    * --preserve-merges and --signoff
>    * --preserve-merges and --rebase-merges
>    * --preserve-merges and --ignore-whitespace
> + * --preserve-merges and --committer-date-is-author-date
>    * --rebase-merges and --ignore-whitespace
>    * --rebase-merges and --strategy
>    * --rebase-merges and --strategy-option
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 3c195ddc73..41fe9ebff8 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -82,6 +82,7 @@ struct rebase_options {
>   	int ignore_whitespace;
>   	char *gpg_sign_opt;
>   	int autostash;
> +	int committer_date_is_author_date;
>   	char *cmd;
>   	int allow_empty_message;
>   	int rebase_merges, rebase_cousins;
> @@ -113,6 +114,8 @@ static struct replay_opts get_replay_opts(struct rebase_options *opts)
>   	replay.allow_empty_message = opts->allow_empty_message;
>   	replay.verbose = opts->flags & REBASE_VERBOSE;
>   	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
> +	replay.committer_date_is_author_date =
> +					opts->committer_date_is_author_date;
>   	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
>   	replay.strategy = opts->strategy;
>   
> @@ -532,6 +535,9 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>   		warning(_("--[no-]rebase-cousins has no effect without "
>   			  "--rebase-merges"));
>   
> +	if (opts.committer_date_is_author_date)
> +		opts.flags |= REBASE_FORCE;
> +
>   	return !!run_rebase_interactive(&opts, command);
>   }
>   
> @@ -970,6 +976,8 @@ static int run_am(struct rebase_options *opts)
>   
>   	if (opts->ignore_whitespace)
>   		argv_array_push(&am.args, "--ignore-whitespace");
> +	if (opts->committer_date_is_author_date)
> +		argv_array_push(&opts->git_am_opts, "--committer-date-is-author-date");
>   	if (opts->action && !strcmp("continue", opts->action)) {
>   		argv_array_push(&am.args, "--resolved");
>   		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
> @@ -1417,9 +1425,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
>   		OPT_BOOL(0, "signoff", &options.signoff,
>   			 N_("add a Signed-off-by: line to each commit")),
> -		OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
> -				  &options.git_am_opts, NULL,
> -				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
> +		OPT_BOOL(0, "committer-date-is-author-date",
> +			 &options.committer_date_is_author_date,
> +			 N_("make committer date match author date")),
>   		OPT_PASSTHRU_ARGV(0, "ignore-date", &options.git_am_opts, NULL,
>   				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
>   		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
> @@ -1686,10 +1694,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		    state_dir_base, cmd_live_rebase, buf.buf);
>   	}
>   
> +	if (options.committer_date_is_author_date)
> +		options.flags |= REBASE_FORCE;
> +
>   	for (i = 0; i < options.git_am_opts.argc; i++) {
>   		const char *option = options.git_am_opts.argv[i], *p;
> -		if (!strcmp(option, "--committer-date-is-author-date") ||
> -		    !strcmp(option, "--ignore-date") ||
> +		if (!strcmp(option, "--ignore-date") ||
>   		    !strcmp(option, "--whitespace=fix") ||
>   		    !strcmp(option, "--whitespace=strip"))
>   			options.flags |= REBASE_FORCE;
> diff --git a/sequencer.c b/sequencer.c
> index a2d7b0925e..65adf79222 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -147,6 +147,7 @@ static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
>    * command-line.
>    */
>   static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
> +static GIT_PATH_FUNC(rebase_path_cdate_is_adate, "rebase-merge/cdate_is_adate")
>   static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
>   static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
>   static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
> @@ -876,6 +877,17 @@ static char *get_author(const char *message)
>   	return NULL;
>   }
>   
> +/* Returns a "date" string that needs to be free()'d by the caller */
> +static char *read_author_date_or_null(void)
> +{
> +	char *date;
> +
> +	if (read_author_script(rebase_path_author_script(),
> +			       NULL, NULL, &date, 0))
> +		return NULL;
> +	return date;
> +}
> +
>   /* Read author-script and return an ident line (author <email> timestamp) */
>   static const char *read_author_ident(struct strbuf *buf)
>   {
> @@ -904,6 +916,18 @@ static const char *read_author_ident(struct strbuf *buf)
>   	return buf->buf;
>   }
>   
> +static int setenv_committer_date_to_author_date(void)
> +{
> +	int res = 1;

In the git codebase it is conventional to return -1 for an error

> +	char *date = read_author_date_or_null();
> +
> +	if (date)
> +		res = setenv("GIT_COMMITTER_DATE", date, 1);
> +
> +	free(date);
> +	return res;
> +}
> +
>   static const char staged_changes_advice[] =
>   N_("you have staged changes in your working tree\n"
>   "If these changes are meant to be squashed into the previous commit, run:\n"
> @@ -961,6 +985,9 @@ static int run_git_commit(struct repository *r,
>   {
>   	struct child_process cmd = CHILD_PROCESS_INIT;
>   
> +	if (opts->committer_date_is_author_date &&
> +	    setenv_committer_date_to_author_date())
> +		return 1;

-1 for errors please, as seen in the surrounding code.

>   	if ((flags & CREATE_ROOT_COMMIT) && !(flags & AMEND_MSG)) {
>   		struct strbuf msg = STRBUF_INIT, script = STRBUF_INIT;
>   		const char *author = NULL;
> @@ -1397,7 +1424,9 @@ static int try_to_commit(struct repository *r,
>   
>   	if (parse_head(r, &current_head))
>   		return -1;
> -
> +	if (!(flags & AMEND_MSG) && opts->committer_date_is_author_date &&
> +	    setenv_committer_date_to_author_date())
> +		return -1;

I think it would be better to handle committer_date_is_author_date in a 
single place in this function, not have two implementations one of which 
is untested as shown in Stolee's latest test email. This function 
receives the author as a string so it should work with the author string 
once we have checked for amend.

>   	if (flags & AMEND_MSG) {
>   		const char *exclude_gpgsig[] = { "gpgsig", NULL };
>   		const char *out_enc = get_commit_output_encoding();
> @@ -1418,6 +1447,17 @@ static int try_to_commit(struct repository *r,
>   			res = error(_("unable to parse commit author"));
>   			goto out;
>   		}
> +		if (opts->committer_date_is_author_date) {
> +			char *date;
> +			int len = strlen(author);
> +			char *idx = memchr(author, '>', len);

what happens if there is a corrupted author without an email?  - We end 
up with undefined behavior.

> +
> +			++idx;
> +			date = malloc(author + len - idx);
> +			memcpy(date, idx, author + len - idx);
> +			setenv("GIT_COMMITTER_DATE", date, 1);
> +			free(date);

git has a high level api for manipulation author/committer information 
in ident.c, it would be best to use that. In any case code like this 
should be using strbuf's rather than malloc

> +		}
>   		parents = copy_commit_list(current_head->parents);
>   		extra = read_commit_extra_headers(current_head, exclude_gpgsig);
>   	} else if (current_head) {

Do the committer_date_is_author_date check after the end of this if.

Best Wishes

Phillip

> @@ -2538,6 +2578,11 @@ static int read_populate_opts(struct replay_opts *opts)
>   			opts->signoff = 1;
>   		}
>   
> +		if (file_exists(rebase_path_cdate_is_adate())) {
> +			opts->allow_ff = 0;
> +			opts->committer_date_is_author_date = 1;
> +		}
> +
>   		if (file_exists(rebase_path_reschedule_failed_exec()))
>   			opts->reschedule_failed_exec = 1;
>   
> @@ -2620,6 +2665,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
>   		write_file(rebase_path_gpg_sign_opt(), "-S%s\n", opts->gpg_sign);
>   	if (opts->signoff)
>   		write_file(rebase_path_signoff(), "--signoff\n");
> +	if (opts->committer_date_is_author_date)
> +		write_file(rebase_path_cdate_is_adate(), "%s", "");
>   	if (opts->reschedule_failed_exec)
>   		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
>   
> @@ -3708,7 +3755,8 @@ static int pick_commits(struct repository *r,
>   	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
>   	if (opts->allow_ff)
>   		assert(!(opts->signoff || opts->no_commit ||
> -				opts->record_origin || opts->edit));
> +				opts->record_origin || opts->edit ||
> +				opts->committer_date_is_author_date));
>   	if (read_and_refresh_cache(r, opts))
>   		return -1;
>   
> diff --git a/sequencer.h b/sequencer.h
> index 0c494b83d4..e6cba468db 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -43,6 +43,7 @@ struct replay_opts {
>   	int verbose;
>   	int quiet;
>   	int reschedule_failed_exec;
> +	int committer_date_is_author_date;
>   
>   	int mainline;
>   
> diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
> index 4342f79eea..7402f7e3da 100755
> --- a/t/t3422-rebase-incompatible-options.sh
> +++ b/t/t3422-rebase-incompatible-options.sh
> @@ -61,7 +61,6 @@ test_rebase_am_only () {
>   }
>   
>   test_rebase_am_only --whitespace=fix
> -test_rebase_am_only --committer-date-is-author-date
>   test_rebase_am_only -C4
>   
>   test_expect_success REBASE_P '--preserve-merges incompatible with --signoff' '
> diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
> index e617d3150e..ceab48a831 100755
> --- a/t/t3433-rebase-options-compatibility.sh
> +++ b/t/t3433-rebase-options-compatibility.sh
> @@ -7,6 +7,9 @@ test_description='tests to ensure compatibility between am and interactive backe
>   
>   . ./test-lib.sh
>   
> +GIT_AUTHOR_DATE="1999-04-02T08:03:20+05:30"
> +export GIT_AUTHOR_DATE
> +
>   # This is a special case in which both am and interactive backends
>   # provide the same output. It was done intentionally because
>   # both the backends fall short of optimal behaviour.
> @@ -62,4 +65,20 @@ test_expect_success '--ignore-whitespace works with interactive backend' '
>   	test_cmp expect file
>   '
>   
> +test_expect_success '--committer-date-is-author-date works with am backend' '
> +	git rebase -f HEAD^ &&
> +	git rebase --committer-date-is-author-date HEAD^ &&
> +	git show HEAD --pretty="format:%at" >authortime &&
> +	git show HEAD --pretty="format:%ct" >committertime &&
> +	test_cmp authortime committertime
> +'
> +
> +test_expect_success '--committer-date-is-author-date works with interactive backend' '
> +	git rebase -f HEAD^ &&
> +	git rebase -i --committer-date-is-author-date HEAD^ &&
> +	git show HEAD --pretty="format:%at" >authortime &&
> +	git show HEAD --pretty="format:%ct" >committertime &&
> +	test_cmp authortime committertime
> +'
> +
>   test_done
> 
