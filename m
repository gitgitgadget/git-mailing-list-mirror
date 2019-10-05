Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 177241F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 18:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387950AbfJESqo (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 14:46:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41068 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387861AbfJESqn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 14:46:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id q9so10748376wrm.8
        for <git@vger.kernel.org>; Sat, 05 Oct 2019 11:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JoTzmZtLTgzsiri+lN4YeQkX/6i7E6GHnp9g9h+NsfY=;
        b=WnWNvo96gLQqksF/Ugko+8P4YjHhoiV4Bpfo5cfpZKStJbh09RVGNzAJyzdTMp3D9E
         qdghqPVWiRRHHrj1CP84WEuHtP5dVBhcPQZd8lolk1wM9cNHYbpZLccfIzWncN9ciTyL
         fJ9V3+jPNO31/MIJyMxiqTwBO+AvWro3d8CjoV25AZ9pheiInp35G3R/z4nGvHZclx7w
         LHl+IAckica9vKzdwbEU06ND4dT0LfPsbP60KH79/qE9O3oOdyEZLZm3kJND0h0Zdaiz
         AtS+72ecP6beGN0kA4OjzldxOIGtHv35XQ8E1Qg8XIjkyi88HqO2EpIghLn3+lz9TNcG
         IHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JoTzmZtLTgzsiri+lN4YeQkX/6i7E6GHnp9g9h+NsfY=;
        b=spuf8LHt1TvausvfDQe1PahCb/lVQNOoXO8AJViMFMUx+m+6q8L9J+Qpq2Ns24sobc
         0u5fx7eXSmFmZEBsnQiEQHQRmlR7YfFx+wNvVSHBuVVwL8qWUQNKkVb79wrpY2q7vTYY
         PFE7i8pKSQKDBpxH6o/T+aG/qZ7rLjTbAMndQLVKe5wL9wbNQipL/aSw+Br9OlICeQ33
         66oePVOj/lIjIYIxXfwRIu6V+5yH4fCrKz9Gt053ykS96eB2sVg1QfWebSvdrCKr+ftP
         HO/sRdBCDTg3NfodQbGIKWvBI2cttAm1cZyp52TQ1tmmqAS3p1l11Q9G7IQUJSHZzb43
         SG7A==
X-Gm-Message-State: APjAAAXolaGuJWQQ/0NCWs0xRVwk8BG8y9I0T5nD66/T+uR9iunvOB/D
        bk7HRqdd0yAj/xq6XsNX1ab8MvIB
X-Google-Smtp-Source: APXvYqzqMZdIINRxe0d4XfRM4iV2zX1uf6J8bOG0AAHaDRcUc9r3EqxhZFRPNOCrONodalSGxOUWMQ==
X-Received: by 2002:adf:ef4a:: with SMTP id c10mr7448802wrp.10.1570301200686;
        Sat, 05 Oct 2019 11:46:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a2sm11258774wrp.11.2019.10.05.11.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Oct 2019 11:46:40 -0700 (PDT)
Date:   Sat, 05 Oct 2019 11:46:40 -0700 (PDT)
X-Google-Original-Date: Sat, 05 Oct 2019 18:46:38 GMT
Message-Id: <93a155a000571df3f3f3a63cd8d886d68fbe8403.1570301198.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.369.v2.git.gitgitgadget@gmail.com>
References: <pull.369.git.gitgitgadget@gmail.com>
        <pull.369.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] fetch: let --jobs=<n> parallelize --multiple, too
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

So far, `--jobs=<n>` only parallelizes submodule fetches/clones, not
`--multiple` fetches, which is unintuitive, given that the option's name
does not say anything about submodules in particular.

Let's change that. With this patch, also fetches from multiple remotes
are parallelized.

For backwards-compatibility (and to prepare for a use case where
submodule and multiple-remote fetches may need different parallelization
limits), the config setting `submodule.fetchJobs` still only controls
the submodule part of `git fetch`, while the newly-introduced setting
`fetch.parallel` controls both (but can be overridden for submodules
with `submodule.fetchJobs`).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/fetch.txt  |  10 +++
 Documentation/fetch-options.txt |  13 ++--
 builtin/fetch.c                 | 124 +++++++++++++++++++++++++++-----
 t/t5514-fetch-multiple.sh       |  11 +++
 4 files changed, 137 insertions(+), 21 deletions(-)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index ba890b5884..b200634065 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -68,3 +68,13 @@ fetch.showForcedUpdates::
 	Set to false to enable `--no-show-forced-updates` in
 	linkgit:git-fetch[1] and linkgit:git-pull[1] commands.
 	Defaults to true.
