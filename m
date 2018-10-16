Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 939AE1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 22:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeJQG3W (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 02:29:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45330 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbeJQG3V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 02:29:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id t70-v6so11514499pgd.12
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 15:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9dub4UGRgjLu0zkHm8JWsQaxviQeUr5UMnvk5A7Kz7Q=;
        b=S7fz5WUmqNWjbSSPG0hwVGXflJU8qoFAqCJ3NXAlg+PlTKX9+LOoTnMzZo30MU2Sbz
         pYDvabKHnzFSe/meA6L6P2KaR8q32eNWf3aBU8oDAZQi/jScDZbKgD6J8hjtIIvFVMV/
         yvvDwKlLy6fnnjuoRxNtV56VL8y65NAZ7JyzGKvF02jezDixxbdZVwq2q38zStmTFNRN
         Dsi3rPUXh2gVkUM5474dez5uBQSdDsztGQJ0pLeKhl/3KEGpxVN6qGWRtxN8+rRZUBI5
         e/byHz4qLgrhM6suifbT5gguZx+LdmYZvir7/BKeDDfwVGzhcGFpu/hZlsKLsz037/wP
         WN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9dub4UGRgjLu0zkHm8JWsQaxviQeUr5UMnvk5A7Kz7Q=;
        b=WuszB3ldLVIveFiU6LwYKQ81SgPIsKxGN/q6YHF3skjuH7D9FY4SxNBFMMFQDcJoy8
         qYLaIzFf/zrUXg0zwtRDfb2TEFFD7ZDs0UTvTo58+Umzpi1lYVViiIT/+MNVJwR5CzrB
         u9GdVBJqhyEZXQPJLXfX3yt2LhAgzP05ecNm26csCU03OFLOKy27G8wnehr6lCscvDlk
         N9yWEY4yuM5yKMm5r4vGjOTwTjZhDqgdxLytlSBq9bThoi6rF5zgY5AJasV0+Bm64e8N
         fMEGu6N/KuLemj3dfUIEM/3jfA1kVL0NhRfulV0cnuDL9ha0Gp1O+atb2yuJyIOclryT
         AqQQ==
X-Gm-Message-State: ABuFfogXngefg+73r4Kg3HO/FmO9O+nvccIehGWxRe8lcjBtak9LTJev
        bz1NEyrRGivXLBqGSh2vyh6m7Zmb
X-Google-Smtp-Source: ACcGV61sU6jR8RN479MiLmElno2FzsUTExVuDAaS7euq4v6Nb4jOHpd0nuR4YPXmpP7eyeIP6WcEnQ==
X-Received: by 2002:a63:df4f:: with SMTP id h15-v6mr21138304pgj.94.1539729407700;
        Tue, 16 Oct 2018 15:36:47 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id q25-v6sm23054959pfk.154.2018.10.16.15.36.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 15:36:46 -0700 (PDT)
Date:   Tue, 16 Oct 2018 15:36:46 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Oct 2018 22:36:32 GMT
Message-Id: <a21febe1128cbaf69f2201598d9efee6f6a4b2d8.1539729393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.25.v4.git.gitgitgadget@gmail.com>
References: <pull.25.v3.git.gitgitgadget@gmail.com>
        <pull.25.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 7/7] t6012: make rev-list tests more interesting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

As we are working to rewrite some of the revision-walk machinery,
there could easily be some interesting interactions between the
options that force topological constraints (--topo-order,
--date-order, and --author-date-order) along with specifying a
path.

Add extra tests to t6012-rev-list-simplify.sh to add coverage of
these interactions. To ensure interesting things occur, alter the
repo data shape to have different orders depending on topo-, date-,
or author-date-order.

When testing using GIT_TEST_COMMIT_GRAPH, this assists in covering
the new logic for topo-order walks using generation numbers. The
extra tests can be added indepently.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t6012-rev-list-simplify.sh | 45 ++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index b5a1190ffe..a10f0df02b 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -12,6 +12,22 @@ unnote () {
 	git name-rev --tags --stdin | sed -e "s|$OID_REGEX (tags/\([^)]*\)) |\1 |g"
 }
 
+#
+# Create a test repo with interesting commit graph:
+#
+# A--B----------G--H--I--K--L
+#  \  \           /     /
+#   \  \         /     /
+#    C------E---F     J
+#        \_/
+#
+# The commits are laid out from left-to-right starting with
+# the root commit A and terminating at the tip commit L.
+#
+# There are a few places where we adjust the commit date or
+# author date to make the --topo-order, --date-order, and
+# --author-date-order flags produce different output.
+
 test_expect_success setup '
 	echo "Hi there" >file &&
 	echo "initial" >lost &&
@@ -21,10 +37,18 @@ test_expect_success setup '
 
 	git branch other-branch &&
 
+	git symbolic-ref HEAD refs/heads/unrelated &&
+	git rm -f "*" &&
+	echo "Unrelated branch" >side &&
+	git add side &&
+	test_tick && git commit -m "Side root" &&
+	note J &&
+	git checkout master &&
+
 	echo "Hello" >file &&
 	echo "second" >lost &&
 	git add file lost &&
-	test_tick && git commit -m "Modified file and lost" &&
+	test_tick && GIT_AUTHOR_DATE=$(($test_tick + 120)) git commit -m "Modified file and lost" &&
 	note B &&
 
 	git checkout other-branch &&
@@ -63,13 +87,6 @@ test_expect_success setup '
 	test_tick && git commit -a -m "Final change" &&
 	note I &&
 
-	git symbolic-ref HEAD refs/heads/unrelated &&
-	git rm -f "*" &&
-	echo "Unrelated branch" >side &&
-	git add side &&
-	test_tick && git commit -m "Side root" &&
-	note J &&
-
 	git checkout master &&
 	test_tick && git merge --allow-unrelated-histories -m "Coolest" unrelated &&
 	note K &&
@@ -103,14 +120,24 @@ check_result () {
 	check_outcome success "$@"
 }
 
-check_result 'L K J I H G F E D C B A' --full-history
+check_result 'L K J I H F E D C G B A' --full-history --topo-order
+check_result 'L K I H G F E D C B J A' --full-history
+check_result 'L K I H G F E D C B J A' --full-history --date-order
+check_result 'L K I H G F E D B C J A' --full-history --author-date-order
 check_result 'K I H E C B A' --full-history -- file
 check_result 'K I H E C B A' --full-history --topo-order -- file
 check_result 'K I H E C B A' --full-history --date-order -- file
+check_result 'K I H E B C A' --full-history --author-date-order -- file
 check_result 'I E C B A' --simplify-merges -- file
+check_result 'I E C B A' --simplify-merges --topo-order -- file
+check_result 'I E C B A' --simplify-merges --date-order -- file
+check_result 'I E B C A' --simplify-merges --author-date-order -- file
 check_result 'I B A' -- file
 check_result 'I B A' --topo-order -- file
+check_result 'I B A' --date-order -- file
+check_result 'I B A' --author-date-order -- file
 check_result 'H' --first-parent -- another-file
+check_result 'H' --first-parent --topo-order -- another-file
 
 check_result 'E C B A' --full-history E -- lost
 test_expect_success 'full history simplification without parent' '
-- 
gitgitgadget
