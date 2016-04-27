From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/29] remove_dir_recursively(): add docstring
Date: Wed, 27 Apr 2016 18:57:19 +0200
Message-ID: <275274daa6126a8896b76ab3fca55d6e4a684948.1461768689.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 19:00:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSop-0004Mm-HE
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 19:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843AbcD0Q6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:58:09 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:59397 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752363AbcD0Q6H (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:07 -0400
X-AuditID: 12074413-487ff700000008c7-74-5720ef9e935f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id B3.48.02247.E9FE0275; Wed, 27 Apr 2016 12:58:06 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6F022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:04 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqDvvvUK4wZ1Z7BbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oxpnw+yFrzmquhZ+5i5gfEGRxcjJ4eEgInE1/ut
	TF2MXBxCAlsZJWauv8wKkhASOM4kcfqiBIjNJqArsainmQnEFhFwkFi+8hc7SAOzQBOTxPfl
	TSwgCWEBO4mHp6axg9gsAqoS13q+M4LYvAJREq07X7FCbJOTuDz9ARuIzSlgIfGl9S0jxDJz
	iSUPVrNPYORZwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXXC83s0QvNaV0EyMkxIR3MO46
	KXeIUYCDUYmHt0BCIVyINbGsuDL3EKMkB5OSKO+Ss0AhvqT8lMqMxOKM+KLSnNTiQ4wSHMxK
	IrzT3wDleFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvOXvgBoFi1LT
	UyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQTEQXwyMApAUD9DeUpB23uKCxFygKETrKUZF
	KXHeBSAJAZBERmke3FhY4njFKA70pTDvVJAqHmDSget+BTSYCWjw5UOyIINLEhFSUg2MKW08
	c4uef9uw2rNqw1rZqq4+ic2Cwbt1G9ev+b2XsTeg9LCrk5/49xIlKaNvPR2RHQHaJw7P+ud7
	z1WowmH6zt4dvmuudu3IWbt/+6pohqtXJzo8itlYome9t+6kXGx5GOOK8JKC0knq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292770>

Add a docstring for the remove_dir_recursively() function and the
REMOVE_DIR_* flags that can be passed to it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 dir.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/dir.h b/dir.h
index 301b737..5f19acc 100644
--- a/dir.h
+++ b/dir.h
@@ -262,9 +262,32 @@ extern int is_empty_dir(const char *dir);
 
 extern void setup_standard_excludes(struct dir_struct *dir);
 
+
+/* Constants for remove_dir_recursively: */
+
+/*
+ * If a non-directory is found within path, stop and return an error.
+ * (In this case some empty directories might already have been
+ * removed.)
+ */
 #define REMOVE_DIR_EMPTY_ONLY 01
+
+/*
+ * If any Git work trees are found within path, skip them without
+ * considering it an error.
+ */
 #define REMOVE_DIR_KEEP_NESTED_GIT 02
+
+/* Remove the contents of path, but leave path itself. */
 #define REMOVE_DIR_KEEP_TOPLEVEL 04
+
+/*
+ * Remove path and its contents, recursively. flags is a combination
+ * of the above REMOVE_DIR_* constants. Return 0 on success.
+ *
+ * This function uses path as temporary scratch space, but restores it
+ * before returning.
+ */
 extern int remove_dir_recursively(struct strbuf *path, int flag);
 
 /* tries to remove the path with empty directories along it, ignores ENOENT */
-- 
2.8.1
