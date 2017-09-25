Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B64DB20281
	for <e@80x24.org>; Mon, 25 Sep 2017 08:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934053AbdIYIA4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 04:00:56 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:49303 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934043AbdIYIAy (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Sep 2017 04:00:54 -0400
X-AuditID: 1207440f-a43ff70000007960-ef-59c8b7b5a7f2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 69.79.31072.5B7B8C95; Mon, 25 Sep 2017 04:00:53 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDF6.dip0.t-ipconnect.de [87.188.205.246])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8P80N6W027347
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 25 Sep 2017 04:00:51 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 12/21] packed-backend.c: reorder some definitions
Date:   Mon, 25 Sep 2017 10:00:09 +0200
Message-Id: <314e08dc1b39101d6e08b8ce20bf4a96ab83ce7c.1506325610.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1506325610.git.mhagger@alum.mit.edu>
References: <cover.1506325610.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqLt1+4lIg4cXpS3WPrvDZPF8/Ql2
        i64r3UwWDb1XmC36l3exWdxeMZ/ZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4fPsZ5
        LNhU6vGsdw+jx8VLyh6fN8kFsEdx2aSk5mSWpRbp2yVwZXxYsIap4AV/xcxZ71kbGBt4uxg5
        OSQETCSa5+1n6WLk4hAS2MEkcb11AZRzikni1uGdrCBVbAK6Eot6mplAbBEBNYmJbYfAipgF
        VjJLTNp6BaxIWMBFYtqRtWwgNouAqsTb/f1AcQ4OXoEoiYP3UiG2yUuce3CbGcTmFLCQeHPm
        CFi5kIC5xPkbt1gnMPIsYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRropebWaKXmlK6iRES
        cvw7GLvWyxxiFOBgVOLhjfh3PFKINbGsuDL3EKMkB5OSKO9dvhORQnxJ+SmVGYnFGfFFpTmp
        xYcYJTiYlUR4j60GyvGmJFZWpRblw6SkOViUxHnVl6j7CQmkJ5akZqemFqQWwWRlODiUJHhd
        twE1ChalpqdWpGXmlCCkmTg4QYbzAA1fDlLDW1yQmFucmQ6RP8Woy9Fx8+4fJiGWvPy8VClx
        3g0gRQIgRRmleXBzYKniFaM40FvCvGkgVTzANAM36RXQEiagJb1TwZaUJCKkpBoYndmv/bi7
        bmnEO9k4nQXlFhMzV04L0zrdnyHp+2QJ+8P7wkczGy/s7Kw9fFvtZZTFDnVFKdc587tmdLc9
        7lXgkPORZzRknKW/ofSCSfFR3xX37q5f9tq64H3wrJ2qzm1SHjHzq2d5R+duDP6U97j6i5E3
        o3xXumvDmQVXDU5cu6a7+fBKwRd/lFiKMxINtZiLihMBneD6aPACAAA=
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