+
+fetch.parallel::
+	Specifies the maximal number of fetch operations to be run in parallel
+	at a time (submodules, or remotes when the `--multiple` option of
+	linkgit:git-fetch[1] is in effect).
++
+A value of 0 will give some reasonable default. If unset, it defaults to 1.
++
+For submodules, this setting can be overridden using the `submodule.fetchJobs`
+config setting.
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 3c9b4f9e09..8f269d3baa 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -160,10 +160,15 @@ ifndef::git-pull[]
 
 -j::
 --jobs=<n>::
-	Number of parallel children to be used for fetching submodules.
-	Each will fetch from different submodules, such that fetching many
-	submodules will be faster. By default submodules will be fetched
-	one at a time.
+	Number of parallel children to be used for all forms of fetching.
++
+If the `--multiple` option was specified, the different remotes will be fetched
+in parallel. If multiple submodules are fetched, they will be fetched in
+parallel. To control them independently, use the config settings
+`fetch.parallel` and `submodule.fetchJobs` (see linkgit:git-config[1]).
++
+Typically, parallel recursive and multi-remote fetches will be faster. By
+default fetches are performed sequentially, not in parallel.
 
 --no-recurse-submodules::
 	Disable recursive fetching of submodules (this has the same effect as
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 53ce99d2bb..e2d374724d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -54,7 +54,8 @@ static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosit
 static int progress = -1;
 static int enable_auto_gc = 1;
 static int tags = TAGS_DEFAULT, unshallow, update_shallow, deepen;
-static int max_children = 1;
+static int max_jobs = -1, submodule_fetch_jobs_config = -1;
+static int fetch_parallel_config = 1;
 static enum transport_family family;
 static const char *depth;
 static const char *deepen_since;
@@ -96,13 +97,20 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 	}
 
 	if (!strcmp(k, "submodule.fetchjobs")) {
-		max_children = parse_submodule_fetchjobs(k, v);
+		submodule_fetch_jobs_config = parse_submodule_fetchjobs(k, v);
 		return 0;
 	} else if (!strcmp(k, "fetch.recursesubmodules")) {
 		recurse_submodules = parse_fetch_recurse_submodules_arg(k, v);
 		return 0;
 	}
 
+	if (!strcmp(k, "fetch.parallel")) {
+		fetch_parallel_config = git_config_int(k, v);
+		if (fetch_parallel_config < 0)
+			die(_("fetch.parallel cannot be negative"));
+		return 0;
+	}
+
 	return git_default_config(k, v, cb);
 }
 
