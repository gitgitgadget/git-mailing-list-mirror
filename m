Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8569F20193
	for <e@80x24.org>; Sun,  4 Sep 2016 16:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754208AbcIDQKk (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:10:40 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:55340 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754111AbcIDQKN (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:10:13 -0400
X-AuditID: 12074414-c8fff70000000931-32-57cc47379cb9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 06.9A.02353.7374CC75; Sun,  4 Sep 2016 12:09:27 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5e026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:26 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 18/38] resolve_gitlink_ref(): rename path parameter to submodule
Date:   Sun,  4 Sep 2016 18:08:24 +0200
Message-Id: <1f8eae1b5920dbe464bb52cc4b54bc26b7f0ec2d.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqGvufibcoGWJpkXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s0X3lLeMFj9aepgtZl61tjjzppHRgcPj7/sPTB47Z91l9+hqP8Lm8ax3D6PH
        xUvKHvuXbmPzWPzAy+PzJrkAjigum5TUnMyy1CJ9uwSujBcvT7MWLBeoaDl9gamB8R1PFyMn
        h4SAicTCmxdYuxi5OIQEtjJK9C3pZYNwTjJJzP+/nQWkik1AV2JRTzMTiC0ioCYxse0QC0gR
        M0jRrIkz2UESwgLBEnf6VoAVsQioSvzvngEW5xWIktjed5kZYp2cxKVtX8BsTgELiTO75wLZ
        HEDbzCXaX2RPYORZwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXQi83s0QvNaV0EyMk5ER2
        MB45KXeIUYCDUYmH10L7TLgQa2JZcWXuIUZJDiYlUd5ZB0+GC/El5adUZiQWZ8QXleakFh9i
        lOBgVhLh1XYBKudNSaysSi3Kh0lJc7AoifN+W6zuJySQnliSmp2aWpBaBJOV4eBQkuC97grU
        KFiUmp5akZaZU4KQZuLgBBnOAzT8JkgNb3FBYm5xZjpE/hSjopQ470uQhABIIqM0D64XlhJe
        MYoDvSLMm+AGVMUDTCdw3a+ABjMBDV63+zTI4JJEhJRUA2NCTZXI7M7qBbb6fiLXk3ymOSar
        3Zp+tG61ir7DzmkrkxI+WS70vSJ0bsYyk1n8wrbGD7uWNbydUvhvclrgpK9h9/l9rHeHL3RN
        2HRZw+mgEWvsM6N9RsVFSxoX/pnLHLt/8qUjZjd3pEWy+veav3uoeUZrm9ZvPeFSUQYt5oMH
        X5y7uiLi+AMlluKMREMt5qLiRABfAwYE5AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c | 13 +++++++------
 refs.h |  9 +++++----
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 34c0c5e..e881874 100644
--- a/refs.c
+++ b/refs.c
@@ -1299,26 +1299,27 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 				       resolve_flags, sha1, flags);
 }
 
-int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
+int resolve_gitlink_ref(const char *submodule, const char *refname,
+			unsigned char *sha1)
 {
-	size_t len = strlen(path);
+	size_t len = strlen(submodule);
 	struct ref_store *refs;
 	int flags;
 
-	while (len && path[len - 1] == '/')
+	while (len && submodule[len - 1] == '/')
 		len--;
 
 	if (!len)
 		return -1;
 
-	if (path[len]) {
+	if (submodule[len]) {
 		/* We need to strip off one or more trailing slashes */
-		char *stripped = xmemdupz(path, len);
+		char *stripped = xmemdupz(submodule, len);
 
 		refs = get_ref_store(stripped);
 		free(stripped);
 	} else {
-		refs = get_ref_store(path);
+		refs = get_ref_store(submodule);
 	}
 
 	if (!refs)
diff --git a/refs.h b/refs.h
index 9a29f1b..17e8cfb 100644
--- a/refs.h
+++ b/refs.h
@@ -77,11 +77,12 @@ int is_branch(const char *refname);
 int peel_ref(const char *refname, unsigned char *sha1);
 
 /**
- * Resolve refname in the nested "gitlink" repository that is located
- * at path.  If the resolution is successful, return 0 and set sha1 to
- * the name of the object; otherwise, return a non-zero value.
+ * Resolve refname in the nested "gitlink" repository in the specified
+ * submodule (which must be non-NULL). If the resolution is
+ * successful, return 0 and set sha1 to the name of the object;
+ * otherwise, return a non-zero value.
  */
-int resolve_gitlink_ref(const char *path, const char *refname,
+int resolve_gitlink_ref(const char *submodule, const char *refname,
 			unsigned char *sha1);
 
 /*
-- 
2.9.3

