Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F19F20259
	for <e@80x24.org>; Wed, 23 Nov 2016 08:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933390AbcKWIWw (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 03:22:52 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34695 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932992AbcKWIWu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 03:22:50 -0500
Received: by mail-pg0-f66.google.com with SMTP id e9so569729pgc.1
        for <git@vger.kernel.org>; Wed, 23 Nov 2016 00:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ah/r/crQ1/PZl1JFAz5ayl3qscS+HOvsdBFdFzua/a0=;
        b=luN88GVaMgB7y16Kl9KdlHakr23PEtRXopmPo1rxL1iXsK0OFoa9DkxBhblwUlbcV1
         kWMOYKLgoqxkemKWVspoQ7SlUH7faLhtKig43FRAiz4CWxr/wArQODVpBMn6HyhOkKh2
         h32bAMOBluD3/Ay0Qh4V+op4e+x4AW4onIru5yNyNzn2BnOCJUxkZyCzy6IOprs4uGX5
         lb6FmTw6jCu3SZh8JNd2cj5Etz3E9TmgwzOgoueQctFNeSeenIoTkHJAP0qbeTtgfPdB
         WQlA5izGofb9vPi6WlI6O4o//gpl6c8WsjBC3d4fwWOjygAQ4tBak8hcvo02dnuBLH7t
         9OtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ah/r/crQ1/PZl1JFAz5ayl3qscS+HOvsdBFdFzua/a0=;
        b=TE8lPCuCA9/jBwdU66Bhd/H4zW+EQyJXNphOq72h4wbpZAGhe+8Iwzb4Oa3tBzHZcD
         ArDryR4qw5eYT/MntGyffiZBvYtXkKwkQuEStU1sgU/roGOjQ7PBMjyo6JxTXbPyK8u9
         we3lKye37dRs5PFvA/K8zSVkwD1+/JE3AJe+UxAbaSxVqwczT1zSbWoZUrIiwAZVOA1y
         zOa0nrsb4hKFyLtzmNyvhThO7129hMo28Wkf7lwot+DaVNXeVRzar822V3Yx9kILlIdv
         N7eTcZKrwnRyIJ7j7tlmWWiHrjIZmfYiIUte8Zp9jxBdHXeh+MnF/Tv7hoH82fCpWd8p
         U4lw==
X-Gm-Message-State: AKaTC001jX+wJNLNlpRPChAQ62BfbphOVjQOeP+L9hHeiQ10auLkLev2i7tqUMFuyLsJkg==
X-Received: by 10.84.146.140 with SMTP id g12mr4121300pla.157.1479888533771;
        Wed, 23 Nov 2016 00:08:53 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id t184sm32441723pgt.36.2016.11.23.00.08.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Nov 2016 00:08:52 -0800 (PST)
Date:   Wed, 23 Nov 2016 00:08:50 -0800
From:   David Aguilar <davvid@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] difftool: add the builtin
Message-ID: <20161123080850.GA23742@gmail.com>
References: <cover.1479834051.git.johannes.schindelin@gmx.de>
 <7aec571e1b0773ca80ea25453d2650af6a18e095.1479834051.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7aec571e1b0773ca80ea25453d2650af6a18e095.1479834051.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2016 at 06:01:23PM +0100, Johannes Schindelin wrote:
> This adds a builtin difftool that represents a conversion of the current
> Perl script version of the difftool.
> 
> The motivation is that Perl scripts are not at all native on Windows,
> and that `git difftool` therefore is pretty slow on that platform, when
> there is no good reason for it to be slow.
> 
> In addition, Perl does not really have access to Git's internals. That
> means that any script will always have to jump through unnecessary
> hoops.

Nice!

> The current version of the builtin difftool does not, however, make full
> use of the internals but instead chooses to spawn a couple of Git
> processes, still, to make for an easier conversion. There remains a lot
> of room for improvement, left for a later date.
> 
> Note: the original difftool is still called by `git difftool`. To get the
> new, experimental version, call `git builtin-difftool`. The reason: this
> new, experimental, builtin difftool will be shipped as part of Git for
> Windows v2.11.0, to allow for easier large-scale testing.

I like this plan.  I was going to ask for an environment
variable (to preset in git-cola) but since Git for Windows is
handling it then everyone benefits.

