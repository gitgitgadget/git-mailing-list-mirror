Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4910120A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 18:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbeLJSGZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 13:06:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45995 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeLJSGY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 13:06:24 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so5755322pfd.12
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 10:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=feGAYVTIWzZxozXO6ZuAk4hnpaHgqLXn5fvUyKmPwCQ=;
        b=eRR+Qpeul0wLyJOiM1rNPmFJlCQLm12swEVdnqIgHSXwVEBvVaH1CPq+IHeSlvb7qD
         MwM/7lBO5c5HCV9+yFFkS52APU71wAg4ghqDrVd+W0IftxTCffMpWZZCf81J+D+cQ2yk
         dVsJ6xEBzdUYIEoeuLd5O0xS/TbqlVoG793metUbd8WUeGBLnT1UTMN88E11mMfRFdcG
         u9NoWF7a/RtfIRPf/MOyJ4GSNBmIztYx6wNmaO5Fzamyp4bjHo/X2aKuh01fnC94JsfH
         0h/lVZvlAwti+lzCJVXPQ2mLqmgfspy3pi6SxEeMy9j68OY1z/hDVEhbN508JXH+AyH6
         lpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=feGAYVTIWzZxozXO6ZuAk4hnpaHgqLXn5fvUyKmPwCQ=;
        b=qD4UwN8sjMw/MmWW6SIkHMBerYVcgA6Y5FfRDQ9tal0ZaTLKfbapD3CmJ5Kw5+3xTX
         rJBOzu3Ymg/HEN5ek2JHaVpfO3f9p0uE4ll+XhfNu0fZoFPwQxod8O9B7rPC0DZA2BoF
         881Ljjt0wG+o0R99TnhiF5ekyfapxN1g9+h2SbgDz062qyohCphDu4LByConfQokBISM
         tAIQJOj9JVxgyvlSFOpn/vMyLRtFPCmCIVB1/FiaP50Dnv1O+iiK5Cqm9KeLYwJOuztN
         bgOuL9Mpr5B/WHQxqr3/gqoFB8BR/4ySrA/BSMJSX0Z2Y814NIBucaEx23VE3AKBbqsj
         B0Yw==
X-Gm-Message-State: AA+aEWa/QS/cgJ6pJl33iO1IElLAiyKt2UJR0v07S+xhGewIrVHKhTsE
        Tt/R+RNo0Xiq2E5xOqaHQPZk7oNt
X-Google-Smtp-Source: AFSGD/Xz7cw9F0kAEW79mLrpO28F6onBmES+loJCUq1Xw1lBL7YGmUPq3ekFO4A5TRJ+ZhmzLlFVjQ==
X-Received: by 2002:a63:9f19:: with SMTP id g25mr11680563pge.327.1544465183307;
        Mon, 10 Dec 2018 10:06:23 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id d69sm18446968pfg.168.2018.12.10.10.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 10:06:22 -0800 (PST)
Date:   Mon, 10 Dec 2018 10:06:22 -0800 (PST)
X-Google-Original-Date: Mon, 10 Dec 2018 18:06:14 GMT
Message-Id: <244bdf2a6fc300f2b535ac8edfc2fbdaf5260266.1544465177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.git.gitgitgadget@gmail.com>
References: <pull.92.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/5] multi-pack-index: implement 'expire' verb
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git multi-pack-index expire' command looks at the existing
mult-pack-index, counts the number of objects referenced in each
pack-file, deletes the pack-fils with no referenced objects, and
rewrites the multi-pack-index to no longer reference those packs.

Refactor the write_midx_file() method to call write_midx_internal()
which now takes an existing 'struct multi_pack_index' and a list
of pack-files to drop (as specified by the names of their pack-
indexes). As we write the new multi-pack-index, we drop those
file names from the list of known pack-files.

The expire_midx_packs() method removes the unreferenced pack-files
after carefully closing the packs to avoid open handles.

Test that a new pack-file that covers the contents of two other
pack-files leads to those pack-files being deleted during the
expire command. Be sure to read the multi-pack-index to ensure
it no longer references those packs.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 87 +++++++++++++++++++++++++++++++++++--
 t/t5319-multi-pack-index.sh | 15 +++++++
 2 files changed, 98 insertions(+), 4 deletions(-)

diff --git a/midx.c b/midx.c
index 3bd7183a53..50e4cd7270 100644
--- a/midx.c
+++ b/midx.c
@@ -751,7 +751,8 @@ static size_t write_midx_large_offsets(struct hashfile *f, uint32_t nr_large_off
 	return written;
 }
 
