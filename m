Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C07020450
	for <e@80x24.org>; Sun,  5 Nov 2017 08:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbdKEImq (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 03:42:46 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:49011 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752660AbdKEIm2 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2017 03:42:28 -0500
X-AuditID: 1207440c-7e5ff7000000143e-77-59fecef1a5b8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 33.48.05182.1FECEF95; Sun,  5 Nov 2017 03:42:26 -0500 (EST)
Received: from bagpipes.fritz.box (p4FC6E019.dip0.t-ipconnect.de [79.198.224.25])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id vA58gCCv018723
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 5 Nov 2017 03:42:23 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 6/9] refs: rename constant `REF_NODEREF` to `REF_NO_DEREF`
Date:   Sun,  5 Nov 2017 09:42:06 +0100
Message-Id: <ac3f3fb4269ebef3d7c0bc1822d62a430b4f0e94.1509870243.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1509870243.git.mhagger@alum.mit.edu>
References: <cover.1509870243.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsUixO6iqPvp3L9Ig8P7DSy6rnQzWTT0XmG2
        +Pumi9Hi9or5zBZn3jQyOrB6/H3/gclj56y77B4XLyl7LH7g5fF5k1wAaxSXTUpqTmZZapG+
        XQJXxrrJ85gKJjcyVkw9OIWtgfFlWhcjJ4eEgIlE/7nXjF2MXBxCAjuYJC7+6mKDcE4wSczr
        a2IBqWIT0JVY1NPMBGKLCKhJTGw7xAJSxCywlVHib3czcxcjB4ewgK/ExJdRIDUsAqoSB19t
        YQOxeQWiJFZ/b2CH2CYvce7BbWYQm1PAQuLPx3lgNUIC5hKfPu1kncDIs4CRYRWjXGJOaa5u
        bmJmTnFqsm5xcmJeXmqRrqFebmaJXmpK6SZGSOjw7GD8tk7mEKMAB6MSD+8Jj3+RQqyJZcWV
        uYcYJTmYlER5r7z8EynEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhDdoMVA5b0piZVVqUT5MSpqD
        RUmcV3WJup+QQHpiSWp2ampBahFMVoODQ+Dukt4NjFIsefl5qUoSvNfOAg0RLEpNT61Iy8wp
        QShl4uAEWcQDtGg5SA1vcUFibnFmOkT+FKMxx7OZrxuYOaZdbW1iFgIbJyXOewykVACkNKM0
        D24aLC28YhQHelSY9zJIFQ8wpcDNewW0iglo1WyOPyCrShIRUlINjF5bE73fO29VYX0g+N3r
        94LSAxbuRsd/eJcfaHfdd/p9ugDbreSdZbz/1r+avPCLyvO/Tos/CZU1396nKi91nl9HZY//
        e2Et+eagcw+naP4Q+8HgHKuUp2J1r6Y96dRiY5HWuSW6QRzXWaaJRYa7z/lWVWrx7NLbaCnj
        PZ6izr29x1akZG8UUmIpzkg01GIuKk4EAAAUJVnmAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even after working with this code for years, I still see this constant
name as "ref node ref". Rename it to make it's meaning clearer.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/am.c           |  2 +-
 builtin/branch.c       |  2 +-
 builtin/checkout.c     |  2 +-
 builtin/clone.c        |  4 ++--
 builtin/notes.c        |  2 +-
 builtin/remote.c       |  6 +++---
 builtin/symbolic-ref.c |  2 +-
 builtin/update-ref.c   |  4 ++--
 refs.h                 |  6 +++---
 refs/files-backend.c   | 40 ++++++++++++++++++++--------------------
 refs/refs-internal.h   |  4 ++--
 sequencer.c            |  6 +++---
 12 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index c9bb14a6c2..894290e2d3 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2151,7 +2151,7 @@ static void am_abort(struct am_state *state)
 			   has_curr_head ? &curr_head : NULL, 0,
 			   UPDATE_REFS_DIE_ON_ERR);
 	else if (curr_branch)
