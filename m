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
	by dcvr.yhbt.net (Postfix) with ESMTP id E41641F461
	for <e@80x24.org>; Tue, 27 Aug 2019 12:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfH0M6L (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 08:58:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37862 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbfH0M6D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 08:58:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id z11so18719477wrt.4
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 05:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3EMC294rIyauU6ygUTkuPxckieWcv6bbZs3Yi/71pnQ=;
        b=jsceBp3DwPOAH9F3mg82MwcAa4YyQaI7fmZsruilYhqSAAzOvH2za0B4ZgwwdvCahX
         RH44qqH7ppWJcIM0ZAR2O9cWWnLxBItllhCUbIzkUIza+If0d/Zz8Z86cIkJNNMHFDIB
         VhYAYs4Cs5v+nMUaELW7taao15o7q9QHY2y1CY8/FwgpDrBzmeuqNz4T9I8HCEVbiPXp
         NgsEvRTYZDwyopikXxywH4I5SWtm3VKzRAldFbgxX+I2p4NKfBepBibqgVEGKiR4tF2u
         0CCz2v3YvZFZmJRUMZ9Zonrk5UESk6xVya7C7/QEUqm6FtAf3eAVTfRSFps9PZHE8dzS
         pnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3EMC294rIyauU6ygUTkuPxckieWcv6bbZs3Yi/71pnQ=;
        b=JNtBS0+P5bmTKi8wuCnHs39uERmlnl/t1B1tIoac1GYW0/dxKxmUT3OHMYT0AfiiSp
         e0qBzjoOypsbDR1CwkFc9Xny4CmCc83eyLtJWp3Z6h9+V3lRNcmhRii6JTKu/JJosPnI
         g2rdZ/aeMuRo0PxqD3SwIa4oYtwkZGZGe6RqO4U/hLsko8eoEJcCtlwWj38DUopkoGVZ
         wv6j3Rc/3MX/HWbOVk3Bm5FLVEGKOY+Xq9Qcs6Jn3bmg58RU3Tex7LqB8clMTeZSyIJc
         pDDC2qZAmNQodX4NPhc+np9qilLwAPYforcIlQFG9c2887wfFKgZhs8xCNJuag/IX7kF
         JkBw==
X-Gm-Message-State: APjAAAVYc/T8pkElCAL+BP/pHh3qD58xT4BjFZmaZ/Gl4cjSD21aqjH5
        Iwf4jLuLaaXTf9qp/W80aXjtlEedX4U=
X-Google-Smtp-Source: APXvYqwRpWmI40tPHJygCi6vjnB+iI79Qv5QdCz76CkrD3LuUUY+lWDN9R/7zUyHy+MR3hd4R3wbNQ==
X-Received: by 2002:a5d:604d:: with SMTP id j13mr28379796wrt.244.1566910679234;
        Tue, 27 Aug 2019 05:57:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14sm14300192wrv.12.2019.08.27.05.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 05:57:58 -0700 (PDT)
Date:   Tue, 27 Aug 2019 05:57:58 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Aug 2019 12:57:48 GMT
Message-Id: <c5a699b6b27e04cf341a20258702bb6d3df917e5.1566910672.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v4.git.gitgitgadget@gmail.com>
References: <pull.170.v3.git.gitgitgadget@gmail.com>
        <pull.170.v4.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 07/11] Add a function to determine unique prefixes for a
 list of strings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Slavica Djukic <slawica92@hotmail.com>

In the `git add -i` command, we show unique prefixes of the commands and
files, to give an indication what prefix would select them.

Naturally, the C implementation looks a lot different than the Perl
implementation: in Perl, a trie is much easier implemented, while we
already have a pretty neat hashmap implementation in C that we use for
the purpose of storing (not necessarily unique) prefixes.

The idea: for each item that we add, we generate prefixes starting with
the first letter, then the first two letters, then three, etc, until we
find a prefix that is unique (or until the prefix length would be
longer than we want). If we encounter a previously-unique prefix on the
way, we adjust that item's prefix to make it unique again (or we mark it
as having no unique prefix if we failed to find one). These partial
prefixes are stored in a hash map (for quick lookup times).

To make sure that this function works as expected, we add a test using a
special-purpose test helper.

Note: We expect the list of prefix items to be passed in as a list of
pointers rather than as regular list to avoid having to copy information
(the actual items will most likely contain more information than just
the name and the length of the unique prefix, but passing in `struct
prefix_item *` would not allow for that).

Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                   |   2 +
 prefix-map.c               | 123 +++++++++++++++++++++++++++++++++++++
 prefix-map.h               |  29 +++++++++
 t/helper/test-prefix-map.c |  58 +++++++++++++++++
 t/helper/test-tool.c       |   1 +
 t/helper/test-tool.h       |   1 +
 t/t0018-prefix-map.sh      |  10 +++
 7 files changed, 224 insertions(+)
 create mode 100644 prefix-map.c
 create mode 100644 prefix-map.h
 create mode 100644 t/helper/test-prefix-map.c
 create mode 100755 t/t0018-prefix-map.sh

