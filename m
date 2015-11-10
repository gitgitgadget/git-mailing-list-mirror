From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v8 01/10] verify_refname_available(): rename function
Date: Tue, 10 Nov 2015 12:42:31 +0100
Message-ID: <199f6d001f9b28b9734d1d145ec4b0c90353b723.1447154711.git.mhagger@alum.mit.edu>
References: <cover.1447154711.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 12:43:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zw7KY-0000ZR-JU
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 12:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbbKJLnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 06:43:11 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:60562 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752033AbbKJLnF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2015 06:43:05 -0500
X-AuditID: 1207440f-f79df6d000007c0f-a8-5641d83daf77
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id CD.F7.31759.D38D1465; Tue, 10 Nov 2015 06:42:53 -0500 (EST)
Received: from michael.fritz.box (p4FC97D33.dip0.t-ipconnect.de [79.201.125.51])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tAABglj5014324
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 10 Nov 2015 06:42:51 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1447154711.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42IRYndR1LW94RhmsOW6iMX8TScYLbqudDNZ
	NPReYbaYNOUmk8XtFfOZLX609DBbzLxqbdHb94nV4t+EGgdOj7/vPzB57Jx1l91jwaZSj7MH
	Mz2e9e5h9Lh4Sdlj/9JtbB4Lnt9n9/i8SS6AM4rbJimxpCw4Mz1P3y6BO2PqqaiC+8oVM6Z+
	ZWlg3C/TxcjJISFgItHU9ZMZwhaTuHBvPVsXIxeHkMBlRomZpyeyQzgnmCR2dh9mB6liE9CV
	WNTTzARiiwioSUxsO8QCUsQscI1J4syT6SwgCWEBV4nbK7YxgtgsAqoSV773soLYvAJREnf7
	FrFCrJOTmHK/HWgQBwengIXE3HMZIGEhAXOJ4+0TGScw8i5gZFjFKJeYU5qrm5uYmVOcmqxb
	nJyYl5dapGuil5tZopeaUrqJERKa/DsYu9bLHGIU4GBU4uGd8M0hTIg1say4MvcQoyQHk5Io
	7/5TjmFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHjtXwCV86YkVlalFuXDpKQ5WJTEedWXqPsJ
	CaQnlqRmp6YWpBbBZGU4OJQkeNmvAw0VLEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmI
	B0VGfDEwNkBSPEB7868BtfMWFyTmAkUhWk8xKkqJ824DSQiAJDJK8+DGwhLOK0ZxoC+FedlA
	tvMAkxVc9yugwUxAg5f6gzxUXJKIkJJqYHRivMWr+PulTGhZgUPk2XfMNn839243TlxQMSFr
	vb+i9pTV/Xpvg01+vX432fynWKDt3DtBag7/tu3NXriJQ7q5WXHWYVatdNsj7xbz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281109>

From: Ronnie Sahlberg <sahlberg@google.com>

Rename verify_refname_available() to verify_refname_available_dir() to
make the old name available for a more general purpose.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/refs.c b/refs.c
index 132eff5..0617e0c 100644
--- a/refs.c
+++ b/refs.c
@@ -279,7 +279,7 @@ struct ref_dir {
  * presence of an empty subdirectory does not block the creation of a
  * similarly-named reference.  (The fact that reference names with the
  * same leading components can conflict *with each other* is a
- * separate issue that is regulated by verify_refname_available().)
+ * separate issue that is regulated by verify_refname_available_dir().)
  *
  * Please note that the name field contains the fully-qualified
  * reference (or subdirectory) name.  Space could be saved by only
@@ -911,11 +911,11 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
  *
  * extras and skip must be sorted.
  */
-static int verify_refname_available(const char *refname,
-				    const struct string_list *extras,
-				    const struct string_list *skip,
-				    struct ref_dir *dir,
-				    struct strbuf *err)
+static int verify_refname_available_dir(const char *refname,
+					const struct string_list *extras,
+					const struct string_list *skip,
+					struct ref_dir *dir,
+					struct strbuf *err)
 {
 	const char *slash;
 	int pos;
@@ -2465,8 +2465,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		strbuf_git_path(&orig_ref_file, "%s", orig_refname);
 		if (remove_empty_directories(&orig_ref_file)) {
 			last_errno = errno;
-			if (!verify_refname_available(orig_refname, extras, skip,
-						      get_loose_refs(&ref_cache), err))
+			if (!verify_refname_available_dir(orig_refname, extras, skip,
+							  get_loose_refs(&ref_cache), err))
 				strbuf_addf(err, "there are still refs under '%s'",
 					    orig_refname);
 			goto error_return;
@@ -2479,8 +2479,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	if (!refname) {
 		last_errno = errno;
 		if (last_errno != ENOTDIR ||
-		    !verify_refname_available(orig_refname, extras, skip,
-					      get_loose_refs(&ref_cache), err))
+		    !verify_refname_available_dir(orig_refname, extras, skip,
+						  get_loose_refs(&ref_cache), err))
 			strbuf_addf(err, "unable to resolve reference %s: %s",
 				    orig_refname, strerror(last_errno));
 
@@ -2493,8 +2493,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * our refname.
 	 */
 	if (is_null_oid(&lock->old_oid) &&
-	    verify_refname_available(refname, extras, skip,
-				     get_packed_refs(&ref_cache), err)) {
+	    verify_refname_available_dir(refname, extras, skip,
+					 get_packed_refs(&ref_cache), err)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -3127,10 +3127,10 @@ static int rename_ref_available(const char *oldname, const char *newname)
 	int ret;
 
 	string_list_insert(&skip, oldname);
-	ret = !verify_refname_available(newname, NULL, &skip,
-					get_packed_refs(&ref_cache), &err)
-		&& !verify_refname_available(newname, NULL, &skip,
-					     get_loose_refs(&ref_cache), &err);
+	ret = !verify_refname_available_dir(newname, NULL, &skip,
+					    get_packed_refs(&ref_cache), &err)
+		&& !verify_refname_available_dir(newname, NULL, &skip,
+						 get_loose_refs(&ref_cache), &err);
 	if (!ret)
 		error("%s", err.buf);
 
@@ -4376,12 +4376,12 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 		if ((update->flags & REF_HAVE_OLD) &&
 		    !is_null_sha1(update->old_sha1))
 			die("BUG: initial ref transaction with old_sha1 set");
-		if (verify_refname_available(update->refname,
-					     &affected_refnames, NULL,
-					     loose_refs, err) ||
-		    verify_refname_available(update->refname,
-					     &affected_refnames, NULL,
-					     packed_refs, err)) {
+		if (verify_refname_available_dir(update->refname,
+						 &affected_refnames, NULL,
+						 loose_refs, err) ||
+		    verify_refname_available_dir(update->refname,
+						 &affected_refnames, NULL,
+						 packed_refs, err)) {
 			ret = TRANSACTION_NAME_CONFLICT;
 			goto cleanup;
 		}
-- 
2.6.2
