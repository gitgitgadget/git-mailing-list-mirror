Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B469202A0
	for <e@80x24.org>; Sat, 28 Oct 2017 09:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbdJ1JuY (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 05:50:24 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:58430 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751286AbdJ1JuR (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2017 05:50:17 -0400
X-AuditID: 1207440d-86bff70000000f42-a8-59f452d36960
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 4E.F6.03906.3D254F95; Sat, 28 Oct 2017 05:50:12 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE7F1.dip0.t-ipconnect.de [84.170.231.241])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9S9nwqc016802
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 28 Oct 2017 05:50:09 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 7/7] refs: rename constant `REF_ISPRUNING` to `REF_IS_PRUNING`
Date:   Sat, 28 Oct 2017 11:49:56 +0200
Message-Id: <f491dbec59b5a17f40481081c9f3f1390f5a93a9.1509183413.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1509183413.git.mhagger@alum.mit.edu>
References: <cover.1509183413.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqHsl6Eukwda14hZdV7qZLBp6rzBb
        3F4xn9nizJtGRgcWj7/vPzB5XLyk7LH4gZfH501yASxRXDYpqTmZZalF+nYJXBnXb+5kLGiV
        rmjp2cnewHhVtIuRk0NCwETi+rnPTCC2kMAOJomDi7K6GLmA7FNMEg2XHzODJNgEdCUW9TSD
        FYkIqElMbDvEAmIzCxRJfF1/FijOwSEs4CexboszSJhFQFXiWdcWsBJegSiJY+/7GCF2yUuc
        e3AbbCSngIXE3WVrmSH2mku8fbOAdQIjzwJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFukZ6
        uZkleqkppZsYIQHCu4Px/zqZQ4wCHIxKPLwSuZ8jhVgTy4orcw8xSnIwKYny7jv/KVKILyk/
        pTIjsTgjvqg0J7X4EKMEB7OSCO9Fny+RQrwpiZVVqUX5MClpDhYlcV61Jep+QgLpiSWp2amp
        BalFMFkNDg6Bu0t6NzBKseTl56UqSfByASNESLAoNT21Ii0zpwShlImDE2QRD9CiH4Egi4oL
        EnOLM9Mh8qcYjTk6bt79w8TxbObrBmYhsHFS4rwvQEoFQEozSvPgpsGi/xWjONCjwryzQap4
        gIkDbt4roFVMQKs0JMFWlSQipKQaGA29z5j0BE57PGe9zracD7ttN9zM2M3+7cFMx2S51U9b
        lxdMvF1R6hf3Tv+H7/xNDfd+n545Zaeno6Gu4dwvgi+vVtum5nBu6jt9LkHiVMHDCY8v39v+
        a2bu6ceyYpM2XI3NuPK3eBP7cgW+JHep/zFnNvqafbmz+Lv/0ZtOHtzxe655WQvNNXdRYinO
        SDTUYi4qTgQA8sOlItkCAAA=
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