-int write_midx_file(const char *object_dir)
+static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
+			       struct string_list *packs_to_drop)
 {
 	unsigned char cur_chunk, num_chunks = 0;
 	char *midx_name;
@@ -765,6 +766,7 @@ int write_midx_file(const char *object_dir)
 	uint32_t nr_entries, num_large_offsets = 0;
 	struct pack_midx_entry *entries = NULL;
 	int large_offsets_needed = 0;
+	int result = 0;
 
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name)) {
@@ -773,7 +775,10 @@ int write_midx_file(const char *object_dir)
 			  midx_name);
 	}
 
-	packs.m = load_multi_pack_index(object_dir, 1);
+	if (m)
+		packs.m = m;
+	else
+		packs.m = load_multi_pack_index(object_dir, 1);
 
 	packs.nr = 0;
 	packs.alloc_list = packs.m ? packs.m->num_packs : 16;
@@ -787,7 +792,24 @@ int write_midx_file(const char *object_dir)
 	ALLOC_ARRAY(packs.perm, packs.alloc_perm);
 
 	if (packs.m) {
+		int drop_index = 0, missing_drops = 0;
 		for (i = 0; i < packs.m->num_packs; i++) {
+			if (packs_to_drop && drop_index < packs_to_drop->nr) {
+				int cmp = strcmp(packs.m->pack_names[i],
+						 packs_to_drop->items[drop_index].string);
+
+				if (!cmp) {
+					drop_index++;
+					continue;
+				} else if (cmp > 0) {
+					error(_("did not see pack-file %s to drop"),
+					      packs_to_drop->items[drop_index].string);
+					drop_index++;
+					i--;
+					missing_drops++;
+				}
+			}
+
 			ALLOC_GROW(packs.list, packs.nr + 1, packs.alloc_list);
 			ALLOC_GROW(packs.names, packs.nr + 1, packs.alloc_names);
 			ALLOC_GROW(packs.perm, packs.nr + 1, packs.alloc_perm);
@@ -798,6 +820,12 @@ int write_midx_file(const char *object_dir)
 			packs.pack_name_concat_len += strlen(packs.names[packs.nr]) + 1;
 			packs.nr++;
 		}
+
+		if (packs_to_drop && (drop_index < packs_to_drop->nr || missing_drops)) {
+			error(_("did not see all pack-files to drop"));
+			result = 1;
+			goto cleanup;
+		}
 	}
 
 	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &packs);
@@ -932,7 +960,12 @@ cleanup:
 	free(packs.perm);
 	free(entries);
 	free(midx_name);
-	return 0;
+	return result;
+}
+
+int write_midx_file(const char *object_dir)
+{
+	return write_midx_internal(object_dir, NULL, NULL);
 }
 
 void clear_midx_file(struct repository *r)
@@ -1034,5 +1067,51 @@ int verify_midx_file(const char *object_dir)
 
 int expire_midx_packs(const char *object_dir)
 {
-	return 0;
+	uint32_t i, *count, result = 0;
+	size_t dirlen;
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list packs_to_drop = STRING_LIST_INIT_DUP;
+	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
+
+	if (!m)
+		return 0;
+
+	count = xcalloc(m->num_packs, sizeof(uint32_t));
+	for (i = 0; i < m->num_objects; i++) {
+		int pack_int_id = nth_midxed_pack_int_id(m, i);
+		count[pack_int_id]++;
+	}
+
+	strbuf_addstr(&buf, object_dir);
+	strbuf_addstr(&buf, "/pack/");
+	dirlen = buf.len;
+
+	for (i = 0; i < m->num_packs; i++) {
+		if (count[i])
+			continue;
+
+		if (m->packs[i]) {
+			close_pack(m->packs[i]);
+			m->packs[i] = NULL;
+		}
+
+		string_list_insert(&packs_to_drop, m->pack_names[i]);
+
+		strbuf_setlen(&buf, dirlen);
+		strbuf_addstr(&buf, m->pack_names[i]);
+		unlink(buf.buf);
+
+		strip_suffix_mem(buf.buf, &buf.len, "idx");
+		strbuf_addstr(&buf, "pack");
+		unlink(buf.buf);
+	}
+
+	strbuf_release(&buf);
+	free(count);
+
+	if (packs_to_drop.nr)
+		result = write_midx_internal(object_dir, m, &packs_to_drop);
+
+	string_list_clear(&packs_to_drop, 0);
+	return result;
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 948effc1ee..210279a3cf 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -395,4 +395,19 @@ test_expect_success 'expire does not remove any packs' '
 	)
 '
 
+test_expect_success 'expire removes unreferenced packs' '
+	(
+		cd dup &&
+		git pack-objects --revs .git/objects/pack/pack-combined <<-EOF &&
+		refs/heads/A
+		^refs/heads/C
+		EOF
+		git multi-pack-index write &&
+		ls .git/objects/pack | grep -v -e pack-[AB] >expect &&
+		git multi-pack-index expire &&
+		ls .git/objects/pack >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
gitgitgadget