-		delete_ref(NULL, curr_branch, NULL, REF_NODEREF);
+		delete_ref(NULL, curr_branch, NULL, REF_NO_DEREF);
 
 	free(curr_branch);
 	am_destroy(state);
diff --git a/builtin/branch.c b/builtin/branch.c
index b1ed649300..33fd5fcfd1 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -258,7 +258,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		}
 
 		if (delete_ref(NULL, name, is_null_oid(&oid) ? NULL : &oid,
-			       REF_NODEREF)) {
+			       REF_NO_DEREF)) {
 			error(remote_branch
 			      ? _("Error deleting remote-tracking branch '%s'")
 			      : _("Error deleting branch '%s'"),
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 463a337e5d..114028ee01 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -665,7 +665,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 		/* Nothing to do. */
 	} else if (opts->force_detach || !new->path) {	/* No longer on any branch. */
 		update_ref(msg.buf, "HEAD", &new->commit->object.oid, NULL,
-			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
+			   REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);
 		if (!opts->quiet) {
 			if (old->path &&
 			    advice_detached_head && !opts->force_detach)
diff --git a/builtin/clone.c b/builtin/clone.c
index 695bdd7046..557c6c3c06 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -689,7 +689,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
 	} else if (our) {
 		struct commit *c = lookup_commit_reference(&our->old_oid);
 		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
-		update_ref(msg, "HEAD", &c->object.oid, NULL, REF_NODEREF,
+		update_ref(msg, "HEAD", &c->object.oid, NULL, REF_NO_DEREF,
 			   UPDATE_REFS_DIE_ON_ERR);
 	} else if (remote) {
 		/*
@@ -697,7 +697,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
 		 * HEAD points to a branch but we don't know which one.
 		 * Detach HEAD in all these cases.
 		 */
-		update_ref(msg, "HEAD", &remote->old_oid, NULL, REF_NODEREF,
+		update_ref(msg, "HEAD", &remote->old_oid, NULL, REF_NO_DEREF,
 			   UPDATE_REFS_DIE_ON_ERR);
 	}
 }
diff --git a/builtin/notes.c b/builtin/notes.c
index 12afdf1907..d7754db143 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -686,7 +686,7 @@ static int merge_abort(struct notes_merge_options *o)
 
 	if (delete_ref(NULL, "NOTES_MERGE_PARTIAL", NULL, 0))
 		ret += error(_("failed to delete ref NOTES_MERGE_PARTIAL"));
-	if (delete_ref(NULL, "NOTES_MERGE_REF", NULL, REF_NODEREF))
+	if (delete_ref(NULL, "NOTES_MERGE_REF", NULL, REF_NO_DEREF))
 		ret += error(_("failed to delete ref NOTES_MERGE_REF"));
 	if (notes_merge_abort(o))
 		ret += error(_("failed to remove 'git notes merge' worktree"));
diff --git a/builtin/remote.c b/builtin/remote.c
index 0fddc64461..3d38c6150c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -693,7 +693,7 @@ static int mv(int argc, const char **argv)
 		read_ref_full(item->string, RESOLVE_REF_READING, &oid, &flag);
 		if (!(flag & REF_ISSYMREF))
 			continue;
-		if (delete_ref(NULL, item->string, NULL, REF_NODEREF))
+		if (delete_ref(NULL, item->string, NULL, REF_NO_DEREF))
 			die(_("deleting '%s' failed"), item->string);
 	}
 	for (i = 0; i < remote_branches.nr; i++) {
@@ -788,7 +788,7 @@ static int rm(int argc, const char **argv)
 	strbuf_release(&buf);
 
 	if (!result)
-		result = delete_refs("remote: remove", &branches, REF_NODEREF);
+		result = delete_refs("remote: remove", &branches, REF_NO_DEREF);
 	string_list_clear(&branches, 0);
 
 	if (skipped.nr) {
@@ -1255,7 +1255,7 @@ static int set_head(int argc, const char **argv)
 			head_name = xstrdup(states.heads.items[0].string);
 		free_remote_ref_states(&states);
 	} else if (opt_d && !opt_a && argc == 1) {
-		if (delete_ref(NULL, buf.buf, NULL, REF_NODEREF))
+		if (delete_ref(NULL, buf.buf, NULL, REF_NO_DEREF))
 			result |= error(_("Could not delete %s"), buf.buf);
 	} else
 		usage_with_options(builtin_remote_sethead_usage, options);
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 17aabaa679..80237f0df1 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -58,7 +58,7 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 			die("Cannot delete %s, not a symbolic ref", argv[0]);
 		if (!strcmp(argv[0], "HEAD"))
 			die("deleting '%s' is not allowed", argv[0]);
-		return delete_ref(NULL, argv[0], NULL, REF_NODEREF);
+		return delete_ref(NULL, argv[0], NULL, REF_NO_DEREF);
 	}
 
 	switch (argc) {
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index cf1552b478..4b4714b3fd 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -312,7 +312,7 @@ static const char *parse_cmd_verify(struct ref_transaction *transaction,
 static const char *parse_cmd_option(struct strbuf *input, const char *next)
 {
 	if (!strncmp(next, "no-deref", 8) && next[8] == line_termination)
-		update_flags |= REF_NODEREF;
+		update_flags |= REF_NO_DEREF;
 	else
 		die("option unknown: %s", next);
 	return next + 8;
@@ -427,7 +427,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	}
 
 	if (no_deref)
-		flags = REF_NODEREF;
+		flags = REF_NO_DEREF;
 	if (delete)
 		/*
 		 * For purposes of backwards compatibility, we treat
diff --git a/refs.h b/refs.h
index 261d46c10c..d396012367 100644
--- a/refs.h
+++ b/refs.h
@@ -476,7 +476,7 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  *         transaction.
  *
  *     flags -- flags affecting the update, passed to
- *         update_ref_lock(). Possible flags: REF_NODEREF,
+ *         update_ref_lock(). Possible flags: REF_NO_DEREF,
  *         REF_FORCE_CREATE_REFLOG. See those constants for more
  *         information.
  *
@@ -504,7 +504,7 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  * If this flag is not specified, then symbolic references are
  * dereferenced and the update is applied to the referent.
  */
-#define REF_NODEREF (1 << 0)
+#define REF_NO_DEREF (1 << 0)
 
 /*
  * Force the creation of a reflog for this reference, even if it
@@ -517,7 +517,7 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  * ref_transaction_update() and friends:
  */
 #define REF_TRANSACTION_UPDATE_ALLOWED_FLAGS \
-	(REF_NODEREF | REF_FORCE_CREATE_REFLOG)
+	(REF_NO_DEREF | REF_FORCE_CREATE_REFLOG)
 
 /*
  * Add a reference update to transaction. `new_oid` is the value that
diff --git a/refs/files-backend.c b/refs/files-backend.c
index bbeafe1db7..71e088e811 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -13,14 +13,14 @@
 /*
  * This backend uses the following flags in `ref_update::flags` for
  * internal bookkeeping purposes. Their numerical values must not
- * conflict with REF_NODEREF, REF_FORCE_CREATE_REFLOG, REF_HAVE_NEW,
+ * conflict with REF_NO_DEREF, REF_FORCE_CREATE_REFLOG, REF_HAVE_NEW,
  * REF_HAVE_OLD, or REF_ISPRUNING, which are also stored in
  * `ref_update::flags`.
  */
 
 /*
  * Used as a flag in ref_update::flags when a loose ref is being
- * pruned. This flag must only be used when REF_NODEREF is set.
+ * pruned. This flag must only be used when REF_NO_DEREF is set.
  */
 #define REF_ISPRUNING (1 << 4)
 
@@ -1044,7 +1044,7 @@ static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 		goto cleanup;
 	ref_transaction_add_update(
 			transaction, r->name,
-			REF_NODEREF | REF_HAVE_NEW | REF_HAVE_OLD | REF_ISPRUNING,
+			REF_NO_DEREF | REF_HAVE_NEW | REF_HAVE_OLD | REF_ISPRUNING,
 			&null_oid, &r->oid, NULL);
 	if (ref_transaction_commit(transaction, &err))
 		goto cleanup;
@@ -1133,7 +1133,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 		 */
 		if (ref_transaction_update(transaction, iter->refname,
 					   iter->oid, NULL,
-					   REF_NODEREF, NULL, &err))
+					   REF_NO_DEREF, NULL, &err))
 			die("failure preparing to create packed reference %s: %s",
 			    iter->refname, err.buf);
 
@@ -1336,7 +1336,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	}
 
 	if (!copy && refs_delete_ref(&refs->base, logmsg, oldrefname,
-			    &orig_oid, REF_NODEREF)) {
+			    &orig_oid, REF_NO_DEREF)) {
 		error("unable to delete old %s", oldrefname);
 		goto rollback;
 	}
