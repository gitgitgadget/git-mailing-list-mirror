From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 20/26] struct ref_update: Rename field "ref_name" to "refname"
Date: Mon, 10 Mar 2014 13:46:37 +0100
Message-ID: <1394455603-2968-21-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:47:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzcO-0007t1-Eb
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753600AbaCJMrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:47:37 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:59269 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753112AbaCJMr3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:47:29 -0400
X-AuditID: 12074413-f79076d000002d17-68-531db460da54
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 0A.96.11543.064BD135; Mon, 10 Mar 2014 08:47:28 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwi025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:47:27 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqJuwRTbYYOEBU4ud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd8akn++YC1pkK058ncfcwLhIvIuRk0NCwETi4NVl
	LBC2mMSFe+vZuhi5OIQELjNKPFs/gRnCOcEk8fR9D1gVm4CuxKKeZiYQW0RATWJi2yEWkCJm
	gSuMEp+//mIHSQgL+Ems6HzFCmKzCKhKvH3QDNbMK+AicXbncTaIdXISU34vAKvnBIpPv/IA
	zBYScJZ4uaeZdQIj7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuuZ6uZkleqkppZsYIcEn
	vINx10m5Q4wCHIxKPLwH3soEC7EmlhVX5h5ilORgUhLlnbhWNliILyk/pTIjsTgjvqg0J7X4
	EKMEB7OSCG/mYqAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mC9/Bm
	oEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UHTEFwPjAyTFA7R3G0g7b3FBYi5Q
	FKL1FKOilDjvHJCEAEgiozQPbiwspbxiFAf6Upi3FaSKB5iO4LpfAQ1mAhrcfFwKZHBJIkJK
	qoGxTvrQjjcbHrbvFhKKUOjf9NxqjnM9g/J0FU2t1da77K5/OpV/Pnx17s7d5s45v9tcWtfO
	CpJOvvCmUGa9bvLcqi455yPLTpkKlotc3Vd8p+zba+vdaxgSL2+8v81R5uUpxe8r 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243742>

This is consistent with the usual nomenclature.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 18 +++++++++---------
 refs.h |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 91af0a0..5d08cdf 100644
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
@@ -3304,7 +3304,7 @@ void free_ref_transaction(struct ref_transaction *transaction)
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
-		free((char *)update->ref_name);
+		free((char *)update->refname);
 		free(update);
 	}
 
@@ -3317,7 +3317,7 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 {
 	struct ref_update *update = xcalloc(1, sizeof(*update));
 
-	update->ref_name = xstrdup(refname);
+	update->refname = xstrdup(refname);
 	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
 	transaction->updates[transaction->nr++] = update;
 	return update;
@@ -3375,7 +3375,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 {
 	const struct ref_update * const *u1 = r1;
 	const struct ref_update * const *u2 = r2;
-	return strcmp((*u1)->ref_name, (*u2)->ref_name);
+	return strcmp((*u1)->refname, (*u2)->refname);
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
@@ -3383,14 +3383,14 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
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
@@ -3427,7 +3427,7 @@ int commit_ref_transaction(struct ref_transaction *transaction,
 
 	/* Acquire all locks while verifying old values */
 	for (i = 0; i < n; i++) {
-		locks[i] = update_ref_lock(updates[i]->ref_name,
+		locks[i] = update_ref_lock(updates[i]->refname,
 					   (updates[i]->have_old ?
 					    updates[i]->old_sha1 : NULL),
 					   updates[i]->flags,
@@ -3442,7 +3442,7 @@ int commit_ref_transaction(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++)
 		if (!is_null_sha1(updates[i]->new_sha1)) {
 			ret = update_ref_write(msg,
-					       updates[i]->ref_name,
+					       updates[i]->refname,
 					       updates[i]->new_sha1,
 					       locks[i], onerr);
 			locks[i] = NULL; /* freed by update_ref_write */
diff --git a/refs.h b/refs.h
index b1f8b74..cc24213 100644
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
