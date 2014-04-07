From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 22/27] struct ref_update: rename field "ref_name" to "refname"
Date: Mon,  7 Apr 2014 15:48:13 +0200
Message-ID: <1396878498-19887-23-git-send-email-mhagger@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:50:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9w0-0003S5-8a
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410AbaDGNtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:49:51 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:64179 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755378AbaDGNtH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:49:07 -0400
X-AuditID: 1207440f-f79326d000003c9f-61-5342acd3b146
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id BE.40.15519.3DCA2435; Mon,  7 Apr 2014 09:49:07 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJaT026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:49:05 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqHt5jVOwwYZ9nBY710lYdF3pZrJo
	6L3CbDHv7i4mi9sr5jNb/GjpYbb42LmA2YHd4+/7D0weO2fdZfe49PI7m8fHZ8vZPZ717mH0
	uHhJ2ePzJrkA9ihum6TEkrLgzPQ8fbsE7oz/L1+xFXTLViy5sJS9gXGFeBcjJ4eEgInEpE8T
	2SBsMYkL99YD2VwcQgKXGSWO/dzBDOEcY5LYsv4bWBWbgK7Eop5mJhBbREBNYmLbIRaQImaB
	K4wSVz5uZwFJCAsESrzqns4MYrMIqEp8nbufHcTmFXCVeHx1EzPEOjmJk8cms4LYnEDxGYdu
	MYLYQgIuEvfXHGOZwMi7gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuiV5uZoleakrpJkZI
	8PHvYOxaL3OIUYCDUYmHd8Uhx2Ah1sSy4srcQ4ySHExKorzPlzkFC/El5adUZiQWZ8QXleak
	Fh9ilOBgVhLh5VoNlONNSaysSi3Kh0lJc7AoifOqL1H3ExJITyxJzU5NLUgtgsnKcHAoSfC+
	BGkULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB0VHfDEwPkBSPEB754LtLS5IzAWK
	QrSeYlSUEuctAUkIgCQySvPgxsJSyitGcaAvhXmfg1TxANMRXPcroMFMQIMNXcEGlyQipKQa
	GGOi31889+DOSeHTb/wWbvsn6GN5mn/uklsmUjZzU4Kc9j3xmcx8vp+h7tm95EJWhcvts/Z+
	vOt8r2xtu7a23457Kex9kzjvH55lvvvHKqWJFhYOx/o/Xnn349678vxDJelNH3fn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245856>

This is consistent with the usual nomenclature.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 18 +++++++++---------
 refs.h |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 6984ff0..b6778aa 100644
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
@@ -3386,7 +3386,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 {
 	const struct ref_update * const *u1 = r1;
 	const struct ref_update * const *u2 = r2;
-	return strcmp((*u1)->ref_name, (*u2)->ref_name);
+	return strcmp((*u1)->refname, (*u2)->refname);
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
@@ -3394,14 +3394,14 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
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
@@ -3438,7 +3438,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Acquire all locks while verifying old values */
 	for (i = 0; i < n; i++) {
-		locks[i] = update_ref_lock(updates[i]->ref_name,
+		locks[i] = update_ref_lock(updates[i]->refname,
 					   (updates[i]->have_old ?
 					    updates[i]->old_sha1 : NULL),
 					   updates[i]->flags,
@@ -3453,7 +3453,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++)
 		if (!is_null_sha1(updates[i]->new_sha1)) {
 			ret = update_ref_write(msg,
-					       updates[i]->ref_name,
+					       updates[i]->refname,
 					       updates[i]->new_sha1,
 					       locks[i], onerr);
 			locks[i] = NULL; /* freed by update_ref_write */
diff --git a/refs.h b/refs.h
index cb799a3..0f08def 100644
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
1.9.1
