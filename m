Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBC0E2055E
	for <e@80x24.org>; Sun,  5 Nov 2017 08:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752744AbdKEImb (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 03:42:31 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:56864 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752732AbdKEIm3 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2017 03:42:29 -0500
X-AuditID: 12074413-38bff70000007929-11-59fecef2126d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 9E.71.31017.2FECEF95; Sun,  5 Nov 2017 03:42:26 -0500 (EST)
Received: from bagpipes.fritz.box (p4FC6E019.dip0.t-ipconnect.de [79.198.224.25])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id vA58gCCw018723
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 5 Nov 2017 03:42:25 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 7/9] refs: rename constant `REF_ISPRUNING` to `REF_IS_PRUNING`
Date:   Sun,  5 Nov 2017 09:42:07 +0100
Message-Id: <1b94c9a3897c0f1ff7d55272942ec85f948a3109.1509870243.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1509870243.git.mhagger@alum.mit.edu>
References: <cover.1509870243.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsUixO6iqPvp3L9Ig7mvtSy6rnQzWTT0XmG2
        +Pumi9Hi9or5zBZn3jQyOrB6/H3/gclj56y77B4XLyl7LH7g5fF5k1wAaxSXTUpqTmZZapG+
        XQJXxvWbOxkLWqUrWnp2sjcwXhXtYuTkkBAwkWjaNo2ti5GLQ0hgB5NES98EFgjnBJPE1mez
        2EGq2AR0JRb1NDOB2CICahIT2w6BFTELbGWU+NvdzAySEBYIlPg14ypYA4uAqsSSvvUsIDav
        QJTEzC23mCDWyUuce3AbrJ5TwELiz8d5bCC2kIC5xKdPO1knMPIsYGRYxSiXmFOaq5ubmJlT
        nJqsW5ycmJeXWqRrrpebWaKXmlK6iRESOsI7GHedlDvEKMDBqMTDe8LjX6QQa2JZcWXuIUZJ
        DiYlUd4rL/9ECvEl5adUZiQWZ8QXleakFh9ilOBgVhLhDVoMVM6bklhZlVqUD5OS5mBREudV
        W6LuJySQnliSmp2aWpBaBJPV4OAQuLukdwOjFEtefl6qkgSvADB2hASLUtNTK9Iyc0oQSpk4
        OEEW8QAtigKp4S0uSMwtzkyHyJ9iNOZ4NvN1AzPHtKutTcxCYOOkxHndQEoFQEozSvPgpsHS
        witGcaBHhXmnnQWq4gGmFLh5r4BWMQGtms3xB2RVSSJCSqqBMeH0sasLnreY5l7wdLdOlpLa
        Z3lVZfr8/4tDJJOuR2l65U9ewFj9a8K225p+y59+VM2SmLMgZmK4zKzt91aan8zsrBURMqle
        pnlATGOm9M+8p3Mm/rVbZjl1rrfnh+NOorLrppp/XzfRaKnHstMy2mfzuERuSQTErdnEcFMg
        Pt1e8aDzqoNeBUosxRmJhlrMRcWJAFno/GnmAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Underscores are cheap, and help readability.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 71e088e811..bb10b715a8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -14,7 +14,7 @@
  * This backend uses the following flags in `ref_update::flags` for
  * internal bookkeeping purposes. Their numerical values must not
  * conflict with REF_NO_DEREF, REF_FORCE_CREATE_REFLOG, REF_HAVE_NEW,
- * REF_HAVE_OLD, or REF_ISPRUNING, which are also stored in
+ * REF_HAVE_OLD, or REF_IS_PRUNING, which are also stored in
  * `ref_update::flags`.
  */
 
@@ -22,7 +22,7 @@
  * Used as a flag in ref_update::flags when a loose ref is being
  * pruned. This flag must only be used when REF_NO_DEREF is set.
  */
-#define REF_ISPRUNING (1 << 4)
+#define REF_IS_PRUNING (1 << 4)
 
 /*
  * Flag passed to lock_ref_sha1_basic() telling it to tolerate broken
@@ -1044,7 +1044,7 @@ static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 		goto cleanup;
 	ref_transaction_add_update(
 			transaction, r->name,
-			REF_NO_DEREF | REF_HAVE_NEW | REF_HAVE_OLD | REF_ISPRUNING,
+			REF_NO_DEREF | REF_HAVE_NEW | REF_HAVE_OLD | REF_IS_PRUNING,
 			&null_oid, &r->oid, NULL);
 	if (ref_transaction_commit(transaction, &err))
 		goto cleanup;
@@ -2177,7 +2177,7 @@ static int split_head_update(struct ref_update *update,
 	struct ref_update *new_update;
 
 	if ((update->flags & REF_LOG_ONLY) ||
-	    (update->flags & REF_ISPRUNING) ||
+	    (update->flags & REF_IS_PRUNING) ||
 	    (update->flags & REF_UPDATE_VIA_HEAD))
 		return 0;
 
@@ -2564,16 +2564,16 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	 * split_symref_update() or split_head_update(), those
 	 * functions will check that the new updates don't have the
 	 * same refname as any existing ones.) Also fail if any of the
-	 * updates use REF_ISPRUNING without REF_NO_DEREF.
+	 * updates use REF_IS_PRUNING without REF_NO_DEREF.
 	 */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 		struct string_list_item *item =
 			string_list_append(&affected_refnames, update->refname);
 
-		if ((update->flags & REF_ISPRUNING) &&
+		if ((update->flags & REF_IS_PRUNING) &&
 		    !(update->flags & REF_NO_DEREF))
-			BUG("REF_ISPRUNING set without REF_NO_DEREF");
+			BUG("REF_IS_PRUNING set without REF_NO_DEREF");
 
 		/*
 		 * We store a pointer to update in item->util, but at
@@ -2632,7 +2632,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 
 		if (update->flags & REF_DELETING &&
 		    !(update->flags & REF_LOG_ONLY) &&
-		    !(update->flags & REF_ISPRUNING)) {
+		    !(update->flags & REF_IS_PRUNING)) {
 			/*
 			 * This reference has to be deleted from
 			 * packed-refs if it exists there.
@@ -2749,7 +2749,7 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		struct ref_update *update = transaction->updates[i];
 		if (update->flags & REF_DELETING &&
 		    !(update->flags & REF_LOG_ONLY) &&
-		    !(update->flags & REF_ISPRUNING)) {
+		    !(update->flags & REF_IS_PRUNING)) {
 			strbuf_reset(&sb);
 			files_reflog_path(refs, &sb, update->refname);
 			if (!unlink_or_warn(sb.buf))
-- 
2.14.1

