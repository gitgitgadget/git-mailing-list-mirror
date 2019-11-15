Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 997301F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 12:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfKOMgc (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 07:36:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50775 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbfKOMga (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 07:36:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id l17so9497253wmh.0
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 04:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eVaQ1Y6X4IxTHV6yN1mrAR/Srf8HR3WZcCUPhD+bVSY=;
        b=eq4u0ygjGn0mmjOyrvQJp1+Hhc8k2vqduXo5FCgsrVhvsEi7rV/eHU/JhzwtK510yB
         B6k7VEgL7MM0ZM1awImtnTrx+XZXRILufZVqf+U24cwvo9bDppYQMYN60rv9RzPxd3p+
         iUNXUHKJNyyOm+EILFNvbMXF9TOOrfiA/k67d9JdEq27S115ilfW5GJoMSvhA3AcGmSa
         JGaS+IeMd5Z7jy0UwTef9tRvRXKcsPhB/SvXEkjVlCH0xIIoya+Xqg2DkxlbKyjTjdnP
         S6S5cfeDYjdsMkCVU9hNieKBi8RUwUeE0qdoKRO2wtNcRNt4U/ma4yIy09MxlQPXhwVJ
         XAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eVaQ1Y6X4IxTHV6yN1mrAR/Srf8HR3WZcCUPhD+bVSY=;
        b=cPKZtyKqhPKTZogj0pUoCn1PpF402yoxiEAg2hvRla/W7akst43myuG0Qlf2ob1EmB
         4wPqkh56tBRKhvr85hjVrQgisjWyQHSGp9sz+wP3ltMFQnXwe7lu7j+w53TYBRN++4tk
         bCKMBMgUrUUmKh3b6GIrkACrD800TJl1ZXi3SoKtZGAM6ZwExy3Aj0jYnOLZmemvjFiN
         Zp/L3vb+OLYxtfcnN+qjNAYJz6cafP79qii8vjjoD2krjSdbMIeKycxxdonf6UNPSrUH
         70j8zq8nMEPtHdQd0Otu/Bpazx++9rM/WzqjyRJK37EnyS0HO04CmSyRAjsNPd9GekTq
         0NBg==
X-Gm-Message-State: APjAAAXIzDyMRW8+lgsCeM9Oq0FUL42UDpj4I/fPh/Lj+BIMk4PZfJxF
        41esuzNCWT72jcjCMONhxMy17rfV
X-Google-Smtp-Source: APXvYqyqtNO8zhXja4g89fjlA5gIpsgq4pZAEahEKThAKjMtZ5mXFJTJ/dyH2PUEgF2V6R0H9KFiHQ==
X-Received: by 2002:a05:600c:214c:: with SMTP id v12mr14111169wml.124.1573821387804;
        Fri, 15 Nov 2019 04:36:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x9sm10891366wru.32.2019.11.15.04.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 04:36:27 -0800 (PST)
Message-Id: <0c8a71e2e861f2ef657a363cc3da198f9062bf95.1573821382.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.171.git.1573821382.gitgitgadget@gmail.com>
References: <pull.171.git.1573821382.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 12:36:20 +0000
Subject: [PATCH 6/8] built-in add -i: implement the `patch` command
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

Well, it is not a full implementation yet. In the interest of making
this easy to review (and easy to keep bugs out), we still hand off to
the Perl script to do the actual work.

The `patch` functionality actually makes up for more than half of the
1,800+ lines of `git-add--interactive.perl`. It will be ported from Perl
to C incrementally, later.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 91 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 7 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 9ed4455a86..fb8124fc57 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -8,6 +8,7 @@
 #include "string-list.h"
 #include "lockfile.h"
 #include "dir.h"
+#include "run-command.h"
 
 struct add_i_state {
 	struct repository *r;
@@ -374,7 +375,7 @@ static ssize_t list_and_choose(struct add_i_state *s,
 
 struct adddel {
 	uintmax_t add, del;
-	unsigned seen:1, binary:1;
+	unsigned seen:1, unmerged:1, binary:1;
 };
 
 struct file_item {
@@ -414,6 +415,7 @@ struct collection_status {
 	const char *reference;
 
 	unsigned skip_unseen:1;
+	size_t unmerged_count, binary_count;
 	struct string_list *files;
 	struct hashmap file_map;
 };
@@ -436,7 +438,7 @@ static void collect_changes_cb(struct diff_queue_struct *q,
 		int hash = strhash(name);
 		struct pathname_entry *entry;
 		struct file_item *file_item;
-		struct adddel *adddel;
+		struct adddel *adddel, *other_adddel;
 
 		entry = hashmap_get_entry_from_hash(&s->file_map, hash, name,
 						    struct pathname_entry, ent);
@@ -456,11 +458,21 @@ static void collect_changes_cb(struct diff_queue_struct *q,
 		file_item = entry->item;
 		adddel = s->phase == FROM_INDEX ?
 			&file_item->index : &file_item->worktree;
+		other_adddel = s->phase == FROM_INDEX ?
+			&file_item->worktree : &file_item->index;
 		adddel->seen = 1;
 		adddel->add = stat.files[i]->added;
 		adddel->del = stat.files[i]->deleted;
-		if (stat.files[i]->is_binary)
+		if (stat.files[i]->is_binary) {
+			if (!other_adddel->binary)
+				s->binary_count++;
 			adddel->binary = 1;
+		}
+		if (stat.files[i]->is_unmerged) {
+			if (!other_adddel->unmerged)
+				s->unmerged_count++;
+			adddel->unmerged = 1;
+		}
 	}
 	free_diffstat_info(&stat);
 }
@@ -474,7 +486,9 @@ enum modified_files_filter {
 static int get_modified_files(struct repository *r,
 			      enum modified_files_filter filter,
 			      struct prefix_item_list *files,
-			      const struct pathspec *ps)
+			      const struct pathspec *ps,
+			      size_t *unmerged_count,
+			      size_t *binary_count)
 {
 	struct object_id head_oid;
 	int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
@@ -521,6 +535,10 @@ static int get_modified_files(struct repository *r,
 		}
 	}
 	hashmap_free_entries(&s.file_map, struct pathname_entry, ent);
+	if (unmerged_count)
+		*unmerged_count = s.unmerged_count;
+	if (binary_count)
+		*binary_count = s.binary_count;
 
 	/* While the diffs are ordered already, we ran *two* diffs... */
 	string_list_sort(&files->items);
@@ -603,7 +621,7 @@ static int run_status(struct add_i_state *s, const struct pathspec *ps,
 		      struct prefix_item_list *files,
 		      struct list_and_choose_options *opts)
 {
-	if (get_modified_files(s->r, NO_FILTER, files, ps) < 0)
+	if (get_modified_files(s->r, NO_FILTER, files, ps, NULL, NULL) < 0)
 		return -1;
 
 	list(s, &files->items, NULL, &opts->list_opts);
@@ -620,7 +638,7 @@ static int run_update(struct add_i_state *s, const struct pathspec *ps,
 	size_t count, i;
 	struct lock_file index_lock;
 
-	if (get_modified_files(s->r, WORKTREE_ONLY, files, ps) < 0)
+	if (get_modified_files(s->r, WORKTREE_ONLY, files, ps, NULL, NULL) < 0)
 		return -1;
 
 	if (!files->items.nr) {
@@ -699,7 +717,7 @@ static int run_revert(struct add_i_state *s, const struct pathspec *ps,
 	struct tree *tree;
 	struct diff_options diffopt = { NULL };
 
-	if (get_modified_files(s->r, INDEX_ONLY, files, ps) < 0)
+	if (get_modified_files(s->r, INDEX_ONLY, files, ps, NULL, NULL) < 0)
 		return -1;
 
 	if (!files->items.nr) {
@@ -851,6 +869,64 @@ static int run_add_untracked(struct add_i_state *s, const struct pathspec *ps,
 	return res;
 }
 
+static int run_patch(struct add_i_state *s, const struct pathspec *ps,
+		     struct prefix_item_list *files,
+		     struct list_and_choose_options *opts)
+{
+	int res = 0;
+	ssize_t count, i, j;
+	size_t unmerged_count = 0, binary_count = 0;
+
+	if (get_modified_files(s->r, WORKTREE_ONLY, files, ps,
+			       &unmerged_count, &binary_count) < 0)
+		return -1;
+
+	if (unmerged_count || binary_count) {
+		for (i = j = 0; i < files->items.nr; i++) {
+			struct file_item *item = files->items.items[i].util;
+
+			if (item->index.binary || item->worktree.binary) {
+				free(item);
+				free(files->items.items[i].string);
+			} else if (item->index.unmerged ||
+				 item->worktree.unmerged) {
+				color_fprintf_ln(stderr, s->error_color,
+						 _("ignoring unmerged: %s"),
+						 files->items.items[i].string);
+				free(item);
+				free(files->items.items[i].string);
+			} else
+				files->items.items[j++] = files->items.items[i];
+		}
+		files->items.nr = j;
+	}
+
+	if (!files->items.nr) {
+		if (binary_count)
+			fprintf(stderr, _("Only binary files changed.\n"));
+		else
+			fprintf(stderr, _("No changes.\n"));
+		return 0;
+	}
+
+	opts->prompt = N_("Patch update");
+	count = list_and_choose(s, files, opts);
+	if (count >= 0) {
+		struct argv_array args = ARGV_ARRAY_INIT;
+
+		argv_array_pushl(&args, "git", "add--interactive", "--patch",
+				 "--", NULL);
+		for (i = 0; i < files->items.nr; i++)
+			if (files->selected[i])
+				argv_array_push(&args,
+						files->items.items[i].string);
+		res = run_command_v_opt(args.argv, 0);
+		argv_array_clear(&args);
+	}
+
+	return res;
+}
+
 static int run_help(struct add_i_state *s, const struct pathspec *unused_ps,
 		    struct prefix_item_list *unused_files,
 		    struct list_and_choose_options *unused_opts)
@@ -948,6 +1024,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 		{ "update", run_update },
 		{ "revert", run_revert },
 		{ "add untracked", run_add_untracked },
+		{ "patch", run_patch },
 		{ "help", run_help },
 	};
 	struct prefix_item_list commands = PREFIX_ITEM_LIST_INIT;
-- 
gitgitgadget

