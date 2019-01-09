Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B3121F803
	for <e@80x24.org>; Wed,  9 Jan 2019 15:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbfAIPV2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 10:21:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38962 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732189AbfAIPVU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 10:21:20 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so8051015wra.6
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 07:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8dBx4DyfpBhxPP86K0wbymJiyRsftObHyFAtMpLF9VA=;
        b=roiR6PJZvPSIDkEb4Dme3kU+BJ5PRewNgQuMXYHhwFbKdfrER65bgGN4UivwoOSFlo
         f1rQgR1kcoFdwNeSubE7/rzr/5IbSth4EDLpvAudz7JOakd0K87V5m8zuam1h2cXzmyN
         pm7qhhbpjw0Xo3DxU/kUdOebhy1cQhY7FIVOiBAQGzbznOwDPYWI1vPypgsvFVmNByJV
         K7fbs2oaV9AKPis2eMBdvf6eYmZ4ItXzrsenbr/D07uLUVqAqotiHbrreEQHJLnQAr9C
         faHINgPMp8UlNWvT5rTFXDP6AbHlWJlkucGeGrHI9pS+MxhN4PfQinh6WpC4Vfi9ewNH
         U4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8dBx4DyfpBhxPP86K0wbymJiyRsftObHyFAtMpLF9VA=;
        b=friSa0jRBQMt6d7ZXTvAuiJobswZAOR3U73NVDPxMKv3vS++JPMa06pAiTXGJjy5YB
         XKMKv4fR+8NbLyR73sQMvFUKobJ0MBLI4fK42BGqZ8LdL3RcMITdxrlwn7kRjF3PiPDF
         QXdvZrTVj34ahWbkXG1xl5MtmIpmxgzXwp8OgRSJ9SgB+fFj/+r4eDvcZ8+ZV+B4tg39
         VxKmeB55z9WPoTFpSjIYYThuXqlGlzLHLMODaLMiwWHMgLkx4RJzqy/jnWniZu2z0DSc
         XsuwXU+SZytFNNqyIsncFLjo1MYnJr1Uc9Xc4MYPpqqUKhRsONBxF++f9qrIoGnUamYq
         GSoQ==
X-Gm-Message-State: AJcUukdc0Dkb1Johi3eYzyxhskGdydaDnhqJPJc78LKA0ayDUTOaqkkJ
        yxFnqdQM4V5H4iLv6XLk6vfO/R0q
X-Google-Smtp-Source: ALg8bN501oTICLDpFrKzYBGNGplVLmUdAVTz1fRSRYYfK5xS0hY6L7qpnqaIobNMue8boYFYN1N/kg==
X-Received: by 2002:adf:f691:: with SMTP id v17mr5310094wrp.114.1547047278244;
        Wed, 09 Jan 2019 07:21:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w6sm13354305wme.46.2019.01.09.07.21.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 07:21:17 -0800 (PST)
Date:   Wed, 09 Jan 2019 07:21:17 -0800 (PST)
X-Google-Original-Date: Wed, 09 Jan 2019 15:21:07 GMT
Message-Id: <b39f90ad09265614efd466fee5089354a193ae8c.1547047269.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.v3.git.gitgitgadget@gmail.com>
References: <pull.92.v2.git.gitgitgadget@gmail.com>
        <pull.92.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 7/9] multi-pack-index: prepare 'repack' subcommand
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

In an environment where the multi-pack-index is useful, it is due
to many pack-files and an inability to repack the object store
into a single pack-file. However, it is likely that many of these
pack-files are rather small, and could be repacked into a slightly
larger pack-file without too much effort. It may also be important
to ensure the object store is highly available and the repack
operation does not interrupt concurrent git commands.

Introduce a 'repack' subcommand to 'git multi-pack-index' that
takes a '--batch-size' option. The verb will inspect the
multi-pack-index for referenced pack-files whose size is smaller
than the batch size, until collecting a list of pack-files whose
sizes sum to larger than the batch size. Then, a new pack-file
will be created containing the objects from those pack-files that
are referenced by the multi-pack-index. The resulting pack is
likely to actually be smaller than the batch size due to
compression and the fact that there may be objects in the pack-
files that have duplicate copies in other pack-files.

