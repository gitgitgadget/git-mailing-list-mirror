From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/11] update_ref(): improve documentation
Date: Sun,  8 Feb 2015 17:14:05 +0100
Message-ID: <1423412045-15616-12-git-send-email-mhagger@alum.mit.edu>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 17:21:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKUcK-0005yo-4x
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 17:21:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758688AbbBHQVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 11:21:47 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:45013 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753651AbbBHQVr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Feb 2015 11:21:47 -0500
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Feb 2015 11:21:46 EST
X-AuditID: 1207440c-f79376d00000680a-9e-54d78b676b9c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 43.54.26634.76B87D45; Sun,  8 Feb 2015 11:14:32 -0500 (EST)
Received: from michael.fritz.box (p4FC9719C.dip0.t-ipconnect.de [79.201.113.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t18GE9lF014021
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 8 Feb 2015 11:14:30 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqJvRfT3E4MpXFouuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLXr7PrFabN7czuLA7vH3/Qcmj52z7rJ7LNhU6nHxkrLH501yAaxR
	3DZJiSVlwZnpefp2CdwZD9Y2Mhd8Fqpo2XeErYFxMn8XIweHhICJxLv5UV2MnECmmMSFe+vZ
	uhi5OIQELjNKvDuygh3COcEkMW3CLTaQKjYBXYlFPc1MILaIgJrExLZDLCA2s8BqJomtd8Fq
	hAWsJFp7DoLFWQRUJZ5/XQsW5xVwldh6bR0TxDY5ifPHfzKD2JxA8SVvesFsIQEXiT23epkm
	MPIuYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrqJebWaKXmlK6iRESZDw7GL+tkznEKMDB
	qMTD2yF3PUSINbGsuDL3EKMkB5OSKO/RcKAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd5Fh6+F
	CPGmJFZWpRblw6SkOViUxHlVl6j7CQmkJ5akZqemFqQWwWRlODiUJHgNu4CGChalpqdWpGXm
	lCCkmTg4QYZzSYkUp+alpBYllpZkxIMiI74YGBsgKR6gvdtA2nmLCxJzgaIQracYFaXEeZNB
	EgIgiYzSPLixsNTxilEc6Eth3lSQKh5g2oHrfgU0mAlo8OKlV0AGlyQipKQaGGcZ5yWbrP5a
	M2OtV4fB3Ga/zvadUUErzdm/xciJrS3SleV+V3J45Xffv55TbdlPfxNjC7XacFGn+XyazrtD
	1dzl+8JWFEXvfbSI82j4bjvrf5FtGbp9iY9eHpR7c7z+LbdnP4uLcuW6m+vLxf9M 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263526>

Add a docstring for update_ref(), emphasizing its similarity to
ref_transaction_update(). Rename its parameters to match those of
ref_transaction_update().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |  8 ++++----
 refs.h | 15 +++++++++++----
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 0da680e..2651583 100644
--- a/refs.c
+++ b/refs.c
@@ -3739,8 +3739,8 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 				      flags, NULL, err);
 }
 
-int update_ref(const char *action, const char *refname,
-	       const unsigned char *sha1, const unsigned char *oldval,
+int update_ref(const char *msg, const char *refname,
+	       const unsigned char *new_sha1, const unsigned char *old_sha1,
 	       int flags, enum action_on_err onerr)
 {
 	struct ref_transaction *t;
@@ -3748,8 +3748,8 @@ int update_ref(const char *action, const char *refname,
 
 	t = ref_transaction_begin(&err);
 	if (!t ||
-	    ref_transaction_update(t, refname, sha1, oldval,
-				   flags, action, &err) ||
+	    ref_transaction_update(t, refname, new_sha1, old_sha1,
+				   flags, msg, &err) ||
 	    ref_transaction_commit(t, &err)) {
 		const char *str = "update_ref failed for ref '%s': %s";
 
diff --git a/refs.h b/refs.h
index 02d6e39..08abd2c 100644
--- a/refs.h
+++ b/refs.h
@@ -344,10 +344,17 @@ int ref_transaction_commit(struct ref_transaction *transaction,
  */
 void ref_transaction_free(struct ref_transaction *transaction);
 
-/** Lock a ref and then write its file */
-int update_ref(const char *action, const char *refname,
-		const unsigned char *sha1, const unsigned char *oldval,
-		int flags, enum action_on_err onerr);
+/**
+ * Lock, update, and unlock a single reference. This function
+ * basically does a transaction containing a single call to
+ * ref_transaction_update(). The parameters to this function have the
+ * same meaning as the corresponding parameters to
+ * ref_transaction_update(). Handle errors as requested by the `onerr`
+ * argument.
+ */
+int update_ref(const char *msg, const char *refname,
+	       const unsigned char *new_sha1, const unsigned char *old_sha1,
+	       int flags, enum action_on_err onerr);
 
 extern int parse_hide_refs_config(const char *var, const char *value, const char *);
 extern int ref_is_hidden(const char *);
-- 
2.1.4
