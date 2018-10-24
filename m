Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C556C1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 15:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeJYAYx (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 20:24:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43319 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbeJYAYv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 20:24:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id n10-v6so1790004pgv.10
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 08:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ioDis4zbp0ktcyDn4ovGG9VNQ1dfYEgDp2ER6Rz3c8c=;
        b=Dh8+8ReZc6Gvumr2YNqKLrOLtRuLSI/lS9oCdLOg4EeLuXUzo1OXXp9uJwav716QP6
         EwcBb2VRHczmefsRgSu54zYue/1tAmrkV+qunIHmYb78Spc+THKKDcDiaE56S5NdzdIW
         J/FVdQGPlXZJnzhDBsWstMDsZb8YzQPTLLzb9BmTIWB9KMEfKS2r3vrjnhCOP2FXXnF3
         DWeBPYgZDs/lhG2AVIWSqMIwjhR6aepFo7AaioRmQHKWRnhJTKTofc2e1R2YUsobBM6j
         yOsgEyctUTFkni+UUkKIhDlmqKFBkq7fOA2lHQpOkmLWOgxOMrNLnYNe9ZIIAEL+9eHz
         GQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ioDis4zbp0ktcyDn4ovGG9VNQ1dfYEgDp2ER6Rz3c8c=;
        b=tsikQWT3XnScg1BB6PxR7EFi1FF/MDv8nnzIOQTEv+GvvKkgulWZqVkLZos15ZYILe
         YBd2I+RLC8XktZ9L/+R2BXS6nKMFcPV8y7eNBvqGHAlWq+i19Jmr6xV6Q+JHiB+yEyAL
         rUcxvq6lM4IDDj4sH9IbYNcaPuc4ja3l/zN9kaa0Z0Dcn1gwn2oNQI3NyJKNRidUzJ3w
         GjbM54vX+usDO63QAH6XZlM2tt90x705YLiKv9kHpEq4QnxfNKXWWyNFkHk95ZZq0YEB
         x8ACGMBPWFVw7xvnVFBMWElzz7NB3FiWXzGU7d1gNCU4EBThPHAu2ozxhZESGPbLcrld
         1NoQ==
X-Gm-Message-State: AGRZ1gKyFdaCacw+WnBo1K9KtNdWef/3wmNla4hjQMsu1CIMD0KGz9tk
        P6V2AID7/szoNabomI6eYVD0PvqS
X-Google-Smtp-Source: AJdET5cB54BZpl+C60qozfH3kqlpVdcl5R93afde1/Z2AoSIWBj7zKO7G2hFqGcEHp8pFcWE3RZZQA==
X-Received: by 2002:a62:d142:: with SMTP id t2-v6mr3176746pfl.175.1540396573169;
        Wed, 24 Oct 2018 08:56:13 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id y24-v6sm6457306pfn.123.2018.10.24.08.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 08:56:12 -0700 (PDT)
Date:   Wed, 24 Oct 2018 08:56:12 -0700 (PDT)
X-Google-Original-Date: Wed, 24 Oct 2018 15:56:06 GMT
Message-Id: <18308c13eee4568dbda39fbf6567666bf4b98eeb.1540396567.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.9.v4.git.gitgitgadget@gmail.com>
References: <pull.9.v3.git.gitgitgadget@gmail.com>
        <pull.9.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 2/3] shallow: offer to prune only non-existing entries
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `prune_shallow()` function wants a full reachability check to be
completed before it goes to work, to ensure that all unreachable entries
are removed from the shallow file.

However, in the upcoming patch we do not even want to go that far. We
really only need to remove entries corresponding to pruned commits, i.e.
to commits that no longer exist.

Let's support that use case.

Rather than extending the signature of `prune_shallow()` to accept
another Boolean, let's turn it into a bit field and declare constants,
for readability.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/prune.c |  2 +-
 commit.h        |  4 +++-
 shallow.c       | 23 +++++++++++++++++------
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index 41230f821..1ec9ddd75 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -161,7 +161,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	free(s);
 
 	if (is_repository_shallow(the_repository))
-		prune_shallow(show_only);
+		prune_shallow(show_only ? PRUNE_SHOW_ONLY : 0);
 
 	return 0;
 }
diff --git a/commit.h b/commit.h
index 1d260d62f..b80d6fdb5 100644
--- a/commit.h
+++ b/commit.h
@@ -249,7 +249,9 @@ extern void assign_shallow_commits_to_refs(struct shallow_info *info,
 					   uint32_t **used,
 					   int *ref_status);
 extern int delayed_reachability_test(struct shallow_info *si, int c);
-extern void prune_shallow(int show_only);
+#define PRUNE_SHOW_ONLY 1
+#define PRUNE_QUICK 2
+extern void prune_shallow(unsigned options);
 extern struct trace_key trace_shallow;
 
 extern int interactive_add(int argc, const char **argv, const char *prefix, int patch);
diff --git a/shallow.c b/shallow.c
index 732e18d54..02fdbfc55 100644
--- a/shallow.c
+++ b/shallow.c
@@ -247,6 +247,7 @@ static void check_shallow_file_for_update(struct repository *r)
 
 #define SEEN_ONLY 1
 #define VERBOSE   2
+#define QUICK 4
 
 struct write_shallow_data {
 	struct strbuf *out;
@@ -261,7 +262,10 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 	const char *hex = oid_to_hex(&graft->oid);
 	if (graft->nr_parent != -1)
 		return 0;
-	if (data->flags & SEEN_ONLY) {
+	if (data->flags & QUICK) {
+		if (!has_object_file(&graft->oid))
+			return 0;
+	} else if (data->flags & SEEN_ONLY) {
 		struct commit *c = lookup_commit(the_repository, &graft->oid);
 		if (!c || !(c->object.flags & SEEN)) {
 			if (data->flags & VERBOSE)
@@ -371,16 +375,23 @@ void advertise_shallow_grafts(int fd)
 
 /*
  * mark_reachable_objects() should have been run prior to this and all
- * reachable commits marked as "SEEN".
+ * reachable commits marked as "SEEN", except when quick_prune is non-zero,
+ * in which case lines are excised from the shallow file if they refer to
+ * commits that do not exist (any longer).
  */
-void prune_shallow(int show_only)
+void prune_shallow(unsigned options)
 {
 	struct lock_file shallow_lock = LOCK_INIT;
 	struct strbuf sb = STRBUF_INIT;
+	unsigned flags = SEEN_ONLY;
 	int fd;
 
-	if (show_only) {
-		write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY | VERBOSE);
+	if (options & PRUNE_QUICK)
+		flags |= QUICK;
+
+	if (options & PRUNE_SHOW_ONLY) {
+		flags |= VERBOSE;
+		write_shallow_commits_1(&sb, 0, NULL, flags);
 		strbuf_release(&sb);
 		return;
 	}
@@ -388,7 +399,7 @@ void prune_shallow(int show_only)
 				       git_path_shallow(the_repository),
 				       LOCK_DIE_ON_ERROR);
 	check_shallow_file_for_update(the_repository);
-	if (write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY)) {
+	if (write_shallow_commits_1(&sb, 0, NULL, flags)) {
 		if (write_in_full(fd, sb.buf, sb.len) < 0)
 			die_errno("failed to write to %s",
 				  get_lock_file_path(&shallow_lock));
-- 
gitgitgadget

