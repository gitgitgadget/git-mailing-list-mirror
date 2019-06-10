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
	by dcvr.yhbt.net (Postfix) with ESMTP id 618FC1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 23:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390647AbfFJXf2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 19:35:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36428 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390542AbfFJXf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 19:35:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id k21so13635550edq.3
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 16:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YPIY2XnjoE9ory6N/X2WJBLLO8KS5ZqTf6UTegR52Xc=;
        b=XulEK6Ukrd+01IuEKBhkPOTG+PSYi3ypQk1Rn8eCNCiLWAspGgiRFQeiCo3McxrZ0S
         NbiTpnJ50tARu8Vth49SqC3LckTokj14eqenrHzFnKIgY8x2ghYFF7+bX+Pt9rHMSkJk
         P6rId/fkEk1LH3JS6XqxJjsSSIrW2Cw1js0ckXHb0VhZw7xUYXV4lJegc1pJ9v205y4M
         hlkQE/oPJamW2MGBrDZsJqzALHuNjOHdTsM2LAHPHhfEOrE351OY8irAZs7wr+CW9B8d
         cwP/GMFAcfLdsxhFerH45Aakn/KVteM62cLO7kVATkEWyZBPnULlcpNrrxKR0+poP7sD
         dj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YPIY2XnjoE9ory6N/X2WJBLLO8KS5ZqTf6UTegR52Xc=;
        b=FzPo5v7t0OFdv37M2CbRQvjbOMYlOn7pIPIMEmVE/3XUfrpS5aCAcwyIVvYND6LnA0
         Miub8MvEB9QBfFNDYBysXPZKOuO04Ew02AHJKFYy6Q4+nAsDEzSDKe7+klkOSli9jjn3
         fXDrSOQFTQDzNKK6/JNCoTaY29kZs7gwgTKkxu2X8TuuA1Cx2DtZbJN15UkUsTWqtRbw
         OZX8A/VLqf8LtWxyaL95PFu3As/1fbQHa7vHHCgxE6niTzzUf4CFOVn9JkVFDtiYSMKm
         sEC7RgEWFhR7Iwj9dIhIfhQXf/tYM1HVDdOUtkvQFj/r9skp8xkq+mSZFl//+Pu9sHpp
         OWdw==
X-Gm-Message-State: APjAAAX8EoxhALTzq1y5oPDGhMZWEg3nC6+I7wiN4mYaQk1CNd7vr0V3
        aUfZ+J/eevKm6GdY7sEIBNJcQmeQ
X-Google-Smtp-Source: APXvYqxSTqJpKASpx0fB+sVMkAOLaF+t7bSAOyfR9XSK+mZhYn5uzz3/8E1Kkv5SurWlCKpGYMrA1w==
X-Received: by 2002:a05:6402:1701:: with SMTP id y1mr75031654edu.22.1560209723849;
        Mon, 10 Jun 2019 16:35:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21sm3195132edv.83.2019.06.10.16.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 16:35:23 -0700 (PDT)
Date:   Mon, 10 Jun 2019 16:35:23 -0700 (PDT)
X-Google-Original-Date: Mon, 10 Jun 2019 23:35:12 GMT
Message-Id: <b78967a0521340ca87b60a4700d9b7b72e40b128.1560209720.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.261.git.gitgitgadget@gmail.com>
References: <pull.261.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 03/11] multi-pack-index: prepare for 'expire' subcommand
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

The multi-pack-index tracks objects in a collection of pack-files.
Only one copy of each object is indexed, using the modified time
of the pack-files to determine tie-breakers. It is possible to
have a pack-file with no referenced objects because all objects
have a duplicate in a newer pack-file.

Introduce a new 'expire' subcommand to the multi-pack-index builtin.
This subcommand will delete these unused pack-files and rewrite the
multi-pack-index to no longer refer to those files. More details
about the specifics will follow as the method is implemented.

