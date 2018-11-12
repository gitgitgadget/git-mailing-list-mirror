Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA5451F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 11:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbeKLVh2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 16:37:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42430 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbeKLVh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 16:37:27 -0500
Received: by mail-pf1-f194.google.com with SMTP id u10-v6so4204473pfn.9
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 03:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i+WED/9kJxZyHHgtVoxCs5YpUgNx33ATGPyf87x3sIY=;
        b=AUFjBLpAmSuQn5jXH2MAibF2Y5WqGSvi0ko2lvfy+1MS77mJk65RWrOHElncOWc8f6
         RohoaxmfJpB1z7TSlneBE2eEjhrb3Ygx/oai7OEw4aVZBDyB8wlw1KTcjSglpmm9KNAE
         A/QfQN+7c++SMg17Z/Cg6IvGJYsP8XqlP2sU9uFrMjIwEvKe4Rlzl6R8zrcQnT3lPH3s
         rv1JQ93O5wcTqnUeOufqkD3CJ04jiBYkQw6Ve5C/OEKOXCYgI0zpZI/2MqyK4kOzGaMP
         y13YnVYi5WFffhbDKhlsL0pIQwa/l1rl4LYV7XHly38CZzpjhvSUPkH6e/pjShZRrECY
         b6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i+WED/9kJxZyHHgtVoxCs5YpUgNx33ATGPyf87x3sIY=;
        b=cwl63A3rRaRE4DnebcUd5iFwWrZTVsyFRtP/ZOcCdATeSBJbWZV8MH0FnMO6Flvy+1
         kJ6wokpuL5n5lhHPNEz/5NLuoTTe4842IE5/ldoBmBXNzup93wmD+IYy8QOS3p7xeE8t
         5EFOYBkqqlwordqESpCikUKe9Vvda6lQBhj2PeWRpqR3PXYQCG2KIDoofijwu5sISFI1
         tGMoB+7kULy1OulHCMsyL6i/wSDbfIQ1ru12zF2ubR8gP17MVv7SN27PZwRgAOmAIgdK
         Wsos2ccLk6FU9/DDC61jL7SGJc4beRy8ZT9EiFM7qRRL5gyIfFOqDEKsBFzoAtBRs/iD
         1wLQ==
X-Gm-Message-State: AGRZ1gLbE+nw63nJDS2q22qDxn1/rAWgLxw0+QAMBKYrLEpdckOLTq/L
        OqCL6SiWHkcO5yvSJjftt2cMoRVj
X-Google-Smtp-Source: AJdET5eWfWZUFkRdgSPhUx2vHRc0MfmMUjgJyvOdGlSAjAwrS4LZDdk+agDIZxnyPH9+lHpA68B1PQ==
X-Received: by 2002:a63:e348:: with SMTP id o8mr540374pgj.158.1542023073376;
        Mon, 12 Nov 2018 03:44:33 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id g64-v6sm18380841pfe.37.2018.11.12.03.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 03:44:32 -0800 (PST)
Date:   Mon, 12 Nov 2018 03:44:32 -0800 (PST)
X-Google-Original-Date: Mon, 12 Nov 2018 11:44:26 GMT
Message-Id: <a7360b856f05169bad094c60e92571035e9d96a7.1542023067.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.72.v2.git.gitgitgadget@gmail.com>
References: <pull.72.git.gitgitgadget@gmail.com>
        <pull.72.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/3] built-in rebase: reinstate `checkout -q` behavior
 where appropriate
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
 builtin/rebase.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 074594cf10..dc78c1497d 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -523,14 +523,16 @@ finished_rebase:
 #define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
 
 #define RESET_HEAD_DETACH (1<<0)
+#define RESET_HEAD_HARD (1<<1)
 
 static int reset_head(struct object_id *oid, const char *action,
 		      const char *switch_to_branch, unsigned flags,
 		      const char *reflog_orig_head, const char *reflog_head)
 {
 	unsigned detach_head = flags & RESET_HEAD_DETACH;
+	unsigned reset_hard = flags & RESET_HEAD_HARD;
 	struct object_id head_oid;
-	struct tree_desc desc;
+	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
 	struct unpack_trees_options unpack_tree_opts;
 	struct tree *tree;
@@ -539,7 +541,7 @@ static int reset_head(struct object_id *oid, const char *action,
 	size_t prefix_len;
 	struct object_id *orig = NULL, oid_orig,
 		*old_orig = NULL, oid_old_orig;
-	int ret = 0;
+	int ret = 0, nr = 0;
 
 	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
 		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
@@ -549,20 +551,20 @@ static int reset_head(struct object_id *oid, const char *action,
 		goto leave_reset_head;
 	}
 
-	if (!oid) {
-		if (get_oid("HEAD", &head_oid)) {
-			ret = error(_("could not determine HEAD revision"));
-			goto leave_reset_head;
-		}
-		oid = &head_oid;
+	if ((!oid || !reset_hard) && get_oid("HEAD", &head_oid)) {
+		ret = error(_("could not determine HEAD revision"));
+		goto leave_reset_head;
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
@@ -573,12 +575,17 @@ static int reset_head(struct object_id *oid, const char *action,
 		goto leave_reset_head;
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
@@ -625,7 +632,8 @@ static int reset_head(struct object_id *oid, const char *action,
 leave_reset_head:
 	strbuf_release(&msg);
 	rollback_lock_file(&lock);
-	free((void *)desc.buffer);
+	while (nr)
+		free((void *)desc[--nr].buffer);
 	return ret;
 }
 
@@ -1003,7 +1011,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		rerere_clear(&merge_rr);
 		string_list_clear(&merge_rr, 1);
 
-		if (reset_head(NULL, "reset", NULL, 0, NULL, NULL) < 0)
+		if (reset_head(NULL, "reset", NULL, RESET_HEAD_HARD,
+			       NULL, NULL) < 0)
 			die(_("could not discard worktree changes"));
 		if (read_basic_state(&options))
 			exit(1);
@@ -1019,7 +1028,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (read_basic_state(&options))
 			exit(1);
 		if (reset_head(&options.orig_head, "reset",
-			       options.head_name, 0, NULL, NULL) < 0)
+			       options.head_name, RESET_HEAD_HARD,
+			       NULL, NULL) < 0)
 			die(_("could not move back to %s"),
 			    oid_to_hex(&options.orig_head));
 		ret = finish_rebase(&options);
@@ -1383,7 +1393,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			write_file(autostash, "%s", oid_to_hex(&oid));
 			printf(_("Created autostash: %s\n"), buf.buf);
 			if (reset_head(&head->object.oid, "reset --hard",
-				       NULL, 0, NULL, NULL) < 0)
+				       NULL, RESET_HEAD_HARD, NULL, NULL) < 0)
 				die(_("could not reset --hard"));
 			printf(_("HEAD is now at %s"),
 			       find_unique_abbrev(&head->object.oid,
-- 
gitgitgadget
