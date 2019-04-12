Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7AA720248
	for <e@80x24.org>; Fri, 12 Apr 2019 09:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfDLJhd (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 05:37:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46717 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfDLJh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 05:37:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id d1so7728484edd.13
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 02:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JyFzcaTYQSB9GuPQKaxTDKm9YHvpcpHbe30toDYdzN8=;
        b=kg6nXE0Qonw5c6ATX8gIOefD1rYFDdoq8vnaODlmZ/hmIGmtJeo1L5eC6HdP+c4ETL
         Vq95xOo9qpWaenggaTRoYzCOj+eg0X5L3k3nYHT593jf6PY6v0Rwl9PR+VPOD1YsZMbO
         fUatExMBPvTQGzS43Zi4Bpn1JIkYUSDIPaMPpCc9IsJNskqGLgnd63U/DZaCY8V2jefE
         bUHruyxJVmWbG4JKjNNISSBEjE2MoUO/IDFr1tpOMLes21i6ZjoqLqIcqWU2Pz5DXkHf
         A9Wfxj7kGW7YJdMNP1r2ByyNnTvQYQceRNxlS4uSqfFVavQD2RkJ80WlGl6bsUQKCFcn
         yvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JyFzcaTYQSB9GuPQKaxTDKm9YHvpcpHbe30toDYdzN8=;
        b=uB9wz+vXEWnDVEoI7yLJ6e0UIgfHj2V3PcZsa2fo3MqBWffbnPE88LGkRnKH8wp7WO
         o7LcoDMdZumhKcDcaL2ABeHJcJhHeJzeuXh0Ma48S5CJoPxVIwezlD7DlJSwraZxCFAq
         +lTJxM0/VwaQxeVCqiG4YEB3Xw8wxx5p3UyuQyAGAh81dwD4oJ8YbWKxjEY0v0LeJwDL
         pKhASLU6PoS4htQJWFx/0vLAONqNnuWowCgr+q/nz6zAtI4jeIlxHkDrnS3X6LI0giKs
         qe7s4jfHcjrflcAHBw2jRZ2OBL7lRhjIsvnK87jGKAPN7o/b+sBFhQ4CzEvOwxolXz6K
         kEHw==
X-Gm-Message-State: APjAAAVGknAqvK0GqEa2PeGp0UrTJUX6eVUgu1rGdH9QqUgsw/ZPphRP
        1mTmM7YS2pWhr9K952FgFSKGQRwi
X-Google-Smtp-Source: APXvYqzDBFKDfjNntWyJtFJVUrVWRfjHbt+u5xaSWJlYkFxBalaAKZUbgfP+HFpnqVnMYIM+jCyAOg==
X-Received: by 2002:a50:8e95:: with SMTP id w21mr3211207edw.154.1555061844397;
        Fri, 12 Apr 2019 02:37:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r14sm12393727edd.87.2019.04.12.02.37.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 02:37:23 -0700 (PDT)
Date:   Fri, 12 Apr 2019 02:37:23 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Apr 2019 09:37:16 GMT
Message-Id: <a722a065d2c3249bddd987cca9a37779a81bb378.1555061837.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.167.v2.git.gitgitgadget@gmail.com>
References: <pull.167.git.gitgitgadget@gmail.com>
        <pull.167.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 7/8] tests (pack-objects): use the full, unabbreviated
 `--revs` option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To use the singular form of a word, when the option wants the plural
form (and quietly expands it because it thinks it was abbreviated), is
an easy mistake to make, and t5317 contains almost two dozen of them.

However, using abbreviated options in tests is a bit fragile, so we will
disallow use of abbreviated options in our test suite.

In preparation for this change, let's fix
`t5317-pack-objects-filter-objects.sh`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5317-pack-objects-filter-objects.sh | 44 +++++++++++++-------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 24541ea137..4c0201c34b 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -25,7 +25,7 @@ test_expect_success 'verify blob count in normal packfile' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r1 pack-objects --rev --stdout >all.pack <<-EOF &&
+	git -C r1 pack-objects --revs --stdout >all.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r1 index-pack ../all.pack &&
@@ -39,7 +39,7 @@ test_expect_success 'verify blob count in normal packfile' '
 '
 
 test_expect_success 'verify blob:none packfile has no blobs' '
