Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63C461FF40
	for <e@80x24.org>; Sat, 25 Jun 2016 06:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbcFYGeL (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 02:34:11 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35435 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbcFYGeK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 02:34:10 -0400
Received: by mail-it0-f67.google.com with SMTP id g127so4770720ith.2
        for <git@vger.kernel.org>; Fri, 24 Jun 2016 23:34:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=YK6h+Be1s46A96ledEKpRlzHGA5uQLY4MG89guQbKLs=;
        b=ro+XLPcrX71sS20CoChCkmdTB80acLp4xcC3xlcxZfPxfStBHKpYgXWE+YPPsKff67
         CHHC54UipA8CuhROMKePr8HKjWUxjI4uN3y7cpq1OzyyYukBXKhV1LfSjUv0TneOkdIp
         4O84XboVogFbxsM9rX7k13fLZUP90xz9M4Bpn4Tu2U3vmPTW56O0OMlXyHS6Yalm0Vyp
         VMpi3J2O2+9qp31SPCevVc4U5FCVtHeSO2cQeluLGv7/kUlAxuPUGrnej7biJpiPtuW8
         RftbVku1ejC7fpx4ROM5PX+TYPC25q5zcPXehCro4JWOnr6Mz93k6DfWgMgV5fjDKADp
         lPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YK6h+Be1s46A96ledEKpRlzHGA5uQLY4MG89guQbKLs=;
        b=X5Vgi5Z680FiilZQ/jvo14+JVLqBXFQ3HOelWdY6L6voU/yCCiQFmLIJO4RPnm8fke
         inzeBa+LKj07CGhvGgmxJZXN35TFIG5P/9mZ0plWZFYv5N8R7u72JLSouNTiIvNdeRT5
         ZgDuMPeNj0E9njsKcA8weoilymDFwzpgk2RKrcfOx2U6suZR2X61lj02UEnvOhy0MR0m
         sp0ExOy8JAGKQnavo7sjglsKiOaTEdDGX751JIsFtPIYoe9DZfsQoWlOTRx8hmiYVMNJ
         /1/73oeOY7fvlU2q6DTNgqOOEj+tDAYSE6E9MARmntDFb+3qeQ/ONpSNMbJ5uhW0f8DD
         ORBQ==
X-Gm-Message-State: ALyK8tLsKvZdsHY9akMERJ9QNLXZaMPWL3DVHV1aOIurWau1iUTfq/+nQ7wf+GiMAWS3Ew==
X-Received: by 10.36.65.162 with SMTP id b34mr1235294itd.30.1466836449451;
        Fri, 24 Jun 2016 23:34:09 -0700 (PDT)
Received: from wolverine.localdomain ([2601:681:4100:c710:e8b:fdff:fecc:2734])
        by smtp.gmail.com with ESMTPSA id 142sm35839itk.12.2016.06.24.23.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jun 2016 23:34:08 -0700 (PDT)
From:	Alex Henrie <alexhenrie24@gmail.com>
To:	gitster@pobox.com, diane.gasselin@ensimag.imag.fr,
	Matthieu.Moy@imag.fr, vascomalmeida@sapo.pt, git@vger.kernel.org
Cc:	Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2] unpack-trees: fix English grammar in do-this-before-that messages
Date:	Sat, 25 Jun 2016 00:34:04 -0600
Message-Id: <20160625063404.1623-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.9.0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 t/t1011-read-tree-sparse-checkout.sh |  2 +-
 t/t7607-merge-overwrite.sh           |  2 +-
 t/t7609-merge-co-error-msgs.sh       | 10 +++++-----
 unpack-trees.c                       | 18 +++++++++---------
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index 0c74bee..1d8d751 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -244,7 +244,7 @@ test_expect_success 'print errors when failed to update worktree' '
 error: The following untracked working tree files would be overwritten by checkout:
 	sub/added
 	sub/addedtoo
-Please move or remove them before you can switch branches.
+Please move or remove them before you switch branches.
 Aborting
 EOF
 	test_cmp expected actual
diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index 758a623..1c59349 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -115,7 +115,7 @@ cat >expect <<\EOF
 error: The following untracked working tree files would be overwritten by merge:
 	sub
 	sub2
-Please move or remove them before you can merge.
+Please move or remove them before you merge.
 Aborting
 EOF
 
diff --git a/t/t7609-merge-co-error-msgs.sh b/t/t7609-merge-co-error-msgs.sh
index 6729cb3..f80bdb8 100755
--- a/t/t7609-merge-co-error-msgs.sh
+++ b/t/t7609-merge-co-error-msgs.sh
@@ -31,7 +31,7 @@ error: The following untracked working tree files would be overwritten by merge:
 	four
 	three
 	two