The current change introduces the command-line arguments, and we
add a test that ensures we parse these options properly. Since
we specify a small batch size, we will guarantee that future
implementations do not change the list of pack-files.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-multi-pack-index.txt | 11 +++++++++++
 builtin/multi-pack-index.c             | 10 +++++++++-
 midx.c                                 |  5 +++++
 midx.h                                 |  1 +
 t/t5319-multi-pack-index.sh            | 11 +++++++++++
 5 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index 6186c4c936..cc63531cc0 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -36,6 +36,17 @@ expire::
 	have no objects referenced by the MIDX. Rewrite the MIDX file
 	afterward to remove all references to these pack-files.
 
+repack::
+	Collect a batch of pack-files whose size are all at most the
+	size given by --batch-size, but whose sizes sum to larger
+	than --batch-size. The batch is selected by greedily adding
+	small pack-files starting with the oldest pack-files that fit
+	the size. Create a new pack-file containing the objects the
+	multi-pack-index indexes into those pack-files, and rewrite
+	the multi-pack-index to contain that pack-file. A later run
+	of 'git multi-pack-index expire' will delete the pack-files
+	that were part of this batch.
+
 
 EXAMPLES
 --------
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 145de3a46c..d87a2235e3 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -5,12 +5,13 @@
 #include "midx.h"
 
 static char const * const builtin_multi_pack_index_usage[] = {
-	N_("git multi-pack-index [--object-dir=<dir>] (write|verify|expire)"),
+	N_("git multi-pack-index [--object-dir=<dir>] (write|verify|expire|repack --batch-size=<size>)"),
 	NULL
 };
 
 static struct opts_multi_pack_index {
 	const char *object_dir;
+	unsigned long batch_size;
 } opts;
 
 int cmd_multi_pack_index(int argc, const char **argv,
@@ -19,6 +20,8 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	static struct option builtin_multi_pack_index_options[] = {
 		OPT_FILENAME(0, "object-dir", &opts.object_dir,
 		  N_("object directory containing set of packfile and pack-index pairs")),
+		OPT_MAGNITUDE(0, "batch-size", &opts.batch_size,
+		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
 		OPT_END(),
 	};
 
@@ -40,6 +43,11 @@ int cmd_multi_pack_index(int argc, const char **argv,
 		return 1;
 	}
 
+	if (!strcmp(argv[0], "repack"))
+		return midx_repack(opts.object_dir, (size_t)opts.batch_size);
+	if (opts.batch_size)
+		die(_("--batch-size option is only for 'repack' verb"));
+
 	if (!strcmp(argv[0], "write"))
 		return write_midx_file(opts.object_dir);
 	if (!strcmp(argv[0], "verify"))
diff --git a/midx.c b/midx.c
index 6ccbec3f19..30ff4430ab 100644
--- a/midx.c
+++ b/midx.c
@@ -1106,3 +1106,8 @@ int expire_midx_packs(const char *object_dir)
 	string_list_clear(&packs_to_drop, 0);
 	return result;
 }
+
+int midx_repack(const char *object_dir, size_t batch_size)
+{
+	return 0;
+}
diff --git a/midx.h b/midx.h
index e3a2b740b5..394a21ee96 100644
--- a/midx.h
+++ b/midx.h
@@ -50,6 +50,7 @@ int write_midx_file(const char *object_dir);
 void clear_midx_file(struct repository *r);
 int verify_midx_file(const char *object_dir);
 int expire_midx_packs(const char *object_dir);
+int midx_repack(const char *object_dir, size_t batch_size);
 
 void close_midx(struct multi_pack_index *m);
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index f55a60a89c..d64767600a 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -413,4 +413,15 @@ test_expect_success 'expire removes unreferenced packs' '
 	)
 '
 
+test_expect_success 'repack with minimum size does not alter existing packs' '
+	(
+		cd dup &&
+		ls .git/objects/pack >expect &&
+		MINSIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 1) &&
+		git multi-pack-index repack --batch-size=$MINSIZE &&
+		ls .git/objects/pack >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
gitgitgadget

