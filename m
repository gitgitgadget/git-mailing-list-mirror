Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E95F1F597
	for <e@80x24.org>; Sun, 29 Jul 2018 00:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbeG2CLD (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 22:11:03 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33298 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731550AbeG2CLC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 22:11:02 -0400
Received: by mail-pl0-f68.google.com with SMTP id 6-v6so3884773plb.0
        for <git@vger.kernel.org>; Sat, 28 Jul 2018 17:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P5YYQZKspC9mQQUqpgUyTQwmB9I9nDSjEKDFeVUaOAk=;
        b=Ar3Bj3gQh0VB43i44GRVuE4tcWmQOPhKXbfk4TRqtAxXGB+l205VazC1/9S7E9ylhH
         453ZX5Hg1rzNjZQPL3OSL7sJqSlnet/LLKggFRYei21v6j3yAnKpzLNdBg4sLpROOZOK
         T3q9KU4/msAlDM7Bgj7ZhwUVFe7JcE1lrbBaHqX9+MBZ836+3T/SHPBgilTcQ8gb4uLW
         uOY+S2AvmBejOwDcK1o84u/+NfArjLeMceIQj8hjdREDRCReKd0p2+uuhnboF3loPa4K
         yUT768HKEQk2pur9N1+HLCHHl/IDk7YMFflsLMKfx5678Ajgi05FczKZurdslvBFHYHD
         v3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P5YYQZKspC9mQQUqpgUyTQwmB9I9nDSjEKDFeVUaOAk=;
        b=Dh+D3Kc4n4VdDjmwiqx3SFjbJ1FIIlSvQQcNkqT1ErSTncZoxMOVBr6Iw+Nw4vUmZy
         pCjnnQbdh7Sr7Vnid/xPSijMRO+sM4k73ulXgfTVEDAUWJezReqeuGdy6dkWAIwRoD+y
         FUSsJWWvos6UbHRC03sMAPSsz3U9eLwjI5tslC5XDoeSqSWOmU9PmC1rCGT+TRplIedQ
         NnYt/Pt/3R6PavN0awIjPVZxrl91bueowfluY2rur8Ag6WxvNPX2xJ81Od1crsULDpfU
         LCCKvplJdYPpctJbOnCO+Rdro0sgZWHKlkLOwClYlqJFTrTy6c8qWl27W0eaYMdFSisX
         I5nA==
X-Gm-Message-State: AOUpUlFvKaIZ3IGFacPrbm39DKV6ouZKapAxH3gzdvzCbrgCqM/Ds4gn
        Mymz0JdYpp3vh00njIddQyG9VOT1
X-Google-Smtp-Source: AAOMgpcUSnhHxq0eOp+30QrIIefyFRTW0PmSkJQcT3DAZ9aPob1lVfbwOxCLH/roeB+WGv26T8NSEQ==
X-Received: by 2002:a17:902:262:: with SMTP id 89-v6mr11138535plc.221.1532824957623;
        Sat, 28 Jul 2018 17:42:37 -0700 (PDT)
Received: from localhost.localdomain ([104.132.11.104])
        by smtp.gmail.com with ESMTPSA id a17-v6sm13034856pfg.106.2018.07.28.17.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 17:42:37 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v4 2/4] wt-status: rename commitable to committable
Date:   Sun, 22 Jul 2018 22:09:01 -0400
Message-Id: <20180723020903.22435-3-sxlijin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180715110807.25544-1-sxlijin@gmail.com>
References: <20180715110807.25544-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a typo in the name of the committable bit in wt_status_state.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 builtin/commit.c | 18 +++++++++---------
 wt-status.c      | 10 +++++-----
 wt-status.h      |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 158e3f843..32f9db33b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -507,7 +507,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	wt_status_collect(s);
 	wt_status_print(s);
 
-	return s->commitable;
+	return s->committable;
 }
 
 static int is_a_merge(const struct commit *current_head)