> diff --git a/builtin/builtin-difftool.c b/builtin/builtin-difftool.c
> new file mode 100644
> index 0000000..9feefcd
> --- /dev/null
> +++ b/builtin/builtin-difftool.c
> @@ -0,0 +1,680 @@
> +/*
> + * "git difftool" builtin command
> + *
> + * This is a wrapper around the GIT_EXTERNAL_DIFF-compatible
> + * git-difftool--helper script.
> + *
> + * This script exports GIT_EXTERNAL_DIFF and GIT_PAGER for use by git.
> + * The GIT_DIFF* variables are exported for use by git-difftool--helper.
> + *
> + * Any arguments that are unknown to this script are forwarded to 'git diff'.
> + *
> + * Copyright (C) 2016 Johannes Schindelin
> + */
> +#include "cache.h"
> +#include "builtin.h"
> +#include "parse-options.h"
> +#include "run-command.h"
> +#include "argv-array.h"
> +#include "strbuf.h"
> +#include "lockfile.h"
> +
> +static char *diff_gui_tool;
> +static int trust_exit_code;
> +
> +static const char * const builtin_difftool_usage[] = {
> +	N_("git add [<options>] [--] <pathspec>..."),
> +	NULL
> +};

The usage should probably say "difftool" (or "builtin-difftool").

> [...]
> +static void changed_files(struct hashmap *result, const char *index_path,
> +			  const char *workdir)
> +{
> +[...]
> +}
> +
> +#include "dir.h"

Can this mid-file #include go to the top of the file?

