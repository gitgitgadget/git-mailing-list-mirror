Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C3F41F453
	for <e@80x24.org>; Wed, 20 Feb 2019 11:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfBTLle (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 06:41:34 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44357 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfBTLld (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 06:41:33 -0500
Received: by mail-ed1-f68.google.com with SMTP id b20so19540771edw.11
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 03:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Tzuao/CTh05RT927rsqrYv5mmnpve7y3eFEkUR9P/Uc=;
        b=YfX5sDywoc2Cabw4JCQ8leFqp/j2+MeEB3VLlj16j6Cfig9vurzTpCTra8KTUkZBCq
         rp2j5KnLIrD4Lg8mYTC3I2NlhfXoaD+OlQQh5MvgPs+IGrsxUwY+d16GAtoe0QU1i3RV
         jwbJNwJqYxZxLLStxJngDMrs0QQUUHLyUOo9DJ2bhFctoYbl4IZEclI9psnMdFcHzPvo
         wvbqpKoW/oJkV6STpAji0U8IPTRbqAObLqb30o7w4NHB78d6VTz0Dh4XR8mvkRK46YK0
         ybLa4l27WCrWgWAECrL3RQHaJPxAkLl+zFDl+RTF9ux23tZQfFFeyTj+d+gzbTYUOYVM
         Elfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Tzuao/CTh05RT927rsqrYv5mmnpve7y3eFEkUR9P/Uc=;
        b=ED+ojaYs88t32VDlXZ/mxezgc441wKDD7d46goT1TFHWw8WPJPfoneD8aC2juPIrxa
         st6DfR9dSeDA5NETYhpTpN7Rn/fFxQVLxH5hMhewWraVc21yrLWy6QGexMdGGAcv21bT
         g0k7FBibhu6CjLGPE7go6unV51+iC7KRHukFuko1qe7gBB6XsqT2wTi9Do98N4lbwpvB
         nEGdqXb5yOHFdX/y0/vEuGwZHSaHr3z8iPUbvaRBBrYJkuxktqVWi9Pys2ZFs1Byi+Cb
         6fMUxhvSZL+/IsxuCg7Rj8AX6C70men0oXyXdZzQm5+rPBCAFQMHoC8lztZ08n489Rj/
         JDIg==
X-Gm-Message-State: AHQUAubFvIeNHpfmMjtLhQBQhdhS/beJT6O5VuIZ8UJcyzEhc5c3IKxY
        bm/C/5KYOOv5y5JLLQAY1ttbMSjz
X-Google-Smtp-Source: AHgI3IaE7t84NYo4gWZbrmnTT72g2bJy3ymTrDvDPxhYh7h9rsYTUPP0IC/XI96WcAlu7EgyKxCvoA==
X-Received: by 2002:a17:906:bf2:: with SMTP id z18mr16846072ejg.52.1550662891094;
        Wed, 20 Feb 2019 03:41:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f1sm4351904ejl.65.2019.02.20.03.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 03:41:30 -0800 (PST)
Date:   Wed, 20 Feb 2019 03:41:30 -0800 (PST)
X-Google-Original-Date: Wed, 20 Feb 2019 11:41:20 GMT
Message-Id: <8790ffaa394603279927f9cd4c80f1d06bb5f976.1550662887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v5.git.gitgitgadget@gmail.com>
References: <pull.103.v4.git.gitgitgadget@gmail.com>
        <pull.103.v5.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 03/10] add-interactive.c: implement list_modified
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Slavica Djukic <slawica92@hotmail.com>

Implement list_modified from Perl, which will be used
by most of the *_cmd functions, including status in the
following commit.

It lists a numstat comparing changed files between a) the worktree and
the index; b) the index and the HEAD.

To do so, we use run_diff_index() and run_diff_files() to get changed
files, use the diffstat API on them to get the numstat and use a
combination of a hashmap and qsort() to print the result in
O(n) + O(n lg n) complexity.

Add new file: add-interactive.c which will be used for implementing
"application logic" of git add -i (alongside with add-interactive.h,
added in later commit), whereas add--helper.c will be used mostly
for parsing the command line.

Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Original-patch-by: Daniel Ferreira <bnmvco@gmail.com>
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 Makefile          |   1 +
 add-interactive.c | 188 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 189 insertions(+)
 create mode 100644 add-interactive.c

diff --git a/Makefile b/Makefile
index e64e202deb..1b3c06b633 100644
--- a/Makefile
+++ b/Makefile
@@ -847,6 +847,7 @@ LIB_H = $(shell $(FIND) . \
 	-name '*.h' -print)
 
 LIB_OBJS += abspath.o
+LIB_OBJS += add-interactive.o
 LIB_OBJS += advice.o
 LIB_OBJS += alias.o
 LIB_OBJS += alloc.o