@@ -1352,7 +1352,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 				RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
 				&oid, NULL) &&
 	    refs_delete_ref(&refs->base, NULL, newrefname,
-			    NULL, REF_NODEREF)) {
+			    NULL, REF_NO_DEREF)) {
 		if (errno == EISDIR) {
 			struct strbuf path = STRBUF_INIT;
 			int result;
@@ -1377,7 +1377,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	logmoved = log;
 
 	lock = lock_ref_oid_basic(refs, newrefname, NULL, NULL, NULL,
-				  REF_NODEREF, NULL, &err);
+				  REF_NO_DEREF, NULL, &err);
 	if (!lock) {
 		if (copy)
 			error("unable to copy '%s' to '%s': %s", oldrefname, newrefname, err.buf);
@@ -1400,7 +1400,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 
  rollback:
 	lock = lock_ref_oid_basic(refs, oldrefname, NULL, NULL, NULL,
-				  REF_NODEREF, NULL, &err);
+				  REF_NO_DEREF, NULL, &err);
 	if (!lock) {
 		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -1816,7 +1816,7 @@ static int files_create_symref(struct ref_store *ref_store,
 	int ret;
 
 	lock = lock_ref_oid_basic(refs, refname, NULL,
-				  NULL, NULL, REF_NODEREF, NULL,
+				  NULL, NULL, REF_NO_DEREF, NULL,
 				  &err);
 	if (!lock) {
 		error("%s", err.buf);
@@ -2200,7 +2200,7 @@ static int split_head_update(struct ref_update *update,
 
 	new_update = ref_transaction_add_update(
 			transaction, "HEAD",
-			update->flags | REF_LOG_ONLY | REF_NODEREF,
+			update->flags | REF_LOG_ONLY | REF_NO_DEREF,
 			&update->new_oid, &update->old_oid,
 			update->msg);
 
@@ -2219,8 +2219,8 @@ static int split_head_update(struct ref_update *update,
 
 /*
  * update is for a symref that points at referent and doesn't have
- * REF_NODEREF set. Split it into two updates:
- * - The original update, but with REF_LOG_ONLY and REF_NODEREF set
+ * REF_NO_DEREF set. Split it into two updates:
+ * - The original update, but with REF_LOG_ONLY and REF_NO_DEREF set
  * - A new, separate update for the referent reference
  * Note that the new update will itself be subject to splitting when
  * the iteration gets to it.
@@ -2275,7 +2275,7 @@ static int split_symref_update(struct files_ref_store *refs,
 	 * doesn't need to check its old SHA-1 value, as that will be
 	 * done when new_update is processed.
 	 */
-	update->flags |= REF_LOG_ONLY | REF_NODEREF;
+	update->flags |= REF_LOG_ONLY | REF_NO_DEREF;
 	update->flags &= ~REF_HAVE_OLD;
 
 	/*
@@ -2344,7 +2344,7 @@ static int check_old_oid(struct ref_update *update, struct object_id *oid,
  * - Check that its old SHA-1 value (if specified) is correct, and in
  *   any case record it in update->lock->old_oid for later use when
  *   writing the reflog.
- * - If it is a symref update without REF_NODEREF, split it up into a
+ * - If it is a symref update without REF_NO_DEREF, split it up into a
  *   REF_LOG_ONLY update of the symref and add a separate update for
  *   the referent to transaction.
  * - If it is an update of head_ref, add a corresponding REF_LOG_ONLY
@@ -2392,7 +2392,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	update->backend_data = lock;
 
 	if (update->type & REF_ISSYMREF) {
-		if (update->flags & REF_NODEREF) {
+		if (update->flags & REF_NO_DEREF) {
 			/*
 			 * We won't be reading the referent as part of
 			 * the transaction, so we have to read it here
@@ -2564,7 +2564,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	 * split_symref_update() or split_head_update(), those
 	 * functions will check that the new updates don't have the
 	 * same refname as any existing ones.) Also fail if any of the
-	 * updates use REF_ISPRUNING without REF_NODEREF.
+	 * updates use REF_ISPRUNING without REF_NO_DEREF.
 	 */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
@@ -2572,8 +2572,8 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 			string_list_append(&affected_refnames, update->refname);
 
 		if ((update->flags & REF_ISPRUNING) &&
-		    !(update->flags & REF_NODEREF))
-			BUG("REF_ISPRUNING set without REF_NODEREF");
+		    !(update->flags & REF_NO_DEREF))
+			BUG("REF_ISPRUNING set without REF_NO_DEREF");
 
 		/*
 		 * We store a pointer to update in item->util, but at
@@ -2651,7 +2651,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 
 			ref_transaction_add_update(
 					packed_transaction, update->refname,
-					REF_HAVE_NEW | REF_NODEREF,
+					REF_HAVE_NEW | REF_NO_DEREF,
 					&update->new_oid, NULL,
 					NULL);
 		}
@@ -2995,7 +2995,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	 * reference if --updateref was specified:
 	 */
 	lock = lock_ref_oid_basic(refs, refname, oid,
-				  NULL, NULL, REF_NODEREF,
+				  NULL, NULL, REF_NO_DEREF,
 				  &type, &err);
 	if (!lock) {
 		error("cannot lock ref '%s': %s", refname, err.buf);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 2ea02dcbe4..f9c6e72c97 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -9,7 +9,7 @@
 
 /*
  * The following flags can appear in `ref_update::flags`. Their
- * numerical values must not conflict with those of REF_NODEREF and
+ * numerical values must not conflict with those of REF_NO_DEREF and
  * REF_FORCE_CREATE_REFLOG, which are also stored in
  * `ref_update::flags`.
  */
@@ -119,7 +119,7 @@ struct ref_update {
 	struct object_id old_oid;
 
 	/*
-	 * One or more of REF_NODEREF, REF_FORCE_CREATE_REFLOG,
+	 * One or more of REF_NO_DEREF, REF_FORCE_CREATE_REFLOG,
 	 * REF_HAVE_NEW, REF_HAVE_OLD, or backend-specific flags.
 	 */
 	unsigned int flags;
diff --git a/sequencer.c b/sequencer.c
index 64abaad0e8..3b88ab2f9c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1116,11 +1116,11 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	 */
 	if (command == TODO_PICK && !opts->no_commit && (res == 0 || res == 1) &&
 	    update_ref(NULL, "CHERRY_PICK_HEAD", &commit->object.oid, NULL,
-		       REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
+		       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
 		res = -1;
 	if (command == TODO_REVERT && ((opts->no_commit && res == 0) || res == 1) &&
 	    update_ref(NULL, "REVERT_HEAD", &commit->object.oid, NULL,
-		       REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
+		       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
 		res = -1;
 
 	if (res) {
@@ -2125,7 +2125,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			msg = reflog_message(opts, "finish", "%s onto %s",
 				head_ref.buf, buf.buf);
 			if (update_ref(msg, head_ref.buf, &head, &orig,
-				       REF_NODEREF, UPDATE_REFS_MSG_ON_ERR)) {
+				       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
 				res = error(_("could not update %s"),
 					head_ref.buf);
 				goto cleanup_head_ref;
-- 
2.14.1

