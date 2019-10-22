Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4B7D1F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 21:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732786AbfJVVXB (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 17:23:01 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:32830 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731573AbfJVVXB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 17:23:01 -0400
Received: by mail-wr1-f50.google.com with SMTP id s1so10910961wro.0
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 14:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vy73FenDacBeMIIG1h81HWITXRQn/WlSVhuTn8XqGiU=;
        b=NcZbohUa5ecAi5+snImIzLtrcYqQCYQE0Ej1R/i9E3OlQz9QsTMWCcfSNI6uxJZHPf
         /3xfal0Nop7kpg1cQtPphgGyx+C0WVV01o/8RFEAEaGRuwOG+an+UAHozeB2APJapKhp
         tmHqk8WseASdf1RyFq3EhQNRoisQFvICFpUOmwEDuSZ9j3XmXqMCdaE1+uroUU+T7FE8
         IcRNcspi3vPGdZicLNC3HzBa3XA7wEiB+ejYTXOijBCDicLvDn+ztLoNJ2MBLfDESuSK
         zeSExon5L6W6pNHTudsCTEq8qSbGmPjC5nqgnMTH0PtBqPtZ9cDAxGzUBsuPRTTKOt2J
         ynoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vy73FenDacBeMIIG1h81HWITXRQn/WlSVhuTn8XqGiU=;
        b=Uz85jHEXH51+ttalc7b4qE0fiXtv7trgXw+gYlyC5SmCcVuHT9XAsRSj+xwcbLbawU
         fOxWt/l/FSZfl6CwaIidVbaEwuS4vvawzK3o46NoQVe9kmxuEaQPUP5QSeKsG+2oWU3T
         DCdIKpm5Hv640OsIBpuguNQbrgFGuC1o38dA+zYVG9dyLm1snZk9xDcTZ8RMC082n2Jk
         06C8yGAH/eiMVl1BK6QJ7DGtTsUxQ+eoM0/3HhRCMoB0h9uYlFMMNqz/KMMxE+XhZx4v
         ScjbEbzgUydyMp9sPpsS0bpekU8qe2pgWvY6dff8s64dE9a4TynC0VW+4g9vkyAyfDDw
         KjAA==
X-Gm-Message-State: APjAAAXzdhHuI0uRqLA/5+LtzSf74YLx51psyCBc3xIrSm5x4QP83FQD
        1denRIk1PtIyt1VPJSETHMK/1mD1
X-Google-Smtp-Source: APXvYqwnufWa0+/mQuaxIb2QTFiNAenwTshJYcJdQ70QoS4ahw1D7NhbwLEuhjhIrt1pQNtS96d+yA==
X-Received: by 2002:a5d:4d0f:: with SMTP id z15mr5037727wrt.195.1571779375232;
        Tue, 22 Oct 2019 14:22:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r19sm12694945wrr.47.2019.10.22.14.22.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 14:22:54 -0700 (PDT)
Message-Id: <0dd61a35806628a65c46f61f77fce2d4b60438bf.1571779371.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.390.v2.git.1571779371.gitgitgadget@gmail.com>
References: <pull.390.git.gitgitgadget@gmail.com>
        <pull.390.v2.git.1571779371.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Oct 2019 21:22:51 +0000
Subject: [PATCH v2 3/3] t604[236]: do not run setup in separate tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin Johannes.Schindelin@gmx.de,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     Johannes Schindelin Johannes.Schindelin@gmx.de
                        ^                           ^-missing end of address
                 \-extraneous tokens in address
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Transform the setup "tests" to setup functions, and have the actual
tests call the setup functions.  Advantages:

  * Should make life easier for people working with webby CI/PR builds
    who have to abuse mice (and their own index finger as well) in
    order to switch from viewing one testcase to another.  Sounds
    awful; hopefully this will improve things for them.

  * Improves re-runnability: any failed test in any of these three
    files can now be re-run in isolation, e.g.
       ./t6042* --ver --imm -x --run=21
    whereas before it would require two tests to be specified to the
    --run argument, the other needing to be picked out as the relevant
    setup test from one or two tests before.

  * Importantly, this still keeps the "setup" and "test" sections
    somewhat separate to make it easier for readers to discern what is
    just ancillary setup and what the intent of the test is.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6042-merge-rename-corner-cases.sh   | 111 +++---
 t/t6043-merge-rename-directories.sh    | 466 ++++++++++++++-----------
 t/t6046-merge-skip-unneeded-updates.sh | 135 ++++---
 3 files changed, 393 insertions(+), 319 deletions(-)

diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index c5b57f40c3..b047cf1c1c 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -5,7 +5,7 @@ test_description="recursive merge corner cases w/ renames but not criss-crosses"
 
 . ./test-lib.sh
 
-test_expect_success 'setup rename/delete + untracked file' '
+test_setup_rename_delete_untracked () {
 	test_create_repo rename-delete-untracked &&
 	(
 		cd rename-delete-untracked &&
@@ -29,9 +29,10 @@ test_expect_success 'setup rename/delete + untracked file' '
 		git commit -m track-people-instead-of-objects &&
 		echo "Myyy PRECIOUSSS" >ring
 	)
-'
+}
 
 test_expect_success "Does git preserve Gollum's precious artifact?" '
+	test_setup_rename_delete_untracked &&
 	(
 		cd rename-delete-untracked &&
 
@@ -49,7 +50,7 @@ test_expect_success "Does git preserve Gollum's precious artifact?" '
 #
 # We should be able to merge B & C cleanly
 
-test_expect_success 'setup rename/modify/add-source conflict' '
+test_setup_rename_modify_add_source () {
 	test_create_repo rename-modify-add-source &&
 	(
 		cd rename-modify-add-source &&
@@ -70,9 +71,10 @@ test_expect_success 'setup rename/modify/add-source conflict' '
 		git add a &&
 		git commit -m C
 	)
-'
+}
 
 test_expect_failure 'rename/modify/add-source conflict resolvable' '
+	test_setup_rename_modify_add_source &&
 	(
 		cd rename-modify-add-source &&
 
@@ -88,7 +90,7 @@ test_expect_failure 'rename/modify/add-source conflict resolvable' '
 	)
 '
 
-test_expect_success 'setup resolvable conflict missed if rename missed' '
+test_setup_break_detection_1 () {
 	test_create_repo break-detection-1 &&
 	(
 		cd break-detection-1 &&
@@ -110,9 +112,10 @@ test_expect_success 'setup resolvable conflict missed if rename missed' '
 		git add a &&
 		git commit -m C
 	)
-'
+}
 
 test_expect_failure 'conflict caused if rename not detected' '
+	test_setup_break_detection_1 &&
 	(
 		cd break-detection-1 &&
 
@@ -135,7 +138,7 @@ test_expect_failure 'conflict caused if rename not detected' '
 	)
 '
 
-test_expect_success 'setup conflict resolved wrong if rename missed' '
+test_setup_break_detection_2 () {
 	test_create_repo break-detection-2 &&
 	(
 		cd break-detection-2 &&
@@ -160,9 +163,10 @@ test_expect_success 'setup conflict resolved wrong if rename missed' '
 		git add a &&
 		git commit -m E
 	)
-'
+}
 
 test_expect_failure 'missed conflict if rename not detected' '
+	test_setup_break_detection_2 &&
 	(
 		cd break-detection-2 &&
 
@@ -182,7 +186,7 @@ test_expect_failure 'missed conflict if rename not detected' '
 #   Commit B: rename a->b
 #   Commit C: rename a->b, add unrelated a
 
-test_expect_success 'setup undetected rename/add-source causes data loss' '
+test_setup_break_detection_3 () {
 	test_create_repo break-detection-3 &&
 	(
 		cd break-detection-3 &&
@@ -202,9 +206,10 @@ test_expect_success 'setup undetected rename/add-source causes data loss' '
 		git add a &&
 		git commit -m C
 	)
-'
+}
 
 test_expect_failure 'detect rename/add-source and preserve all data' '
+	test_setup_break_detection_3 &&
 	(
 		cd break-detection-3 &&
 
@@ -231,6 +236,7 @@ test_expect_failure 'detect rename/add-source and preserve all data' '
 '
 
 test_expect_failure 'detect rename/add-source and preserve all data, merge other way' '
+	test_setup_break_detection_3 &&
 	(
 		cd break-detection-3 &&
 
@@ -256,10 +262,10 @@ test_expect_failure 'detect rename/add-source and preserve all data, merge other
 	)
 '
 
-test_expect_success 'setup content merge + rename/directory conflict' '
-	test_create_repo rename-directory-1 &&
+test_setup_rename_directory () {
+	test_create_repo rename-directory-$1 &&
 	(
-		cd rename-directory-1 &&
+		cd rename-directory-$1 &&
 
 		printf "1\n2\n3\n4\n5\n6\n" >file &&
 		git add file &&
@@ -290,11 +296,12 @@ test_expect_success 'setup content merge + rename/directory conflict' '
 		test_tick &&
 		git commit -m left
 	)
-'
+}
 
 test_expect_success 'rename/directory conflict + clean content merge' '
+	test_setup_rename_directory 1a &&
 	(
-		cd rename-directory-1 &&
+		cd rename-directory-1a &&
 
 		git checkout left-clean^0 &&
 
@@ -320,8 +327,9 @@ test_expect_success 'rename/directory conflict + clean content merge' '
 '
 
 test_expect_success 'rename/directory conflict + content merge conflict' '
+	test_setup_rename_directory 1b &&
 	(
-		cd rename-directory-1 &&
+		cd rename-directory-1b &&
 
 		git reset --hard &&
 		git clean -fdqx &&
@@ -358,7 +366,7 @@ test_expect_success 'rename/directory conflict + content merge conflict' '
 	)
 '
 
-test_expect_success 'setup content merge + rename/directory conflict w/ disappearing dir' '
+test_setup_rename_directory_2 () {
 	test_create_repo rename-directory-2 &&
 	(
 		cd rename-directory-2 &&
@@ -385,9 +393,10 @@ test_expect_success 'setup content merge + rename/directory conflict w/ disappea
 		test_tick &&
 		git commit -m left
 	)
-'
+}
 
 test_expect_success 'disappearing dir in rename/directory conflict handled' '
+	test_setup_rename_directory_2 &&
 	(
 		cd rename-directory-2 &&
 
@@ -416,10 +425,10 @@ test_expect_success 'disappearing dir in rename/directory conflict handled' '
 #   Commit A: rename a->b, modifying b too
 #   Commit B: modify a, add different b
 
-test_expect_success 'setup rename-with-content-merge vs. add' '
-	test_create_repo rename-with-content-merge-and-add &&
+test_setup_rename_with_content_merge_and_add () {
+	test_create_repo rename-with-content-merge-and-add-$1 &&
 	(
-		cd rename-with-content-merge-and-add &&
+		cd rename-with-content-merge-and-add-$1 &&
 
 		test_seq 1 5 >a &&
 		git add a &&
@@ -438,11 +447,12 @@ test_expect_success 'setup rename-with-content-merge vs. add' '
 		git add a b &&
 		git commit -m B
 	)
-'
+}
 
 test_expect_success 'handle rename-with-content-merge vs. add' '
+	test_setup_rename_with_content_merge_and_add AB &&
 	(
-		cd rename-with-content-merge-and-add &&
+		cd rename-with-content-merge-and-add-AB &&
 
 		git checkout A^0 &&
 
@@ -483,8 +493,9 @@ test_expect_success 'handle rename-with-content-merge vs. add' '
 '
 
 test_expect_success 'handle rename-with-content-merge vs. add, merge other way' '
+	test_setup_rename_with_content_merge_and_add BA &&
 	(
-		cd rename-with-content-merge-and-add &&
+		cd rename-with-content-merge-and-add-BA &&
 
 		git reset --hard &&
 		git clean -fdx &&
@@ -539,7 +550,7 @@ test_expect_success 'handle rename-with-content-merge vs. add, merge other way'
 #   * The working copy should have two files, both of form c~<unique>; does it?
 #   * Nothing else should be present.  Is anything?
 
-test_expect_success 'setup rename/rename (2to1) + modify/modify' '
+test_setup_rename_rename_2to1 () {
 	test_create_repo rename-rename-2to1 &&
 	(
 		cd rename-rename-2to1 &&
@@ -562,9 +573,10 @@ test_expect_success 'setup rename/rename (2to1) + modify/modify' '
 		git add a &&
 		git commit -m C
 	)
-'
+}
 
 test_expect_success 'handle rename/rename (2to1) conflict correctly' '
+	test_setup_rename_rename_2to1 &&
 	(
 		cd rename-rename-2to1 &&
 
@@ -610,7 +622,7 @@ test_expect_success 'handle rename/rename (2to1) conflict correctly' '
 #   Commit A: new file: a
 #   Commit B: rename a->b
 #   Commit C: rename a->c
-test_expect_success 'setup simple rename/rename (1to2) conflict' '
+test_setup_rename_rename_1to2 () {
 	test_create_repo rename-rename-1to2 &&
 	(
 		cd rename-rename-1to2 &&
@@ -631,9 +643,10 @@ test_expect_success 'setup simple rename/rename (1to2) conflict' '
 		test_tick &&
 		git commit -m C
 	)
-'
+}
 
 test_expect_success 'merge has correct working tree contents' '
+	test_setup_rename_rename_1to2 &&
 	(
 		cd rename-rename-1to2 &&
 
@@ -667,7 +680,7 @@ test_expect_success 'merge has correct working tree contents' '
 #
 # Merging of B & C should NOT be clean; there's a rename/rename conflict
 
-test_expect_success 'setup rename/rename(1to2)/add-source conflict' '
+test_setup_rename_rename_1to2_add_source_1 () {
 	test_create_repo rename-rename-1to2-add-source-1 &&
 	(
 		cd rename-rename-1to2-add-source-1 &&
@@ -687,9 +700,10 @@ test_expect_success 'setup rename/rename(1to2)/add-source conflict' '
 		git add a &&
 		git commit -m C
 	)
-'
+}
 
 test_expect_failure 'detect conflict with rename/rename(1to2)/add-source merge' '
+	test_setup_rename_rename_1to2_add_source_1 &&
 	(
 		cd rename-rename-1to2-add-source-1 &&
 
@@ -714,7 +728,7 @@ test_expect_failure 'detect conflict with rename/rename(1to2)/add-source merge'
 	)
 '
 
-test_expect_success 'setup rename/rename(1to2)/add-source resolvable conflict' '
+test_setup_rename_rename_1to2_add_source_2 () {
 	test_create_repo rename-rename-1to2-add-source-2 &&
 	(
 		cd rename-rename-1to2-add-source-2 &&
@@ -737,9 +751,10 @@ test_expect_success 'setup rename/rename(1to2)/add-source resolvable conflict' '
 		test_tick &&
 		git commit -m two
 	)
-'
+}
 
 test_expect_failure 'rename/rename/add-source still tracks new a file' '
+	test_setup_rename_rename_1to2_add_source_2 &&
 	(
 		cd rename-rename-1to2-add-source-2 &&
 
@@ -759,7 +774,7 @@ test_expect_failure 'rename/rename/add-source still tracks new a file' '
 	)
 '
 
-test_expect_success 'setup rename/rename(1to2)/add-dest conflict' '
+test_setup_rename_rename_1to2_add_dest () {
 	test_create_repo rename-rename-1to2-add-dest &&
 	(
 		cd rename-rename-1to2-add-dest &&
@@ -784,9 +799,10 @@ test_expect_success 'setup rename/rename(1to2)/add-dest conflict' '
 		test_tick &&
 		git commit -m two
 	)
-'
+}
 
 test_expect_success 'rename/rename/add-dest merge still knows about conflicting file versions' '
+	test_setup_rename_rename_1to2_add_dest &&
 	(
 		cd rename-rename-1to2-add-dest &&
 
@@ -838,7 +854,7 @@ test_expect_success 'rename/rename/add-dest merge still knows about conflicting
 #   Commit B: rename foo->bar
 #   Expected: CONFLICT (rename/add/delete), two-way merged bar
 
-test_expect_success 'rad-setup: rename/add/delete conflict' '
+test_setup_rad () {
 	test_create_repo rad &&
 	(
 		cd rad &&
@@ -860,9 +876,10 @@ test_expect_success 'rad-setup: rename/add/delete conflict' '
 		git mv foo bar &&
 		git commit -m "rename foo to bar"
 	)
-'
+}
 
 test_expect_failure 'rad-check: rename/add/delete conflict' '
+	test_setup_rad &&
 	(
 		cd rad &&
 
@@ -904,7 +921,7 @@ test_expect_failure 'rad-check: rename/add/delete conflict' '
 #   Commit B: rename bar->baz, rm foo
 #   Expected: CONFLICT (rename/rename/delete/delete), two-way merged baz
 
-test_expect_success 'rrdd-setup: rename/rename(2to1)/delete/delete conflict' '
+test_setup_rrdd () {
 	test_create_repo rrdd &&
 	(
 		cd rrdd &&
@@ -927,9 +944,10 @@ test_expect_success 'rrdd-setup: rename/rename(2to1)/delete/delete conflict' '
 		git rm foo &&
 		git commit -m "Rename bar, remove foo"
 	)
-'
+}
 
 test_expect_failure 'rrdd-check: rename/rename(2to1)/delete/delete conflict' '
+	test_setup_rrdd &&
 	(
 		cd rrdd &&
 
@@ -973,7 +991,7 @@ test_expect_failure 'rrdd-check: rename/rename(2to1)/delete/delete conflict' '
 #   Expected: six CONFLICT(rename/rename) messages, each path in two of the
 #             multi-way merged contents found in two, four, six
 
-test_expect_success 'mod6-setup: chains of rename/rename(1to2) and rename/rename(2to1)' '
+test_setup_mod6 () {
 	test_create_repo mod6 &&
 	(
 		cd mod6 &&
@@ -1009,9 +1027,10 @@ test_expect_success 'mod6-setup: chains of rename/rename(1to2) and rename/rename
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
 test_expect_failure 'mod6-check: chains of rename/rename(1to2) and rename/rename(2to1)' '
+	test_setup_mod6 &&
 	(
 		cd mod6 &&
 
@@ -1108,7 +1127,8 @@ test_conflicts_with_adds_and_renames() {
 	#      files.  Is it present?
 	#   4) There should not be any three~* files in the working
 	#      tree
-	test_expect_success "setup simple $sideL/$sideR conflict" '
+	test_setup_collision_conflict () {
+	#test_expect_success "setup simple $sideL/$sideR conflict" '
 		test_create_repo simple_${sideL}_${sideR} &&
 		(
 			cd simple_${sideL}_${sideR} &&
@@ -1185,9 +1205,11 @@ test_conflicts_with_adds_and_renames() {
 			fi &&
 			test_tick && git commit -m R
 		)
-	'
+	#'
+	}
 
 	test_expect_success "check simple $sideL/$sideR conflict" '
+		test_setup_collision_conflict &&
 		(
 			cd simple_${sideL}_${sideR} &&
 
@@ -1254,7 +1276,7 @@ test_conflicts_with_adds_and_renames add    add
 #
 #   So, we have four different conflicting files that all end up at path
 #   'three'.
-test_expect_success 'setup nested conflicts from rename/rename(2to1)' '
+test_setup_nested_conflicts_from_rename_rename () {
 	test_create_repo nested_conflicts_from_rename_rename &&
 	(
 		cd nested_conflicts_from_rename_rename &&
@@ -1305,9 +1327,10 @@ test_expect_success 'setup nested conflicts from rename/rename(2to1)' '
 		git add one three &&
 		test_tick && git commit -m german
 	)
-'
+}
 
 test_expect_success 'check nested conflicts from rename/rename(2to1)' '
+	test_setup_nested_conflicts_from_rename_rename &&
 	(
 		cd nested_conflicts_from_rename_rename &&
 
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 32cdd1f493..bd2f97ba95 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -38,7 +38,7 @@ test_description="recursive merge with directory renames"
 #   Commit B: z/{b,c,d,e/f}
 #   Expected: y/{b,c,d,e/f}
 
-test_expect_success '1a-setup: Simple directory rename detection' '
+test_setup_1a () {
 	test_create_repo 1a &&
 	(
 		cd 1a &&
@@ -67,9 +67,10 @@ test_expect_success '1a-setup: Simple directory rename detection' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '1a-check: Simple directory rename detection' '
+test_expect_success '1a: Simple directory rename detection' '
+	test_setup_1a &&
 	(
 		cd 1a &&
 
@@ -103,7 +104,7 @@ test_expect_success '1a-check: Simple directory rename detection' '
 #   Commit B: y/{b,c,d}
 #   Expected: y/{b,c,d,e}
 
-test_expect_success '1b-setup: Merge a directory with another' '
+test_setup_1b () {
 	test_create_repo 1b &&
 	(
 		cd 1b &&
@@ -134,9 +135,10 @@ test_expect_success '1b-setup: Merge a directory with another' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '1b-check: Merge a directory with another' '
+test_expect_success '1b: Merge a directory with another' '
+	test_setup_1b &&
 	(
 		cd 1b &&
 
@@ -165,7 +167,7 @@ test_expect_success '1b-check: Merge a directory with another' '
 #   Commit B: z/{b,c,d}
 #   Expected: y/{b,c,d}  (because x/d -> z/d -> y/d)
 
-test_expect_success '1c-setup: Transitive renaming' '
+test_setup_1c () {
 	test_create_repo 1c &&
 	(
 		cd 1c &&
@@ -193,9 +195,10 @@ test_expect_success '1c-setup: Transitive renaming' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '1c-check: Transitive renaming' '
+test_expect_success '1c: Transitive renaming' '
+	test_setup_1c &&
 	(
 		cd 1c &&
 
@@ -227,7 +230,7 @@ test_expect_success '1c-check: Transitive renaming' '
 #   Note: y/m & z/n should definitely move into x.  By the same token, both
 #         y/wham_1 & z/wham_2 should too...giving us a conflict.
 
-test_expect_success '1d-setup: Directory renames cause a rename/rename(2to1) conflict' '
+test_setup_1d () {
 	test_create_repo 1d &&
 	(
 		cd 1d &&
@@ -262,9 +265,10 @@ test_expect_success '1d-setup: Directory renames cause a rename/rename(2to1) con
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '1d-check: Directory renames cause a rename/rename(2to1) conflict' '
+test_expect_success '1d: Directory renames cause a rename/rename(2to1) conflict' '
+	test_setup_1d &&
 	(
 		cd 1d &&
 
@@ -313,7 +317,7 @@ test_expect_success '1d-check: Directory renames cause a rename/rename(2to1) con
 #   Commit B: z/{oldb,oldc,d}
 #   Expected: y/{newb,newc,d}
 
-test_expect_success '1e-setup: Renamed directory, with all files being renamed too' '
+test_setup_1e () {
 	test_create_repo 1e &&
 	(
 		cd 1e &&
@@ -342,9 +346,10 @@ test_expect_success '1e-setup: Renamed directory, with all files being renamed t
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '1e-check: Renamed directory, with all files being renamed too' '
+test_expect_success '1e: Renamed directory, with all files being renamed too' '
+	test_setup_1e &&
 	(
 		cd 1e &&
 
@@ -371,7 +376,7 @@ test_expect_success '1e-check: Renamed directory, with all files being renamed t
 #   Commit B: y/{b,c}, x/{d,e,f}
 #   Expected: y/{b,c}, x/{d,e,f,g}
 
-test_expect_success '1f-setup: Split a directory into two other directories' '
+test_setup_1f () {
 	test_create_repo 1f &&
 	(
 		cd 1f &&
@@ -408,9 +413,10 @@ test_expect_success '1f-setup: Split a directory into two other directories' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '1f-check: Split a directory into two other directories' '
+test_expect_success '1f: Split a directory into two other directories' '
+	test_setup_1f &&
 	(
 		cd 1f &&
 
@@ -459,7 +465,7 @@ test_expect_success '1f-check: Split a directory into two other directories' '
 #   Commit A: y/b, w/c
 #   Commit B: z/{b,c,d}
 #   Expected: y/b, w/c, z/d, with warning about z/ -> (y/ vs. w/) conflict
-test_expect_success '2a-setup: Directory split into two on one side, with equal numbers of paths' '
+test_setup_2a () {
 	test_create_repo 2a &&
 	(
 		cd 2a &&
@@ -489,9 +495,10 @@ test_expect_success '2a-setup: Directory split into two on one side, with equal
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '2a-check: Directory split into two on one side, with equal numbers of paths' '
+test_expect_success '2a: Directory split into two on one side, with equal numbers of paths' '
+	test_setup_2a &&
 	(
 		cd 2a &&
 
@@ -520,7 +527,7 @@ test_expect_success '2a-check: Directory split into two on one side, with equal
 #   Commit A: y/b, w/c
 #   Commit B: z/{b,c}, x/d
 #   Expected: y/b, w/c, x/d; No warning about z/ -> (y/ vs. w/) conflict
-test_expect_success '2b-setup: Directory split into two on one side, with equal numbers of paths' '
+test_setup_2b () {
 	test_create_repo 2b &&
 	(
 		cd 2b &&
@@ -551,9 +558,10 @@ test_expect_success '2b-setup: Directory split into two on one side, with equal
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '2b-check: Directory split into two on one side, with equal numbers of paths' '
+test_expect_success '2b: Directory split into two on one side, with equal numbers of paths' '
+	test_setup_2b &&
 	(
 		cd 2b &&
 
@@ -601,7 +609,7 @@ test_expect_success '2b-check: Directory split into two on one side, with equal
 #   Commit A: z/{b,c,d} (no change)
 #   Commit B: y/{b,c}, x/d
 #   Expected: y/{b,c}, x/d
-test_expect_success '3a-setup: Avoid implicit rename if involved as source on other side' '
+test_setup_3a () {
 	test_create_repo 3a &&
 	(
 		cd 3a &&
@@ -632,9 +640,10 @@ test_expect_success '3a-setup: Avoid implicit rename if involved as source on ot
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '3a-check: Avoid implicit rename if involved as source on other side' '
+test_expect_success '3a: Avoid implicit rename if involved as source on other side' '
+	test_setup_3a &&
 	(
 		cd 3a &&
 
@@ -664,7 +673,7 @@ test_expect_success '3a-check: Avoid implicit rename if involved as source on ot
 #         get it involved in directory rename detection.  If it were, we might
 #         end up with CONFLICT:(z/d -> y/d vs. x/d vs. w/d), i.e. a
 #         rename/rename/rename(1to3) conflict, which is just weird.
-test_expect_success '3b-setup: Avoid implicit rename if involved as source on current side' '
+test_setup_3b () {
 	test_create_repo 3b &&
 	(
 		cd 3b &&
@@ -697,9 +706,10 @@ test_expect_success '3b-setup: Avoid implicit rename if involved as source on cu
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '3b-check: Avoid implicit rename if involved as source on current side' '
+test_expect_success '3b: Avoid implicit rename if involved as source on current side' '
+	test_setup_3b &&
 	(
 		cd 3b &&
 
@@ -786,7 +796,7 @@ test_expect_success '3b-check: Avoid implicit rename if involved as source on cu
 #   Expected: y/{b,c,d}, z/{e,f}
 #   NOTE: Even though most files from z moved to y, we don't want f to follow.
 
-test_expect_success '4a-setup: Directory split, with original directory still present' '
+test_setup_4a () {
 	test_create_repo 4a &&
 	(
 		cd 4a &&
@@ -818,9 +828,10 @@ test_expect_success '4a-setup: Directory split, with original directory still pr
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '4a-check: Directory split, with original directory still present' '
+test_expect_success '4a: Directory split, with original directory still present' '
+	test_setup_4a &&
 	(
 		cd 4a &&
 
@@ -874,7 +885,7 @@ test_expect_success '4a-check: Directory split, with original directory still pr
 #         of history, giving us no way to represent this conflict in the
 #         index.
 
-test_expect_success '5a-setup: Merge directories, other side adds files to original and target' '
+test_setup_5a () {
 	test_create_repo 5a &&
 	(
 		cd 5a &&
@@ -907,9 +918,10 @@ test_expect_success '5a-setup: Merge directories, other side adds files to origi
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '5a-check: Merge directories, other side adds files to original and target' '
+test_expect_success '5a: Merge directories, other side adds files to original and target' '
+	test_setup_5a &&
 	(
 		cd 5a &&
 
@@ -948,7 +960,7 @@ test_expect_success '5a-check: Merge directories, other side adds files to origi
 #         cause us to bail on directory rename detection for that path, falling
 #         back to git behavior without the directory rename detection.
 
-test_expect_success '5b-setup: Rename/delete in order to get add/add/add conflict' '
+test_setup_5b () {
 	test_create_repo 5b &&
 	(
 		cd 5b &&
@@ -981,9 +993,10 @@ test_expect_success '5b-setup: Rename/delete in order to get add/add/add conflic
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '5b-check: Rename/delete in order to get add/add/add conflict' '
+test_expect_success '5b: Rename/delete in order to get add/add/add conflict' '
+	test_setup_5b &&
 	(
 		cd 5b &&
 
@@ -1024,7 +1037,7 @@ test_expect_success '5b-check: Rename/delete in order to get add/add/add conflic
 #             y/d are y/d_2 and y/d_4.  We still do the move from z/e to y/e,
 #             though, because it doesn't have anything in the way.
 
-test_expect_success '5c-setup: Transitive rename would cause rename/rename/rename/add/add/add' '
+test_setup_5c () {
 	test_create_repo 5c &&
 	(
 		cd 5c &&
@@ -1061,9 +1074,10 @@ test_expect_success '5c-setup: Transitive rename would cause rename/rename/renam
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '5c-check: Transitive rename would cause rename/rename/rename/add/add/add' '
+test_expect_success '5c: Transitive rename would cause rename/rename/rename/add/add/add' '
+	test_setup_5c &&
 	(
 		cd 5c &&
 
@@ -1113,7 +1127,7 @@ test_expect_success '5c-check: Transitive rename would cause rename/rename/renam
 #         detection for z/d_2, but that doesn't prevent us from applying the
 #         directory rename detection for z/f -> y/f.
 
-test_expect_success '5d-setup: Directory/file/file conflict due to directory rename' '
+test_setup_5d () {
 	test_create_repo 5d &&
 	(
 		cd 5d &&
@@ -1145,9 +1159,10 @@ test_expect_success '5d-setup: Directory/file/file conflict due to directory ren
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '5d-check: Directory/file/file conflict due to directory rename' '
+test_expect_success '5d: Directory/file/file conflict due to directory rename' '
+	test_setup_5d &&
 	(
 		cd 5d &&
 
@@ -1205,7 +1220,7 @@ test_expect_success '5d-check: Directory/file/file conflict due to directory ren
 #         them under y/ doesn't accidentally catch z/d and make it look like
 #         it is also involved in a rename/delete conflict.
 
-test_expect_success '6a-setup: Tricky rename/delete' '
+test_setup_6a () {
 	test_create_repo 6a &&
 	(
 		cd 6a &&
@@ -1235,9 +1250,10 @@ test_expect_success '6a-setup: Tricky rename/delete' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '6a-check: Tricky rename/delete' '
+test_expect_success '6a: Tricky rename/delete' '
+	test_setup_6a &&
 	(
 		cd 6a &&
 
@@ -1271,7 +1287,7 @@ test_expect_success '6a-check: Tricky rename/delete' '
 #         but B did that rename and still decided to put the file into z/,
 #         so we probably shouldn't apply directory rename detection for it.
 
-test_expect_success '6b-setup: Same rename done on both sides' '
+test_setup_6b () {
 	test_create_repo 6b &&
 	(
 		cd 6b &&
@@ -1300,9 +1316,10 @@ test_expect_success '6b-setup: Same rename done on both sides' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '6b-check: Same rename done on both sides' '
+test_expect_success '6b: Same rename done on both sides' '
+	test_setup_6b &&
 	(
 		cd 6b &&
 
@@ -1334,7 +1351,7 @@ test_expect_success '6b-check: Same rename done on both sides' '
 #   NOTE: Seems obvious, but just checking that the implementation doesn't
 #         "accidentally detect a rename" and give us y/{b,c,d}.
 
-test_expect_success '6c-setup: Rename only done on same side' '
+test_setup_6c () {
 	test_create_repo 6c &&
 	(
 		cd 6c &&
@@ -1362,9 +1379,10 @@ test_expect_success '6c-setup: Rename only done on same side' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '6c-check: Rename only done on same side' '
+test_expect_success '6c: Rename only done on same side' '
+	test_setup_6c &&
 	(
 		cd 6c &&
 
@@ -1396,7 +1414,7 @@ test_expect_success '6c-check: Rename only done on same side' '
 #   NOTE: Again, this seems obvious but just checking that the implementation
 #         doesn't "accidentally detect a rename" and give us y/{b,c,d}.
 
-test_expect_success '6d-setup: We do not always want transitive renaming' '
+test_setup_6d () {
 	test_create_repo 6d &&
 	(
 		cd 6d &&
@@ -1424,9 +1442,10 @@ test_expect_success '6d-setup: We do not always want transitive renaming' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '6d-check: We do not always want transitive renaming' '
+test_expect_success '6d: We do not always want transitive renaming' '
+	test_setup_6d &&
 	(
 		cd 6d &&
 
@@ -1458,7 +1477,7 @@ test_expect_success '6d-check: We do not always want transitive renaming' '
 #         doesn't "accidentally detect a rename" and give us y/{b,c} +
 #         add/add conflict on y/d_1 vs y/d_2.
 
-test_expect_success '6e-setup: Add/add from one side' '
+test_setup_6e () {
 	test_create_repo 6e &&
 	(
 		cd 6e &&
@@ -1487,9 +1506,10 @@ test_expect_success '6e-setup: Add/add from one side' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '6e-check: Add/add from one side' '
+test_expect_success '6e: Add/add from one side' '
+	test_setup_6e &&
 	(
 		cd 6e &&
 
@@ -1552,7 +1572,7 @@ test_expect_success '6e-check: Add/add from one side' '
 #   Expected: y/d, CONFLICT(rename/rename for both z/b and z/c)
 #   NOTE: There's a rename of z/ here, y/ has more renames, so z/d -> y/d.
 
-test_expect_success '7a-setup: rename-dir vs. rename-dir (NOT split evenly) PLUS add-other-file' '
+test_setup_7a () {
 	test_create_repo 7a &&
 	(
 		cd 7a &&
@@ -1583,9 +1603,10 @@ test_expect_success '7a-setup: rename-dir vs. rename-dir (NOT split evenly) PLUS
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '7a-check: rename-dir vs. rename-dir (NOT split evenly) PLUS add-other-file' '
+test_expect_success '7a: rename-dir vs. rename-dir (NOT split evenly) PLUS add-other-file' '
+	test_setup_7a &&
 	(
 		cd 7a &&
 
@@ -1623,7 +1644,7 @@ test_expect_success '7a-check: rename-dir vs. rename-dir (NOT split evenly) PLUS
 #   Commit B: z/{b,c,d_1},        w/d_2
 #   Expected: y/{b,c}, CONFLICT(rename/rename(2to1): x/d_1, w/d_2 -> y_d)
 
-test_expect_success '7b-setup: rename/rename(2to1), but only due to transitive rename' '
+test_setup_7b () {
 	test_create_repo 7b &&
 	(
 		cd 7b &&
@@ -1655,9 +1676,10 @@ test_expect_success '7b-setup: rename/rename(2to1), but only due to transitive r
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '7b-check: rename/rename(2to1), but only due to transitive rename' '
+test_expect_success '7b: rename/rename(2to1), but only due to transitive rename' '
+	test_setup_7b &&
 	(
 		cd 7b &&
 
@@ -1702,7 +1724,7 @@ test_expect_success '7b-check: rename/rename(2to1), but only due to transitive r
 #         neither CONFLICT(x/d -> w/d vs. z/d)
 #         nor CONFLiCT x/d -> w/d vs. y/d vs. z/d)
 
-test_expect_success '7c-setup: rename/rename(1to...2or3); transitive rename may add complexity' '
+test_setup_7c () {
 	test_create_repo 7c &&
 	(
 		cd 7c &&
@@ -1732,9 +1754,10 @@ test_expect_success '7c-setup: rename/rename(1to...2or3); transitive rename may
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '7c-check: rename/rename(1to...2or3); transitive rename may add complexity' '
+test_expect_success '7c: rename/rename(1to...2or3); transitive rename may add complexity' '
+	test_setup_7c &&
 	(
 		cd 7c &&
 
@@ -1766,7 +1789,7 @@ test_expect_success '7c-check: rename/rename(1to...2or3); transitive rename may
 #   Expected: y/{b,c}, CONFLICT(delete x/d vs rename to y/d)
 #   NOTE: z->y so NOT CONFLICT(delete x/d vs rename to z/d)
 
-test_expect_success '7d-setup: transitive rename involved in rename/delete; how is it reported?' '
+test_setup_7d () {
 	test_create_repo 7d &&
 	(
 		cd 7d &&
@@ -1796,9 +1819,10 @@ test_expect_success '7d-setup: transitive rename involved in rename/delete; how
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '7d-check: transitive rename involved in rename/delete; how is it reported?' '
+test_expect_success '7d: transitive rename involved in rename/delete; how is it reported?' '
+	test_setup_7d &&
 	(
 		cd 7d &&
 
@@ -1851,7 +1875,7 @@ test_expect_success '7d-check: transitive rename involved in rename/delete; how
 #         see testcases 9c and 9d for further discussion of this issue and
 #         how it's resolved.
 
-test_expect_success '7e-setup: transitive rename in rename/delete AND dirs in the way' '
+test_setup_7e () {
 	test_create_repo 7e &&
 	(
 		cd 7e &&
@@ -1886,9 +1910,10 @@ test_expect_success '7e-setup: transitive rename in rename/delete AND dirs in th
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '7e-check: transitive rename in rename/delete AND dirs in the way' '
+test_expect_success '7e: transitive rename in rename/delete AND dirs in the way' '
+	test_setup_7e &&
 	(
 		cd 7e &&
 
@@ -1945,7 +1970,7 @@ test_expect_success '7e-check: transitive rename in rename/delete AND dirs in th
 # simple rule from section 5 prevents me from handling this as optimally as
 # we potentially could.
 
-test_expect_success '8a-setup: Dual-directory rename, one into the others way' '
+test_setup_8a () {
 	test_create_repo 8a &&
 	(
 		cd 8a &&
@@ -1977,9 +2002,10 @@ test_expect_success '8a-setup: Dual-directory rename, one into the others way' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '8a-check: Dual-directory rename, one into the others way' '
+test_expect_success '8a: Dual-directory rename, one into the others way' '
+	test_setup_8a &&
 	(
 		cd 8a &&
 
@@ -2023,7 +2049,7 @@ test_expect_success '8a-check: Dual-directory rename, one into the others way' '
 # making us fall back to pre-directory-rename-detection behavior for both
 # e_1 and e_2.
 
-test_expect_success '8b-setup: Dual-directory rename, one into the others way, with conflicting filenames' '
+test_setup_8b () {
 	test_create_repo 8b &&
 	(
 		cd 8b &&
@@ -2055,9 +2081,10 @@ test_expect_success '8b-setup: Dual-directory rename, one into the others way, w
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '8b-check: Dual-directory rename, one into the others way, with conflicting filenames' '
+test_expect_success '8b: Dual-directory rename, one into the others way, with conflicting filenames' '
+	test_setup_8b &&
 	(
 		cd 8b &&
 
@@ -2096,7 +2123,7 @@ test_expect_success '8b-check: Dual-directory rename, one into the others way, w
 #         rename/rename(1to2) conflicts -- see testcase 9h.  See also
 #         notes in 8d.
 
-test_expect_success '8c-setup: modify/delete or rename+modify/delete?' '
+test_setup_8c () {
 	test_create_repo 8c &&
 	(
 		cd 8c &&
@@ -2127,9 +2154,10 @@ test_expect_success '8c-setup: modify/delete or rename+modify/delete?' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '8c-check: modify/delete or rename+modify/delete' '
+test_expect_success '8c: modify/delete or rename+modify/delete' '
+	test_setup_8c &&
 	(
 		cd 8c &&
 
@@ -2175,7 +2203,7 @@ test_expect_success '8c-check: modify/delete or rename+modify/delete' '
 #   during merging are supposed to be about opposite sides doing things
 #   differently.
 
-test_expect_success '8d-setup: rename/delete...or not?' '
+test_setup_8d () {
 	test_create_repo 8d &&
 	(
 		cd 8d &&
@@ -2204,9 +2232,10 @@ test_expect_success '8d-setup: rename/delete...or not?' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '8d-check: rename/delete...or not?' '
+test_expect_success '8d: rename/delete...or not?' '
+	test_setup_8d &&
 	(
 		cd 8d &&
 
@@ -2250,7 +2279,7 @@ test_expect_success '8d-check: rename/delete...or not?' '
 #        about the ramifications of doing that, I didn't know how to rule out
 #        that opening other weird edge and corner cases so I just punted.
 
-test_expect_success '8e-setup: Both sides rename, one side adds to original directory' '
+test_setup_8e () {
 	test_create_repo 8e &&
 	(
 		cd 8e &&
@@ -2279,9 +2308,10 @@ test_expect_success '8e-setup: Both sides rename, one side adds to original dire
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '8e-check: Both sides rename, one side adds to original directory' '
+test_expect_success '8e: Both sides rename, one side adds to original directory' '
+	test_setup_8e &&
 	(
 		cd 8e &&
 
@@ -2333,7 +2363,7 @@ test_expect_success '8e-check: Both sides rename, one side adds to original dire
 #         of which one had the most paths going to it.  A naive implementation
 #         of that could take the new file in commit B at z/i to x/w/i or x/i.
 
-test_expect_success '9a-setup: Inner renamed directory within outer renamed directory' '
+test_setup_9a () {
 	test_create_repo 9a &&
 	(
 		cd 9a &&
@@ -2366,9 +2396,10 @@ test_expect_success '9a-setup: Inner renamed directory within outer renamed dire
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '9a-check: Inner renamed directory within outer renamed directory' '
+test_expect_success '9a: Inner renamed directory within outer renamed directory' '
+	test_setup_9a &&
 	(
 		cd 9a &&
 
@@ -2404,7 +2435,7 @@ test_expect_success '9a-check: Inner renamed directory within outer renamed dire
 #   Commit B: z/{b,c,d_3}
 #   Expected: y/{b,c,d_merged}
 
-test_expect_success '9b-setup: Transitive rename with content merge' '
+test_setup_9b () {
 	test_create_repo 9b &&
 	(
 		cd 9b &&
@@ -2436,9 +2467,10 @@ test_expect_success '9b-setup: Transitive rename with content merge' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '9b-check: Transitive rename with content merge' '
+test_expect_success '9b: Transitive rename with content merge' '
+	test_setup_9b &&
 	(
 		cd 9b &&
 
@@ -2491,7 +2523,7 @@ test_expect_success '9b-check: Transitive rename with content merge' '
 #         away, then ignore that particular rename from the other side of
 #         history for any implicit directory renames.
 
-test_expect_success '9c-setup: Doubly transitive rename?' '
+test_setup_9c () {
 	test_create_repo 9c &&
 	(
 		cd 9c &&
@@ -2526,9 +2558,10 @@ test_expect_success '9c-setup: Doubly transitive rename?' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '9c-check: Doubly transitive rename?' '
+test_expect_success '9c: Doubly transitive rename?' '
+	test_setup_9c &&
 	(
 		cd 9c &&
 
@@ -2579,7 +2612,7 @@ test_expect_success '9c-check: Doubly transitive rename?' '
 #   simple rules that are consistent with what we need for all the other
 #   testcases and simplifies things for the user.
 
-test_expect_success '9d-setup: N-way transitive rename?' '
+test_setup_9d () {
 	test_create_repo 9d &&
 	(
 		cd 9d &&
@@ -2614,9 +2647,10 @@ test_expect_success '9d-setup: N-way transitive rename?' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '9d-check: N-way transitive rename?' '
+test_expect_success '9d: N-way transitive rename?' '
+	test_setup_9d &&
 	(
 		cd 9d &&
 
@@ -2653,7 +2687,7 @@ test_expect_success '9d-check: N-way transitive rename?' '
 #   Expected: combined/{a,b,c,d,e,f,g,h,i,j,k,l}, CONFLICT(Nto1) warnings,
 #             dir1/yo, dir2/yo, dir3/yo, dirN/yo
 
-test_expect_success '9e-setup: N-to-1 whammo' '
+test_setup_9e () {
 	test_create_repo 9e &&
 	(
 		cd 9e &&
@@ -2696,9 +2730,10 @@ test_expect_success '9e-setup: N-to-1 whammo' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success C_LOCALE_OUTPUT '9e-check: N-to-1 whammo' '
+test_expect_success C_LOCALE_OUTPUT '9e: N-to-1 whammo' '
+	test_setup_9e &&
 	(
 		cd 9e &&
 
@@ -2745,7 +2780,7 @@ test_expect_success C_LOCALE_OUTPUT '9e-check: N-to-1 whammo' '
 #   Commit B: goal/{a,b}/$more_files, goal/c
 #   Expected: priority/{a,b}/$more_files, priority/c
 
-test_expect_success '9f-setup: Renamed directory that only contained immediate subdirs' '
+test_setup_9f () {
 	test_create_repo 9f &&
 	(
 		cd 9f &&
@@ -2774,9 +2809,10 @@ test_expect_success '9f-setup: Renamed directory that only contained immediate s
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '9f-check: Renamed directory that only contained immediate subdirs' '
+test_expect_success '9f: Renamed directory that only contained immediate subdirs' '
+	test_setup_9f &&
 	(
 		cd 9f &&
 
@@ -2809,7 +2845,7 @@ test_expect_success '9f-check: Renamed directory that only contained immediate s
 #   Commit B: goal/{a,b}/$more_files, goal/c
 #   Expected: priority/{alpha,bravo}/$more_files, priority/c
 
-test_expect_success '9g-setup: Renamed directory that only contained immediate subdirs, immediate subdirs renamed' '
+test_setup_9g () {
 	test_create_repo 9g &&
 	(
 		cd 9g &&
@@ -2841,9 +2877,9 @@ test_expect_success '9g-setup: Renamed directory that only contained immediate s
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_failure '9g-check: Renamed directory that only contained immediate subdirs, immediate subdirs renamed' '
+test_expect_failure '9g: Renamed directory that only contained immediate subdirs, immediate subdirs renamed' '
 	(
 		cd 9g &&
 
@@ -2877,7 +2913,7 @@ test_expect_failure '9g-check: Renamed directory that only contained immediate s
 #   Expected: y/{b,c}, x/d_2
 #   NOTE: If we applied the z/ -> y/ rename to z/d, then we'd end up with
 #         a rename/rename(1to2) conflict (z/d -> y/d vs. x/d)
-test_expect_success '9h-setup: Avoid dir rename on merely modified path' '
+test_setup_9h () {
 	test_create_repo 9h &&
 	(
 		cd 9h &&
@@ -2910,9 +2946,10 @@ test_expect_success '9h-setup: Avoid dir rename on merely modified path' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '9h-check: Avoid dir rename on merely modified path' '
+test_expect_success '9h: Avoid dir rename on merely modified path' '
+	test_setup_9h &&
 	(
 		cd 9h &&
 
@@ -2957,7 +2994,7 @@ test_expect_success '9h-check: Avoid dir rename on merely modified path' '
 #   Expected: Aborted Merge +
 #       ERROR_MSG(untracked working tree files would be overwritten by merge)
 
-test_expect_success '10a-setup: Overwrite untracked with normal rename/delete' '
+test_setup_10a () {
 	test_create_repo 10a &&
 	(
 		cd 10a &&
@@ -2983,9 +3020,10 @@ test_expect_success '10a-setup: Overwrite untracked with normal rename/delete' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '10a-check: Overwrite untracked with normal rename/delete' '
+test_expect_success '10a: Overwrite untracked with normal rename/delete' '
+	test_setup_10a &&
 	(
 		cd 10a &&
 
@@ -3021,7 +3059,7 @@ test_expect_success '10a-check: Overwrite untracked with normal rename/delete' '
 #             z/c_1 -> z/d_1 rename recorded at stage 3 for y/d +
 #       ERROR_MSG(refusing to lose untracked file at 'y/d')
 
-test_expect_success '10b-setup: Overwrite untracked with dir rename + delete' '
+test_setup_10b () {
 	test_create_repo 10b &&
 	(
 		cd 10b &&
@@ -3050,9 +3088,10 @@ test_expect_success '10b-setup: Overwrite untracked with dir rename + delete' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '10b-check: Overwrite untracked with dir rename + delete' '
+test_expect_success '10b: Overwrite untracked with dir rename + delete' '
+	test_setup_10b &&
 	(
 		cd 10b &&
 
@@ -3098,10 +3137,10 @@ test_expect_success '10b-check: Overwrite untracked with dir rename + delete' '
 #             y/c~B^0 +
 #             ERROR_MSG(Refusing to lose untracked file at y/c)
 
-test_expect_success '10c-setup: Overwrite untracked with dir rename/rename(1to2)' '
-	test_create_repo 10c &&
+test_setup_10c () {
+	test_create_repo 10c_$1 &&
 	(
-		cd 10c &&
+		cd 10c_$1 &&
 
 		mkdir z x &&
 		echo a >z/a &&
@@ -3128,11 +3167,12 @@ test_expect_success '10c-setup: Overwrite untracked with dir rename/rename(1to2)
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '10c-check: Overwrite untracked with dir rename/rename(1to2)' '
+test_expect_success '10c1: Overwrite untracked with dir rename/rename(1to2)' '
+	test_setup_10c 1 &&
 	(
-		cd 10c &&
+		cd 10c_1 &&
 
 		git checkout A^0 &&
 		echo important >y/c &&
@@ -3163,9 +3203,10 @@ test_expect_success '10c-check: Overwrite untracked with dir rename/rename(1to2)
 	)
 '
 
-test_expect_success '10c-check: Overwrite untracked with dir rename/rename(1to2), other direction' '
+test_expect_success '10c2: Overwrite untracked with dir rename/rename(1to2), other direction' '
+	test_setup_10c 2 &&
 	(
-		cd 10c &&
+		cd 10c_2 &&
 
 		git reset --hard &&
 		git clean -fdqx &&
@@ -3208,7 +3249,7 @@ test_expect_success '10c-check: Overwrite untracked with dir rename/rename(1to2)
 #             CONFLICT(rename/rename) z/c_1 vs x/f_2 -> y/wham
 #             ERROR_MSG(Refusing to lose untracked file at y/wham)
 
-test_expect_success '10d-setup: Delete untracked with dir rename/rename(2to1)' '
+test_setup_10d () {
 	test_create_repo 10d &&
 	(
 		cd 10d &&
@@ -3240,9 +3281,10 @@ test_expect_success '10d-setup: Delete untracked with dir rename/rename(2to1)' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '10d-check: Delete untracked with dir rename/rename(2to1)' '
+test_expect_success '10d: Delete untracked with dir rename/rename(2to1)' '
+	test_setup_10d &&
 	(
 		cd 10d &&
 
@@ -3290,7 +3332,7 @@ test_expect_success '10d-check: Delete untracked with dir rename/rename(2to1)' '
 #   Commit B: z/{a,b,c}
 #   Expected: y/{a,b,c} + untracked z/c
 
-test_expect_success '10e-setup: Does git complain about untracked file that is not really in the way?' '
+test_setup_10e () {
 	test_create_repo 10e &&
 	(
 		cd 10e &&
@@ -3317,9 +3359,9 @@ test_expect_success '10e-setup: Does git complain about untracked file that is n
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_failure '10e-check: Does git complain about untracked file that is not really in the way?' '
+test_expect_failure '10e: Does git complain about untracked file that is not really in the way?' '
 	(
 		cd 10e &&
 
@@ -3371,7 +3413,7 @@ test_expect_failure '10e-check: Does git complain about untracked file that is n
 #             z/c~HEAD with contents of B:z/b_v2,
 #             z/c with uncommitted mods on top of A:z/c_v1
 
-test_expect_success '11a-setup: Avoid losing dirty contents with simple rename' '
+test_setup_11a () {
 	test_create_repo 11a &&
 	(
 		cd 11a &&
@@ -3398,9 +3440,10 @@ test_expect_success '11a-setup: Avoid losing dirty contents with simple rename'
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '11a-check: Avoid losing dirty contents with simple rename' '
+test_expect_success '11a: Avoid losing dirty contents with simple rename' '
+	test_setup_11a &&
 	(
 		cd 11a &&
 
@@ -3441,7 +3484,7 @@ test_expect_success '11a-check: Avoid losing dirty contents with simple rename'
 #             ERROR_MSG(Refusing to lose dirty file at z/c)
 
 
-test_expect_success '11b-setup: Avoid losing dirty file involved in directory rename' '
+test_setup_11b () {
 	test_create_repo 11b &&
 	(
 		cd 11b &&
@@ -3470,9 +3513,10 @@ test_expect_success '11b-setup: Avoid losing dirty file involved in directory re
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '11b-check: Avoid losing dirty file involved in directory rename' '
+test_expect_success '11b: Avoid losing dirty file involved in directory rename' '
+	test_setup_11b &&
 	(
 		cd 11b &&
 
@@ -3515,7 +3559,7 @@ test_expect_success '11b-check: Avoid losing dirty file involved in directory re
 #   Expected: Abort_msg("following files would be overwritten by merge") +
 #             y/c left untouched (still has uncommitted mods)
 
-test_expect_success '11c-setup: Avoid losing not-uptodate with rename + D/F conflict' '
+test_setup_11c () {
 	test_create_repo 11c &&
 	(
 		cd 11c &&
@@ -3545,9 +3589,10 @@ test_expect_success '11c-setup: Avoid losing not-uptodate with rename + D/F conf
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '11c-check: Avoid losing not-uptodate with rename + D/F conflict' '
+test_expect_success '11c: Avoid losing not-uptodate with rename + D/F conflict' '
+	test_setup_11c &&
 	(
 		cd 11c &&
 
@@ -3581,7 +3626,7 @@ test_expect_success '11c-check: Avoid losing not-uptodate with rename + D/F conf
 #             Warning_Msg("Refusing to lose dirty file at z/c) +
 #             y/{a,c~HEAD,c/d}, x/b, now-untracked z/c_v1 with uncommitted mods
 
-test_expect_success '11d-setup: Avoid losing not-uptodate with rename + D/F conflict' '
+test_setup_11d () {
 	test_create_repo 11d &&
 	(
 		cd 11d &&
@@ -3612,9 +3657,10 @@ test_expect_success '11d-setup: Avoid losing not-uptodate with rename + D/F conf
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '11d-check: Avoid losing not-uptodate with rename + D/F conflict' '
+test_expect_success '11d: Avoid losing not-uptodate with rename + D/F conflict' '
+	test_setup_11d &&
 	(
 		cd 11d &&
 
@@ -3659,7 +3705,7 @@ test_expect_success '11d-check: Avoid losing not-uptodate with rename + D/F conf
 #             y/c~HEAD has A:y/c_2 contents
 #             y/c has dirty file from before merge
 
-test_expect_success '11e-setup: Avoid deleting not-uptodate with dir rename/rename(1to2)/add' '
+test_setup_11e () {
 	test_create_repo 11e &&
 	(
 		cd 11e &&
@@ -3691,9 +3737,10 @@ test_expect_success '11e-setup: Avoid deleting not-uptodate with dir rename/rena
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '11e-check: Avoid deleting not-uptodate with dir rename/rename(1to2)/add' '
+test_expect_success '11e: Avoid deleting not-uptodate with dir rename/rename(1to2)/add' '
+	test_setup_11e &&
 	(
 		cd 11e &&
 
@@ -3744,7 +3791,7 @@ test_expect_success '11e-check: Avoid deleting not-uptodate with dir rename/rena
 #             CONFLICT(rename/rename) x/c vs x/d -> y/wham
 #             ERROR_MSG(Refusing to lose dirty file at y/wham)
 
-test_expect_success '11f-setup: Avoid deleting not-uptodate with dir rename/rename(2to1)' '
+test_setup_11f () {
 	test_create_repo 11f &&
 	(
 		cd 11f &&
@@ -3773,9 +3820,10 @@ test_expect_success '11f-setup: Avoid deleting not-uptodate with dir rename/rena
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '11f-check: Avoid deleting not-uptodate with dir rename/rename(2to1)' '
+test_expect_success '11f: Avoid deleting not-uptodate with dir rename/rename(2to1)' '
+	test_setup_11f &&
 	(
 		cd 11f &&
 
@@ -3832,7 +3880,7 @@ test_expect_success '11f-check: Avoid deleting not-uptodate with dir rename/rena
 #   Commit B: node1/{leaf1,leaf2,leaf5}, node2/{leaf3,leaf4,leaf6}
 #   Expected: node1/{leaf1,leaf2,leaf5,node2/{leaf3,leaf4,leaf6}}
 
-test_expect_success '12a-setup: Moving one directory hierarchy into another' '
+test_setup_12a () {
 	test_create_repo 12a &&
 	(
 		cd 12a &&
@@ -3862,9 +3910,10 @@ test_expect_success '12a-setup: Moving one directory hierarchy into another' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '12a-check: Moving one directory hierarchy into another' '
+test_expect_success '12a: Moving one directory hierarchy into another' '
+	test_setup_12a &&
 	(
 		cd 12a &&
 
@@ -3910,7 +3959,7 @@ test_expect_success '12a-check: Moving one directory hierarchy into another' '
 #         To which, I can do no more than shrug my shoulders and say that
 #         even simple rules give weird results when given weird inputs.
 
-test_expect_success '12b-setup: Moving two directory hierarchies into each other' '
+test_setup_12b () {
 	test_create_repo 12b &&
 	(
 		cd 12b &&
@@ -3938,9 +3987,10 @@ test_expect_success '12b-setup: Moving two directory hierarchies into each other
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '12b-check: Moving two directory hierarchies into each other' '
+test_expect_success '12b: Moving two directory hierarchies into each other' '
+	test_setup_12b &&
 	(
 		cd 12b &&
 
@@ -3976,7 +4026,7 @@ test_expect_success '12b-check: Moving two directory hierarchies into each other
 #   NOTE: This is *exactly* like 12c, except that every path is modified on
 #         each side of the merge.
 
-test_expect_success '12c-setup: Moving one directory hierarchy into another w/ content merge' '
+test_setup_12c () {
 	test_create_repo 12c &&
 	(
 		cd 12c &&
@@ -4008,9 +4058,10 @@ test_expect_success '12c-setup: Moving one directory hierarchy into another w/ c
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '12c-check: Moving one directory hierarchy into another w/ content merge' '
+test_expect_success '12c: Moving one directory hierarchy into another w/ content merge' '
+	test_setup_12c &&
 	(
 		cd 12c &&
 
@@ -4057,7 +4108,7 @@ test_expect_success '12c-check: Moving one directory hierarchy into another w/ c
 #   Commit B: a/b/subdir/foo, a/b/bar
 #   Expected: subdir/foo, bar
 
-test_expect_success '12d-setup: Rename/merge subdir into the root, variant 1' '
+test_setup_12d () {
 	test_create_repo 12d &&
 	(
 		cd 12d &&
@@ -4078,9 +4129,10 @@ test_expect_success '12d-setup: Rename/merge subdir into the root, variant 1' '
 		git checkout B &&
 		test_commit a/b/bar
 	)
-'
+}
 
-test_expect_success '12d-check: Rename/merge subdir into the root, variant 1' '
+test_expect_success '12d: Rename/merge subdir into the root, variant 1' '
+	test_setup_12d &&
 	(
 		cd 12d &&
 
@@ -4114,7 +4166,7 @@ test_expect_success '12d-check: Rename/merge subdir into the root, variant 1' '
 #   Commit B: a/b/foo, a/b/bar
 #   Expected: foo, bar
 
-test_expect_success '12e-setup: Rename/merge subdir into the root, variant 2' '
+test_setup_12e () {
 	test_create_repo 12e &&
 	(
 		cd 12e &&
@@ -4135,9 +4187,10 @@ test_expect_success '12e-setup: Rename/merge subdir into the root, variant 2' '
 		git checkout B &&
 		test_commit a/b/bar
 	)
-'
+}
 
-test_expect_success '12e-check: Rename/merge subdir into the root, variant 2' '
+test_expect_success '12e: Rename/merge subdir into the root, variant 2' '
+	test_setup_12e &&
 	(
 		cd 12e &&
 
@@ -4182,10 +4235,10 @@ test_expect_success '12e-check: Rename/merge subdir into the root, variant 2' '
 #   Commit B: z/{b,c,d,e/f}
 #   Expected: y/{b,c,d,e/f}, with notices/conflicts for both y/d and y/e/f
 
-test_expect_success '13a-setup: messages for newly added files' '
-	test_create_repo 13a &&
+test_setup_13a () {
+	test_create_repo 13a_$1 &&
 	(
-		cd 13a &&
+		cd 13a_$1 &&
 
 		mkdir z &&
 		echo b >z/b &&
@@ -4211,11 +4264,12 @@ test_expect_success '13a-setup: messages for newly added files' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '13a-check(conflict): messages for newly added files' '
+test_expect_success '13a(conflict): messages for newly added files' '
+	test_setup_13a conflict &&
 	(
-		cd 13a &&
+		cd 13a_conflict &&
 
 		git checkout A^0 &&
 
@@ -4235,9 +4289,10 @@ test_expect_success '13a-check(conflict): messages for newly added files' '
 	)
 '
 
-test_expect_success '13a-check(info): messages for newly added files' '
+test_expect_success '13a(info): messages for newly added files' '
+	test_setup_13a info &&
 	(
-		cd 13a &&
+		cd 13a_info &&
 
 		git reset --hard &&
 		git checkout A^0 &&
@@ -4267,10 +4322,10 @@ test_expect_success '13a-check(info): messages for newly added files' '
 #   Expected: y/{b,c,d_merged}, with two conflict messages for y/d,
 #             one about content, and one about file location
 
-test_expect_success '13b-setup: messages for transitive rename with conflicted content' '
-	test_create_repo 13b &&
+test_setup_13b () {
+	test_create_repo 13b_$1 &&
 	(
-		cd 13b &&
+		cd 13b_$1 &&
 
 		mkdir x &&
 		mkdir z &&
@@ -4299,11 +4354,12 @@ test_expect_success '13b-setup: messages for transitive rename with conflicted c
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '13b-check(conflict): messages for transitive rename with conflicted content' '
+test_expect_success '13b(conflict): messages for transitive rename with conflicted content' '
+	test_setup_13b conflict &&
 	(
-		cd 13b &&
+		cd 13b_conflict &&
 
 		git checkout A^0 &&
 
@@ -4321,9 +4377,10 @@ test_expect_success '13b-check(conflict): messages for transitive rename with co
 	)
 '
 
-test_expect_success '13b-check(info): messages for transitive rename with conflicted content' '
+test_expect_success '13b(info): messages for transitive rename with conflicted content' '
+	test_setup_13b info &&
 	(
-		cd 13b &&
+		cd 13b_info &&
 
 		git reset --hard &&
 		git checkout A^0 &&
@@ -4352,10 +4409,10 @@ test_expect_success '13b-check(info): messages for transitive rename with confli
 #             d and B had full knowledge, but that's a slippery slope as
 #             shown in testcase 13d.
 
-test_expect_success '13c-setup: messages for rename/rename(1to1) via transitive rename' '
-	test_create_repo 13c &&
+test_setup_13c () {
+	test_create_repo 13c_$1 &&
 	(
-		cd 13c &&
+		cd 13c_$1 &&
 
 		mkdir x &&
 		mkdir z &&
@@ -4383,11 +4440,12 @@ test_expect_success '13c-setup: messages for rename/rename(1to1) via transitive
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '13c-check(conflict): messages for rename/rename(1to1) via transitive rename' '
+test_expect_success '13c(conflict): messages for rename/rename(1to1) via transitive rename' '
+	test_setup_13c conflict &&
 	(
-		cd 13c &&
+		cd 13c_conflict &&
 
 		git checkout A^0 &&
 
@@ -4404,9 +4462,10 @@ test_expect_success '13c-check(conflict): messages for rename/rename(1to1) via t
 	)
 '
 
-test_expect_success '13c-check(info): messages for rename/rename(1to1) via transitive rename' '
+test_expect_success '13c(info): messages for rename/rename(1to1) via transitive rename' '
+	test_setup_13c info &&
 	(
-		cd 13c &&
+		cd 13c_info &&
 
 		git reset --hard &&
 		git checkout A^0 &&
@@ -4438,10 +4497,10 @@ test_expect_success '13c-check(info): messages for rename/rename(1to1) via trans
 #               * B renames a/y to c/y, and A renames c/->d/ => a/y -> d/y
 #               No conflict in where a/y ends up, so put it in d/y.
 
-test_expect_success '13d-setup: messages for rename/rename(1to1) via dual transitive rename' '
-	test_create_repo 13d &&
+test_setup_13d () {
+	test_create_repo 13d_$1 &&
 	(
-		cd 13d &&
+		cd 13d_$1 &&
 
 		mkdir a &&
 		mkdir b &&
@@ -4470,11 +4529,12 @@ test_expect_success '13d-setup: messages for rename/rename(1to1) via dual transi
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '13d-check(conflict): messages for rename/rename(1to1) via dual transitive rename' '
+test_expect_success '13d(conflict): messages for rename/rename(1to1) via dual transitive rename' '
+	test_setup_13d conflict &&
 	(
-		cd 13d &&
+		cd 13d_conflict &&
 
 		git checkout A^0 &&
 
@@ -4494,9 +4554,10 @@ test_expect_success '13d-check(conflict): messages for rename/rename(1to1) via d
 	)
 '
 
-test_expect_success '13d-check(info): messages for rename/rename(1to1) via dual transitive rename' '
+test_expect_success '13d(info): messages for rename/rename(1to1) via dual transitive rename' '
+	test_setup_13d info &&
 	(
-		cd 13d &&
+		cd 13d_info &&
 
 		git reset --hard &&
 		git checkout A^0 &&
@@ -4562,7 +4623,7 @@ test_expect_success '13d-check(info): messages for rename/rename(1to1) via dual
 #          in the outer merge for this special kind of setup, but it at
 #          least avoids hitting a BUG().
 #
-test_expect_success '13e-setup: directory rename detection in recursive case' '
+test_setup_13e () {
 	test_create_repo 13e &&
 	(
 		cd 13e &&
@@ -4607,9 +4668,10 @@ test_expect_success '13e-setup: directory rename detection in recursive case' '
 		test_tick &&
 		git commit -m "D"
 	)
-'
+}
 
-test_expect_success '13e-check: directory rename detection in recursive case' '
+test_expect_success '13e: directory rename detection in recursive case' '
+	test_setup_13e &&
 	(
 		cd 13e &&
 
diff --git a/t/t6046-merge-skip-unneeded-updates.sh b/t/t6046-merge-skip-unneeded-updates.sh
index 3a47623ed3..b7e4669832 100755
--- a/t/t6046-merge-skip-unneeded-updates.sh
+++ b/t/t6046-merge-skip-unneeded-updates.sh
@@ -36,10 +36,10 @@ test_description="merge cases"
 #   Commit B: b_3
 #   Expected: b_2
 
-test_expect_success '1a-setup: Modify(A)/Modify(B), change on B subset of A' '
-	test_create_repo 1a &&
+test_setup_1a () {
+	test_create_repo 1a_$1 &&
 	(
-		cd 1a &&
+		cd 1a_$1 &&
 
 		test_write_lines 1 2 3 4 5 6 7 8 9 10 >b &&
 		git add b &&
@@ -62,13 +62,12 @@ test_expect_success '1a-setup: Modify(A)/Modify(B), change on B subset of A' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '1a-check-L: Modify(A)/Modify(B), change on B subset of A' '
-	test_when_finished "git -C 1a reset --hard" &&
-	test_when_finished "git -C 1a clean -fd" &&
+test_expect_success '1a-L: Modify(A)/Modify(B), change on B subset of A' '
+	test_setup_1a L &&
 	(
-		cd 1a &&
+		cd 1a_L &&
 
 		git checkout A^0 &&
 
@@ -96,11 +95,10 @@ test_expect_success '1a-check-L: Modify(A)/Modify(B), change on B subset of A' '
 	)
 '
 
-test_expect_success '1a-check-R: Modify(A)/Modify(B), change on B subset of A' '
-	test_when_finished "git -C 1a reset --hard" &&
-	test_when_finished "git -C 1a clean -fd" &&
+test_expect_success '1a-R: Modify(A)/Modify(B), change on B subset of A' '
+	test_setup_1a R &&
 	(
-		cd 1a &&
+		cd 1a_R &&
 
 		git checkout B^0 &&
 
@@ -133,10 +131,10 @@ test_expect_success '1a-check-R: Modify(A)/Modify(B), change on B subset of A' '
 #   Commit B: c_1
 #   Expected: c_2
 
-test_expect_success '2a-setup: Modify(A)/rename(B)' '
-	test_create_repo 2a &&
+test_setup_2a () {
+	test_create_repo 2a_$1 &&
 	(
-		cd 2a &&
+		cd 2a_$1 &&
 
 		test_seq 1 10 >b &&
 		git add b &&
@@ -158,13 +156,12 @@ test_expect_success '2a-setup: Modify(A)/rename(B)' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '2a-check-L: Modify/rename, merge into modify side' '
-	test_when_finished "git -C 2a reset --hard" &&
-	test_when_finished "git -C 2a clean -fd" &&
+test_expect_success '2a-L: Modify/rename, merge into modify side' '
+	test_setup_2a L &&
 	(
-		cd 2a &&
+		cd 2a_L &&
 
 		git checkout A^0 &&
 
@@ -189,11 +186,10 @@ test_expect_success '2a-check-L: Modify/rename, merge into modify side' '
 	)
 '
 
-test_expect_success '2a-check-R: Modify/rename, merge into rename side' '
-	test_when_finished "git -C 2a reset --hard" &&
-	test_when_finished "git -C 2a clean -fd" &&
+test_expect_success '2a-R: Modify/rename, merge into rename side' '
+	test_setup_2a R &&
 	(
-		cd 2a &&
+		cd 2a_R &&
 
 		git checkout B^0 &&
 
@@ -224,10 +220,10 @@ test_expect_success '2a-check-R: Modify/rename, merge into rename side' '
 #   Commit B: b_3
 #   Expected: c_2
 
-test_expect_success '2b-setup: Rename+Mod(A)/Mod(B), B mods subset of A' '
-	test_create_repo 2b &&
+test_setup_2b () {
+	test_create_repo 2b_$1 &&
 	(
-		cd 2b &&
+		cd 2b_$1 &&
 
 		test_write_lines 1 2 3 4 5 6 7 8 9 10 >b &&
 		git add b &&
@@ -251,13 +247,12 @@ test_expect_success '2b-setup: Rename+Mod(A)/Mod(B), B mods subset of A' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '2b-check-L: Rename+Mod(A)/Mod(B), B mods subset of A' '
-	test_when_finished "git -C 2b reset --hard" &&
-	test_when_finished "git -C 2b clean -fd" &&
+test_expect_success '2b-L: Rename+Mod(A)/Mod(B), B mods subset of A' '
+	test_setup_2b L &&
 	(
-		cd 2b &&
+		cd 2b_L &&
 
 		git checkout A^0 &&
 
@@ -288,11 +283,10 @@ test_expect_success '2b-check-L: Rename+Mod(A)/Mod(B), B mods subset of A' '
 	)
 '
 
-test_expect_success '2b-check-R: Rename+Mod(A)/Mod(B), B mods subset of A' '
-	test_when_finished "git -C 2b reset --hard" &&
-	test_when_finished "git -C 2b clean -fd" &&
+test_expect_success '2b-R: Rename+Mod(A)/Mod(B), B mods subset of A' '
+	test_setup_2b R &&
 	(
-		cd 2b &&
+		cd 2b_R &&
 
 		git checkout B^0 &&
 
@@ -332,7 +326,7 @@ test_expect_success '2b-check-R: Rename+Mod(A)/Mod(B), B mods subset of A' '
 #         skip the update, then we're in trouble.  This test verifies we do
 #         not make that particular mistake.
 
-test_expect_success '2c-setup: Modify b & add c VS rename b->c' '
+test_setup_2c () {
 	test_create_repo 2c &&
 	(
 		cd 2c &&
@@ -358,9 +352,10 @@ test_expect_success '2c-setup: Modify b & add c VS rename b->c' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '2c-check: Modify b & add c VS rename b->c' '
+test_expect_success '2c: Modify b & add c VS rename b->c' '
+	test_setup_2c &&
 	(
 		cd 2c &&
 
@@ -428,10 +423,10 @@ test_expect_success '2c-check: Modify b & add c VS rename b->c' '
 #   Commit B: bq_1, bar/whatever
 #   Expected: bar/{bq_2, whatever}
 
-test_expect_success '3a-setup: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
-	test_create_repo 3a &&
+test_setup_3a () {
+	test_create_repo 3a_$1 &&
 	(
-		cd 3a &&
+		cd 3a_$1 &&
 
 		mkdir foo &&
 		test_seq 1 10 >bq &&
@@ -456,13 +451,12 @@ test_expect_success '3a-setup: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '3a-check-L: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
-	test_when_finished "git -C 3a reset --hard" &&
-	test_when_finished "git -C 3a clean -fd" &&
+test_expect_success '3a-L: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
+	test_setup_3a L &&
 	(
-		cd 3a &&
+		cd 3a_L &&
 
 		git checkout A^0 &&
 
@@ -487,11 +481,10 @@ test_expect_success '3a-check-L: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 	)
 '
 
-test_expect_success '3a-check-R: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
-	test_when_finished "git -C 3a reset --hard" &&
-	test_when_finished "git -C 3a clean -fd" &&
+test_expect_success '3a-R: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
+	test_setup_3a R &&
 	(
-		cd 3a &&
+		cd 3a_R &&
 
 		git checkout B^0 &&
 
@@ -522,10 +515,10 @@ test_expect_success '3a-check-R: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 #   Commit B: bq_2, bar/whatever
 #   Expected: bar/{bq_2, whatever}
 
-test_expect_success '3b-setup: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
-	test_create_repo 3b &&
+test_setup_3b () {
+	test_create_repo 3b_$1 &&
 	(
-		cd 3b &&
+		cd 3b_$1 &&
 
 		mkdir foo &&
 		test_seq 1 10 >bq &&
@@ -550,13 +543,12 @@ test_expect_success '3b-setup: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '3b-check-L: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
-	test_when_finished "git -C 3b reset --hard" &&
-	test_when_finished "git -C 3b clean -fd" &&
+test_expect_success '3b-L: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
+	test_setup_3b L &&
 	(
-		cd 3b &&
+		cd 3b_L &&
 
 		git checkout A^0 &&
 
@@ -581,11 +573,10 @@ test_expect_success '3b-check-L: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 	)
 '
 
-test_expect_success '3b-check-R: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
-	test_when_finished "git -C 3b reset --hard" &&
-	test_when_finished "git -C 3b clean -fd" &&
+test_expect_success '3b-R: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
+	test_setup_3b R &&
 	(
-		cd 3b &&
+		cd 3b_R &&
 
 		git checkout B^0 &&
 
@@ -621,7 +612,7 @@ test_expect_success '3b-check-R: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 #   Working copy: b_4
 #   Expected: b_2 for merge, b_4 in working copy
 
-test_expect_success '4a-setup: Change on A, change on B subset of A, dirty mods present' '
+test_setup_4a () {
 	test_create_repo 4a &&
 	(
 		cd 4a &&
@@ -647,7 +638,7 @@ test_expect_success '4a-setup: Change on A, change on B subset of A, dirty mods
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
 # NOTE: For as long as we continue using unpack_trees() without index_only
 #   set to true, it will error out on a case like this claiming the the locally
@@ -655,9 +646,8 @@ test_expect_success '4a-setup: Change on A, change on B subset of A, dirty mods
 #   correct requires doing the merge in-memory first, then realizing that no
 #   updates to the file are necessary, and thus that we can just leave the path
 #   alone.
-test_expect_failure '4a-check: Change on A, change on B subset of A, dirty mods present' '
-	test_when_finished "git -C 4a reset --hard" &&
-	test_when_finished "git -C 4a clean -fd" &&
+test_expect_failure '4a: Change on A, change on B subset of A, dirty mods present' '
+	test_setup_4a &&
 	(
 		cd 4a &&
 
@@ -695,7 +685,7 @@ test_expect_failure '4a-check: Change on A, change on B subset of A, dirty mods
 #   Working copy: c_4
 #   Expected: c_2
 
-test_expect_success '4b-setup: Rename+Mod(A)/Mod(B), change on B subset of A, dirty mods present' '
+test_setup_4b () {
 	test_create_repo 4b &&
 	(
 		cd 4b &&
@@ -722,11 +712,10 @@ test_expect_success '4b-setup: Rename+Mod(A)/Mod(B), change on B subset of A, di
 		test_tick &&
 		git commit -m "B"
 	)
-'
+}
 
-test_expect_success '4b-check: Rename+Mod(A)/Mod(B), change on B subset of A, dirty mods present' '
-	test_when_finished "git -C 4b reset --hard" &&
-	test_when_finished "git -C 4b clean -fd" &&
+test_expect_success '4b: Rename+Mod(A)/Mod(B), change on B subset of A, dirty mods present' '
+	test_setup_4b &&
 	(
 		cd 4b &&
 
-- 
gitgitgadget
