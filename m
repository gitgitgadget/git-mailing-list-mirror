Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92A531F453
	for <e@80x24.org>; Fri,  9 Nov 2018 09:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbeKITOE (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 14:14:04 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44706 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbeKITOE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 14:14:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id b81-v6so188499pfe.11
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 01:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gGX0Cx+jPEUdP0n/ygFRRwrKikf2e9EOE6amDb1Emxc=;
        b=B8NerpFvJjUCQMyjsPBIMHREQnnTZHUSA6cSEAckGlMVSiQBbtxxX9qtCKQYADyiuv
         cHqWjCSFdMAD+cHqTt2tQi3dWjfYyMJHG1Xmerqfb1oVZMnQ15065aKmORNpL5/rY6YD
         LBkRjJOSwWfiNTtmJAWmfmOx/jeXKLsDMAixjCnB4/9YspryhNzIYxUnoa3qSAqtLTDn
         EbpPbhP0WL/XB144eqJzWpVPOT6ThobogBNc6/Ji2ooMvRHAyOyvL3f6Ijm3q2dWXpa0
         /sW8FpAFkCfOqcSi49fc07Quc+V8lAx5M9w9WR4QfqF6OfWCefC5ahU809vecIu+kopW
         XU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gGX0Cx+jPEUdP0n/ygFRRwrKikf2e9EOE6amDb1Emxc=;
        b=G1p5lLtY7DmbXR20aXyWDfJ20st9myZDnVEAqe0BYV1SLoCbGvSq0Mh5qcdKD1B2ST
         nne+zNvkHvF3Wu2n7A1uzW3bycluKNFtgey/6lovLmg3AUIcrnMSjhUIFMDBFRbLLEf/
         vyfjH3RQQM4QCkqieQBby7ecct5i/EZvteAidk+O8GfGY/dYYBaZP/VCIB8wDfSP6Dn9
         os1+cze8rUKyNtYmKpOR6ME+6XvyPTMbMIWwgaYNaFchXLnobdDwLsjSU4elWJFgQ5AN
         asYvQcnHU6O5gQPJrNzn+IO90jWrqXrot9hsnVKl58YSJJR8sLSsOQeDjHqc8QGkbaq2
         bV1Q==
X-Gm-Message-State: AGRZ1gK56uH5HRnFn21cU4AD1xsFlPXKJbhAqapI36EPAYedKwcMzXCc
        KyIO+z6S7oVs3mnXzqL2DofdYhNb
X-Google-Smtp-Source: AJdET5ftVQoUSPND1BgvDjscqwwsdbwNYYmsf4RCdq56pMPR5xs1+AaGZo77mu49x4I7TRQDUDpyMg==
X-Received: by 2002:a63:89c2:: with SMTP id v185mr6349669pgd.97.1541756059768;
        Fri, 09 Nov 2018 01:34:19 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id f62sm6063796pgc.67.2018.11.09.01.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 01:34:19 -0800 (PST)
Date:   Fri, 09 Nov 2018 01:34:19 -0800 (PST)
X-Google-Original-Date: Fri, 09 Nov 2018 09:34:14 GMT
Message-Id: <070092b4309e5e74e3a1b3be54613cccf26e97da.1541756054.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.72.git.gitgitgadget@gmail.com>
References: <pull.72.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] built-in rebase: reinstate `checkout -q` behavior where
 appropriate
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

When we converted a `git checkout -q $onto^0` call to use
`reset_head()`, we inadvertently incurred a change from a twoway_merge
to a oneway_merge, as if we wanted a `git reset --hard` instead.

This has performance ramifications under certain, though, as the
oneway_merge needs to lstat() every single index entry whereas
twoway_merge does not.

