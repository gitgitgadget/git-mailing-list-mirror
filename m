From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 12/12] refs.h: Remove duplication in function docstrings
Date: Thu, 12 Feb 2015 12:12:23 +0100
Message-ID: <1423739543-1025-13-git-send-email-mhagger@alum.mit.edu>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 12:13:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLrhh-0004Bo-Bm
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 12:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755631AbbBLLMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 06:12:53 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:56114 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755609AbbBLLMu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2015 06:12:50 -0500
X-AuditID: 12074412-f79e46d0000036b4-28-54dc8ab182cc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 53.52.14004.1BA8CD45; Thu, 12 Feb 2015 06:12:49 -0500 (EST)
Received: from michael.fritz.box (p4FC96396.dip0.t-ipconnect.de [79.201.99.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1CBCT7f003107
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 12 Feb 2015 06:12:48 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqLux606Iwe9V6hZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvT2fWK12Ly5ncWB3ePv+w9MHjtn3WX3WLCp1OPiJWWPz5vkAlij
	uG2SEkvKgjPT8/TtErgzzpw+xFxwVL1iwtQvLA2M0+W7GDk5JARMJJqmv2eHsMUkLtxbzwZi
	CwlcZpSY/FC5i5ELyD7BJHHg1A1mkASbgK7Eop5mJhBbREBNYmLbIRYQm1lgNZPE1rtgzcIC
	3hKbWiczgtgsAqoStxvegsV5BVwkbvzezgaxTE7i/PGfYDM5geLvLjUwQix2ltjVtoV1AiPv
	AkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Znq5mSV6qSmlmxghQSa0g3H9SblDjAIcjEo8
	vCtM74QIsSaWFVfmHmKU5GBSEuXlagUK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuH1bQLK8aYk
	VlalFuXDpKQ5WJTEeX8uVvcTEkhPLEnNTk0tSC2CycpwcChJ8JZ3AjUKFqWmp1akZeaUIKSZ
	ODhBhnNJiRSn5qWkFiWWlmTEgyIjvhgYGyApHqC9YiDtvMUFiblAUYjWU4yKUuK8mSAJAZBE
	Rmke3FhY6njFKA70pTDvHZAqHmDaget+BTSYCWjwxBm3QQaXJCKkpBoY595wvza151Nozw6P
	Jz//lc5vVGH4X9czwzZkzc9/PB/Ktk/4tvDdgRX9YiK7SpV+1605cO/U3IL7a7lEVJsZdwv/
	u7WF78lm849h1xX3z7qWxv3rctx5ffaQ3vy3B473vGz5Z75w4cTpAi8y9/LYblvW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263723>

Add more information to the comment introducing the four reference
transaction update functions, so that each function's docstring
doesn't have to repeat it. Add a pointer from the individual
functions' docstrings to the introductory comment.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.h | 66 +++++++++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/refs.h b/refs.h
index 08abd2c..4c5e3d2 100644
--- a/refs.h
+++ b/refs.h
@@ -255,11 +255,31 @@ enum action_on_err {
 struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 
 /*
- * The following functions add a reference check or update to a
- * ref_transaction.  In all of them, refname is the name of the
- * reference to be affected.  The functions make internal copies of
- * refname and msg, so the caller retains ownership of these parameters.
- * flags can be REF_NODEREF; it is passed to update_ref_lock().
+ * Reference transaction updates
+ *
+ * The following four functions add a reference check or update to a
+ * ref_transaction.  They have some common similar parameters:
+ *
+ *     transaction -- a pointer to an open ref_transaction, obtained
+ *         from ref_transaction_begin().
+ *
+ *     refname -- the name of the reference to be affected.
+ *
+ *     flags -- flags affecting the update, passed to
+ *         update_ref_lock(). Can be REF_NODEREF, which means that
+ *         symbolic references should not be followed.
+ *
+ *     msg -- a message describing the change (for the reflog).
+ *
+ *     err -- a strbuf for receiving a description of any error that
+ *         might have occured.
+ *
+ * The functions make internal copies of refname and msg, so the
+ * caller retains ownership of these parameters.
+ *
+ * The functions return 0 on success and non-zero on failure. A
+ * failure means that the transaction as a whole has failed and needs
+ * to be rolled back.
  */
 
 /*
@@ -273,9 +293,8 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  * whole transaction fails. If old_sha1 is NULL, then the previous
  * value is not checked.
  *
- * Return 0 on success and non-zero on failure. Any failure in the
- * transaction means that the transaction as a whole has failed and
- * will need to be rolled back.
+ * See the above comment "Reference transaction updates" for more
+ * information.
  */
 int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
@@ -285,13 +304,13 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   struct strbuf *err);
 
 /*
- * Add a reference creation to transaction.  new_sha1 is the value
- * that the reference should have after the update; it must not be the
- * null SHA-1.  It is verified that the reference does not exist
+ * Add a reference creation to transaction. new_sha1 is the value that
+ * the reference should have after the update; it must not be
+ * null_sha1. It is verified that the reference does not exist
  * already.
- * Function returns 0 on success and non-zero on failure. A failure to create
- * means that the transaction as a whole has failed and will need to be
- * rolled back.
+ *
+ * See the above comment "Reference transaction updates" for more
+ * information.
  */
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
@@ -300,12 +319,12 @@ int ref_transaction_create(struct ref_transaction *transaction,
 			   struct strbuf *err);
 
 /*
- * Add a reference deletion to transaction.  If old_sha1 is non-NULL, then
- * it holds the value that the reference should have had before
- * the update (which must not be the null SHA-1).
- * Function returns 0 on success and non-zero on failure. A failure to delete
- * means that the transaction as a whole has failed and will need to be
- * rolled back.
+ * Add a reference deletion to transaction. If old_sha1 is non-NULL,
+ * then it holds the value that the reference should have had before
+ * the update (which must not be null_sha1).
+ *
+ * See the above comment "Reference transaction updates" for more
+ * information.
  */
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
@@ -316,9 +335,10 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 /*
  * Verify, within a transaction, that refname has the value old_sha1,
  * or, if old_sha1 is null_sha1, then verify that the reference
- * doesn't exist. old_sha1 must be non-NULL. Function returns 0 on
- * success and non-zero on failure. A failure to verify means that the
- * transaction as a whole has failed and will need to be rolled back.
+ * doesn't exist. old_sha1 must be non-NULL.
+ *
+ * See the above comment "Reference transaction updates" for more
+ * information.
  */
 int ref_transaction_verify(struct ref_transaction *transaction,
 			   const char *refname,
-- 
2.1.4
