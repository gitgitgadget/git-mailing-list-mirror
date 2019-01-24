Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A99191F453
	for <e@80x24.org>; Thu, 24 Jan 2019 21:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfAXVwL (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 16:52:11 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34962 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbfAXVwC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 16:52:02 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so5850256edx.2
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 13:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qa4nh8yOf4o5JOTfZ39IVv/zKm36nPFtf8y74fqLm/o=;
        b=bDSBPnFCVF6U9vpuitKXgMZYA9FLh/lS7OZN64DmSEGJDJabPI0FUqVxoAA8GuqiIl
         32zIBl8JPyLh2aY9pVQlRllDcWIddvVbAx4Zh97Hpr2/ZTECN4A9KNbw/6j8w/BA4frF
         Ty6VM2Owjd4NKeeXP+t6LHQgwUByDi18SESzI1VaFtflKjZBt6QvS2eQJgyUksm0sorh
         9UrZ4fX8sFY9Mib2QU23AokWvQu2o0RK7qFUm/8Tstj7nqQyIkui13diqWwY+JD/L5T+
         NwHEVy/uLQPgzVSBYAEoisHR7ny8rGVzfV2PirYhFcrV4aK2Ye+ZskYFWmwQqfbXuPmM
         QrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qa4nh8yOf4o5JOTfZ39IVv/zKm36nPFtf8y74fqLm/o=;
        b=TfEGW5SLzYx0bYd6zSUOisqRMpTs7yJuRdMyOpN8T/GlDq1y9qirlJJs+d5n4MDvbc
         rCd+fmBIcauHneyBvHg6yF6SH6chiXygrHq91NiqlBELW1nDBsWHNp8TVDuvQwoQ0QbV
         vZx4JirRFUSX9DzeeWrxjucyh0+EySUmOj8dtSYsQm2mJ65W4P+qAec0wqKLKBcD34mN
         Rg4KT4Kewx2xEnxbRPFiZrW/k3xs0+Ijh4tr9dgxauh/aAojHIkd2cwoDCx49bHeytfV
         nxsjz3tdkjBq7aUlm+qSUpudV5fD4+m5N03VVpcD2dkr3uSnLi1TKIak9wHL9mUg4dEf
         6Z6Q==
X-Gm-Message-State: AJcUukerqn64ODSCv+B+08C1GfUq8th1gRpOxQjBJ+e9+W8O56ZCcVFU
        +nqyTJsdEbxVMSH/ndhgJ0IET3yg
X-Google-Smtp-Source: ALg8bN6vmvbNMtceXqn1nMSZ62OOu+ybtUt5UekCHj6T22BUbJwGomjkbFv9s1ZV6Piqpn//morxng==
X-Received: by 2002:a50:8b41:: with SMTP id l59mr8200246edl.44.1548366720262;
        Thu, 24 Jan 2019 13:52:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a14sm971218eju.24.2019.01.24.13.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 13:51:59 -0800 (PST)
Date:   Thu, 24 Jan 2019 13:51:59 -0800 (PST)
X-Google-Original-Date: Thu, 24 Jan 2019 21:51:50 GMT
Message-Id: <f5a8ff21dda5b29d8fe75b3b52be873bdb4b3031.1548366713.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.v4.git.gitgitgadget@gmail.com>
References: <pull.92.v3.git.gitgitgadget@gmail.com>
        <pull.92.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 07/10] multi-pack-index: prepare 'repack' subcommand
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

In an environment where the multi-pack-index is useful, it is due
to many pack-files and an inability to repack the object store
into a single pack-file. However, it is likely that many of these
pack-files are rather small, and could be repacked into a slightly
larger pack-file without too much effort. It may also be important
to ensure the object store is highly available and the repack
operation does not interrupt concurrent git commands.

Introduce a 'repack' subcommand to 'git multi-pack-index' that
takes a '--batch-size' option. The subcommand will inspect the
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

In addition, we hard-code the modified times of the packs in
the pack directory to ensure the list of packs sorted by modified
time matches the order if sorted by size (ascending). This will
be important in a future test.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-multi-pack-index.txt | 11 +++++++++++
 builtin/multi-pack-index.c             | 12 ++++++++++--
 midx.c                                 |  5 +++++
 midx.h                                 |  1 +
 t/t5319-multi-pack-index.sh            | 17 +++++++++++++++++
 5 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index 6186c4c936..de345c2400 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -36,6 +36,17 @@ expire::
 	have no objects referenced by the MIDX. Rewrite the MIDX file
 	afterward to remove all references to these pack-files.
 
+repack::
+	Create a new pack-file containing objects in small pack-files
+	referenced by the multi-pack-index. Select the pack-files by
+	examining packs from oldest-to-newest, adding a pack if its
+	size is below the batch size. Stop adding packs when the sum
+	of sizes of the added packs is above the batch size. If the
+	total size does not reach the batch size, then do nothing.
+	Rewrite the multi-pack-index to reference the new pack-file.
+	A later run of 'git multi-pack-index expire' will delete the
+	pack-files that were part of this batch.
+
 
 EXAMPLES
 --------
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 145de3a46c..c66239de33 100644
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
+		die(_("--batch-size option is only for 'repack' subcommand"));
+
 	if (!strcmp(argv[0], "write"))
 		return write_midx_file(opts.object_dir);
 	if (!strcmp(argv[0], "verify"))
@@ -47,5 +55,5 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	if (!strcmp(argv[0], "expire"))
 		return expire_midx_packs(opts.object_dir);
 
-	die(_("unrecognized verb: %s"), argv[0]);
+	die(_("unrecognized subcommand: %s"), argv[0]);
 }
diff --git a/midx.c b/midx.c
index 299e9b2e8f..768a7dff73 100644
--- a/midx.c
+++ b/midx.c
@@ -1112,3 +1112,8 @@ int expire_midx_packs(const char *object_dir)
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
index 65e85debec..acc5e65ecc 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -417,4 +417,21 @@ test_expect_success 'expire removes unreferenced packs' '
 	)
 '
 
+test_expect_success 'repack with minimum size does not alter existing packs' '
+	(
+		cd dup &&
+		rm -rf .git/objects/pack &&
+		mv .git/objects/pack-backup .git/objects/pack &&
+		touch -m -t 201901010000 .git/objects/pack/pack-D* &&
+		touch -m -t 201901010001 .git/objects/pack/pack-C* &&
+		touch -m -t 201901010002 .git/objects/pack/pack-B* &&
+		touch -m -t 201901010003 .git/objects/pack/pack-A* &&
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

