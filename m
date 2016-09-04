Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 449FB1F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754198AbcIDQKQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:10:16 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:55308 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753657AbcIDQKN (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:10:13 -0400
X-AuditID: 12074414-c8fff70000000931-18-57cc4719e18e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id A3.9A.02353.9174CC75; Sun,  4 Sep 2016 12:08:59 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5O026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:08:55 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        David Turner <dturner@twopensource.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 02/38] rename_ref_available(): add docstring
Date:   Sun,  4 Sep 2016 18:08:08 +0200
Message-Id: <f89d56ef0841a3cc35689436c0b9473c6773d22d.1473003902.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqCvtfibc4OgBFYv5m04wWnRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li5lVrizNvGhkdOD3+vv/A5LFz1l12j672I2we
        z3r3MHpcvKTssX/pNjaPxQ+8PBY8v8/u8XmTXABnFJdNSmpOZllqkb5dAlfGlgerGAvWC1Xc
        vf6UpYGxn7+LkZNDQsBEovttJ0sXIxeHkMBWRom1K1rYIZyTTBLtd04ygVSxCehKLOppBrNF
        BNQkJrYdAutgFvjNJHFh63N2kISwgL3EvK23WUFsFgFVibv9x8DivAJREneW7WeCWCcncWnb
        F2YQm1PAQuLM7rlANgfQNnOJ9hfZExh5FjAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3StdDL
        zSzRS00p3cQICUORHYxHTsodYhTgYFTi4bXQPhMuxJpYVlyZe4hRkoNJSZR31sGT4UJ8Sfkp
        lRmJxRnxRaU5qcWHGCU4mJVEeLVdgMp5UxIrq1KL8mFS0hwsSuK83xar+wkJpCeWpGanphak
        FsFkZTg4lCR4G1yBGgWLUtNTK9Iyc0oQ0kwcnCDDeYCGzwep4S0uSMwtzkyHyJ9iVJQS5w0B
        2SoAksgozYPrhaWJV4ziQK8I8yq6AVXxAFMMXPcroMFMQIPX7T4NMrgkESEl1cCoyZG4ecsU
        o8XWwjrXpDZd7prse5P5aNvV5QULbz3i1H23M3XhhjCeqXKORV7NS47fWts7yU7SM/K68Yy9
        83PnKilnHT+cbOj8rX710/NX0qezLE42FykMZTH7enNy6ONXtjvCn777HrGKUbWZ++avR+di
        hFd8VDmtW+nzqsLt3BLfiG2Hnog5KrEUZyQaajEXFScCAFFBub/uAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Turner <dturner@twopensource.com>

And improve the internal variable names.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 12 ++++++------
 refs/refs-internal.h | 12 +++++++++++-
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index b4e7cac..4c609df 100644
--- a/refs.c
+++ b/refs.c
@@ -1081,20 +1081,20 @@ const char *find_descendant_ref(const char *dirname,
 	return NULL;
 }
 
-int rename_ref_available(const char *oldname, const char *newname)
+int rename_ref_available(const char *old_refname, const char *new_refname)
 {
 	struct string_list skip = STRING_LIST_INIT_NODUP;
 	struct strbuf err = STRBUF_INIT;
-	int ret;
+	int ok;
 
-	string_list_insert(&skip, oldname);
-	ret = !verify_refname_available(newname, NULL, &skip, &err);
-	if (!ret)
+	string_list_insert(&skip, old_refname);
+	ok = !verify_refname_available(new_refname, NULL, &skip, &err);
+	if (!ok)
 		error("%s", err.buf);
 
 	string_list_clear(&skip, 0);
 	strbuf_release(&err);
-	return ret;
+	return ok;
 }
 
 int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index efe5847..0206e2b 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -240,7 +240,17 @@ const char *find_descendant_ref(const char *dirname,
 				const struct string_list *extras,
 				const struct string_list *skip);
 
-int rename_ref_available(const char *oldname, const char *newname);
+/*
+ * Check whether an attempt to rename old_refname to new_refname would
+ * cause a D/F conflict with any existing reference (other than
+ * possibly old_refname). If there would be a conflict, emit an error
+ * message and return false; otherwise, return true.
+ *
+ * Note that this function is not safe against all races with other
+ * processes (though rename_ref() catches some races that might get by
+ * this check).
+ */
+int rename_ref_available(const char *old_refname, const char *new_refname);
 
 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define SYMREF_MAXDEPTH 5
-- 
2.9.3

