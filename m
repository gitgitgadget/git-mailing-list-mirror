Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96F3F1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 16:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbeGRQvQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 12:51:16 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:41750 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731535AbeGRQvP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 12:51:15 -0400
Received: by mail-lj1-f180.google.com with SMTP id y17-v6so4594787ljy.8
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 09:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wxSEa9zs7u8Ch+wM2QUo3M47EUZz9Aa8KKAnBWm8U14=;
        b=TOzOVpYRVDkVku552SMxNFftwsdx8KBlAJVc4MQ6TrAGsKPn81tKLPsDJUizGMe05T
         1b9zsZ0popzEGINi4b+RWHjjKryvr4GnPsyX2ExaPWRSqYRloKYfZdYmBs8rae7s7I6R
         qMqYLUJkSexjG+bPxG3OTH0T6fvtFpqkZPpDlfkVtAw/DnYhWFPWP8SrekIF1Y+D260U
         YiiwmVx33IVTER4hIVhnXEoY2dZXR0DTNpHxc/ntgWYM4J7z8tZElmAJyXeTcE3YteXj
         kwn+HWO5qh9TF+5+P4iEw4Fib4RRVJUmD8EV0WUP2M2/pyQN2hRW8NTwQIqG54thxSiR
         KVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wxSEa9zs7u8Ch+wM2QUo3M47EUZz9Aa8KKAnBWm8U14=;
        b=kedsw/2oOVu78LOxtSQgIcJQUPWudZy6yKMrlL8CXFcm0IWL1jxysWsPyNcIXbjqWx
         p9ovyIGjujoTIsX+7pgbq2kta9zEvyP+85TZRDq3OTtZlbJ7QoOcWbCWaFZTAE5gIT5D
         onm6L/nQ63y2iuqvDOABITgtM0uylilJxv55Q19RKiS0I2Oy77ru4hGn/UDgSe60P4lb
         sw4AKUUo5ipEyaeP/CLUntYpmONAAaK790TPbQWZRyg0T0Y/6iR/jv2xW10CPn1aKuCb
         1+5TFtNKwUe+CH1/kwab2wVODGetULm3DccxmFNiCMn3uIVxHoLwXjmtC6g64cGRBflC
         LkLg==
X-Gm-Message-State: AOUpUlFOpO8et8MT/Y7Y4sc7OB+NwIgH3d6kBuxQRD/VpLJ0LCEaxzCs
        cBJcmXzkv5wLGykUwwB7E5Dg/g==
X-Google-Smtp-Source: AAOMgpcR0bxydtQVRhy3mLQNF8uFjd4ZBNr5ZZIuPu8DxK8O5Bf8csIwqEH08NUib8xg39okEwV9Tw==
X-Received: by 2002:a2e:8185:: with SMTP id e5-v6mr5338701ljg.93.1531930356690;
        Wed, 18 Jul 2018 09:12:36 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j26-v6sm689203ljc.54.2018.07.18.09.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:11:05 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 00/23] Mark strings for translation
Date:   Wed, 18 Jul 2018 18:10:38 +0200
Message-Id: <20180718161101.19765-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series marks more strings for translation. It was done during the
last rc period and probably misses new strings now, but we can mark
more later.

Compared to v1 [1], this moves interesting changes back to patch one
and leave the boring _() to the remaining patches. I also cleaned up
the "die (" and "warning (" a bit. Interdiff

diff --git a/builtin/blame.c b/builtin/blame.c
index 5a0388aaef..b77ba6ae82 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -408,7 +408,7 @@ static void parse_color_fields(const char *s)
 	}
 
 	if (next == EXPECT_COLOR)
-		die (_("must end with a color"));
+		die(_("must end with a color"));
 
 	colorfield[colorfield_nr].hop = TIME_MAX;
 	string_list_clear(&l, 0);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4c41d8b4c8..626868637a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1191,12 +1191,12 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	if (opts.track != BRANCH_TRACK_UNSPECIFIED && !opts.new_branch) {
 		const char *argv0 = argv[0];
 		if (!argc || !strcmp(argv0, "--"))
-			die (_("--track needs a branch name"));
+			die(_("--track needs a branch name"));
 		skip_prefix(argv0, "refs/", &argv0);
 		skip_prefix(argv0, "remotes/", &argv0);
 		argv0 = strchr(argv0, '/');
 		if (!argv0 || !argv0[1])
-			die (_("Missing branch name; try -b"));
+			die(_("missing branch name; try -b"));
 		opts.new_branch = argv0 + 1;
 	}
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 9bcbb0c25c..d3276a10b2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1647,9 +1647,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	unlink(git_path_squash_msg());
 
 	if (commit_index_files())
