Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A8B31F453
	for <e@80x24.org>; Fri, 18 Jan 2019 15:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfARPJc (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 10:09:32 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38144 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbfARPJb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 10:09:31 -0500
Received: by mail-ed1-f65.google.com with SMTP id h50so11374349ede.5
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 07:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sBiosw+sgbq1pY5ahxumEp2L3R+AfaZgNynGeKv9lUk=;
        b=mpi3LUEozCkUxc1MzvP566jo/LSEh/T9XHAnc9rrlQyzBin5BQ7VrGZieFptjXmL9T
         +8D9yGw5xGhYVJhFJzXBLVQWKV3WhxhrlO0c2Skj/96dH7PfEirVJExDKkFT8U+QGm93
         xFwSAnAOZ1VXoR1Og6zgjEIuK0PuI5St5VSnSQflldR7QcDSUD2B2UcXrsPsp/wk7F4k
         Wta1xFcupUSkmILXhBFJuBzHK0y6ilkbkuDvZEn+izJevlq/eS4gxiHKNZVDUfzZ3Bwg
         zC9opokzKYHCSGJUgx9uTEIeE6H6tZVoxkjt0iKa+mb6PJDjQbKKswZ9W8maQ1ys9Uac
         KUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sBiosw+sgbq1pY5ahxumEp2L3R+AfaZgNynGeKv9lUk=;
        b=NvpHPwPjA2ocpB7Z4c1WCjxVA3GAiREw7JKlBUBPX3JBr+wQaUfXDmJoZYJJLNfpVf
         rpQSpx+J/pNfMB6sWJsKgraiEFpjj7Z+IVsquVQWK2A8lkREpxLqxcsj22lNmfpzZaKm
         EUui/f3bcevs5e75m11jQ9We/VuI552REguPhn3jNRimRitkE8fuEHxNG3s5CuErNRqB
         df0fOa9hkyIZuI12bN+nGVPKe2jsCPhHi1WB5Gj8lsLfhcAS3oPsT/eEq9HbMV7/JSwu
         p0bNilg2TnJdIntoib3hi91AFjogg+yVPokwqcu65Oeyi+Z5TluukQHNzMa+a9OyRGRD
         OCzg==
X-Gm-Message-State: AJcUukfPFxqE5rIhPgTCntrzwhlMBzlgcO7QZJlTsNf5NFkMQgzS4D3T
        xFBsdTbsK7c9KUHsKnizHD3ytFB1
X-Google-Smtp-Source: ALg8bN6uwK8d82VbvhcfxxT+QvaefNXyUHw+WGafPLq5jJAcPQ5n79RSk8iquBWe5IjK3feMJnXMHQ==
X-Received: by 2002:a50:ef18:: with SMTP id m24mr16062634eds.136.1547824168513;
        Fri, 18 Jan 2019 07:09:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i46sm7088989eda.37.2019.01.18.07.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 07:09:27 -0800 (PST)
Date:   Fri, 18 Jan 2019 07:09:27 -0800 (PST)
X-Google-Original-Date: Fri, 18 Jan 2019 15:09:22 GMT
Message-Id: <3c4031868204862ea4e2a53a03cd8d7ec066a891.1547824162.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.24.v2.git.gitgitgadget@gmail.com>
References: <pull.24.git.gitgitgadget@gmail.com>
        <pull.24.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 4/4] built-in rebase: call `git am` directly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

While the scripted `git rebase` still has to rely on the
`git-rebase--am.sh` script to implement the glue between the `rebase`
and the `am` commands, we can go a more direct route in the built-in
rebase and avoid using a shell script altogether.

This patch represents a straight-forward port of `git-rebase--am.sh` to
C, along with the glue code to call it directly from within
`builtin/rebase.c`.

This reduces the chances of Git for Windows running into trouble due to
problems with the POSIX emulation layer (known as "MSYS2 runtime",
itself a derivative of the Cygwin runtime): when no shell script is
called, the POSIX emulation layer is avoided altogether.