-	git -C r1 pack-objects --rev --stdout --filter=blob:none >filter.pack <<-EOF &&
+	git -C r1 pack-objects --revs --stdout --filter=blob:none >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r1 index-pack ../filter.pack &&
@@ -74,7 +74,7 @@ test_expect_success 'get an error for missing tree object' '
 	git -C r5 commit -m "foo" &&
 	del=$(git -C r5 rev-parse HEAD^{tree} | sed "s|..|&/|") &&
 	rm r5/.git/objects/$del &&
-	test_must_fail git -C r5 pack-objects --rev --stdout 2>bad_tree <<-EOF &&
+	test_must_fail git -C r5 pack-objects --revs --stdout 2>bad_tree <<-EOF &&
 	HEAD
 	EOF
 	grep "bad tree object" bad_tree
@@ -88,7 +88,7 @@ test_expect_success 'setup for tests of tree:0' '
 '
 
 test_expect_success 'verify tree:0 packfile has no blobs or trees' '
-	git -C r1 pack-objects --rev --stdout --filter=tree:0 >commitsonly.pack <<-EOF &&
+	git -C r1 pack-objects --revs --stdout --filter=tree:0 >commitsonly.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r1 index-pack ../commitsonly.pack &&
@@ -98,7 +98,7 @@ test_expect_success 'verify tree:0 packfile has no blobs or trees' '
 
 test_expect_success 'grab tree directly when using tree:0' '
 	# We should get the tree specified directly but not its blobs or subtrees.
-	git -C r1 pack-objects --rev --stdout --filter=tree:0 >commitsonly.pack <<-EOF &&
+	git -C r1 pack-objects --revs --stdout --filter=tree:0 >commitsonly.pack <<-EOF &&
 	HEAD:
 	EOF
 	git -C r1 index-pack ../commitsonly.pack &&
@@ -128,7 +128,7 @@ test_expect_success 'verify blob count in normal packfile' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r2 pack-objects --rev --stdout >all.pack <<-EOF &&
+	git -C r2 pack-objects --revs --stdout >all.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r2 index-pack ../all.pack &&
@@ -142,7 +142,7 @@ test_expect_success 'verify blob count in normal packfile' '
 '
 
 test_expect_success 'verify blob:limit=500 omits all blobs' '
-	git -C r2 pack-objects --rev --stdout --filter=blob:limit=500 >filter.pack <<-EOF &&
+	git -C r2 pack-objects --revs --stdout --filter=blob:limit=500 >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r2 index-pack ../filter.pack &&
@@ -157,7 +157,7 @@ test_expect_success 'verify blob:limit=500 omits all blobs' '
 '
 
 test_expect_success 'verify blob:limit=1000' '
-	git -C r2 pack-objects --rev --stdout --filter=blob:limit=1000 >filter.pack <<-EOF &&
+	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1000 >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r2 index-pack ../filter.pack &&
@@ -176,7 +176,7 @@ test_expect_success 'verify blob:limit=1001' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r2 pack-objects --rev --stdout --filter=blob:limit=1001 >filter.pack <<-EOF &&
+	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1001 >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r2 index-pack ../filter.pack &&
@@ -194,7 +194,7 @@ test_expect_success 'verify blob:limit=10001' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r2 pack-objects --rev --stdout --filter=blob:limit=10001 >filter.pack <<-EOF &&
+	git -C r2 pack-objects --revs --stdout --filter=blob:limit=10001 >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r2 index-pack ../filter.pack &&
@@ -212,7 +212,7 @@ test_expect_success 'verify blob:limit=1k' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r2 pack-objects --rev --stdout --filter=blob:limit=1k >filter.pack <<-EOF &&
+	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1k >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r2 index-pack ../filter.pack &&
@@ -230,7 +230,7 @@ test_expect_success 'verify explicitly specifying oversized blob in input' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r2 pack-objects --rev --stdout --filter=blob:limit=1k >filter.pack <<-EOF &&
+	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1k >filter.pack <<-EOF &&
 	HEAD
 	$(git -C r2 rev-parse HEAD:large.10000)
 	EOF
