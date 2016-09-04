Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C6BC1F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754535AbcIDQND (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:13:03 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:45909 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754517AbcIDQNB (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:13:01 -0400
X-AuditID: 1207440c-22bff700000008d5-53-57cc472c2fb5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 7A.0A.02261.C274CC75; Sun,  4 Sep 2016 12:09:16 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5Y026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:15 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 12/38] resolve_packed_ref(): rename function from resolve_missing_loose_ref()
Date:   Sun,  4 Sep 2016 18:08:18 +0200
Message-Id: <ddf220e2f0a79cef2642c05209d87fbd7d135912.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqKvjfibc4H6ruUXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s0X3lLeMFj9aepgtZl61tjjzppHRgcPj7/sPTB47Z91l9+hqP8Lm8ax3D6PH
        xUvKHvuXbmPzWPzAy+PzJrkAjigum5TUnMyy1CJ9uwSujINNU5gK3nJXLNzym7mBcRFnFyMn
        h4SAicSizl8sXYxcHEICWxklzv77xw7hnGSSuLVkORNIFZuArsSinmYwW0RATWJi2yGwDmaQ
        olkTZ7KDJIQFEiTW3djBCmKzCKhKtN6dyQZi8wpESdza188CsU5O4tK2L8wgNqeAhcSZ3XOB
        bA6gbeYS7S+yJzDyLGBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6iXm1mil5pSuokREnI8
        Oxi/rZM5xCjAwajEw2uhfSZciDWxrLgy9xCjJAeTkijvrIMnw4X4kvJTKjMSizPii0pzUosP
        MUpwMCuJ8Gq7AJXzpiRWVqUW5cOkpDlYlMR5VZeo+wkJpCeWpGanphakFsFkZTg4lCR4o9yA
        GgWLUtNTK9Iyc0oQ0kwcnCDDeYCG94HU8BYXJOYWZ6ZD5E8xKkqJ8750BUoIgCQySvPgemEp
        4RWjONArwryKIO08wHQC1/0KaDAT0OB1u0+DDC5JREhJNTCKn4u6L3plXd6MW4/CufQWGRyx
        mFGawfV38/E9Mj2tDUtEO3K6jbsc1Vrfcs0877HPfK2uXMnb4rcV6jflFnZtKnxfaTQxItbN
        pyg4bO6Nc8wL5K+fyMxp3BWj++Gflr/8ef0/Tlf5j+TOd3sjPUl/ksndfTJhQg7iJVV7zG0s
        Jrlf2HBJ30WJpTgj0VCLuag4EQDxmSkP5AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/files-backend.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7673342..32ca5ff 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1329,10 +1329,9 @@ static struct ref_entry *get_packed_ref(struct files_ref_store *refs,
 /*
  * A loose ref file doesn't exist; check for a packed ref.
  */
-static int resolve_missing_loose_ref(struct files_ref_store *refs,
-				     const char *refname,
-				     unsigned char *sha1,
-				     unsigned int *flags)
+static int resolve_packed_ref(struct files_ref_store *refs,
+			      const char *refname,
+			      unsigned char *sha1, unsigned int *flags)
 {
 	struct ref_entry *entry;
 
@@ -1383,7 +1382,7 @@ int read_raw_ref(const char *refname, unsigned char *sha1,
 	if (lstat(path, &st) < 0) {
 		if (errno != ENOENT)
 			goto out;
-		if (resolve_missing_loose_ref(refs, refname, sha1, type)) {
+		if (resolve_packed_ref(refs, refname, sha1, type)) {
 			errno = ENOENT;
 			goto out;
 		}
@@ -1417,7 +1416,7 @@ int read_raw_ref(const char *refname, unsigned char *sha1,
 		 * ref is supposed to be, there could still be a
 		 * packed ref:
 		 */
-		if (resolve_missing_loose_ref(refs, refname, sha1, type)) {
+		if (resolve_packed_ref(refs, refname, sha1, type)) {
 			errno = EISDIR;
 			goto out;
 		}
-- 
2.9.3