Add a test that verifies the 'expire' subcommand is correctly wired,
but will still be valid when the verb is implemented. Specifically,
create a set of packs that should all have referenced objects and
should not be removed during an 'expire' operation. The packs are
created carefully to ensure they have a specific order when sorted
by size. This will be important in a later test.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-multi-pack-index.txt |  5 +++
 builtin/multi-pack-index.c             |  4 ++-
 midx.c                                 |  5 +++
 midx.h                                 |  1 +
 t/t5319-multi-pack-index.sh            | 49 ++++++++++++++++++++++++++
 5 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index 1af406aca2..6186c4c936 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -31,6 +31,11 @@ write::
 verify::
 	Verify the contents of the MIDX file.
 
+expire::
+	Delete the pack-files that are tracked 	by the MIDX file, but
+	have no objects referenced by the MIDX. Rewrite the MIDX file
+	afterward to remove all references to these pack-files.
+
 
 EXAMPLES
 --------
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 72dfd3dadc..ad10d40512 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -6,7 +6,7 @@
 #include "trace2.h"
 
 static char const * const builtin_multi_pack_index_usage[] = {
-	N_("git multi-pack-index [--object-dir=<dir>] (write|verify)"),
+	N_("git multi-pack-index [--object-dir=<dir>] (write|verify|expire)"),
 	NULL
 };
 
@@ -47,6 +47,8 @@ int cmd_multi_pack_index(int argc, const char **argv,
 		return write_midx_file(opts.object_dir);
 	if (!strcmp(argv[0], "verify"))
 		return verify_midx_file(the_repository, opts.object_dir);
+	if (!strcmp(argv[0], "expire"))
+		return expire_midx_packs(the_repository, opts.object_dir);
 
 	die(_("unrecognized verb: %s"), argv[0]);
 }
diff --git a/midx.c b/midx.c
index e7e1fe4d65..3b7da1a360 100644
--- a/midx.c
+++ b/midx.c
@@ -1140,3 +1140,8 @@ int verify_midx_file(struct repository *r, const char *object_dir)
 
 	return verify_midx_error;
 }
+
+int expire_midx_packs(struct repository *r, const char *object_dir)
+{
+	return 0;
+}
diff --git a/midx.h b/midx.h
index 3eb29731f2..505f1431b7 100644
--- a/midx.h
+++ b/midx.h
@@ -50,6 +50,7 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, i
 int write_midx_file(const char *object_dir);
 void clear_midx_file(struct repository *r);
 int verify_midx_file(struct repository *r, const char *object_dir);
+int expire_midx_packs(struct repository *r, const char *object_dir);
 
 void close_midx(struct multi_pack_index *m);
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 1ebf19ec3c..1b2d32f475 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -363,4 +363,53 @@ test_expect_success 'verify incorrect 64-bit offset' '
 		"incorrect object offset"
 '
 
+test_expect_success 'setup expire tests' '
+	mkdir dup &&
+	(
+		cd dup &&
+		git init &&
+		test-tool genrandom "data" 4096 >large_file.txt &&
+		git update-index --add large_file.txt &&
+		for i in $(test_seq 1 20)
+		do
+			test_commit $i
+		done &&
+		git branch A HEAD &&
+		git branch B HEAD~8 &&
+		git branch C HEAD~13 &&
+		git branch D HEAD~16 &&
+		git branch E HEAD~18 &&
+		git pack-objects --revs .git/objects/pack/pack-A <<-EOF &&
+		refs/heads/A
+		^refs/heads/B
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-B <<-EOF &&
+		refs/heads/B
+		^refs/heads/C
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-C <<-EOF &&
+		refs/heads/C
+		^refs/heads/D
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-D <<-EOF &&
+		refs/heads/D
+		^refs/heads/E
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-E <<-EOF &&
+		refs/heads/E
+		EOF
+		git multi-pack-index write
+	)
+'
+
+test_expect_success 'expire does not remove any packs' '
+	(
+		cd dup &&
+		ls .git/objects/pack >expect &&
+		git multi-pack-index expire &&
+		ls .git/objects/pack >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
gitgitgadget