@@ -249,7 +249,7 @@ test_expect_success 'verify blob:limit=1m' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r2 pack-objects --rev --stdout --filter=blob:limit=1m >filter.pack <<-EOF &&
+	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1m >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r2 index-pack ../filter.pack &&
@@ -302,7 +302,7 @@ test_expect_success 'verify blob count in normal packfile' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r3 pack-objects --rev --stdout >all.pack <<-EOF &&
+	git -C r3 pack-objects --revs --stdout >all.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r3 index-pack ../all.pack &&
@@ -320,7 +320,7 @@ test_expect_success 'verify sparse:path=pattern1' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r3 pack-objects --rev --stdout --filter=sparse:path=../pattern1 >filter.pack <<-EOF &&
+	git -C r3 pack-objects --revs --stdout --filter=sparse:path=../pattern1 >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r3 index-pack ../filter.pack &&
@@ -352,7 +352,7 @@ test_expect_success 'verify sparse:path=pattern2' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r3 pack-objects --rev --stdout --filter=sparse:path=../pattern2 >filter.pack <<-EOF &&
+	git -C r3 pack-objects --revs --stdout --filter=sparse:path=../pattern2 >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r3 index-pack ../filter.pack &&
@@ -404,7 +404,7 @@ test_expect_success 'verify blob count in normal packfile' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r4 pack-objects --rev --stdout >all.pack <<-EOF &&
+	git -C r4 pack-objects --revs --stdout >all.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r4 index-pack ../all.pack &&
@@ -423,7 +423,7 @@ test_expect_success 'verify sparse:oid=OID' '
 	sort >expected &&
 
 	oid=$(git -C r4 ls-files -s pattern | awk -f print_2.awk) &&
-	git -C r4 pack-objects --rev --stdout --filter=sparse:oid=$oid >filter.pack <<-EOF &&
+	git -C r4 pack-objects --revs --stdout --filter=sparse:oid=$oid >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r4 index-pack ../filter.pack &&
@@ -441,7 +441,7 @@ test_expect_success 'verify sparse:oid=oid-ish' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r4 pack-objects --rev --stdout --filter=sparse:oid=master:pattern >filter.pack <<-EOF &&
+	git -C r4 pack-objects --revs --stdout --filter=sparse:oid=master:pattern >filter.pack <<-EOF &&
 	HEAD
 	EOF
 	git -C r4 index-pack ../filter.pack &&
@@ -470,19 +470,19 @@ test_expect_success 'setup r1 - delete loose blobs' '
 '
 
 test_expect_success 'verify pack-objects fails w/ missing objects' '
-	test_must_fail git -C r1 pack-objects --rev --stdout >miss.pack <<-EOF
+	test_must_fail git -C r1 pack-objects --revs --stdout >miss.pack <<-EOF
 	HEAD
 	EOF
 '
 
 test_expect_success 'verify pack-objects fails w/ --missing=error' '
-	test_must_fail git -C r1 pack-objects --rev --stdout --missing=error >miss.pack <<-EOF
+	test_must_fail git -C r1 pack-objects --revs --stdout --missing=error >miss.pack <<-EOF
 	HEAD
 	EOF
 '
 
 test_expect_success 'verify pack-objects w/ --missing=allow-any' '
-	git -C r1 pack-objects --rev --stdout --missing=allow-any >miss.pack <<-EOF
+	git -C r1 pack-objects --revs --stdout --missing=allow-any >miss.pack <<-EOF
 	HEAD
 	EOF
 '
-- 
gitgitgadget

