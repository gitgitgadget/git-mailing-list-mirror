Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 268511F405
	for <e@80x24.org>; Fri, 21 Dec 2018 16:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389239AbeLUQ2p (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 11:28:45 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45608 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389179AbeLUQ2o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 11:28:44 -0500
Received: by mail-ed1-f65.google.com with SMTP id d39so5106496edb.12
        for <git@vger.kernel.org>; Fri, 21 Dec 2018 08:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XSXDKhELJ5mZgONBO/c0KBMR0KUQa6bfHEmClVutJY4=;
        b=qFJ5dYXrfXkF5NNwTyxYxhaf8Ui6sZ9nmNriSaLov3LNOH6zp/2Wk8oJiftK9nbn14
         0ADv0Cp3NjHi7OCWf2+7E1Mmgo5GSz9zGEvbm7xhYHZlOtLJvMs679uyF/vrAyKcGItB
         C3nTu1ybq6gNSsLyHQBfz7qkEXW9w1uz0UwFvtViiHeP1wthAdfH3XTRrNgV+Fb7vs/C
         wDxfgsGp9fjdL+YHFXmjal1vndarwYZMgjI8sJ1dmkimvOGlIbIAnZmGc0yFP/PfkYcF
         SSxPSUAxz5NiNvaL5lDlKvlwqbfDDjLryFt0XjPBuj6/REAutvsJH150G0vTsqCKhPi8
         OJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XSXDKhELJ5mZgONBO/c0KBMR0KUQa6bfHEmClVutJY4=;
        b=AxQCdBHa42jc1LJZ8nlvM7LdpOqM2DKTxmYihWco8I2ByLFO4pvlBn2xWfbM6s5kDy
         3ML++8Rfxu/85Fr3F+uGY3wEZe1vkv90Q8ZYbUXXdHVglh0ekIwJ3zbC5NUs4Am2TPSz
         5K9iQXZ1cj7gSv8W9ofzfNYa3P71lsTefxXf4nDH0ANlQRKzlm/P1Jljo4TnuZjopBtc
         bwFTZZQ+BXGnjyQAsWAFYPKcsGCMj17OLA+k8W09eRFPKHHdYqSxGIPmUT9rO4+flcr+
         wl0r/mWg1b7J9Ui+ytr2UQkJTyVFigwGQ8j6hbMz81qeARPHSebCF9TxpegM7bmkHndI
         xD8w==
X-Gm-Message-State: AA+aEWYhbr/RJcR+bIWtiowv3MSBGewnuVoKm8A3A0rFKm8rsNgWHk24
        UKlVstrQY58QmQDSUfJA7SKo9VD1AfFDCA==
X-Google-Smtp-Source: AFSGD/U5YUJhWhdcgf6s2N1B0pCdCdIalATkY/9nHlxRGM21ud3f2Nz2b7DN0wQDg0KFuqbDJj+wNg==
X-Received: by 2002:a17:906:2009:: with SMTP id 9-v6mr2608441ejo.2.1545409722542;
        Fri, 21 Dec 2018 08:28:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j21-v6sm3722020ejz.51.2018.12.21.08.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 08:28:42 -0800 (PST)
Date:   Fri, 21 Dec 2018 08:28:42 -0800 (PST)
X-Google-Original-Date: Fri, 21 Dec 2018 16:28:35 GMT
Message-Id: <af08e21c974f72c96f4892571e9e617137a94c2a.1545409716.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.v2.git.gitgitgadget@gmail.com>
References: <pull.92.git.gitgitgadget@gmail.com>
        <pull.92.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 6/7] multi-pack-index: prepare 'repack' subcommand
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
index 043cd1fd97..127c43f7b0 100644
--- a/midx.c
+++ b/midx.c
@@ -1110,3 +1110,8 @@ int expire_midx_packs(const char *object_dir)
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
index 210279a3cf..f675621080 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -410,4 +410,15 @@ test_expect_success 'expire removes unreferenced packs' '
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

