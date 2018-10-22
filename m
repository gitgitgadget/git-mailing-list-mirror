Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4946A1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 22:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbeJWG0D (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 02:26:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40503 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbeJWG0C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 02:26:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id g21-v6so13582936pfi.7
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 15:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IrSMn/yqUAUB0iApLsivSagvG7v4aqWjyElSwqfsH8I=;
        b=PjfneO8MTUNK4Ie5IzNIsNRxANq5EdGO/bw1Sdg5ZlP1sAQjGXSTbrGk+TzwX6eNZL
         fQZAlzcG0EdseDqXN+MensrZoC8AZKQuK7pqeKg7OaZYQX0g2qtRfA9AA3vBhXB/wygz
         oPNmwZX2qjrTmjF5RkOUZKgiVaU1nnIxUz3daocD1DzjJ2tTL6oalEqD+1TIPUJqIfA+
         vKXHjqP2kHeImOjrG1nKUIrhu/tATRq3uA3R59GwkjslCQ0Mep6yogp7tF9uMB72dVGw
         IqEH2gmz5k32whr25l2EhnkTOFSSSU/aHT2rIVUbDZmllmyIApbEGuYy5Eb5/6DAOoKs
         clNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IrSMn/yqUAUB0iApLsivSagvG7v4aqWjyElSwqfsH8I=;
        b=lTv8evDEuxY3NxEe4LRxITsKaSicXgHwmRGLZfECE31eoZCwx6GsRWVyNH/8BI0DrR
         IWgJ6iA4F2/pebjGMgKvuy28xzb2ZtsApQZ763rt7TAz8HF7IW+d7Gq4P3BaxDqFVujS
         wl3EIhIIv48SNV99OcFtoSSkfy0V3K/cCPWlUQGLZ3tZ2wJxns2tovoirk2ArtQ3TwLL
         hbUJrkkhMW/J55K2s+UXHOWZzsQTG0qYTt9HOqeob5QfOJsnYEuxOhJZrk0+aw0xy+7z
         GTVGRWgDEIeSwv6Q0LSrDwd2BjiuFQ4KGMLNq7kL1nfbEg2BJrwNqWpb9cT3UdZLhtPk
         DSsQ==
X-Gm-Message-State: ABuFfohg0NJmqlgkifqHFBzmeJ7x+YYvMnNmJj7ERz7m/UYST1LWotOK
        EkkW6kBvFHfk6qTEpv+zMcL/Mbwq
X-Google-Smtp-Source: ACcGV63Z+H9as4iWzaZfkGQLRzVHkxwX+siQBLrUnh2TsbRQTagD6EISVl7L1OnGZApbiHgf8DuZ9Q==
X-Received: by 2002:a62:1ccb:: with SMTP id c194-v6mr46779364pfc.203.1540245939775;
        Mon, 22 Oct 2018 15:05:39 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id w66-v6sm32707067pfb.51.2018.10.22.15.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 15:05:38 -0700 (PDT)
Date:   Mon, 22 Oct 2018 15:05:38 -0700 (PDT)
X-Google-Original-Date: Mon, 22 Oct 2018 22:05:32 GMT
Message-Id: <f085eb4f728f5cd102f56b7a90ce9b10fdb59dee.1540245934.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.9.v3.git.gitgitgadget@gmail.com>
References: <pull.9.v2.git.gitgitgadget@gmail.com>
        <pull.9.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 2/3] shallow: offer to prune only non-existing entries
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

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/prune.c |  2 +-
 commit.h        |  2 +-
 shallow.c       | 22 +++++++++++++++++-----
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index 41230f821..6d6ab6cf1 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -161,7 +161,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	free(s);
 
 	if (is_repository_shallow(the_repository))
-		prune_shallow(show_only);
+		prune_shallow(show_only, 0);
 
 	return 0;
 }
diff --git a/commit.h b/commit.h
index 1d260d62f..ff34447ab 100644
--- a/commit.h
+++ b/commit.h
@@ -249,7 +249,7 @@ extern void assign_shallow_commits_to_refs(struct shallow_info *info,
 					   uint32_t **used,
 					   int *ref_status);
 extern int delayed_reachability_test(struct shallow_info *si, int c);
-extern void prune_shallow(int show_only);
+extern void prune_shallow(int show_only, int quick_prune);
 extern struct trace_key trace_shallow;
 
 extern int interactive_add(int argc, const char **argv, const char *prefix, int patch);
diff --git a/shallow.c b/shallow.c
index 732e18d54..0a2671bc2 100644
--- a/shallow.c
+++ b/shallow.c
@@ -247,6 +247,7 @@ static void check_shallow_file_for_update(struct repository *r)
 
 #define SEEN_ONLY 1
 #define VERBOSE   2
+#define QUICK_PRUNE 4
 
 struct write_shallow_data {
 	struct strbuf *out;
@@ -261,7 +262,11 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 	const char *hex = oid_to_hex(&graft->oid);
 	if (graft->nr_parent != -1)
 		return 0;
-	if (data->flags & SEEN_ONLY) {
+	if (data->flags & QUICK_PRUNE) {
+		struct commit *c = lookup_commit(the_repository, &graft->oid);
+		if (!c || parse_commit(c))
+			return 0;
+	} else if (data->flags & SEEN_ONLY) {
 		struct commit *c = lookup_commit(the_repository, &graft->oid);
 		if (!c || !(c->object.flags & SEEN)) {
 			if (data->flags & VERBOSE)
@@ -371,16 +376,23 @@ void advertise_shallow_grafts(int fd)
 
 /*
  * mark_reachable_objects() should have been run prior to this and all
- * reachable commits marked as "SEEN".
+ * reachable commits marked as "SEEN", except when quick_prune is non-zero,
+ * in which case lines are excised from the shallow file if they refer to
+ * commits that do not exist (any longer).
  */
-void prune_shallow(int show_only)
+void prune_shallow(int show_only, int quick_prune)
 {
 	struct lock_file shallow_lock = LOCK_INIT;
 	struct strbuf sb = STRBUF_INIT;
+	unsigned flags = SEEN_ONLY;
 	int fd;
 
+	if (quick_prune)
+		flags |= QUICK_PRUNE;
+
 	if (show_only) {
-		write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY | VERBOSE);
+		flags |= VERBOSE;
+		write_shallow_commits_1(&sb, 0, NULL, flags);
 		strbuf_release(&sb);
 		return;
 	}
@@ -388,7 +400,7 @@ void prune_shallow(int show_only)
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

