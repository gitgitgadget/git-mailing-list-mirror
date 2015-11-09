From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 02/11] verify_refname_available(): rename function
Date: Mon,  9 Nov 2015 18:03:39 +0100
Message-ID: <178f98e23cf3d515d34e0e739a1d610ad83c1f9a.1447085798.git.mhagger@alum.mit.edu>
References: <cover.1447085798.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 18:11:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zvpyc-00060m-5D
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 18:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbbKIRL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 12:11:26 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:62819 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751957AbbKIRLX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 12:11:23 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Nov 2015 12:11:23 EST
X-AuditID: 1207440e-f79516d0000012b3-c7-5640d208fecc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 72.34.04787.802D0465; Mon,  9 Nov 2015 12:04:08 -0500 (EST)
Received: from michael.fritz.box (p4FC97689.dip0.t-ipconnect.de [79.201.118.137])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA9H41Yp026059
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 9 Nov 2015 12:04:06 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1447085798.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqMtxySHMYMEjMYv5m04wWnRd6Way
	aOi9wmwxacpNJovbK+YzW/xo6WG26O37xGrxb0KNA4fH3/cfmDx2zrrL7rFgU6nH2YOZHs96
	9zB6XLyk7LHg+X12j8+b5AI4orhtkhJLyoIz0/P07RK4M6aeiiq4r1wxY+pXlgbG/TJdjJwc
	EgImErO+PGCEsMUkLtxbz9bFyMUhJHCZUWLfzAlsIAkhgRNMEtfPF4LYbAK6Eot6mplAbBEB
	NYmJbYdYQBqYBRYySazcvAcsISzgKrGs5TMriM0ioCrxc+kLFhCbVyBKYt3BKVDb5CSm3G8H
	q+cUsJDYceIfI8Qyc4mJq9YwTWDkXcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11gvN7NE
	LzWldBMjJBD5djC2r5c5xCjAwajEwxsx0z5MiDWxrLgy9xCjJAeTkihv9AmHMCG+pPyUyozE
	4oz4otKc1OJDjBIczEoivAW7gHK8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZ
	GQ4OJQneTReAGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBkRFfDIwNkBQP0N4d
	IO28xQWJuUBRiNZTjIpS4rziF4ESAiCJjNI8uLGw9PKKURzoS2HezyDtPMDUBNf9CmgwE9Dg
	pf5gg0sSEVJSDYyiiv9u+UllPbq5RGThJdFXc+OzmVU3LwydqLgmem7s1Z/Kqgd4fUP1e4+4
	c5iUJHlPX1LXqNa9y6o98gwDywyj0+qsUQeKXyltkr93MKes8OQJv5QNN7Yvsd5u 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281064>

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
