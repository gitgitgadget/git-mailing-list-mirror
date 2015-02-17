From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 13/13] refs.h: Remove duplication in function docstrings
Date: Tue, 17 Feb 2015 18:00:23 +0100
Message-ID: <1424192423-27979-14-git-send-email-mhagger@alum.mit.edu>
References: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:01:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNlWH-0003v4-P7
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 18:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbbBQRA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 12:00:57 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:62409 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752343AbbBQRAx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2015 12:00:53 -0500
X-AuditID: 12074413-f79f26d0000030e7-4a-54e373c45482
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 58.5B.12519.4C373E45; Tue, 17 Feb 2015 12:00:52 -0500 (EST)
Received: from michael.fritz.box (p5DDB008A.dip0.t-ipconnect.de [93.219.0.138])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1HH0TXi000419
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Feb 2015 12:00:51 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1424192423-27979-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqHuk+HGIwfUuHYuuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLXr7PrFabN7czuLA7vH3/Qcmj52z7rJ7LNhU6nHxkrLH501yAaxR
	3DZJiSVlwZnpefp2CdwZb9/cYio4ql7R8v4GSwPjdPkuRk4OCQETiRt7lrFA2GISF+6tZ+ti
	5OIQErjMKPH7w0UWCOc4k0Rrzzo2kCo2AV2JRT3NTCC2iICaxMS2Q2DdzAKrmSS23gWrERbw
	lni76gd7FyMHB4uAqsTWxQYgYV4BV4kLmw6xQSyTkzh//CcziM0JFF/2axk7iC0k4CIxv2M2
	0wRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM31cjNL9FJTSjcxQoJMeAfjrpNyhxgF
	OBiVeHgtJjwKEWJNLCuuzD3EKMnBpCTKywkMUSG+pPyUyozE4oz4otKc1OJDjBIczEoivEEp
	QDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgRvWxFQo2BRanpqRVpm
	TglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoMuKLgbEBkuIB2psF0s5bXJCYCxSFaD3FqCglzpsC
	khAASWSU5sGNhaWOV4ziQF8K864DqeIBph247ldAg5mABs//8whkcEkiQkqqgbFmpaP71En3
	OWd/iO4w2W7W0V2/4Uyfw8JJL2JW+FmwJ7pulUvtS9U+qLn9/8myzOozty9mHcrTW/1mXedX
	j8USHiXzl2e9rg3eYyEod+Hspfpk7scVJcJrT5YXSd16K9N5eSeL+NJD4t9a0hnn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263961>

Add more information to the comment introducing the four reference
transaction update functions, so that each function's docstring
doesn't have to repeat it. Add a pointer from the individual
functions' docstrings to the introductory comment.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.h | 66 +++++++++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/refs.h b/refs.h
index bb9d7b5..cf642e6 100644
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