> +static int run_dir_diff(const char *extcmd, int symlinks,
> +			int argc, const char **argv)
> +{
> +	char tmpdir[PATH_MAX];
> +	struct strbuf info = STRBUF_INIT, lpath = STRBUF_INIT;
> +	struct strbuf rpath = STRBUF_INIT, buf = STRBUF_INIT;
> +	struct strbuf ldir = STRBUF_INIT, rdir = STRBUF_INIT;
> +	struct strbuf wtdir = STRBUF_INIT;
> +	size_t ldir_len, rdir_len, wtdir_len;
> +	struct cache_entry *ce = xcalloc(1, sizeof(ce) + PATH_MAX + 1);
> +	const char *workdir, *tmp;
> +	int ret = 0, i;
> +	FILE *fp;
> +	struct hashmap working_tree_dups, submodules, symlinks2;
> +	struct hashmap_iter iter;
> +	struct pair_entry *entry;
> +	enum object_type type;
> +	unsigned long size;
> +	struct index_state wtindex;
> +	struct checkout lstate, rstate;
> +	int rc, flags = RUN_GIT_CMD, err = 0;
> +	struct child_process child = CHILD_PROCESS_INIT;
> +	const char *helper_argv[] = { "difftool--helper", NULL, NULL, NULL };
> +	struct hashmap wt_modified, tmp_modified;
> +	int indices_loaded = 0;
> +
> +	setup_work_tree();
> +	workdir = get_git_work_tree();
> +
> +	/* Setup temp directories */
> +	tmp = getenv("TMPDIR");
> +	sprintf(tmpdir, "%s/git-difftool.XXXXXX", tmp ? tmp : "/tmp");

Maybe snprintf instead?

getenv() won't return anything longer than PATH_MAX for most
users, but users are weird.

> +	if (!mkdtemp(tmpdir))
> +		return error("could not create temporary directory");

Mention the tmpdir here?

> +	strbuf_addf(&ldir, "%s/left/", tmpdir);
> +	strbuf_addf(&rdir, "%s/right/", tmpdir);
> +	strbuf_addstr(&wtdir, workdir);
> +	if (!wtdir.len || !is_dir_sep(wtdir.buf[wtdir.len - 1]))
> +		strbuf_addch(&wtdir, '/');
> +	mkdir(ldir.buf, 0777);
> +	mkdir(rdir.buf, 0777);

Seeing the perl mkpath() default 0777 spelled out this way
makes me wonder whether 0700 would be safer.

The mkdtemp() above is already using 0700 so it's ok, but it
might be worth making it consistent (later, perhaps).

> [...]
> +int cmd_builtin_difftool(int argc, const char ** argv, const char * prefix)
> +{
> +	int use_gui_tool = 0, dir_diff = 0, prompt = -1, symlinks = 0,
> +	    tool_help = 0;
> +	static char *difftool_cmd = NULL, *extcmd = NULL;
> +
> +	struct option builtin_difftool_options[] = {
> +		OPT_BOOL('g', "gui", &use_gui_tool,
> +			 N_("use `diff.guitool` instead of `diff.tool`")),
> +		OPT_BOOL('d', "dir-diff", &dir_diff,
> +			 N_("perform a full-directory diff")),
> +		{ OPTION_SET_INT, 'y', "no-prompt", &prompt, NULL,
> +			N_("do not prompt before launching a diff tool"),
> +			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 0},
> +		{ OPTION_SET_INT, 0, "prompt", &prompt, NULL, NULL,
> +			PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_HIDDEN,
> +			NULL, 1 },
> +		OPT_BOOL(0, "symlinks", &symlinks,
> +			 N_("use symlinks in dir-diff mode")),
> +		OPT_STRING('t', "tool", &difftool_cmd, N_("<tool>"),
> +			   N_("use the specified diff tool")),
> +		OPT_BOOL(0, "tool-help", &tool_help,
> +			 N_("print a list of diff tools that may be used with "
> +			    "`--tool`")),
> +		OPT_BOOL(0, "trust-exit-code", &trust_exit_code,
> +			 N_("make 'git-difftool' exit when an invoked diff "
> +			    "tool returns a non - zero exit code")),
> +		OPT_STRING('x', "extcmd", &extcmd, N_("<command>"),
> +			   N_("specify a custom command for viewing diffs")),
> +		OPT_END()
> +	};
> +
> +	symlinks = has_symlinks;
> +
> +	git_config(difftool_config, NULL);
> +
> +	argc = parse_options(argc, argv, prefix, builtin_difftool_options,
> +			     builtin_difftool_usage, PARSE_OPT_KEEP_UNKNOWN |
> +			     PARSE_OPT_KEEP_DASHDASH);
> +
> +	if (tool_help)
> +		return print_tool_help();
> +
> +	if (use_gui_tool && diff_gui_tool && *diff_gui_tool)
> +		setenv("GIT_DIFF_TOOL", diff_gui_tool, 1);
> +	else if (difftool_cmd) {
> +		if (*difftool_cmd)
> +			setenv("GIT_DIFF_TOOL", difftool_cmd, 1);
> +		else
> +			die(_("no <tool> given for --tool=<tool>"));
> +	}
> +
> +	if (extcmd) {
> +		if (*extcmd)
> +			setenv("GIT_DIFFTOOL_EXTCMD", extcmd, 1);
> +		else
> +			die(_("no <cmd> given for --extcmd=<cmd>"));
> +	}
> +
> +	setenv("GIT_DIFFTOOL_TRUST_EXIT_CODE",
> +	       trust_exit_code ? "true" : "false", 1);
> +
> +	/*
> +	 * In directory diff mode, 'git-difftool--helper' is called once
> +	 * to compare the a / b directories.In file diff mode, 'git diff'
> +	 * will invoke a separate instance of 'git-difftool--helper' for
> +	 * each file that changed.
> +	 */

Missing space after "." in the comment above.

> +	if (dir_diff)
> +		return run_dir_diff(extcmd, symlinks, argc, argv);
> +	return run_file_diff(prompt, argc, argv);
> +}
> diff --git a/git.c b/git.c
> index efa1059..eaa0f67 100644
> --- a/git.c
> +++ b/git.c
> @@ -424,6 +424,7 @@ static struct cmd_struct commands[] = {
>  	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE },
>  	{ "diff-index", cmd_diff_index, RUN_SETUP },
>  	{ "diff-tree", cmd_diff_tree, RUN_SETUP },
> +	{ "builtin-difftool", cmd_builtin_difftool, RUN_SETUP | NEED_WORK_TREE },
>  	{ "fast-export", cmd_fast_export, RUN_SETUP },
>  	{ "fetch", cmd_fetch, RUN_SETUP },
>  	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },

This isn't alphabetical anymore, but it actually is if you
consider that the final plan is to change "builtin-difftool" to
"difftool".

If we want to minimize that future diff we could name
cmd_builtin_difftool() as cmd_difftool() for consistency now so
that the future commit only needs to tweak the string here.
-- 
David
