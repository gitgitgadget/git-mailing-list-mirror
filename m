Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7834920281
	for <e@80x24.org>; Tue, 19 Sep 2017 06:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbdISGXE (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 02:23:04 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:42098 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751455AbdISGXD (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Sep 2017 02:23:03 -0400
X-AuditID: 1207440c-7e5ff7000000143e-f8-59c0b7c64e80
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 40.47.05182.6C7B0C95; Tue, 19 Sep 2017 02:23:02 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE885.dip0.t-ipconnect.de [84.170.232.133])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8J6MV1j002857
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 19 Sep 2017 02:23:00 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 12/21] packed-backend.c: reorder some definitions
Date:   Tue, 19 Sep 2017 08:22:20 +0200
Message-Id: <b00a80a8ee82c18dfa7e6120261945546f7ae97d.1505799700.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505799700.git.mhagger@alum.mit.edu>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqHts+4FIg5NbVS3WPrvDZPF8/Ql2
        i64r3UwWDb1XmC36l3exWdxeMZ/ZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4fPsZ5
        LNhU6vGsdw+jx8VLyh6fN8kFsEdx2aSk5mSWpRbp2yVwZXxYsIap4AV/xcxZ71kbGBt4uxg5
        OSQETCSWn3rG2sXIxSEksINJYn7DJyjnFJPEy4ZuFpAqNgFdiUU9zUwgtoiAmsTEtkMsIEXM
        AiuZJSZtvcIKkhAWcJFY0zERKMHBwSKgKtHxWw8kzCsQJbH40xxGiG3yEuce3GYGsTkFLCSa
        92wHKxcSMJc4cLR4AiPPAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6hnq5mSV6qSmlmxgh
        Acezg/HbOplDjAIcjEo8vALX9kcKsSaWFVfmHmKU5GBSEuUN23QgUogvKT+lMiOxOCO+qDQn
        tfgQowQHs5II76FFQDnelMTKqtSifJiUNAeLkjiv6hJ1PyGB9MSS1OzU1ILUIpisDAeHkgSv
        IjCyhASLUtNTK9Iyc0oQ0kwcnCDDeYCGq4DU8BYXJOYWZ6ZD5E8x6nJ03Lz7h0mIJS8/L1VK
        nPf+NqAiAZCijNI8uDmwRPGKURzoLWHeBpAqHmCSgZv0CmgJE9CS7A1gS0oSEVJSDYwsQS1P
        zbb2+pSff5QQLLhKxemz7KzfyfNVdm/KviEhoq391b46yDdE7+Cqr1VPRWX8P0jwTTJnXzrP
        LOaTpiDvSuckoVSxcyL9r3kV805Mmr/oYZjY5g6PNxGL209U2Jzq/P7nKoNPiW1vqTa7e83X
        yMbfqxZIp789Onf3f7aXSSpV+kGiO5RYijMSDbWYi4oTAW1MhgDvAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No code has been changed. This will make subsequent patches more
self-contained.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 724c88631d..0fe41a7203 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -36,30 +36,6 @@ struct packed_ref_cache {
 	struct stat_validity validity;
 };
 
-/*
- * Increment the reference count of *packed_refs.
- */
-static void acquire_packed_ref_cache(struct packed_ref_cache *packed_refs)
-{
-	packed_refs->referrers++;
-}
-
-/*
- * Decrease the reference count of *packed_refs.  If it goes to zero,
- * free *packed_refs and return true; otherwise return false.
- */
-static int release_packed_ref_cache(struct packed_ref_cache *packed_refs)
-{
-	if (!--packed_refs->referrers) {
-		free_ref_cache(packed_refs->cache);
-		stat_validity_clear(&packed_refs->validity);
-		free(packed_refs);
-		return 1;
-	} else {
-		return 0;
-	}
-}
-
 /*
  * A container for `packed-refs`-related data. It is not (yet) a
  * `ref_store`.
@@ -92,6 +68,30 @@ struct packed_ref_store {
 	struct tempfile tempfile;
 };
 
+/*
+ * Increment the reference count of *packed_refs.
+ */
+static void acquire_packed_ref_cache(struct packed_ref_cache *packed_refs)
+{
+	packed_refs->referrers++;
+}
+
+/*
+ * Decrease the reference count of *packed_refs.  If it goes to zero,
+ * free *packed_refs and return true; otherwise return false.
+ */
+static int release_packed_ref_cache(struct packed_ref_cache *packed_refs)
+{
+	if (!--packed_refs->referrers) {
+		free_ref_cache(packed_refs->cache);
+		stat_validity_clear(&packed_refs->validity);
+		free(packed_refs);
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
 struct ref_store *packed_ref_store_create(const char *path,
 					  unsigned int store_flags)
 {
-- 
2.14.1

