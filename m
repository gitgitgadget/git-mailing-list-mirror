From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 13/20] try_remove_empty_parents(): rename parameter "name" -> "refname"
Date: Tue, 16 Feb 2016 14:22:26 +0100
Message-ID: <0fc53be1c243e22809289c8893b867b8b7a7aaa2.1455626201.git.mhagger@alum.mit.edu>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 14:30:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfhr-0002qY-WC
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbcBPNaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 08:30:14 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:65361 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932338AbcBPNaM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 08:30:12 -0500
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Feb 2016 08:30:11 EST
X-AuditID: 1207440e-c03ff70000000398-59-56c322bb4569
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 09.B2.00920.BB223C65; Tue, 16 Feb 2016 08:23:07 -0500 (EST)
Received: from michael.fritz.box (p548D6919.dip0.t-ipconnect.de [84.141.105.25])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1GDMfOZ028717
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Feb 2016 08:23:06 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1455626201.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqLtb6XCYwYMv+hbzN51gtOi60s1k
	0dB7hdniw9pDbBa9k3tZLW6vmM9s8aOlh9mB3ePv+w9MHk+3T2H2eHG+wuNZ7x5Gj4uXlD0W
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8amCXvYC2ZwVPxa+5O5gXE3WxcjJ4eEgInEtX3T
	GbsYuTiEBLYySqz7+IsdwjnBJLF4y20WkCo2AV2JRT3NTCC2iICaxMS2QywgRcwCjxgluvZv
	B2rn4BAWCJc48EUfpIZFQFXi0osGVhCbVyBKYtXbVnaIbXISLT92g8U5BSwkTrb0gs0XEjCX
	uPNlD9MERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9XIzS/RSU0o3MUJCjG8HY/t6
	mUOMAhyMSjy8HB6HwoRYE8uKK3MPMUpyMCmJ8vJwHw4T4kvKT6nMSCzOiC8qzUktPsQowcGs
	JML77xVQOW9KYmVValE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJgveTItBQwaLU
	9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFAMxBcDowAkxQO0Nw2knbe4IDEXKArReopR
	UUqcdz9IQgAkkVGaBzcWljheMYoDfSnMexykigeYdOC6XwENZgIanHMJ5KHikkSElFQDo5qc
	enxIosHMj7NWV9o7b/pZLXp5+xu5x7IfrBbMX99dOHGZTrmsXNX+RBXb5++/qMjxsRwMDt+a
	Ic974ejpJ1fOLhErF86t3KVTZC4y6/bi+LyHNSzfT3+/F979ymLWUacnZj1lOuLc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286373>

This is the standard nomenclature.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9c13653..7e870fc 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2200,13 +2200,13 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 
 /*
  * Remove empty parents, but spare refs/ and immediate subdirs.
- * Note: munges *name.
+ * Note: munges *refname.
  */
-static void try_remove_empty_parents(char *name)
+static void try_remove_empty_parents(char *refname)
 {
 	char *p, *q;
 	int i;
-	p = name;
+	p = refname;
 	for (i = 0; i < 2; i++) { /* refs/{heads,tags,...}/ */
 		while (*p && *p != '/')
 			p++;
@@ -2224,7 +2224,7 @@ static void try_remove_empty_parents(char *name)
 		if (q == p)
 			break;
 		*q = '\0';
-		if (rmdir(git_path("%s", name)))
+		if (rmdir(git_path("%s", refname)))
 			break;
 	}
 }
-- 
2.7.0
