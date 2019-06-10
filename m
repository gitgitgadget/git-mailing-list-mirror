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
	by dcvr.yhbt.net (Postfix) with ESMTP id 21A571F462
	for <e@80x24.org>; Mon, 10 Jun 2019 23:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390664AbfFJXfb (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 19:35:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37895 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390542AbfFJXf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 19:35:29 -0400
Received: by mail-ed1-f66.google.com with SMTP id g13so16973020edu.5
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 16:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ycyscfLXOrkbmY2w0Hk1HLxjyvVhXJ4MRJmYgcdjxIM=;
        b=ayRRZNAG/fdDcwjdq3emE2O75SdpxUuXEU5Qhjo7mUuQCdCd592GDTm1MJALP2eJGV
         GtRcZv3Dg7xQC1K8cFPjJSUqw3amAdIyhO5LUKlupBtUbiME7va/TFObaLV7RuVH9PtD
         4ogfCE9P0s8v6bGX93HF0JsGu/8+OszemaVGxaMtHUXOvYz/TpA2u5VouQqHZYp6xq+C
         qkxm4PWZVT4AB5DOhWp3rnuL/evPRy4UUJbSSzx3Ffk1RVzXNBWf16MnpPraEoFu+U9i
         HPB5UmtKB2QOEwmgzV+9/sNQbGE8JFjq1CJRVU9hLGFKL+EUQWxQxpe+2VTc18eGYi35
         ZfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ycyscfLXOrkbmY2w0Hk1HLxjyvVhXJ4MRJmYgcdjxIM=;
        b=s9oO8XIGIR94+4rLy1O2/MB9ugb5l79p6NY3w35R3qeU8y3fQknrdPSJ8fOIt2XAV6
         FY5ugjVFSz7abq0d3dXhdcjOODn2G6+kMwir4428ppXTzVpbpYG/jxYsfeRQ+DQG/UvC
         fdAwFwEdgFO/L6jVYA5rC1siV5JYb2ymprEVGhgc7fs5QPSa01xUZex70b0cRWfX9Qob
         z+A4AcBRqXPehDJVDl3G8W5Mjy+JiCGwHusEtXbRqvWYqAMtnjs28KIN5gvCEluU+YBw
         nF+Y7szFOoLS7vxyKen5LjQNLdQ2uU7vRHz9M0QlOx4MxXh0BglBU5ChLp1gPT2JMXFe
         KPPQ==
X-Gm-Message-State: APjAAAWV0ylKUIm9GjwEplsXc7P9QJHzv9pb2kncLzD31pLGiQyox1KE
        EYHuBC37kHhW5FxqBOcW9J5YZH2e
X-Google-Smtp-Source: APXvYqznYiIWRqbPw/+ITJvRg5zeH925bMg928+Neqt7yd01qW2Eq7Zz8rP7YYRuzhTJ+zc4E71zWg==
X-Received: by 2002:a05:6402:1557:: with SMTP id p23mr1051125edx.207.1560209727557;
        Mon, 10 Jun 2019 16:35:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j10sm1991102ejk.49.2019.06.10.16.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 16:35:27 -0700 (PDT)
Date:   Mon, 10 Jun 2019 16:35:27 -0700 (PDT)
X-Google-Original-Date: Mon, 10 Jun 2019 23:35:17 GMT
Message-Id: <ab77ce8afe186bee4c94463b832528fd2695996f.1560209720.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.261.git.gitgitgadget@gmail.com>
References: <pull.261.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 08/11] midx: implement midx_repack()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

To repack with a non-zero batch-size, first sort all pack-files by
their modified time. Second, walk those pack-files from oldest
to newest, compute their expected size, and add the packs to a list
if they are smaller than the given batch-size. Stop when the total
expected size is at least the batch size.

If the batch size is zero, select all packs in the multi-pack-index.

Finally, collect the objects from the multi-pack-index that are in
the selected packs and send them to 'git pack-objects'. Write a new
multi-pack-index that includes the new pack.

Using a batch size of zero is very similar to a standard 'git repack'
command, except that we do not delete the old packs and instead rely
on the new multi-pack-index to prevent new processes from reading the
old packs. This does not disrupt other Git processes that are currently
reading the old packs based on the old multi-pack-index.

While first designing a 'git multi-pack-index repack' operation, I
started by collecting the batches based on the actual size of the
objects instead of the size of the pack-files. This allows repacking
a large pack-file that has very few referencd objects. However, this
came at a significant cost of parsing pack-files instead of simply
reading the multi-pack-index and getting the file information for
the pack-files. The "expected size" version provides similar
behavior, but could skip a pack-file if the average object size is
much larger than the actual size of the referenced objects, or
can create a large pack if the actual size of the referenced objects
is larger than the expected size.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 151 +++++++++++++++++++++++++++++++++++-
 t/t5319-multi-pack-index.sh |  28 +++++++
 2 files changed, 178 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index fbed8a8adb..d649644420 100644
--- a/midx.c
+++ b/midx.c
@@ -9,6 +9,7 @@
 #include "midx.h"
 #include "progress.h"
 #include "trace2.h"
+#include "run-command.h"
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION 1
@@ -1227,7 +1228,155 @@ int expire_midx_packs(struct repository *r, const char *object_dir)
 	return result;
 }
 