diff --git a/Makefile b/Makefile
index d04daf9fd8..5c141c4609 100644
--- a/Makefile
+++ b/Makefile
@@ -727,6 +727,7 @@ TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-parse-options.o
 TEST_BUILTINS_OBJS += test-path-utils.o
 TEST_BUILTINS_OBJS += test-pkt-line.o
+TEST_BUILTINS_OBJS += test-prefix-map.o
 TEST_BUILTINS_OBJS += test-prio-queue.o
 TEST_BUILTINS_OBJS += test-reach.o
 TEST_BUILTINS_OBJS += test-read-cache.o
@@ -945,6 +946,7 @@ LIB_OBJS += patch-ids.o
 LIB_OBJS += path.o
 LIB_OBJS += pathspec.o
 LIB_OBJS += pkt-line.o
+LIB_OBJS += prefix-map.o
 LIB_OBJS += preload-index.o
 LIB_OBJS += pretty.o
 LIB_OBJS += prio-queue.o
diff --git a/prefix-map.c b/prefix-map.c
new file mode 100644
index 0000000000..ff4284bbe3
--- /dev/null
+++ b/prefix-map.c
@@ -0,0 +1,123 @@
+#include "cache.h"
+#include "prefix-map.h"
+
+struct prefix_map_entry {
+	struct hashmap_entry e;
+	const char *name;
+	size_t prefix_length;
+	/* if item is NULL, the prefix is not unique */
+	struct prefix_item *item;
+};
+
+struct prefix_map {
+	struct hashmap map;
+	size_t min_length, max_length;
+};
+
+static int map_cmp(const void *unused_cmp_data,
+		   const void *entry,
+		   const void *entry_or_key,
+		   const void *unused_keydata)
+{
+	const struct prefix_map_entry *a = entry;
+	const struct prefix_map_entry *b = entry_or_key;
+
+	return a->prefix_length != b->prefix_length ||
+		strncmp(a->name, b->name, a->prefix_length);
+}
+
+static void add_prefix_entry(struct hashmap *map, const char *name,
+			     size_t prefix_length, struct prefix_item *item)
+{
+	struct prefix_map_entry *result = xmalloc(sizeof(*result));
+	result->name = name;
+	result->prefix_length = prefix_length;
+	result->item = item;
+	hashmap_entry_init(&result->e, memhash(name, prefix_length));
+	hashmap_add(map, &result->e);
+}
+
+static void init_prefix_map(struct prefix_map *prefix_map,
+			    size_t min_prefix_length, size_t max_prefix_length)
+{
+	hashmap_init(&prefix_map->map, map_cmp, NULL, 0);
+	prefix_map->min_length = min_prefix_length;
+	prefix_map->max_length = max_prefix_length;
+}
+
+static void add_prefix_item(struct prefix_map *prefix_map,
+			    struct prefix_item *item)
+{
+	struct prefix_map_entry e = { { NULL } }, *e2;
+	size_t j;
+
+	e.item = item;
+	e.name = item->name;
+
+	for (j = prefix_map->min_length;
+	     j <= prefix_map->max_length && e.name[j]; j++) {
+		/* Avoid breaking UTF-8 multi-byte sequences */
+		if (!isascii(e.name[j]))
+			break;
+
+		e.prefix_length = j;
+		hashmap_entry_init(&e.e, memhash(e.name, j));
+		e2 = hashmap_get(&prefix_map->map, &e.e, NULL);
+		if (!e2) {
+			/* prefix is unique at this stage */
+			item->prefix_length = j;
+			add_prefix_entry(&prefix_map->map, e.name, j, item);
+			break;
+		}
+
+		if (!e2->item)
+			continue; /* non-unique prefix */
+
+		if (j != e2->item->prefix_length || memcmp(e.name, e2->name, j))
+			BUG("unexpected prefix length: %d != %d (%s != %s)",
+			    (int)j, (int)e2->item->prefix_length,
+			    e.name, e2->name);
+
+		/* skip common prefix */
+		for (; j < prefix_map->max_length && e.name[j]; j++) {
+			if (e.item->name[j] != e2->item->name[j])
+				break;
+			add_prefix_entry(&prefix_map->map, e.name, j + 1,
+					 NULL);
+		}
+
+		/* e2 no longer refers to a unique prefix */
+		if (j < prefix_map->max_length && e2->name[j]) {
+			/* found a new unique prefix for e2's item */
+			e2->item->prefix_length = j + 1;
+			add_prefix_entry(&prefix_map->map, e2->name, j + 1,
+					 e2->item);
+		}
+		else
+			e2->item->prefix_length = 0;
+		e2->item = NULL;
+
+		if (j < prefix_map->max_length && e.name[j]) {
+			/* found a unique prefix for the item */
+			e.item->prefix_length = j + 1;
+			add_prefix_entry(&prefix_map->map, e.name, j + 1,
+					 e.item);
+		} else
+			/* item has no (short enough) unique prefix */
+			e.item->prefix_length = 0;
+
+		break;
+	}
+}
+
+void find_unique_prefixes(struct prefix_item **array, size_t nr,
+			  size_t min_length, size_t max_length)
+{
+	size_t i;
+	struct prefix_map prefix_map;
+
+	init_prefix_map(&prefix_map, min_length, max_length);
+	for (i = 0; i < nr; i++)
+		add_prefix_item(&prefix_map, array[i]);
+	hashmap_free(&prefix_map.map, 1);
+}
diff --git a/prefix-map.h b/prefix-map.h
new file mode 100644
index 0000000000..0c55ee0b2b
--- /dev/null
+++ b/prefix-map.h
@@ -0,0 +1,29 @@
+#ifndef PREFIX_MAP_H
+#define PREFIX_MAP_H
+
+#include "hashmap.h"
+
+struct prefix_item {
+	const char *name;
+	size_t prefix_length;
+};
+
+/*
+ * Given an array of names, find unique prefixes (i.e. the first <n> characters
+ * that uniquely identify the names) and store the lengths of the unique
+ * prefixes in the 'prefix_length' field of the elements of the given array..
+ *
+ * Typically, the `struct prefix_item` information is a field in the actual
+ * item struct; For this reason, the `array` parameter is specified as an array
+ * of pointers to the items.
+ *
+ * The `min_length`/`max_length` parameters define what length the unique
+ * prefixes should have.
+ *
+ * If no unique prefix could be found for a given item, its `prefix_length`
+ * will be set to 0.
+ */
+void find_unique_prefixes(struct prefix_item **array, size_t nr,
+			  size_t min_length, size_t max_length);
+
+#endif
diff --git a/t/helper/test-prefix-map.c b/t/helper/test-prefix-map.c
new file mode 100644
index 0000000000..3f1c90eaf0
--- /dev/null
+++ b/t/helper/test-prefix-map.c
@@ -0,0 +1,58 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "prefix-map.h"
+
+static size_t test_count, failed_count;
+
+static void check(int succeeded, const char *file, size_t line_no,
+		  const char *fmt, ...)
+{
+	va_list ap;
+
+	test_count++;
+	if (succeeded)
+		return;
+
+	va_start(ap, fmt);
+	fprintf(stderr, "%s:%d: ", file, (int)line_no);
+	vfprintf(stderr, fmt, ap);
+	fputc('\n', stderr);
+	va_end(ap);
+
+	failed_count++;
+}
+
+#define EXPECT_SIZE_T_EQUALS(expect, actual, hint) \
+	check(expect == actual, __FILE__, __LINE__, \
+	      "size_t's do not match: %" \
+	      PRIdMAX " != %" PRIdMAX " (%s) (%s)", \
+	      (intmax_t)expect, (intmax_t)actual, #actual, hint)
+
+int cmd__prefix_map(int argc, const char **argv)
+{
+#define NR 5
+	struct prefix_item items[NR] = {
+		{ "unique" },
+		{ "hell" },
+		{ "hello" },
+		{ "wok" },
+		{ "world" },
+	};
+	struct prefix_item *list[NR] = {
+		items, items + 1, items + 2, items + 3, items + 4
+	};
+
+	find_unique_prefixes(list, NR, 1, 3);
+
+#define EXPECT_PREFIX_LENGTH_EQUALS(expect, index) \
+	EXPECT_SIZE_T_EQUALS(expect, list[index]->prefix_length, \
+			     list[index]->name)
+
+	EXPECT_PREFIX_LENGTH_EQUALS(1, 0);
+	EXPECT_PREFIX_LENGTH_EQUALS(0, 1);
+	EXPECT_PREFIX_LENGTH_EQUALS(0, 2);
+	EXPECT_PREFIX_LENGTH_EQUALS(3, 3);
+	EXPECT_PREFIX_LENGTH_EQUALS(3, 4);
+
+	return !!failed_count;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index ce7e89028c..34ddf3f8b7 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -41,6 +41,7 @@ static struct test_cmd cmds[] = {
 	{ "parse-options", cmd__parse_options },
 	{ "path-utils", cmd__path_utils },
 	{ "pkt-line", cmd__pkt_line },
+	{ "prefix-map", cmd__prefix_map },
 	{ "prio-queue", cmd__prio_queue },
 	{ "reach", cmd__reach },
 	{ "read-cache", cmd__read_cache },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index f805bb39ae..400854e60d 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -31,6 +31,7 @@ int cmd__online_cpus(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
 int cmd__pkt_line(int argc, const char **argv);
+int cmd__prefix_map(int argc, const char **argv);
 int cmd__prio_queue(int argc, const char **argv);
 int cmd__reach(int argc, const char **argv);
 int cmd__read_cache(int argc, const char **argv);
diff --git a/t/t0018-prefix-map.sh b/t/t0018-prefix-map.sh
new file mode 100755
index 0000000000..187fa92aec
--- /dev/null
+++ b/t/t0018-prefix-map.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+test_description='basic tests for prefix map'
+. ./test-lib.sh
+
+test_expect_success 'prefix map' '
+	test-tool prefix-map
+'
+
+test_done
-- 
gitgitgadget