So let's go back to the old behavior.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6f6d7de156..c1cc50f3f8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -523,11 +523,12 @@ finished_rebase:
 #define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
 
 static int reset_head(struct object_id *oid, const char *action,
-		      const char *switch_to_branch, int detach_head,
+		      const char *switch_to_branch,
+		      int detach_head, int reset_hard,
 		      const char *reflog_orig_head, const char *reflog_head)
 {
 	struct object_id head_oid;
-	struct tree_desc desc;
+	struct tree_desc desc[2];
 	struct lock_file lock = LOCK_INIT;
 	struct unpack_trees_options unpack_tree_opts;
 	struct tree *tree;
@@ -536,7 +537,7 @@ static int reset_head(struct object_id *oid, const char *action,
 	size_t prefix_len;
 	struct object_id *orig = NULL, oid_orig,
 		*old_orig = NULL, oid_old_orig;
-	int ret = 0;
+	int ret = 0, nr = 0;
 
 	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
 		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
@@ -544,20 +545,20 @@ static int reset_head(struct object_id *oid, const char *action,
 	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
 
-	if (!oid) {
-		if (get_oid("HEAD", &head_oid)) {
-			rollback_lock_file(&lock);
-			return error(_("could not determine HEAD revision"));
-		}
-		oid = &head_oid;
+	if (get_oid("HEAD", &head_oid)) {
+		rollback_lock_file(&lock);
+		return error(_("could not determine HEAD revision"));
 	}
 
+	if (!oid)
+		oid = &head_oid;
+
 	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
 	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
 	unpack_tree_opts.head_idx = 1;
 	unpack_tree_opts.src_index = the_repository->index;
 	unpack_tree_opts.dst_index = the_repository->index;
-	unpack_tree_opts.fn = oneway_merge;
+	unpack_tree_opts.fn = reset_hard ? oneway_merge : twoway_merge;
 	unpack_tree_opts.update = 1;
 	unpack_tree_opts.merge = 1;
 	if (!detach_head)
@@ -568,12 +569,17 @@ static int reset_head(struct object_id *oid, const char *action,
 		return error(_("could not read index"));
 	}
 
-	if (!fill_tree_descriptor(&desc, oid)) {
+	if (!reset_hard && !fill_tree_descriptor(&desc[nr++], &head_oid)) {
+		ret = error(_("failed to find tree of %s"), oid_to_hex(oid));
+		goto leave_reset_head;
+	}
+
+	if (!fill_tree_descriptor(&desc[nr++], oid)) {
 		ret = error(_("failed to find tree of %s"), oid_to_hex(oid));
 		goto leave_reset_head;
 	}
 
-	if (unpack_trees(1, &desc, &unpack_tree_opts)) {
+	if (unpack_trees(nr, desc, &unpack_tree_opts)) {
 		ret = -1;
 		goto leave_reset_head;
 	}
@@ -621,7 +627,8 @@ static int reset_head(struct object_id *oid, const char *action,
 leave_reset_head:
 	strbuf_release(&msg);
 	rollback_lock_file(&lock);
-	free((void *)desc.buffer);
+	while (nr)
+		free((void *)desc[--nr].buffer);
 	return ret;
 }
 
@@ -999,7 +1006,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		rerere_clear(&merge_rr);
 		string_list_clear(&merge_rr, 1);
 
-		if (reset_head(NULL, "reset", NULL, 0, NULL, NULL) < 0)
+		if (reset_head(NULL, "reset", NULL, 0, 1, NULL, NULL) < 0)
 			die(_("could not discard worktree changes"));
 		if (read_basic_state(&options))
 			exit(1);
@@ -1015,7 +1022,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (read_basic_state(&options))
 			exit(1);
 		if (reset_head(&options.orig_head, "reset",
-			       options.head_name, 0, NULL, NULL) < 0)
+			       options.head_name, 0, 1, NULL, NULL) < 0)
 			die(_("could not move back to %s"),
 			    oid_to_hex(&options.orig_head));
 		ret = finish_rebase(&options);
@@ -1379,7 +1386,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			write_file(autostash, "%s", oid_to_hex(&oid));
 			printf(_("Created autostash: %s\n"), buf.buf);
 			if (reset_head(&head->object.oid, "reset --hard",
-				       NULL, 0, NULL, NULL) < 0)
+				       NULL, 0, 1, NULL, NULL) < 0)
 				die(_("could not reset --hard"));
 			printf(_("HEAD is now at %s"),
 			       find_unique_abbrev(&head->object.oid,
@@ -1433,7 +1440,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				strbuf_addf(&buf, "rebase: checkout %s",
 					    options.switch_to);
 				if (reset_head(&oid, "checkout",
-					       options.head_name, 0,
+					       options.head_name, 0, 0,
 					       NULL, NULL) < 0) {
 					ret = !!error(_("could not switch to "
 							"%s"),
@@ -1499,7 +1506,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			 "it...\n"));
 
 	strbuf_addf(&msg, "rebase: checkout %s", options.onto_name);
-	if (reset_head(&options.onto->object.oid, "checkout", NULL, 1,
+	if (reset_head(&options.onto->object.oid, "checkout", NULL, 1, 0,
 	    NULL, msg.buf))
 		die(_("Could not detach HEAD"));
 	strbuf_release(&msg);
@@ -1515,7 +1522,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&msg, "rebase finished: %s onto %s",
 			options.head_name ? options.head_name : "detached HEAD",
 			oid_to_hex(&options.onto->object.oid));
-		reset_head(NULL, "Fast-forwarded", options.head_name, 0,
+		reset_head(NULL, "Fast-forwarded", options.head_name, 0, 0,
 			   "HEAD", msg.buf);
 		strbuf_release(&msg);
 		ret = !!finish_rebase(&options);
-- 
gitgitgadget
