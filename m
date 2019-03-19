Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE42720248
	for <e@80x24.org>; Tue, 19 Mar 2019 14:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfCSOh5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 10:37:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45052 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfCSOhy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 10:37:54 -0400
Received: by mail-ed1-f65.google.com with SMTP id x10so13634835edh.11
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 07:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9j39bMPzZ9V1DUKEFavsP/daXBC7Cbu6n23MChQDYXc=;
        b=bLTBmygeH3UNkkEWUNHX39AkpZsc0YUOn0UvDIyIRzBbfEC1Tylx929ZfuaiCMte3d
         Pom+UIWW6qudt42MmiE+R/pz6MMZT4qNgNKkpbnsyPB1QJ1JK6rkszr3M0CLO2rftWMK
         mP7Nk1GRZs/feTBmY6Wta64y/S2971bat1XiLyFFKDWpbCpa4IS6GjkMhEnbuDcZ8mGN
         t0bjlrw1zmmT1gwTOQYspUPWffykOmvcwdXf2B0eiuorvpCQKKD11EHTfGFTFV9Nb0mz
         7XSs1N0taZTciRJcukgdn+4IVTHTIcIZlro89/gXPI8LLhgoGnNYdUlliwouV3sJSz8x
         K+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9j39bMPzZ9V1DUKEFavsP/daXBC7Cbu6n23MChQDYXc=;
        b=CJx073H4aEHQPlJ/Qa9j+WZoIouMaOY9VyiFxyYWrq6/EizQLPOaZvHNjwL3sm+1Gi
         TUJOmT/tHYIIlr3I2SwT4ZSD9iEcXVtXLE0ZealuCQEYeLQiEUHD02pOVsc/ELzxfs6v
         onTDMEwplv0MWun2UMdYHNVsK7Yd0aJwrKhbIitD7V3TnZA3HMuTkglitJoK84jQNvL7
         OVqgl8/IkDFLwpkFsA1Audu7klv+owv9s3qk9tqhaeu6wq251Ug9s7oPqQ2kCC27C2bo
         6b2LRdvH5Un9gt3zLDnAdQW6AphEksgIxl+i79fwMUQCSTI9EP4HXrzsuEPIldYbhtvS
         HzRw==
X-Gm-Message-State: APjAAAWZBXcCUIAHkwh1J3o88hurttN9ktHopldxiqLlOGP2A/om20YD
        UUwhoUNQw2EmZAef5IhSbjgO4pGI
X-Google-Smtp-Source: APXvYqx1PiXwlP33Hl9Qu0x5PH+tyeRPs7DUhdZr1zyHEugcXJrffkXao2tU0JgOTpHM6FP4VZeG5Q==
X-Received: by 2002:a50:8854:: with SMTP id c20mr12212735edc.167.1553006272669;
        Tue, 19 Mar 2019 07:37:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g2sm2223702edi.76.2019.03.19.07.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 07:37:52 -0700 (PDT)
Date:   Tue, 19 Mar 2019 07:37:52 -0700 (PDT)
X-Google-Original-Date: Tue, 19 Mar 2019 14:37:47 GMT
Message-Id: <e2dd99911f6054cc7a60d9d3a7187b487f594a65.1553006268.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.166.v2.git.gitgitgadget@gmail.com>
References: <pull.166.git.gitgitgadget@gmail.com>
        <pull.166.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 4/4] midx: verify: group objects by packfile to speed up
 object verification
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach `multi-pack-index verify` to sort the set of objects by
packfile so that only one packfile needs to be open at a time.

This is a performance improvement.  Previously, objects were
verified in OID order.  This essentially requires all packfiles
to be open at the same time.  If the number of packfiles exceeds
the open file limit, packfiles would be LRU-closed and re-opened
many times.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 midx.c     | 77 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 packfile.c |  2 +-
 packfile.h |  2 ++
 3 files changed, 74 insertions(+), 7 deletions(-)

diff --git a/midx.c b/midx.c
index b2f33bcd90..a37c09f2a5 100644
--- a/midx.c
+++ b/midx.c
@@ -962,9 +962,36 @@ static void midx_report(const char *fmt, ...)
 	va_end(ap);
 }
 