-int midx_repack(struct repository *r, const char *object_dir, size_t batch_size)
+struct repack_info {
+	timestamp_t mtime;
+	uint32_t referenced_objects;
+	uint32_t pack_int_id;
+};
+
+static int compare_by_mtime(const void *a_, const void *b_)
 {
+	const struct repack_info *a, *b;
+
+	a = (const struct repack_info *)a_;
+	b = (const struct repack_info *)b_;
+
+	if (a->mtime < b->mtime)
+		return -1;
+	if (a->mtime > b->mtime)
+		return 1;
+	return 0;
+}
+
+static int fill_included_packs_all(struct multi_pack_index *m,
+				   unsigned char *include_pack)
+{
+	uint32_t i;
+
+	for (i = 0; i < m->num_packs; i++)
+		include_pack[i] = 1;
+
+	return m->num_packs < 2;
+}
+
+static int fill_included_packs_batch(struct repository *r,
+				     struct multi_pack_index *m,
+				     unsigned char *include_pack,
+				     size_t batch_size)
+{
+	uint32_t i, packs_to_repack;
+	size_t total_size;
+	struct repack_info *pack_info = xcalloc(m->num_packs, sizeof(struct repack_info));
+
+	for (i = 0; i < m->num_packs; i++) {
+		pack_info[i].pack_int_id = i;
+
+		if (prepare_midx_pack(r, m, i))
+			continue;
+
+		pack_info[i].mtime = m->packs[i]->mtime;
+	}
+
+	for (i = 0; batch_size && i < m->num_objects; i++) {
+		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
+		pack_info[pack_int_id].referenced_objects++;
+	}
+
+	QSORT(pack_info, m->num_packs, compare_by_mtime);
+
+	total_size = 0;
+	packs_to_repack = 0;
+	for (i = 0; total_size < batch_size && i < m->num_packs; i++) {
+		int pack_int_id = pack_info[i].pack_int_id;
+		struct packed_git *p = m->packs[pack_int_id];
+		size_t expected_size;
+
+		if (!p)
+			continue;
+		if (open_pack_index(p) || !p->num_objects)
+			continue;
+
+		expected_size = (size_t)(p->pack_size
+					 * pack_info[i].referenced_objects);
+		expected_size /= p->num_objects;
+
+		if (expected_size >= batch_size)
+			continue;
+
+		packs_to_repack++;
+		total_size += expected_size;
+		include_pack[pack_int_id] = 1;
+	}
+
+	free(pack_info);
+
+	if (total_size < batch_size || packs_to_repack < 2)
+		return 1;
+
 	return 0;
 }
+
+int midx_repack(struct repository *r, const char *object_dir, size_t batch_size)
+{
+	int result = 0;
+	uint32_t i;
+	unsigned char *include_pack;
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct strbuf base_name = STRBUF_INIT;
+	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
+
+	if (!m)
+		return 0;
+
+	include_pack = xcalloc(m->num_packs, sizeof(unsigned char));
+
+	if (batch_size) {
+		if (fill_included_packs_batch(r, m, include_pack, batch_size))
+			goto cleanup;
+	} else if (fill_included_packs_all(m, include_pack))
+		goto cleanup;
+
+	argv_array_push(&cmd.args, "pack-objects");
+
+	strbuf_addstr(&base_name, object_dir);
+	strbuf_addstr(&base_name, "/pack/pack");
+	argv_array_push(&cmd.args, base_name.buf);
+	strbuf_release(&base_name);
+
+	cmd.git_cmd = 1;
+	cmd.in = cmd.out = -1;
+
+	if (start_command(&cmd)) {
+		error(_("could not start pack-objects"));
+		result = 1;
+		goto cleanup;
+	}
+
+	for (i = 0; i < m->num_objects; i++) {
+		struct object_id oid;
+		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
+
+		if (!include_pack[pack_int_id])
+			continue;
+
+		nth_midxed_object_oid(&oid, m, i);
+		xwrite(cmd.in, oid_to_hex(&oid), the_hash_algo->hexsz);
+		xwrite(cmd.in, "\n", 1);
+	}
+	close(cmd.in);
+
+	if (finish_command(&cmd)) {
+		error(_("could not finish pack-objects"));
+		result = 1;
+		goto cleanup;
+	}
+
+	result = write_midx_internal(object_dir, m, NULL);
+	m = NULL;
+
+cleanup:
+	if (m)
+		close_midx(m);
+	free(include_pack);
+	return result;
+}
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 133d5b7068..6e47e5d0b2 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -450,4 +450,32 @@ test_expect_success 'repack with minimum size does not alter existing packs' '
 	)
 '
 
+test_expect_success 'repack creates a new pack' '
+	(
+		cd dup &&
+		ls .git/objects/pack/*idx >idx-list &&
+		test_line_count = 5 idx-list &&
+		THIRD_SMALLEST_SIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 3 | tail -n 1) &&
+		BATCH_SIZE=$(($THIRD_SMALLEST_SIZE + 1)) &&
+		git multi-pack-index repack --batch-size=$BATCH_SIZE &&
+		ls .git/objects/pack/*idx >idx-list &&
+		test_line_count = 6 idx-list &&
+		test-tool read-midx .git/objects | grep idx >midx-list &&
+		test_line_count = 6 midx-list
+	)
+'
+
+test_expect_success 'expire removes repacked packs' '
+	(
+		cd dup &&
+		ls -al .git/objects/pack/*pack &&
+		ls -S .git/objects/pack/*pack | head -n 4 >expect &&
+		git multi-pack-index expire &&
+		ls -S .git/objects/pack/*pack >actual &&
+		test_cmp expect actual &&
+		test-tool read-midx .git/objects | grep idx >midx-list &&
+		test_line_count = 4 midx-list
+	)
+'
+
 test_done
-- 
gitgitgadget