-Please move or remove them before you can merge.
+Please move or remove them before you merge.
 Aborting
 EOF
 
@@ -53,10 +53,10 @@ error: Your local changes to the following files would be overwritten by merge:
 	four
 	three
 	two
-Please commit your changes or stash them before you can merge.
+Please commit your changes or stash them before you merge.
 error: The following untracked working tree files would be overwritten by merge:
 	five
-Please move or remove them before you can merge.
+Please move or remove them before you merge.
 Aborting
 EOF
 
@@ -72,7 +72,7 @@ cat >expect <<\EOF
 error: Your local changes to the following files would be overwritten by checkout:
 	rep/one
 	rep/two
-Please commit your changes or stash them before you can switch branches.
+Please commit your changes or stash them before you switch branches.
 Aborting
 EOF
 
@@ -94,7 +94,7 @@ cat >expect <<\EOF
 error: Your local changes to the following files would be overwritten by checkout:
 	rep/one
 	rep/two
-Please commit your changes or stash them before you can switch branches.
+Please commit your changes or stash them before you switch branches.
 Aborting
 EOF
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 6bc9512..11c37fb 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -62,17 +62,17 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_commit_before_merge
 		      ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
-			  "Please commit your changes or stash them before you can switch branches.")
+			  "Please commit your changes or stash them before you switch branches.")
 		      : _("Your local changes to the following files would be overwritten by checkout:\n%%s");
 	else if (!strcmp(cmd, "merge"))
 		msg = advice_commit_before_merge
 		      ? _("Your local changes to the following files would be overwritten by merge:\n%%s"
-			  "Please commit your changes or stash them before you can merge.")
+			  "Please commit your changes or stash them before you merge.")
 		      : _("Your local changes to the following files would be overwritten by merge:\n%%s");
 	else
 		msg = advice_commit_before_merge
 		      ? _("Your local changes to the following files would be overwritten by %s:\n%%s"
-			  "Please commit your changes or stash them before you can %s.")
+			  "Please commit your changes or stash them before you %s.")
 		      : _("Your local changes to the following files would be overwritten by %s:\n%%s");
 	msgs[ERROR_WOULD_OVERWRITE] = msgs[ERROR_NOT_UPTODATE_FILE] =
 		xstrfmt(msg, cmd, cmd);
@@ -83,34 +83,34 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_commit_before_merge
 		      ? _("The following untracked working tree files would be removed by checkout:\n%%s"
-			  "Please move or remove them before you can switch branches.")
+			  "Please move or remove them before you switch branches.")
 		      : _("The following untracked working tree files would be removed by checkout:\n%%s");
 	else if (!strcmp(cmd, "merge"))
 		msg = advice_commit_before_merge
 		      ? _("The following untracked working tree files would be removed by merge:\n%%s"
-			  "Please move or remove them before you can merge.")
+			  "Please move or remove them before you merge.")
 		      : _("The following untracked working tree files would be removed by merge:\n%%s");
 	else
 		msg = advice_commit_before_merge
 		      ? _("The following untracked working tree files would be removed by %s:\n%%s"
-			  "Please move or remove them before you can %s.")
+			  "Please move or remove them before you %s.")
 		      : _("The following untracked working tree files would be removed by %s:\n%%s");
 	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] = xstrfmt(msg, cmd, cmd);
 
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_commit_before_merge
 		      ? _("The following untracked working tree files would be overwritten by checkout:\n%%s"
-			  "Please move or remove them before you can switch branches.")
+			  "Please move or remove them before you switch branches.")
 		      : _("The following untracked working tree files would be overwritten by checkout:\n%%s");
 	else if (!strcmp(cmd, "merge"))
 		msg = advice_commit_before_merge
 		      ? _("The following untracked working tree files would be overwritten by merge:\n%%s"
-			  "Please move or remove them before you can merge.")
+			  "Please move or remove them before you merge.")
 		      : _("The following untracked working tree files would be overwritten by merge:\n%%s");
 	else
 		msg = advice_commit_before_merge
 		      ? _("The following untracked working tree files would be overwritten by %s:\n%%s"
-			  "Please move or remove them before you can %s.")
+			  "Please move or remove them before you %s.")
 		      : _("The following untracked working tree files would be overwritten by %s:\n%%s");
 	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] = xstrfmt(msg, cmd, cmd);
 
-- 
2.9.0