+struct pair_pos_vs_id
+{
+	uint32_t pos;
+	uint32_t pack_int_id;
+};
+
+static int compare_pair_pos_vs_id(const void *_a, const void *_b)
+{
+	struct pair_pos_vs_id *a = (struct pair_pos_vs_id *)_a;
+	struct pair_pos_vs_id *b = (struct pair_pos_vs_id *)_b;
+
+	return b->pack_int_id - a->pack_int_id;
+}
+
+/*
+ * Limit calls to display_progress() for performance reasons.
+ * The interval here was arbitrarily chosen.
+ */
+#define SPARSE_PROGRESS_INTERVAL (1 << 12)
+#define midx_display_sparse_progress(progress, n) \
+	do { \
+		uint64_t _n = (n); \
+		if ((_n & (SPARSE_PROGRESS_INTERVAL - 1)) == 0)	\
+			display_progress(progress, _n); \
+	} while (0)
+
 int verify_midx_file(const char *object_dir)
 {
-	uint32_t i;
+	struct pair_pos_vs_id *pairs = NULL;
+	uint32_t i, k;
 	struct progress *progress;
 	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
 	verify_midx_error = 0;
@@ -972,13 +999,18 @@ int verify_midx_file(const char *object_dir)
 	if (!m)
 		return 0;
 
+	progress = start_progress(_("Looking for referenced packfiles"),
+				  m->num_packs);
 	for (i = 0; i < m->num_packs; i++) {
 		if (prepare_midx_pack(m, i))
 			midx_report("failed to load pack in position %d", i);
 
 		if (m->packs[i])
 			install_packed_git(the_repository, m->packs[i]);
+
+		display_progress(progress, i + 1);
 	}
+	stop_progress(&progress);
 
 	for (i = 0; i < 255; i++) {
 		uint32_t oid_fanout1 = ntohl(m->chunk_oid_fanout[i]);
@@ -989,6 +1021,8 @@ int verify_midx_file(const char *object_dir)
 				    i, oid_fanout1, oid_fanout2, i + 1);
 	}
 
+	progress = start_sparse_progress(_("Verifying OID order in MIDX"),
+					 m->num_objects - 1);
 	for (i = 0; i < m->num_objects - 1; i++) {
 		struct object_id oid1, oid2;
 
@@ -998,18 +1032,47 @@ int verify_midx_file(const char *object_dir)
 		if (oidcmp(&oid1, &oid2) >= 0)
 			midx_report(_("oid lookup out of order: oid[%d] = %s >= %s = oid[%d]"),
 				    i, oid_to_hex(&oid1), oid_to_hex(&oid2), i + 1);
+
+		midx_display_sparse_progress(progress, i + 1);
 	}
+	stop_progress(&progress);
 
-	progress = start_progress(_("Verifying object offsets"), m->num_objects);
+	/*
+	 * Create an array mapping each object to its packfile id.  Sort it
+	 * to group the objects by packfile.  Use this permutation to visit
+	 * each of the objects and only require 1 packfile to be open at a
+	 * time.
+	 */
+	ALLOC_ARRAY(pairs, m->num_objects);
 	for (i = 0; i < m->num_objects; i++) {
+		pairs[i].pos = i;
+		pairs[i].pack_int_id = nth_midxed_pack_int_id(m, i);
+	}
+
+	progress = start_sparse_progress(
+		_("Sorting objects by packfile"), m->num_objects);
+	display_progress(progress, 0); /* TODO: Measure QSORT() progress */
+	QSORT(pairs, m->num_objects, compare_pair_pos_vs_id);
+	stop_progress(&progress);
+
+	progress = start_sparse_progress(_("Verifying object offsets"),
+					 m->num_objects);
+	for (k = 0; k < m->num_objects; k++) {
 		struct object_id oid;
 		struct pack_entry e;
 		off_t m_offset, p_offset;
 
-		nth_midxed_object_oid(&oid, m, i);
+		if (k > 0 && pairs[k-1].pack_int_id != pairs[k].pack_int_id &&
+		    m->packs[pairs[k-1].pack_int_id])
+		{
+			close_pack_fd(m->packs[pairs[k-1].pack_int_id]);
+			close_pack_index(m->packs[pairs[k-1].pack_int_id]);
+		}
+
+		nth_midxed_object_oid(&oid, m, pairs[k].pos);
 		if (!fill_midx_entry(&oid, &e, m)) {
 			midx_report(_("failed to load pack entry for oid[%d] = %s"),
-				    i, oid_to_hex(&oid));
+				    pairs[k].pos, oid_to_hex(&oid));
 			continue;
 		}
 
@@ -1024,11 +1087,13 @@ int verify_midx_file(const char *object_dir)
 
 		if (m_offset != p_offset)
 			midx_report(_("incorrect object offset for oid[%d] = %s: %"PRIx64" != %"PRIx64),
-				    i, oid_to_hex(&oid), m_offset, p_offset);
+				    pairs[k].pos, oid_to_hex(&oid), m_offset, p_offset);
 
-		display_progress(progress, i + 1);
+		midx_display_sparse_progress(progress, k + 1);
 	}
 	stop_progress(&progress);
 
+	free(pairs);
+
 	return verify_midx_error;
 }
diff --git a/packfile.c b/packfile.c
index 16bcb75262..d2bcb2f860 100644
--- a/packfile.c
+++ b/packfile.c
@@ -309,7 +309,7 @@ void close_pack_windows(struct packed_git *p)
 	}
 }
 
-static int close_pack_fd(struct packed_git *p)
+int close_pack_fd(struct packed_git *p)
 {
 	if (p->pack_fd < 0)
 		return 0;
diff --git a/packfile.h b/packfile.h
index d70c6d9afb..b1c18504eb 100644
--- a/packfile.h
+++ b/packfile.h
@@ -76,6 +76,8 @@ extern int open_pack_index(struct packed_git *);
  */
 extern void close_pack_index(struct packed_git *);
 
+int close_pack_fd(struct packed_git *p);
+
 extern uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);
 
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
-- 
gitgitgadget