@@ -134,7 +142,7 @@ static struct option builtin_fetch_options[] = {
 		    N_("fetch all tags and associated objects"), TAGS_SET),
 	OPT_SET_INT('n', NULL, &tags,
 		    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
-	OPT_INTEGER('j', "jobs", &max_children,
+	OPT_INTEGER('j', "jobs", &max_jobs,
 		    N_("number of submodules fetched in parallel")),
 	OPT_BOOL('p', "prune", &prune,
 		 N_("prune remote-tracking branches no longer on remote")),
@@ -1456,7 +1464,62 @@ static void add_options_to_argv(struct argv_array *argv)
 
 }
 
-static int fetch_multiple(struct string_list *list)
+/* Fetch multiple remotes in parallel */
+
+struct parallel_fetch_state {
+	const char **argv;
+	struct string_list *remotes;
+	int next, result;
+};
+
+static int fetch_next_remote(struct child_process *cp, struct strbuf *out,
+			     void *cb, void **task_cb)
+{
+	struct parallel_fetch_state *state = cb;
+	char *remote;
+
+	if (state->next < 0 || state->next >= state->remotes->nr)
+		return 0;
+
+	remote = state->remotes->items[state->next++].string;
+	*task_cb = remote;
+
+	argv_array_pushv(&cp->args, state->argv);
+	argv_array_push(&cp->args, remote);
+	cp->git_cmd = 1;
+
+	if (verbosity >= 0)
+		printf(_("Fetching %s\n"), remote);
+
+	return 1;
+}
+
+static int fetch_failed_to_start(struct strbuf *out, void *cb, void *task_cb)
+{
+	struct parallel_fetch_state *state = cb;
+	const char *remote = task_cb;
+
+	state->result = error(_("Could not fetch %s"), remote);
+
+	return 0;
+}
+
+static int fetch_finished(int result, struct strbuf *out,
+			  void *cb, void *task_cb)
+{
+	struct parallel_fetch_state *state = cb;
+	const char *remote = task_cb;
+
+	if (result) {
+		strbuf_addf(out, _("could not fetch '%s' (exit code: %d)\n"),
+			    remote, result);
+		state->result = -1;
+	}
+
+	return 0;
+}
+
+static int fetch_multiple(struct string_list *list, int max_children)
 {
 	int i, result = 0;
 	struct argv_array argv = ARGV_ARRAY_INIT;
@@ -1470,20 +1533,34 @@ static int fetch_multiple(struct string_list *list)
 	argv_array_pushl(&argv, "fetch", "--append", "--no-auto-gc", NULL);
 	add_options_to_argv(&argv);
 
-	for (i = 0; i < list->nr; i++) {
-		const char *name = list->items[i].string;
-		argv_array_push(&argv, name);
-		if (verbosity >= 0)
-			printf(_("Fetching %s\n"), name);
-		if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
-			error(_("Could not fetch %s"), name);
-			result = 1;
+	if (max_children != 1 && list->nr != 1) {
+		struct parallel_fetch_state state = { argv.argv, list, 0, 0 };
+
+		argv_array_push(&argv, "--end-of-options");
+		result = run_processes_parallel_tr2(max_children,
+						    &fetch_next_remote,
+						    &fetch_failed_to_start,
+						    &fetch_finished,
+						    &state,
+						    "fetch", "parallel/fetch");
+
+		if (!result)
+			result = state.result;
+	} else
+		for (i = 0; i < list->nr; i++) {
+			const char *name = list->items[i].string;
+			argv_array_push(&argv, name);
+			if (verbosity >= 0)
+				printf(_("Fetching %s\n"), name);
+			if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
+				error(_("Could not fetch %s"), name);
+				result = 1;
+			}
+			argv_array_pop(&argv);
 		}
-		argv_array_pop(&argv);
-	}
 
 	argv_array_clear(&argv);
-	return result;
+	return !!result;
 }
 
 /*
@@ -1626,7 +1703,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; i++)
 		strbuf_addf(&default_rla, " %s", argv[i]);
 
-	fetch_config_from_gitmodules(&max_children, &recurse_submodules);
+	fetch_config_from_gitmodules(&submodule_fetch_jobs_config,
+				     &recurse_submodules);
 	git_config(git_fetch_config, NULL);
 
 	argc = parse_options(argc, argv, prefix,
@@ -1692,15 +1770,27 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			fetch_one_setup_partial(remote);
 		result = fetch_one(remote, argc, argv, prune_tags_ok);
 	} else {
+		int max_children = max_jobs;
+
 		if (filter_options.choice)
 			die(_("--filter can only be used with the remote "
 			      "configured in extensions.partialclone"));
+
+		if (max_children < 0)
+			max_children = fetch_parallel_config;
+
 		/* TODO should this also die if we have a previous partial-clone? */
-		result = fetch_multiple(&list);
+		result = fetch_multiple(&list, max_children);
 	}
 
 	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
 		struct argv_array options = ARGV_ARRAY_INIT;
+		int max_children = max_jobs;
+
+		if (max_children < 0)
+			max_children = submodule_fetch_jobs_config;
+		if (max_children < 0)
+			max_children = fetch_parallel_config;
 
 		add_options_to_argv(&options);
 		result = fetch_populated_submodules(the_repository,
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index 5426d4b5ab..de8e2f1531 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -183,4 +183,15 @@ test_expect_success 'git fetch --all --tags' '
 	test_cmp expect test8/output
 '
 
+test_expect_success 'parallel' '
+	git remote add one ./bogus1 &&
+	git remote add two ./bogus2 &&
+
+	test_must_fail env GIT_TRACE="$PWD/trace" \
+		git fetch --jobs=2 --multiple one two 2>err &&
+	grep "preparing to run up to 2 tasks" trace &&
+	test_i18ngrep "could not fetch .one.*128" err &&
+	test_i18ngrep "could not fetch .two.*128" err
+'
+
 test_done
-- 
gitgitgadget