@@ -653,7 +653,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 {
 	struct stat statbuf;
 	struct strbuf committer_ident = STRBUF_INIT;
-	int commitable;
+	int committable;
 	struct strbuf sb = STRBUF_INIT;
 	const char *hook_arg1 = NULL;
 	const char *hook_arg2 = NULL;
@@ -870,7 +870,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 
 		saved_color_setting = s->use_color;
 		s->use_color = 0;
-		commitable = run_status(s->fp, index_file, prefix, 1, s);
+		committable = run_status(s->fp, index_file, prefix, 1, s);
 		s->use_color = saved_color_setting;
 	} else {
 		struct object_id oid;
@@ -888,7 +888,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			for (i = 0; i < active_nr; i++)
 				if (ce_intent_to_add(active_cache[i]))
 					ita_nr++;
-			commitable = active_nr - ita_nr > 0;
+			committable = active_nr - ita_nr > 0;
 		} else {
 			/*
 			 * Unless the user did explicitly request a submodule
@@ -904,7 +904,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			if (ignore_submodule_arg &&
 			    !strcmp(ignore_submodule_arg, "all"))
 				flags.ignore_submodules = 1;
-			commitable = index_differs_from(parent, &flags, 1);
+			committable = index_differs_from(parent, &flags, 1);
 		}
 	}
 	strbuf_release(&committer_ident);
@@ -916,7 +916,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	 * explicit --allow-empty. In the cherry-pick case, it may be
 	 * empty due to conflict resolution, which the user should okay.
 	 */
-	if (!commitable && whence != FROM_MERGE && !allow_empty &&
+	if (!committable && whence != FROM_MERGE && !allow_empty &&
 	    !(amend && is_a_merge(current_head))) {
 		s->display_comment_prefix = old_display_comment_prefix;
 		run_status(stdout, index_file, prefix, 0, s);
@@ -1186,14 +1186,14 @@ static int parse_and_validate_options(int argc, const char *argv[],
 static int dry_run_commit(int argc, const char **argv, const char *prefix,
 			  const struct commit *current_head, struct wt_status *s)
 {
-	int commitable;
+	int committable;
 	const char *index_file;
 
 	index_file = prepare_index(argc, argv, prefix, current_head, 1);
-	commitable = run_status(stdout, index_file, prefix, 0, s);
+	committable = run_status(stdout, index_file, prefix, 0, s);
 	rollback_index_files();
 
-	return commitable ? 0 : 1;
+	return committable ? 0 : 1;
 }
 
 define_list_config_array_extra(color_status_slots, {"added"});
diff --git a/wt-status.c b/wt-status.c
index 8827a256d..18ea333a5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -773,7 +773,7 @@ static void wt_longstatus_print_updated(struct wt_status *s)
 			continue;
 		if (!shown_header) {
 			wt_longstatus_print_cached_header(s);
-			s->commitable = 1;
+			s->committable = 1;
 			shown_header = 1;
 		}
 		wt_longstatus_print_change_data(s, WT_STATUS_UPDATED, it);
@@ -1008,7 +1008,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 		rev.diffopt.use_color = 0;
 		wt_status_add_cut_line(s->fp);
 	}
-	if (s->verbose > 1 && s->commitable) {
+	if (s->verbose > 1 && s->committable) {
 		/* print_updated() printed a header, so do we */
 		if (s->fp != stdout)
 			wt_longstatus_print_trailer(s);
@@ -1089,7 +1089,7 @@ static void show_merge_in_progress(struct wt_status *s,
 					 _("  (use \"git merge --abort\" to abort the merge)"));
 		}
 	} else {
-		s-> commitable = 1;
+		s-> committable = 1;
 		status_printf_ln(s, color,
 			_("All conflicts fixed but you are still merging."));
 		if (s->hints)
@@ -1665,14 +1665,14 @@ static void wt_longstatus_print(struct wt_status *s)
 					   "new files yourself (see 'git help status')."),
 					 s->untracked_in_ms / 1000.0);
 		}
-	} else if (s->commitable)
+	} else if (s->committable)
 		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed%s"),
 			s->hints
 			? _(" (use -u option to show untracked files)") : "");
 
 	if (s->verbose)
 		wt_longstatus_print_verbose(s);
-	if (!s->commitable) {
+	if (!s->committable) {
 		if (s->amend)
 			status_printf_ln(s, GIT_COLOR_NORMAL, _("No changes"));
 		else if (s->nowarn)
diff --git a/wt-status.h b/wt-status.h
index 1673d146f..937b2c352 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -96,7 +96,7 @@ struct wt_status {
 	unsigned char sha1_commit[GIT_MAX_RAWSZ]; /* when not Initial */
 
 	/* These are computed during processing of the individual sections */
-	int commitable;
+	int committable;
 	int workdir_dirty;
 	const char *index_file;
 	FILE *fp;
-- 
2.18.0

