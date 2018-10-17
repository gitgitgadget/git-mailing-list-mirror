Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CD9D1F454
	for <e@80x24.org>; Wed, 17 Oct 2018 20:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeJREai (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 00:30:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39113 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbeJREai (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 00:30:38 -0400
Received: by mail-pl1-f193.google.com with SMTP id e67-v6so4250408plb.6
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 13:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k9K1PaMSBEBpYlyEw1LIcalAZZSV1wKRzXW9aoZ5YOo=;
        b=QHgqfabIIQAyeFbbqh6f/36ejLQ0TP5vdbu41mingAcBeJWgb+l1u1rXnLV2TDio3Q
         x8mvdZRJJOSWbHpCUJk2sW/z7pAncotckwc0p7P1Ib0JH6p4DThY7sRH3nbEb7tvqH1I
         kAFEPsqNflhZADVr1AEhUm0q8pTMwVVq6WUGPKipJl33H2lkKVj7wjzUg6PA2g/nqUYO
         Uiq1/QUkXxDdshrfBn9G47M0pICZgoc+MdSMu6No0OJzwlqSIB9g2HqbXcMfYj6oToaU
         eGmtG7WNot2KFb5mqgMpY2kKX6x4JTifY/LmjCKhDbkeuGcbCEQEq/sFd6rM8D+Ayq7R
         HuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=k9K1PaMSBEBpYlyEw1LIcalAZZSV1wKRzXW9aoZ5YOo=;
        b=LovrrNRb0IbkqJJQQXCvBTJDSRE7uPpHNHPpvv1N+vJars7Kz7BrEU8ir8BYFd1474
         H5eqd72BdXgqp7sXmClrHQQB5Xkp9a0lCVxW+qaWvv3yp72b7LJcON8i7zVtaSS46ycp
         SiVIXZSaIIvqvEJZYW/ux0xcSDRNc1U2pwhf+LDG4MYQd2Rvp7CZf0w9DtlJ0I64kur+
         F1PIagI9H2DpNPgthNziBFStYD3xHDWiyaozviS9yuyOPNp/mohBKxxVN/CM8rDxX3bD
         nFBZR6VWKnX9bDrz7HLaGbln39SViWadBLT7fCZNwbLkAGPd5kcTGpY1J5GpceOKyNaJ
         szQA==
X-Gm-Message-State: ABuFfogIKB6CduN1F2xNAnYVWjOloRvUjELxeJm8uxt4j5RyzlpY0zga
        QRtWgkDXWmeiJeK1G5AbT/IoJGcS
X-Google-Smtp-Source: ACcGV63csm8jSUSwHBv5CG6VVWknh5H/IsU29aL1OAEGCutqvGcAPen8qCYF6fEoe9iJfhMFvVsCzw==
X-Received: by 2002:a17:902:2b84:: with SMTP id l4-v6mr3479926plb.124.1539808394727;
        Wed, 17 Oct 2018 13:33:14 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id p62-v6sm28865452pfp.111.2018.10.17.13.33.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 13:33:13 -0700 (PDT)
Date:   Wed, 17 Oct 2018 13:33:13 -0700 (PDT)
X-Google-Original-Date: Wed, 17 Oct 2018 20:33:07 GMT
Message-Id: <d2ea66630752f02f22e806725e5e3699d6dd2043.1539808389.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.50.git.gitgitgadget@gmail.com>
References: <pull.50.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/3] t: explicitly turn off core.commitGraph as needed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

There are a few tests that already require GIT_TEST_COMMIT_GRAPH=0
as they rely on an interaction with the commits in the object store
that is circumvented by parsing commit information from the
commit-graph instead. Before enabling core.commitGraph as true by
default, explicitly turn the setting off for these tests.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t0410-partial-clone.sh            | 3 ++-
 t/t5307-pack-missing-commit.sh      | 3 ++-
 t/t6011-rev-list-with-bad-commit.sh | 3 ++-
 t/t6024-recursive-merge.sh          | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index cfd0655ea1..f5277fafb1 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -193,7 +193,8 @@ test_expect_success 'rev-list stops traversal at missing and promised commit' '
 
 	git -C repo config core.repositoryformatversion 1 &&
 	git -C repo config extensions.partialclone "arbitrary string" &&
-	GIT_TEST_COMMIT_GRAPH=0 git -C repo rev-list --exclude-promisor-objects --objects bar >out &&
+	GIT_TEST_COMMIT_GRAPH=0 git -c core.commitGraph=false \
+		-C repo rev-list --exclude-promisor-objects --objects bar >out &&
 	grep $(git -C repo rev-parse bar) out &&
 	! grep $FOO out
 '
diff --git a/t/t5307-pack-missing-commit.sh b/t/t5307-pack-missing-commit.sh
index dacb440b27..dc4c19d0aa 100755
--- a/t/t5307-pack-missing-commit.sh
+++ b/t/t5307-pack-missing-commit.sh
@@ -16,7 +16,8 @@ test_expect_success setup '
 	obj=$(git rev-parse --verify tag3) &&
 	fanout=$(expr "$obj" : "\(..\)") &&
 	remainder=$(expr "$obj" : "..\(.*\)") &&
-	rm -f ".git/objects/$fanout/$remainder"
+	rm -f ".git/objects/$fanout/$remainder" &&
+	git config core.commitGraph false
 '
 
 test_expect_success 'check corruption' '
diff --git a/t/t6011-rev-list-with-bad-commit.sh b/t/t6011-rev-list-with-bad-commit.sh
index 545b461e51..da6949743d 100755
--- a/t/t6011-rev-list-with-bad-commit.sh
+++ b/t/t6011-rev-list-with-bad-commit.sh
@@ -42,7 +42,8 @@ test_expect_success 'corrupt second commit object' \
    '
 
 test_expect_success 'rev-list should fail' '
-	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git rev-list --all > /dev/null
+	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 \
+		git -c core.commitGraph=false rev-list --all > /dev/null
 '
 
 test_expect_success 'git repack _MUST_ fail' \
diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index 27c7de90ce..fccdf96f13 100755
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -61,7 +61,8 @@ GIT_AUTHOR_DATE="2006-12-12 23:00:08" git commit -m F
 '
 
 test_expect_success 'combined merge conflicts' '
-	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git merge -m final G
+	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 \
+		git -c core.commitGraph=false merge -m final G
 '
 
 cat > expect << EOF
-- 
gitgitgadget

