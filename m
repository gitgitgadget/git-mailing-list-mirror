Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD2612055E
	for <e@80x24.org>; Sun,  5 Nov 2017 08:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbdKEImg (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 03:42:36 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:54941 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752751AbdKEImd (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2017 03:42:33 -0500
X-AuditID: 1207440e-be1ff70000007085-c4-59fecef5ad13
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 7F.36.28805.6FECEF95; Sun,  5 Nov 2017 03:42:30 -0500 (EST)
Received: from bagpipes.fritz.box (p4FC6E019.dip0.t-ipconnect.de [79.198.224.25])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id vA58gCD0018723
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 5 Nov 2017 03:42:28 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 9/9] refs: update some more docs to use "oid" rather than "sha1"
Date:   Sun,  5 Nov 2017 09:42:09 +0100
Message-Id: <0f10807a4bd186f5bc39a97197d3d34a2bec6f2e.1509870243.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1509870243.git.mhagger@alum.mit.edu>
References: <cover.1509870243.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqPv93L9Ig83/BC26rnQzWTT0XmG2
        +Pumi9Hi9or5zBZn3jQyOrB6/H3/gclj56y77B4XLyl7LH7g5fF5k1wAaxSXTUpqTmZZapG+
        XQJXxpq/FQU3vSpO3VzK1MC42qqLkZNDQsBEYsnua8xdjFwcQgI7mCTebJzKCJIQEjjBJHFi
        vQKIzSagK7Gop5kJxBYRUJOY2HaIBaSBWWAro8Tf7mZmkISwQLDE9uk7WUFsFgFViTeNF9lA
        bF6BKIk5p7uZILbJS5x7cBusnlPAQuLPx3lsEMvMJT592sk6gZFnASPDKka5xJzSXN3cxMyc
        4tRk3eLkxLy81CJdY73czBK91JTSTYyQsOHbwdi+XuYQowAHoxIP7wmPf5FCrIllxZW5hxgl
        OZiURHmvvPwTKcSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEN2gxUDlvSmJlVWpRPkxKmoNFSZxX
        bYm6n5BAemJJanZqakFqEUxWhoNDSYJXABgfQoJFqempFWmZOSUIaSYOTpDhPEDDH58FGV5c
        kJhbnJkOkT/FaMzxbObrBmaOaVdbm5iFWPLy81KlxHmPgZQKgJRmlObBTYPF/itGcaDnhHkv
        g1TxANMG3LxXQKuYgFbN5vgDsqokESEl1cAoLfOFMZZXeGWo4em/x1RO/Z7xuORd2fVT4fal
        v7sCZP63fPrQt+n+nyk59yefOCPVcPHixMP2U6Pnl944Jv9CMOXCxyKVRvFJc/SdDcMK62Zx
        1Nl6BPRKf1FS7L+T/0ZV5Rrn9g0c9ucEbG+EbvrWf2TXxeZDLvf6u10Ydm7ds2mtLSvvp8pI
        JZbijERDLeai4kQAkC0Z/dgCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c                |  2 +-
 refs.h                |  8 ++++----
 refs/files-backend.c  | 19 +++++++++----------
 refs/packed-backend.c |  2 +-
 refs/ref-cache.c      |  4 ++--
 refs/refs-internal.h  | 18 +++++++++---------
 6 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/refs.c b/refs.c
index 0d9a1348cd..339d4318ee 100644
--- a/refs.c
+++ b/refs.c
@@ -770,7 +770,7 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
 		if (cb->cutoff_cnt)
 			*cb->cutoff_cnt = cb->reccnt - 1;
 		/*
-		 * we have not yet updated cb->[n|o]sha1 so they still
+		 * we have not yet updated cb->[n|o]oid so they still
 		 * hold the values for the previous record.
 		 */
 		if (!is_null_oid(&cb->ooid)) {
diff --git a/refs.h b/refs.h
index d396012367..18582a408c 100644
--- a/refs.h
+++ b/refs.h
@@ -126,7 +126,7 @@ int peel_ref(const char *refname, struct object_id *oid);
 /**
  * Resolve refname in the nested "gitlink" repository in the specified
  * submodule (which must be non-NULL). If the resolution is
- * successful, return 0 and set sha1 to the name of the object;
+ * successful, return 0 and set oid to the name of the object;
  * otherwise, return a non-zero value.
  */
 int resolve_gitlink_ref(const char *submodule, const char *refname,
@@ -260,7 +260,7 @@ struct ref_transaction;
 
 /*
  * The signature for the callback function for the for_each_*()
- * functions below.  The memory pointed to by the refname and sha1
+ * functions below.  The memory pointed to by the refname and oid
  * arguments is only guaranteed to be valid for the duration of a
  * single callback invocation.
  */
@@ -354,7 +354,7 @@ int reflog_exists(const char *refname);
 
 /*
  * Delete the specified reference. If old_oid is non-NULL, then
- * verify that the current value of the reference is old_sha1 before
+ * verify that the current value of the reference is old_oid before
  * deleting it. If old_oid is NULL, delete the reference if it
  * exists, regardless of its old value. It is an error for old_oid to
  * be null_oid. msg and flags are passed through to
@@ -633,7 +633,7 @@ int ref_transaction_abort(struct ref_transaction *transaction,
  * It is a bug to call this function when there might be other
  * processes accessing the repository or if there are existing
  * references that might conflict with the ones being created. All
- * old_sha1 values must either be absent or NULL_SHA1.
+ * old_oid values must either be absent or null_oid.
  */
 int initial_ref_transaction_commit(struct ref_transaction *transaction,
 				   struct strbuf *err);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index bb10b715a8..2298f900dd 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -240,7 +240,7 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 			} else if (is_null_oid(&oid)) {
 				/*
 				 * It is so astronomically unlikely
-				 * that NULL_SHA1 is the SHA-1 of an
+				 * that null_oid is the OID of an
 				 * actual object that we consider its
 				 * appearance in a loose reference
 				 * file to be repo corruption
@@ -473,7 +473,7 @@ static void unlock_ref(struct ref_lock *lock)
  * are passed to refs_verify_refname_available() for this check.
  *
  * If mustexist is not set and the reference is not found or is
- * broken, lock the reference anyway but clear sha1.
+ * broken, lock the reference anyway but clear old_oid.
  *
  * Return 0 on success. On failure, write an error message to err and
  * return TRANSACTION_NAME_CONFLICT or TRANSACTION_GENERIC_ERROR.
@@ -1648,9 +1648,8 @@ static int files_log_ref_write(struct files_ref_store *refs,
 }
 
 /*
- * Write sha1 into the open lockfile, then close the lockfile. On
- * errors, rollback the lockfile, fill in *err and
- * return -1.
+ * Write oid into the open lockfile, then close the lockfile. On
+ * errors, rollback the lockfile, fill in *err and return -1.
  */
 static int write_ref_to_lockfile(struct ref_lock *lock,
 				 const struct object_id *oid, struct strbuf *err)
@@ -2272,7 +2271,7 @@ static int split_symref_update(struct files_ref_store *refs,
 
 	/*
 	 * Change the symbolic ref update to log only. Also, it
-	 * doesn't need to check its old SHA-1 value, as that will be
+	 * doesn't need to check its old OID value, as that will be
 	 * done when new_update is processed.
 	 */
 	update->flags |= REF_LOG_ONLY | REF_NO_DEREF;
@@ -2341,7 +2340,7 @@ static int check_old_oid(struct ref_update *update, struct object_id *oid,
  * Prepare for carrying out update:
  * - Lock the reference referred to by update.
  * - Read the reference under lock.
- * - Check that its old SHA-1 value (if specified) is correct, and in
+ * - Check that its old OID value (if specified) is correct, and in
  *   any case record it in update->lock->old_oid for later use when
  *   writing the reflog.
  * - If it is a symref update without REF_NO_DEREF, split it up into a
@@ -2396,7 +2395,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			/*
 			 * We won't be reading the referent as part of
 			 * the transaction, so we have to read it here
-			 * to record and possibly check old_sha1:
+			 * to record and possibly check old_oid:
 			 */
 			if (refs_read_ref_full(&refs->base,
 					       referent.buf, 0,
@@ -2416,7 +2415,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			/*
 			 * Create a new update for the reference this
 			 * symref is pointing at. Also, we will record
-			 * and verify old_sha1 for this update as part
+			 * and verify old_oid for this update as part
 			 * of processing the split-off update, so we
 			 * don't have to do it here.
 			 */
@@ -2436,7 +2435,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 
 		/*
 		 * If this update is happening indirectly because of a
-		 * symref update, record the old SHA-1 in the parent
+		 * symref update, record the old OID in the parent
 		 * update:
 		 */
 		for (parent_update = update->parent_update;
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 43ad74fc5a..72164a1d64 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -744,7 +744,7 @@ static int packed_read_raw_ref(struct ref_store *ref_store,
 /*
  * This value is set in `base.flags` if the peeled value of the
  * current reference is known. In that case, `peeled` contains the
- * correct peeled value for the reference, which might be `null_sha1`
+ * correct peeled value for the reference, which might be `null_oid`
  * if the reference is not a tag or if it is broken.
  */
 #define REF_KNOWS_PEELED 0x40
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 043eb83748..82c1cf90a7 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -260,8 +260,8 @@ int add_ref_entry(struct ref_dir *dir, struct ref_entry *ref)
 
 /*
  * Emit a warning and return true iff ref1 and ref2 have the same name
- * and the same sha1.  Die if they have the same name but different
- * sha1s.
+ * and the same oid. Die if they have the same name but different
+ * oids.
  */
 static int is_dup_ref(const struct ref_entry *ref1, const struct ref_entry *ref2)
 {
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f9c6e72c97..dd834314bd 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -15,13 +15,13 @@
  */
 
 /*
- * The reference should be updated to new_sha1.
+ * The reference should be updated to new_oid.
  */
 #define REF_HAVE_NEW (1 << 2)
 
 /*
  * The current reference's value should be checked to make sure that
- * it agrees with old_sha1.
+ * it agrees with old_oid.
  */
 #define REF_HAVE_OLD (1 << 3)
 
@@ -86,7 +86,7 @@ enum peel_status {
  * tag recursively until a non-tag is found.  If successful, store the
  * result to oid and return PEEL_PEELED.  If the object is not a tag
  * or is not valid, return PEEL_NON_TAG or PEEL_INVALID, respectively,
- * and leave sha1 unchanged.
+ * and leave oid unchanged.
  */
 enum peel_status peel_object(const struct object_id *name, struct object_id *oid);
 
@@ -98,11 +98,11 @@ enum peel_status peel_object(const struct object_id *name, struct object_id *oid
 int copy_reflog_msg(char *buf, const char *msg);
 
 /**
- * Information needed for a single ref update. Set new_sha1 to the new
- * value or to null_sha1 to delete the ref. To check the old value
- * while the ref is locked, set (flags & REF_HAVE_OLD) and set
- * old_sha1 to the old value, or to null_sha1 to ensure the ref does
- * not exist before update.
+ * Information needed for a single ref update. Set new_oid to the new
+ * value or to null_oid to delete the ref. To check the old value
+ * while the ref is locked, set (flags & REF_HAVE_OLD) and set old_oid
+ * to the old value, or to null_oid to ensure the ref does not exist
+ * before update.
  */
 struct ref_update {
 	/*
@@ -158,7 +158,7 @@ int ref_update_reject_duplicates(struct string_list *refnames,
 /*
  * Add a ref_update with the specified properties to transaction, and
  * return a pointer to the new object. This function does not verify
- * that refname is well-formed. new_sha1 and old_sha1 are only
+ * that refname is well-formed. new_oid and old_oid are only
  * dereferenced if the REF_HAVE_NEW and REF_HAVE_OLD bits,
  * respectively, are set in flags.
  */
-- 
2.14.1