-		die (_("Repository has been updated, but unable to write\n"
-		     "new_index file. Check that disk is not full and quota is\n"
-		     "not exceeded, and then \"git reset HEAD\" to recover."));
+		die(_("repository has been updated, but unable to write\n"
+		      "new_index file. Check that disk is not full and quota is\n"
+		      "not exceeded, and then \"git reset HEAD\" to recover."));
 
 	rerere(0);
 	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 73d12c1020..83c482581b 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -240,7 +240,7 @@ static void export_blob(const struct object_id *oid)
 	} else {
 		buf = read_object_file(oid, &type, &size);
 		if (!buf)
-			die ("Could not read blob %s", oid_to_hex(oid));
+			die("could not read blob %s", oid_to_hex(oid));
 		if (check_object_signature(oid, buf, size, type_name(type)) < 0)
 			die("sha1 mismatch in blob %s", oid_to_hex(oid));
 		object = parse_object_buffer(oid, type, size, buf, &eaten);
@@ -253,7 +253,7 @@ static void export_blob(const struct object_id *oid)
 
 	printf("blob\nmark :%"PRIu32"\ndata %lu\n", last_idnum, size);
 	if (size && fwrite(buf, size, 1, stdout) != 1)
-		die_errno ("Could not write blob '%s'", oid_to_hex(oid));
+		die_errno("could not write blob '%s'", oid_to_hex(oid));
 	printf("\n");
 
 	show_progress();
@@ -560,14 +560,14 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	commit_buffer = get_commit_buffer(commit, NULL);
 	author = strstr(commit_buffer, "\nauthor ");
 	if (!author)
-		die ("Could not find author in commit %s",
-		     oid_to_hex(&commit->object.oid));
+		die("could not find author in commit %s",
+		    oid_to_hex(&commit->object.oid));
 	author++;
 	author_end = strchrnul(author, '\n');
 	committer = strstr(author_end, "\ncommitter ");
 	if (!committer)
-		die ("Could not find committer in commit %s",
-		     oid_to_hex(&commit->object.oid));
+		die("could not find committer in commit %s",
+		    oid_to_hex(&commit->object.oid));
 	committer++;
 	committer_end = strchrnul(committer, '\n');
 	message = strstr(committer_end, "\n\n");
@@ -688,7 +688,7 @@ static void handle_tag(const char *name, struct tag *tag)
 
 	buf = read_object_file(&tag->object.oid, &type, &size);
 	if (!buf)
-		die ("Could not read tag %s", oid_to_hex(&tag->object.oid));
+		die("could not read tag %s", oid_to_hex(&tag->object.oid));
 	message = memmem(buf, size, "\n\n", 2);
 	if (message) {
 		message += 2;
@@ -725,18 +725,18 @@ static void handle_tag(const char *name, struct tag *tag)
 		if (signature)
 			switch(signed_tag_mode) {
 			case ABORT:
-				die ("Encountered signed tag %s; use "
-				     "--signed-tags=<mode> to handle it.",
-				     oid_to_hex(&tag->object.oid));
+				die("encountered signed tag %s; use "
+				    "--signed-tags=<mode> to handle it",
+				    oid_to_hex(&tag->object.oid));
 			case WARN:
-				warning ("Exporting signed tag %s",
-					 oid_to_hex(&tag->object.oid));
+				warning("exporting signed tag %s",
+					oid_to_hex(&tag->object.oid));
 				/* fallthru */
 			case VERBATIM:
 				break;
 			case WARN_STRIP:
-				warning ("Stripping signature from tag %s",
-					 oid_to_hex(&tag->object.oid));
+				warning("stripping signature from tag %s",
+					oid_to_hex(&tag->object.oid));
 				/* fallthru */
 			case STRIP:
 				message_size = signature + 1 - message;
@@ -750,18 +750,18 @@ static void handle_tag(const char *name, struct tag *tag)
 	if (!tagged_mark) {
 		switch(tag_of_filtered_mode) {
 		case ABORT:
-			die ("Tag %s tags unexported object; use "
-			     "--tag-of-filtered-object=<mode> to handle it.",
-			     oid_to_hex(&tag->object.oid));
+			die("tag %s tags unexported object; use "
+			    "--tag-of-filtered-object=<mode> to handle it",
+			    oid_to_hex(&tag->object.oid));
 		case DROP:
 			/* Ignore this tag altogether */
 			free(buf);
 			return;
 		case REWRITE:
 			if (tagged->type != OBJ_COMMIT) {
-				die ("Tag %s tags unexported %s!",
-				     oid_to_hex(&tag->object.oid),
-				     type_name(tagged->type));
+				die("tag %s tags unexported %s!",
+				    oid_to_hex(&tag->object.oid),
+				    type_name(tagged->type));
 			}
 			p = (struct commit *)tagged;
 			for (;;) {
@@ -772,7 +772,7 @@ static void handle_tag(const char *name, struct tag *tag)
 				if (!(p->object.flags & TREESAME))
 					break;
 				if (!p->parents)
-					die ("Can't find replacement commit for tag %s\n",
+					die("can't find replacement commit for tag %s",
 					     oid_to_hex(&tag->object.oid));
 				p = p->parents->item;
 			}
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index bd680be687..a08f239e00 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -623,7 +623,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		i++;
 		p[len] = 0;
 		if (handle_line(p, &merge_parents))
-			die ("Error in line %d: %.*s", i, len, p);
+			die("error in line %d: %.*s", i, len, p);
 	}
 
 	if (opts->add_title && srcs.nr)
diff --git a/builtin/log.c b/builtin/log.c
index 0583f7f383..99d4c6996e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1606,14 +1606,14 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		numbered = 0;
 
 	if (numbered && keep_subject)
-		die (_("-n and -k are mutually exclusive."));
+		die(_("-n and -k are mutually exclusive"));
 	if (keep_subject && subject_prefix)
-		die (_("--subject-prefix/--rfc and -k are mutually exclusive."));
+		die(_("--subject-prefix/--rfc and -k are mutually exclusive"));
 	rev.preserve_subject = keep_subject;
 
 	argc = setup_revisions(argc, argv, &rev, &s_r_opt);
 	if (argc > 1)
-		die (_("unrecognized argument: %s"), argv[1]);
+		die(_("unrecognized argument: %s"), argv[1]);
 
 	if (rev.diffopt.output_format & DIFF_FORMAT_NAME)
 		die(_("--name-only does not make sense"));
diff --git a/builtin/merge.c b/builtin/merge.c
index 4a4c09496c..f553f89a48 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -693,7 +693,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			exit(128);
 		if (write_locked_index(&the_index, &lock,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
-			die (_("unable to write %s"), get_index_file());
+			die(_("unable to write %s"), get_index_file());
 		return clean ? 0 : 1;
 	} else {
 		return try_merge_command(strategy, xopts_nr, xopts,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5c697279a9..6b778b0a82 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3357,6 +3357,6 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		fprintf_ln(stderr,
 			   _("Total %"PRIu32" (delta %"PRIu32"),"
 			     " reused %"PRIu32" (delta %"PRIu32")"),
-			written, written_delta, reused, reused_delta);
+			   written, written_delta, reused, reused_delta);
 	return 0;
 }
diff --git a/builtin/rm.c b/builtin/rm.c
index 65b448ef8e..f4d3f000b6 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -285,7 +285,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		list.entry[list.nr].is_submodule = S_ISGITLINK(ce->ce_mode);
 		if (list.entry[list.nr++].is_submodule &&
 		    !is_staging_gitmodules_ok(&the_index))
-			die (_("Please stage your changes to .gitmodules or stash them to proceed"));
+			die(_("please stage your changes to .gitmodules or stash them to proceed"));
 	}
 
 	if (pathspec.nr) {
diff --git a/diff.c b/diff.c
index 639eb646b9..b70eb79e47 100644
--- a/diff.c
+++ b/diff.c
@@ -1863,8 +1863,8 @@ static void init_diff_words_data(struct emit_callback *ecbdata,
 		if (regcomp(ecbdata->diff_words->word_regex,
 			    o->word_regex,
 			    REG_EXTENDED | REG_NEWLINE))
-			die ("Invalid regular expression: %s",
-			     o->word_regex);
+			die("invalid regular expression: %s",
+			    o->word_regex);
 	}
 	for (i = 0; i < ARRAY_SIZE(diff_words_styles); i++) {
 		if (o->word_diff == diff_words_styles[i].type) {
diff --git a/reflog-walk.c b/reflog-walk.c
index 5008bbf6ad..e0048a88d8 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -128,7 +128,7 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 	enum selector_type selector = SELECTOR_NONE;
 
 	if (commit->object.flags & UNINTERESTING)
-		die ("Cannot walk reflogs for %s", name);
+		die("cannot walk reflogs for %s", name);
 
 	branch = xstrdup(name);
 	if (at && at[1] == '{') {
@@ -153,7 +153,7 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 			free(branch);
 			branch = resolve_refdup("HEAD", 0, NULL, NULL);
 			if (!branch)
-				die ("No current branch");
+				die("no current branch");
 
 		}
 		reflogs = read_complete_reflog(branch);


[1] https://public-inbox.org/git/20180630090818.28937-1-pclouds@gmail.com/

Nguyễn Thái Ngọc Duy (23):
  Update messages in preparation for i18n
  archive-tar.c: mark more strings for translation
  archive-zip.c: mark more strings for translation
  builtin/config.c: mark more strings for translation
  builtin/grep.c: mark strings for translation
  builtin/pack-objects.c: mark more strings for translation
  builtin/replace.c: mark more strings for translation
  commit-graph.c: mark more strings for translation
  config.c: mark more strings for translation
  connect.c: mark more strings for translation
  convert.c: mark more strings for translation
  dir.c: mark more strings for translation
  environment.c: mark more strings for translation
  exec-cmd.c: mark more strings for translation
  object.c: mark more strings for translation
  pkt-line.c: mark more strings for translation
  refs.c: mark more strings for translation
  refspec.c: mark more strings for translation
  replace-object.c: mark more strings for translation
  sequencer.c: mark more strings for translation
  sha1-file.c: mark more strings for translation
  transport.c: mark more strings for translation
  transport-helper.c: mark more strings for translation

 archive-tar.c                         |  12 +--
 archive-zip.c                         |  14 ++--
 builtin/blame.c                       |   2 +-
 builtin/checkout.c                    |   4 +-
 builtin/commit.c                      |   6 +-
 builtin/config.c                      |  50 ++++++------
 builtin/fast-export.c                 |  42 +++++-----
 builtin/fmt-merge-msg.c               |   2 +-
 builtin/grep.c                        |  12 +--
 builtin/log.c                         |   6 +-
 builtin/merge.c                       |   2 +-
 builtin/pack-objects.c                | 110 +++++++++++++-------------
 builtin/replace.c                     |  90 ++++++++++-----------
 builtin/rm.c                          |   2 +-
 commit-graph.c                        |  20 ++---
 config.c                              |  76 +++++++++---------
 connect.c                             |  85 +++++++++++---------
 convert.c                             |  42 +++++-----
 diff.c                                |   4 +-
 dir.c                                 |   8 +-
 environment.c                         |   4 +-
 exec-cmd.c                            |   2 +-
 object.c                              |  10 +--
 pkt-line.c                            |  26 +++---
 reflog-walk.c                         |   4 +-
 refs.c                                |  40 +++++-----
 refspec.c                             |   2 +-
 replace-object.c                      |   6 +-
 sequencer.c                           |  28 ++++---
 sha1-file.c                           | 110 +++++++++++++-------------
 t/t0021-conversion.sh                 |   2 +-
 t/t1305-config-include.sh             |   2 +-
 t/t1308-config-set.sh                 |   2 +-
 t/t1400-update-ref.sh                 |  20 ++---
 t/t1404-update-ref-errors.sh          |   4 +-
 t/t1450-fsck.sh                       |   2 +-
 t/t3005-ls-files-relative.sh          |   8 +-
 t/t3210-pack-refs.sh                  |   2 +-
 t/t3310-notes-merge-manual-resolve.sh |   6 +-
 t/t5500-fetch-pack.sh                 |   2 +-
 t/t5505-remote.sh                     |   2 +-
 t/t5570-git-daemon.sh                 |   6 +-
 t/t5801-remote-helpers.sh             |   8 +-
 t/t7063-status-untracked-cache.sh     |   2 +-
 t/t7400-submodule-basic.sh            |   2 +-
 transport-helper.c                    |  89 ++++++++++-----------
 transport.c                           |  18 ++---
 47 files changed, 508 insertions(+), 490 deletions(-)

-- 
2.18.0.rc2.476.g39500d3211