diff --git a/add-interactive.c b/add-interactive.c
new file mode 100644
index 0000000000..7d096207d4
--- /dev/null
+++ b/add-interactive.c
@@ -0,0 +1,188 @@
+#include "cache.h"
+#include "commit.h"
+#include "color.h"
+#include "config.h"
+#include "diffcore.h"
+#include "revision.h"
+
+enum collection_phase {
+	WORKTREE,
+	INDEX
+};
+
+struct file_stat {
+	struct hashmap_entry ent;
+	struct {
+		uintmax_t added, deleted;
+	} index, worktree;
+	char name[FLEX_ARRAY];
+};
+
+struct collection_status {
+	enum collection_phase phase;
+
+	const char *reference;
+	struct pathspec pathspec;
+
+	struct hashmap file_map;
+};
+
+static int hash_cmp(const void *unused_cmp_data, const void *entry,
+		    const void *entry_or_key, const void *keydata)
+{
+	const struct file_stat *e1 = entry, *e2 = entry_or_key;
+	const char *name = keydata ? keydata : e2->name;
+
+	return strcmp(e1->name, name);
+}
+
+static int alphabetical_cmp(const void *a, const void *b)
+{
+	struct file_stat *f1 = *((struct file_stat **)a);
+	struct file_stat *f2 = *((struct file_stat **)b);
+
+	return strcmp(f1->name, f2->name);
+}
+
+static void collect_changes_cb(struct diff_queue_struct *q,
+			       struct diff_options *options,
+			       void *data)
+{
+	struct collection_status *s = data;
+	struct diffstat_t stat = { 0 };
+	int i;
+
+	if (!q->nr)
+		return;
+
+	compute_diffstat(options, &stat);
+
+	for (i = 0; i < stat.nr; i++) {
+		struct file_stat *entry;
+		const char *name = stat.files[i]->name;
+		unsigned int hash = strhash(name);
+
+		entry = hashmap_get_from_hash(&s->file_map, hash, name);
+		if (!entry) {
+			FLEX_ALLOC_STR(entry, name, name);
+			hashmap_entry_init(entry, hash);
+			hashmap_add(&s->file_map, entry);
+		}
+
+		if (s->phase == WORKTREE) {
+			entry->worktree.added = stat.files[i]->added;
+			entry->worktree.deleted = stat.files[i]->deleted;
+		} else if (s->phase == INDEX) {
+			entry->index.added = stat.files[i]->added;
+			entry->index.deleted = stat.files[i]->deleted;
+		}
+	}
+}
+
+static void collect_changes_worktree(struct collection_status *s)
+{
+	struct rev_info rev;
+
+	s->phase = WORKTREE;
+
+	init_revisions(&rev, NULL);
+	setup_revisions(0, NULL, &rev, NULL);
+
+	rev.max_count = 0;
+
+	rev.diffopt.flags.ignore_dirty_submodules = 1;
+	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = collect_changes_cb;
+	rev.diffopt.format_callback_data = s;
+
+	run_diff_files(&rev, 0);
+}
+
+static void collect_changes_index(struct collection_status *s)
+{
+	struct rev_info rev;
+	struct setup_revision_opt opt = { 0 };
+
+	s->phase = INDEX;
+
+	init_revisions(&rev, NULL);
+	opt.def = s->reference;
+	setup_revisions(0, NULL, &rev, &opt);
+
+	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = collect_changes_cb;
+	rev.diffopt.format_callback_data = s;
+
+	run_diff_index(&rev, 1);
+}
+
+static int is_inital_commit(void)
+{
+	struct object_id sha1;
+	if (get_oid("HEAD", &sha1))
+		return 1;
+	return 0;
+}
+
+static const char *get_diff_reference(void)
+{
+	if(is_inital_commit())
+		return empty_tree_oid_hex();
+	return "HEAD";
+}
+
+static void filter_files(const char *filter, struct hashmap *file_map,
+			 struct file_stat **files)
+{
+
+	for (int i = 0; i < hashmap_get_size(file_map); i++) {
+		struct file_stat *f = files[i];
+
+		if ((!(f->worktree.added || f->worktree.deleted)) &&
+		   (!strcmp(filter, "file-only")))
+				hashmap_remove(file_map, f, NULL);
+
+		if ((!(f->index.added || f->index.deleted)) &&
+		   (!strcmp(filter, "index-only")))
+				hashmap_remove(file_map, f, NULL);
+	}
+}
+
+static struct collection_status *list_modified(struct repository *r, const char *filter)
+{
+	int i = 0;
+	struct collection_status *s = xcalloc(1, sizeof(*s));
+	struct hashmap_iter iter;
+	struct file_stat **files;
+	struct file_stat *entry;
+
+	if (repo_read_index(r) < 0) {
+		printf("\n");
+		return NULL;
+	}
+
+	s->reference = get_diff_reference();
+	hashmap_init(&s->file_map, hash_cmp, NULL, 0);
+
+	collect_changes_worktree(s);
+	collect_changes_index(s);
+
+	if (hashmap_get_size(&s->file_map) < 1) {
+		printf("\n");
+		return NULL;
+	}
+
+	hashmap_iter_init(&s->file_map, &iter);
+
+	files = xcalloc(hashmap_get_size(&s->file_map), sizeof(struct file_stat *));
+	while ((entry = hashmap_iter_next(&iter))) {
+		files[i++] = entry;
+	}
+	QSORT(files, hashmap_get_size(&s->file_map), alphabetical_cmp);
+
+	if (filter)
+		filter_files(filter, &s->file_map, files);
+
+	free(files);
+	return s;
+}
-- 
gitgitgadget