Note: we pass an empty action to `reset_head()` here when moving back to
the original branch, as no other action is applicable, really. This
parameter is used to initialize `unpack_trees()`' messages.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 179 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index c65493a484..0727ddaf00 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -246,6 +246,37 @@ static int read_basic_state(struct rebase_options *opts)
 	return 0;
 }
 
+static int write_basic_state(struct rebase_options *opts)
+{
+	write_file(state_dir_path("head-name", opts), "%s",
+		   opts->head_name ? opts->head_name : "detached HEAD");
+	write_file(state_dir_path("onto", opts), "%s",
+		   opts->onto ? oid_to_hex(&opts->onto->object.oid) : "");
+	write_file(state_dir_path("orig-head", opts), "%s",
+		   oid_to_hex(&opts->orig_head));
+	write_file(state_dir_path("quiet", opts), "%s",
+		   opts->flags & REBASE_NO_QUIET ? "" : "t");
+	if (opts->flags & REBASE_VERBOSE)
+		write_file(state_dir_path("verbose", opts), "%s", "");
+	if (opts->strategy)
+		write_file(state_dir_path("strategy", opts), "%s",
+			   opts->strategy);
+	if (opts->strategy_opts)
+		write_file(state_dir_path("strategy_opts", opts), "%s",
+			   opts->strategy_opts);
+	if (opts->allow_rerere_autoupdate >= 0)
+		write_file(state_dir_path("allow_rerere_autoupdate", opts),
+			   "-%s-rerere-autoupdate",
+			   opts->allow_rerere_autoupdate ? "" : "-no");
+	if (opts->gpg_sign_opt)
+		write_file(state_dir_path("gpg_sign_opt", opts), "%s",
+			   opts->gpg_sign_opt);
+	if (opts->signoff)
+		write_file(state_dir_path("strategy", opts), "--signoff");
+
+	return 0;
+}
+
 static int apply_autostash(struct rebase_options *opts)
 {
 	const char *path = state_dir_path("autostash", opts);
@@ -459,6 +490,29 @@ static int reset_head(struct object_id *oid, const char *action,
 	return ret;
 }
 
+static int move_to_original_branch(struct rebase_options *opts)
+{
+	struct strbuf orig_head_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
+	int ret;
+
+	if (!opts->head_name)
+		return 0; /* nothing to move back to */
+
+	if (!opts->onto)
+		BUG("move_to_original_branch without onto");
+
+	strbuf_addf(&orig_head_reflog, "rebase finished: %s onto %s",
+		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
+	strbuf_addf(&head_reflog, "rebase finished: returning to %s",
+		    opts->head_name);
+	ret = reset_head(NULL, "", opts->head_name, RESET_HEAD_REFS_ONLY,
+			 orig_head_reflog.buf, head_reflog.buf);
+
+	strbuf_release(&orig_head_reflog);
+	strbuf_release(&head_reflog);
+	return ret;
+}
+
 static const char *resolvemsg =
 N_("Resolve all conflicts manually, mark them as resolved with\n"
 "\"git add/rm <conflicted_files>\", then run \"git rebase --continue\".\n"
@@ -466,6 +520,126 @@ N_("Resolve all conflicts manually, mark them as resolved with\n"
 "To abort and get back to the state before \"git rebase\", run "
 "\"git rebase --abort\".");
 
+static int run_am(struct rebase_options *opts)
+{
+	struct child_process am = CHILD_PROCESS_INIT;
+	struct child_process format_patch = CHILD_PROCESS_INIT;
+	struct strbuf revisions = STRBUF_INIT;
+	int status;
+	char *rebased_patches;
+
+	am.git_cmd = 1;
+	argv_array_push(&am.args, "am");
+
+	if (opts->action && !strcmp("continue", opts->action)) {
+		argv_array_push(&am.args, "--resolved");
+		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
+		if (opts->gpg_sign_opt)
+			argv_array_push(&am.args, opts->gpg_sign_opt);
+		status = run_command(&am);
+		if (status)
+			return status;
+
+		return move_to_original_branch(opts);
+	}
+	if (opts->action && !strcmp("skip", opts->action)) {
+		argv_array_push(&am.args, "--skip");
+		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
+		status = run_command(&am);
+		if (status)
+			return status;
+
+		return move_to_original_branch(opts);
+	}
+	if (opts->action && !strcmp("show-current-patch", opts->action)) {
+		argv_array_push(&am.args, "--show-current-patch");
+		return run_command(&am);
+	}
+
+	strbuf_addf(&revisions, "%s...%s",
+		    oid_to_hex(opts->root ?
+			       /* this is now equivalent to !opts->upstream */
+			       &opts->onto->object.oid :
+			       &opts->upstream->object.oid),
+		    oid_to_hex(&opts->orig_head));
+
+	rebased_patches = xstrdup(git_path("rebased-patches"));
+	format_patch.out = open(rebased_patches,
+				O_WRONLY | O_CREAT | O_TRUNC, 0666);
+	if (format_patch.out < 0) {
+		status = error_errno(_("could not open '%s' for writing"),
+				     rebased_patches);
+		free(rebased_patches);
+		argv_array_clear(&am.args);
+		return status;
+	}
+
+	format_patch.git_cmd = 1;
+	argv_array_pushl(&format_patch.args, "format-patch", "-k", "--stdout",
+			 "--full-index", "--cherry-pick", "--right-only",
+			 "--src-prefix=a/", "--dst-prefix=b/", "--no-renames",
+			 "--no-cover-letter", "--pretty=mboxrd", NULL);
+	if (opts->git_format_patch_opt.len)
+		argv_array_split(&format_patch.args,
+				 opts->git_format_patch_opt.buf);
+	argv_array_push(&format_patch.args, revisions.buf);
+	if (opts->restrict_revision)
+		argv_array_pushf(&format_patch.args, "^%s",
+				 oid_to_hex(&opts->restrict_revision->object.oid));
+
+	status = run_command(&format_patch);
+	if (status) {
+		unlink(rebased_patches);
+		free(rebased_patches);
+		argv_array_clear(&am.args);
+
+		reset_head(&opts->orig_head, "checkout", opts->head_name, 0,
+			   "HEAD", NULL);
+		error(_("\ngit encountered an error while preparing the "
+			"patches to replay\n"
+			"these revisions:\n"
+			"\n    %s\n\n"
+			"As a result, git cannot rebase them."),
+		      opts->revisions);
+
+		strbuf_release(&revisions);
+		return status;
+	}
+	strbuf_release(&revisions);
+
+	am.in = open(rebased_patches, O_RDONLY);
+	if (am.in < 0) {
+		status = error_errno(_("could not open '%s' for reading"),
+				     rebased_patches);
+		free(rebased_patches);
+		argv_array_clear(&am.args);
+		return status;
+	}
+
+	argv_array_pushv(&am.args, opts->git_am_opts.argv);
+	argv_array_push(&am.args, "--rebasing");
+	argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
+	argv_array_push(&am.args, "--patch-format=mboxrd");
+	if (opts->allow_rerere_autoupdate > 0)
+		argv_array_push(&am.args, "--rerere-autoupdate");
+	else if (opts->allow_rerere_autoupdate == 0)
+		argv_array_push(&am.args, "--no-rerere-autoupdate");
+	if (opts->gpg_sign_opt)
+		argv_array_push(&am.args, opts->gpg_sign_opt);
+	status = run_command(&am);
+	unlink(rebased_patches);
+	free(rebased_patches);
+
+	if (!status) {
+		return move_to_original_branch(opts);
+	}
+
+	if (is_directory(opts->state_dir))
+		write_basic_state(opts);
+
+	return status;
+}
+
 static int run_specific_rebase(struct rebase_options *opts)
 {
 	const char *argv[] = { NULL, NULL };
@@ -546,6 +720,11 @@ static int run_specific_rebase(struct rebase_options *opts)
 		goto finished_rebase;
 	}
 
+	if (opts->type == REBASE_AM) {
+		status = run_am(opts);
+		goto finished_rebase;
+	}
+
 	add_var(&script_snippet, "GIT_DIR", absolute_path(get_git_dir()));
 	add_var(&script_snippet, "state_dir", opts->state_dir);
 
-- 
gitgitgadget
