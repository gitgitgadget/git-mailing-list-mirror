Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7A1E208B8
	for <e@80x24.org>; Wed,  9 Aug 2017 21:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751958AbdHIVW7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 17:22:59 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33145 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbdHIVW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 17:22:58 -0400
Received: by mail-pf0-f182.google.com with SMTP id h68so32750034pfk.0
        for <git@vger.kernel.org>; Wed, 09 Aug 2017 14:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vLrv2/ebqd3inIahlMP4UNlaBou/V/0Zg20PNmYpp+g=;
        b=VLrQxNw9mJ5LZhhTsmw2IKS+MP9EKQ7YGCLNSwbrrReBIRQR0DPJrTOL04yNt5SOpj
         siKILtS2eoGycHZSz/5OQX6MVhfLHYr+G6eso5jIvOHKYQK08c4WCDrU8EXq5HcoSDcG
         wMbaIBdu19PJIMU6xsf/DSOYZkf/TQ3d6T7U/DLwxGScb10SIyDsTMmoLEfLym825IHN
         aLcIJ1RmM8itGefj6ozIyh2K4v3+PbGrYaEgE9ggoyaLdNzXcH+Tr9E5o5F3IgkLlkc+
         t+rQ+8yREu3B0KbAsvSE+b/w5+QIorfoswvRery98lCe0dGqvlDM8iHCPJ0ZCpabeh7j
         QN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vLrv2/ebqd3inIahlMP4UNlaBou/V/0Zg20PNmYpp+g=;
        b=HHWKZZn5y6Yte2r7mfLX34Xp6fSSIn+4BcNLJFH2TiKU5BaRhdWXEOcp+Sai17Oi0G
         MmbEqoSwIXVHNoTfG6xyqD+AEEmIKUhu41HGv5ZiwZZywiZ0TrSusRYTB1+wcbiF5mp1
         OSr6xAxg6mwFFEZTx8jWhHQpvmsm5VHu7E3tnrBeSErFis9r+O8QyZ8uxgtLQroxa31/
         THCJ9WFUjVRdP70Yp31Bh4Umz4cg5u/TjawbmY/nx8JszTCaRkDha5/HO28qSjki9OOh
         vJscMNAhZEAdGPFcmfm9YfIUzfAy8JbOUN1Wxb3QB5kbeu990JZAbHdBW6Zpjh3ga3MN
         +9Dw==
X-Gm-Message-State: AHYfb5hlJSYhTd8VW8wYNqR4tGzX1NeqYBJyYMqGApWCg1XejfVSR5bs
        U0Ib/MC8ksZ8ph7T
X-Received: by 10.98.144.209 with SMTP id q78mr9713672pfk.81.1502313777474;
        Wed, 09 Aug 2017 14:22:57 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:8dfb:48e4:6b78:3096])
        by smtp.gmail.com with ESMTPSA id r27sm7843899pfd.69.2017.08.09.14.22.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 09 Aug 2017 14:22:55 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jrnieder@gmail.com, sbeller@google.com
Subject: [PATCH] t1200: remove t1200-tutorial.sh
Date:   Wed,  9 Aug 2017 14:22:53 -0700
Message-Id: <20170809212253.27597-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <xmqqh8xh8fcb.fsf@gitster.mtv.corp.google.com>
References: <xmqqh8xh8fcb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v1.2.0~121 (New tutorial, 2006-01-22) rewrote the tutorial such that the
original intent of 2ae6c70674 (Adapt tutorial to cygwin and add test case,
2005-10-13) to test the examples from the tutorial doesn't hold any more.

There are dedicated tests for the commands used, even "git whatchanged",
such that removing these tests doesn't seem like a reduction in test
coverage.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 I tried finding bug reports in the archive based on t1200 and found none, 
 lots of maintenance patches, though.
 
 Jonathan,  I did not add your reviewed-by yet, as you'd want to decide
 for yourself if this is a corrected description. 
 
 Thanks,
 Stefan

 t/t1200-tutorial.sh | 268 ----------------------------------------------------
 1 file changed, 268 deletions(-)
 delete mode 100755 t/t1200-tutorial.sh

diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
deleted file mode 100755
index 397ccb6909..0000000000
--- a/t/t1200-tutorial.sh
+++ /dev/null
@@ -1,268 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005 Johannes Schindelin
-#
-
-test_description='A simple turial in the form of a test case'
-
-. ./test-lib.sh
-
-test_expect_success 'blob'  '
-	echo "Hello World" > hello &&
-	echo "Silly example" > example &&
-
-	git update-index --add hello example &&
-
-	test blob = "$(git cat-file -t 557db03)"
-'
-
-test_expect_success 'blob 557db03' '
-	test "Hello World" = "$(git cat-file blob 557db03)"
-'
-
-echo "It's a new day for git" >>hello
-cat > diff.expect << EOF
-diff --git a/hello b/hello
-index 557db03..263414f 100644
---- a/hello
-+++ b/hello
-@@ -1 +1,2 @@
- Hello World
-+It's a new day for git
-EOF
-
-test_expect_success 'git diff-files -p' '
-	git diff-files -p > diff.output &&
-	test_cmp diff.expect diff.output
-'
-
-test_expect_success 'git diff' '
-	git diff > diff.output &&
-	test_cmp diff.expect diff.output
-'
-
-test_expect_success 'tree' '
-	tree=$(git write-tree 2>/dev/null) &&
-	test 8988da15d077d4829fc51d8544c097def6644dbb = $tree
-'
-
-test_expect_success 'git diff-index -p HEAD' '
-	test_tick &&
-	tree=$(git write-tree) &&
-	commit=$(echo "Initial commit" | git commit-tree $tree) &&
-	git update-ref HEAD $commit &&
-	git diff-index -p HEAD > diff.output &&
-	test_cmp diff.expect diff.output
-'
-
-test_expect_success 'git diff HEAD' '
-	git diff HEAD > diff.output &&
-	test_cmp diff.expect diff.output
-'
-
-cat > whatchanged.expect << EOF
-commit VARIABLE
-Author: VARIABLE
-Date:   VARIABLE
-
-    Initial commit
-
-diff --git a/example b/example
-new file mode 100644
-index 0000000..f24c74a
---- /dev/null
-+++ b/example
-@@ -0,0 +1 @@
-+Silly example
-diff --git a/hello b/hello
-new file mode 100644
-index 0000000..557db03
---- /dev/null
-+++ b/hello
-@@ -0,0 +1 @@
-+Hello World
-EOF
-
-test_expect_success 'git whatchanged -p --root' '
-	git whatchanged -p --root |
-		sed -e "1s/^\(.\{7\}\).\{40\}/\1VARIABLE/" \
-		-e "2,3s/^\(.\{8\}\).*$/\1VARIABLE/" \
-	> whatchanged.output &&
-	test_cmp whatchanged.expect whatchanged.output
-'
-
-test_expect_success 'git tag my-first-tag' '
-	git tag my-first-tag &&
-	test_cmp .git/refs/heads/master .git/refs/tags/my-first-tag
-'
-
-test_expect_success 'git checkout -b mybranch' '
-	git checkout -b mybranch &&
-	test_cmp .git/refs/heads/master .git/refs/heads/mybranch
-'
-
-cat > branch.expect <<EOF
-  master
-* mybranch
-EOF
-
-test_expect_success 'git branch' '
-	git branch > branch.output &&
-	test_cmp branch.expect branch.output
-'
-
-test_expect_success 'git resolve now fails' '
-	git checkout mybranch &&
-	echo "Work, work, work" >>hello &&
-	test_tick &&
-	git commit -m "Some work." -i hello &&
-
-	git checkout master &&
-
-	echo "Play, play, play" >>hello &&
-	echo "Lots of fun" >>example &&
-	test_tick &&
-	git commit -m "Some fun." -i hello example &&
-
-	test_must_fail git merge -m "Merge work in mybranch" mybranch
-'
-
-cat > hello << EOF
-Hello World
-It's a new day for git
-Play, play, play
-Work, work, work
-EOF
-
-cat > show-branch.expect << EOF
-* [master] Merge work in mybranch
- ! [mybranch] Some work.
---
--  [master] Merge work in mybranch
-*+ [mybranch] Some work.
-*  [master^] Some fun.
-EOF
-
-test_expect_success 'git show-branch' '
-	test_tick &&
-	git commit -m "Merge work in mybranch" -i hello &&
-	git show-branch --topo-order --more=1 master mybranch \
-		> show-branch.output &&
-	test_cmp show-branch.expect show-branch.output
-'
-
-cat > resolve.expect << EOF
-Updating VARIABLE..VARIABLE
-FASTFORWARD (no commit created; -m option ignored)
- example | 1 +
- hello   | 1 +
- 2 files changed, 2 insertions(+)
-EOF
-
-test_expect_success 'git resolve' '
-	git checkout mybranch &&
-	git merge -m "Merge upstream changes." master |
-		sed -e "1s/[0-9a-f]\{7\}/VARIABLE/g" \
-		-e "s/^Fast[- ]forward /FASTFORWARD /" >resolve.output
-'
-
-test_expect_success 'git resolve output' '
-	test_i18ncmp resolve.expect resolve.output
-'
-
-cat > show-branch2.expect << EOF
-! [master] Merge work in mybranch
- * [mybranch] Merge work in mybranch
---
--- [master] Merge work in mybranch
-EOF
-
-test_expect_success 'git show-branch (part 2)' '
-	git show-branch --topo-order master mybranch > show-branch2.output &&
-	test_cmp show-branch2.expect show-branch2.output
-'
-
-cat > show-branch3.expect << EOF
-! [master] Merge work in mybranch
- * [mybranch] Merge work in mybranch
---
--- [master] Merge work in mybranch
-+* [master^2] Some work.
-+* [master^] Some fun.
-EOF
-
-test_expect_success 'git show-branch (part 3)' '
-	git show-branch --topo-order --more=2 master mybranch \
-		> show-branch3.output &&
-	test_cmp show-branch3.expect show-branch3.output
-'
-
-test_expect_success 'rewind to "Some fun." and "Some work."' '
-	git checkout mybranch &&
-	git reset --hard master^2 &&
-	git checkout master &&
-	git reset --hard master^
-'
-
-cat > show-branch4.expect << EOF
-* [master] Some fun.
- ! [mybranch] Some work.
---
-*  [master] Some fun.
- + [mybranch] Some work.
-*+ [master^] Initial commit
-EOF
-
-test_expect_success 'git show-branch (part 4)' '
-	git show-branch --topo-order > show-branch4.output &&
-	test_cmp show-branch4.expect show-branch4.output
-'
-
-test_expect_success 'manual merge' '
-	mb=$(git merge-base HEAD mybranch) &&
-	git name-rev --name-only --tags $mb > name-rev.output &&
-	test "my-first-tag" = $(cat name-rev.output) &&
-
-	git read-tree -m -u $mb HEAD mybranch
-'
-
-cat > ls-files.expect << EOF
-100644 7f8b141b65fdcee47321e399a2598a235a032422 0	example
-100644 557db03de997c86a4a028e1ebd3a1ceb225be238 1	hello
-100644 ba42a2a96e3027f3333e13ede4ccf4498c3ae942 2	hello
-100644 cc44c73eb783565da5831b4d820c962954019b69 3	hello
-EOF
-
-test_expect_success 'git ls-files --stage' '
-	git ls-files --stage > ls-files.output &&
-	test_cmp ls-files.expect ls-files.output
-'
-
-cat > ls-files-unmerged.expect << EOF
-100644 557db03de997c86a4a028e1ebd3a1ceb225be238 1	hello
-100644 ba42a2a96e3027f3333e13ede4ccf4498c3ae942 2	hello
-100644 cc44c73eb783565da5831b4d820c962954019b69 3	hello
-EOF
-
-test_expect_success 'git ls-files --unmerged' '
-	git ls-files --unmerged > ls-files-unmerged.output &&
-	test_cmp ls-files-unmerged.expect ls-files-unmerged.output
-'
-
-test_expect_success 'git-merge-index' '
-	test_must_fail git merge-index git-merge-one-file hello
-'
-
-test_expect_success 'git ls-files --stage (part 2)' '
-	git ls-files --stage > ls-files.output2 &&
-	test_cmp ls-files.expect ls-files.output2
-'
-
-test_expect_success 'git repack' 'git repack'
-test_expect_success 'git prune-packed' 'git prune-packed'
-test_expect_success '-> only packed objects' '
-	git prune && # Remove conflict marked blobs
-	test $(find .git/objects/[0-9a-f][0-9a-f] -type f -print 2>/dev/null | wc -l) = 0
-'
-
-test_done
-- 
2.14.0.rc0.3.g6c2e499285

