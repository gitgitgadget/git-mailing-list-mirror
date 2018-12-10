Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0FB620A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 18:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbeLJSG0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 13:06:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46400 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbeLJSGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 13:06:25 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so5746321pfe.13
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 10:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4YRaYPP2JArOCTFE1ajPTAb1B3fZ9LpXNL2sPTjASDc=;
        b=mgK3hxycmC1Vqusgw+BFHYrtAa9/XBrGz1QZNffFLG6E5fQKJRn5qZVnMaRmPspekO
         EoqP701JaO5OP5OJN0VkcCWD5iNJCenaEqXlA1jaKW9ii/eA2YCbBczRIZY0syEEPHkS
         G1p/WGLXUFnRGgCDc1q69HUqvSXTHhfcLBe6xNnOgiAfeeCbfBqP61vgqhfnYp/Zq2x+
         ZUUPbywA/T+XnruIo4QtlwV1BE6wgI13+4d6rvFi4vaZS/LoWH8sc2NM87mOiZoOXn3s
         99KCRMm6j36B5ryabYAIqifOAM4jCQhZ22xpQCDa3DA34SkL23V5HMKOJNa+DhTz00F2
         cAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4YRaYPP2JArOCTFE1ajPTAb1B3fZ9LpXNL2sPTjASDc=;
        b=UdCkXlOxIYBIly+EanqFxsCUv6IRxCGRZIOMgGw2mIsGMm93cKc1XDJ72PA5qoveXG
         b7MfLmFdsCkwa5LM8J7kcn034Z0PUmybIFMqCAx/LVjr1LJd2isIzde7i0LhnF20iOQd
         XYniwvH5mCohinC1jgE67ytZ0OPPxxpyXo3lLU+MwjGfuntEa/nTJn/iQHUq/A9d8UCQ
         OWck0AbaRgmw0wC1bShGkfFLQVYa+MioWgKiCjELIWmXOxPvglF11TzBYOUCgwHiEIxK
         21fGQG4FT2YMZptYlf25Aev0JRgDUJ0iDj1pcXkeGPNLu4nRsqnfa+iWnvE1J/TWsDK8
         2ufg==
X-Gm-Message-State: AA+aEWYNU1YVzubqfQ+mF4ijlBumY2nNNVjme1o+NvvVd1TKi88Rx1DY
        x3+SSyDceTdGRyGGvqFQPWPD8YUY
X-Google-Smtp-Source: AFSGD/Vj/51VQbYvr4PxD2RqziFkqmyfTQwI0WBDvhzA1fJ9U9QCF25zXSzbzeLWPS2tYf1ejZ3NDw==
X-Received: by 2002:a63:101:: with SMTP id 1mr11663873pgb.152.1544465184540;
        Mon, 10 Dec 2018 10:06:24 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id p11sm20343688pgn.60.2018.12.10.10.06.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 10:06:24 -0800 (PST)
Date:   Mon, 10 Dec 2018 10:06:24 -0800 (PST)
X-Google-Original-Date: Mon, 10 Dec 2018 18:06:15 GMT
Message-Id: <72b213959171af3bfe4d849b925920ddbfb3d4b7.1544465177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.git.gitgitgadget@gmail.com>
References: <pull.92.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/5] multi-pack-index: prepare 'repack' verb
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

Introduce a 'repack' verb to 'git multi-pack-index' that takes a
'--batch-size' option. The verb will inspect the multi-pack-index
for referenced pack-files whose size is smaller than the batch
size, until collecting a list of pack-files whose sizes sum to
larger than the batch size. Then, a new pack-file will be created
containing the objects from those pack-files that are referenced
by the multi-pack-index. The resulting pack is likely to actually
be smaller than the batch size due to compression and the fact
that there may be objects in the pack-files that have duplicate
copies in other pack-files.

The current change introduces the command-line arguments, and we
add a test that ensures we parse these options properly. Since
we specify a small batch size, we will guarantee that future
implementations do not change the list of pack-files.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-multi-pack-index.txt | 12 ++++++++++++
 builtin/multi-pack-index.c             | 10 +++++++++-
 midx.c                                 |  5 +++++
 midx.h                                 |  1 +
 t/t5319-multi-pack-index.sh            | 11 +++++++++++
 5 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index 822d83c845..e43e7da71e 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -39,6 +39,18 @@ expire::
 	Rewrite the MIDX file afterward to remove all references to
 	these pack-files.
 
+repack::
+	When given as the verb, collect a batch of pack-files whose
+	size are all at most the size given by --batch-size, but
+	whose sizes sum to larger than --batch-size. The batch is
+	selected by greedily adding small pack-files starting with
+	the oldest pack-files that fit the size. Create a new pack-
+	file containing the objects the multi-pack-index indexes
+	into thos pack-files, and rewrite the multi-pack-index to
+	contain that pack-file. A later run of 'git multi-pack-index
+	expire' will delete the pack-files that were part of this
+	batch.
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
index 50e4cd7270..4caf148464 100644
--- a/midx.c
+++ b/midx.c
@@ -1115,3 +1115,8 @@ int expire_midx_packs(const char *object_dir)
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
index 210279a3cf..c23e930a5d 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -410,4 +410,15 @@ test_expect_success 'expire removes unreferenced packs' '
 	)
 '
 
+test_expect_success 'repack does not create any packs' '
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

