From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 22/27] struct ref_update: Rename field "ref_name" to "refname"
Date: Mon, 24 Mar 2014 18:56:55 +0100
Message-ID: <1395683820-17304-23-git-send-email-mhagger@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:58:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS99A-0002Oo-7M
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851AbaCXR54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:57:56 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:43478 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753818AbaCXR5y (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 13:57:54 -0400
X-AuditID: 1207440c-f79656d000003eba-36-5330722134b1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 69.AF.16058.12270335; Mon, 24 Mar 2014 13:57:53 -0400 (EDT)
Received: from michael.fritz.box (p57A25F6C.dip0.t-ipconnect.de [87.162.95.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2OHv4xs028070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 24 Mar 2014 13:57:51 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqKtYZBBscGiltMXOdRIWXVe6mSwa
	eq8wW8y7u4vJ4vaK+cwWP1p6mC0+di5gdmD3+Pv+A5PHzll32T0uvfzO5vHx2XJ2j2e9exg9
	Ll5S9vi8SS6APYrbJimxpCw4Mz1P3y6BO+PNqkfMBd2yFZ1/PrM0MK4Q72Lk5JAQMJFoPP2U
	HcIWk7hwbz1bFyMXh5DAZUaJHfN6mCCcE0wSf+acYQapYhPQlVjU08wEYosIqElMbDvEAlLE
	LHCFUeLKx+0sIAlhgUCJlY2z2UBsFgFVidlPV4HFeQVcJU7OaWaEWCcnMeX3ArDVnEDxre2H
	wRYICbhI7PjYyzSBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1DvdzMEr3UlNJNjJDg
	49nB+G2dzCFGAQ5GJR7eCGODYCHWxLLiytxDjJIcTEqivGy5QCG+pPyUyozE4oz4otKc1OJD
	jBIczEoivJbhQDnelMTKqtSifJiUNAeLkjiv6hJ1PyGB9MSS1OzU1ILUIpisDAeHkgRvWCFQ
	o2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoOuKLgfEBkuIB2usA0s5bXJCYCxSF
	aD3FqCglznutACghAJLIKM2DGwtLKa8YxYG+FOZNAGnnAaYjuO5XQIOZgAaHN+mBDC5JREhJ
	NTDOUH9gOLdg8aJQh9P1Tgyq8lcrhPPLitzdvjwM3MmeyHTY76WCX4bbkt0T7ZelLi5Y79yx
	Wu3NYacvSXosPfydRqfXLdROC5Vy/hF7cMs0VvHrIgwWui+n2djnv5y759eFiYLl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244842>

This is consistent with the usual nomenclature.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 18 +++++++++---------
 refs.h |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index dfff117..d72d0ab 100644
--- a/refs.c
+++ b/refs.c
@@ -3274,7 +3274,7 @@ static int update_ref_write(const char *action, const char *refname,
  * value or to zero to ensure the ref does not exist before update.
  */
 struct ref_update {
-	const char *ref_name;
+	const char *refname;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
 	int flags; /* REF_NODEREF? */
@@ -3304,7 +3304,7 @@ static void ref_transaction_free(struct ref_transaction *transaction)
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
-		free((char *)update->ref_name);
+		free((char *)update->refname);
 		free(update);
 	}
 
@@ -3322,7 +3322,7 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 {
 	struct ref_update *update = xcalloc(1, sizeof(*update));
 
-	update->ref_name = xstrdup(refname);
+	update->refname = xstrdup(refname);
 	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
 	transaction->updates[transaction->nr++] = update;
 	return update;
@@ -3383,7 +3383,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 {
 	const struct ref_update * const *u1 = r1;
 	const struct ref_update * const *u2 = r2;
-	return strcmp((*u1)->ref_name, (*u2)->ref_name);
+	return strcmp((*u1)->refname, (*u2)->refname);
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
@@ -3391,14 +3391,14 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 {
 	int i;
 	for (i = 1; i < n; i++)
-		if (!strcmp(updates[i - 1]->ref_name, updates[i]->ref_name)) {
+		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
 			const char *str =
 				"Multiple updates for ref '%s' not allowed.";
 			switch (onerr) {
 			case UPDATE_REFS_MSG_ON_ERR:
-				error(str, updates[i]->ref_name); break;
+				error(str, updates[i]->refname); break;
 			case UPDATE_REFS_DIE_ON_ERR:
-				die(str, updates[i]->ref_name); break;
+				die(str, updates[i]->refname); break;
 			case UPDATE_REFS_QUIET_ON_ERR:
 				break;
 			}
@@ -3435,7 +3435,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Acquire all locks while verifying old values */
 	for (i = 0; i < n; i++) {
-		locks[i] = update_ref_lock(updates[i]->ref_name,
+		locks[i] = update_ref_lock(updates[i]->refname,
 					   (updates[i]->have_old ?
 					    updates[i]->old_sha1 : NULL),
 					   updates[i]->flags,
@@ -3450,7 +3450,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++)
 		if (!is_null_sha1(updates[i]->new_sha1)) {
 			ret = update_ref_write(msg,
-					       updates[i]->ref_name,
+					       updates[i]->refname,
 					       updates[i]->new_sha1,
 					       locks[i], onerr);
 			locks[i] = NULL; /* freed by update_ref_write */
diff --git a/refs.h b/refs.h
index 99c194b..30ee721 100644
--- a/refs.h
+++ b/refs.h
@@ -154,7 +154,7 @@ extern void unlock_ref(struct ref_lock *lock);
 extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
 
 /** Setup reflog before using. **/
-int log_ref_setup(const char *ref_name, char *logfile, int bufsize);
+int log_ref_setup(const char *refname, char *logfile, int bufsize);
 
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *refname, unsigned long at_time, int cnt,
-- 
1.9.0
