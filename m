From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/5] git tag: mention versionsort.prereleaseSuffix in manpage
Date: Thu, 23 Apr 2015 14:27:47 +0200
Message-ID: <1429792070-22991-3-git-send-email-mhagger@alum.mit.edu>
References: <1429792070-22991-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 14:28:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlGEs-0005wU-OS
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 14:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934435AbbDWM2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 08:28:12 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:45561 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934428AbbDWM2F (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2015 08:28:05 -0400
X-AuditID: 1207440c-f79376d00000680a-c6-5538e54f13df
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 87.BC.26634.F45E8355; Thu, 23 Apr 2015 08:27:59 -0400 (EDT)
Received: from michael.fritz.box (p4FC97208.dip0.t-ipconnect.de [79.201.114.8])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3NCRsfL011822
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 23 Apr 2015 08:27:58 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1429792070-22991-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsUixO6iqOv/1CLUYE0/h0XXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGfMOPKCsWANZ0X3hA/sDYwv
	2LsYOTgkBEwket8UdTFyApliEhfurWfrYuTiEBK4zCjR27iPFcI5ziTxfVIvE0gVm4CuxKKe
	ZjBbREBNYmLbIRYQm1nAQWLz50ZGEFtYwFfieccndhCbRUBVYvbaw2D1vAIuEjNPHGCH2CYn
	cf74T2YQm1PAVWL79DYwWwio5vOdO+wTGHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI1
	1MvNLNFLTSndxAgJFZ4djN/WyRxiFOBgVOLhdcizCBViTSwrrsw9xCjJwaQkynv2JlCILyk/
	pTIjsTgjvqg0J7X4EKMEB7OSCO+e20A53pTEyqrUonyYlDQHi5I4r+oSdT8hgfTEktTs1NSC
	1CKYrAwHh5IE76wnQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoMiILwbGBkiK
	B2hvJUg7b3FBYi5QFKL1FKOilDhvHUhCACSRUZoHNxaWAF4xigN9Kcz79jFQFQ8wecB1vwIa
	zAQ0eOZSsMEliQgpqQZGkdlTi4R5f4gwniu6cvPZxfnvl36ui3U/Vz6dg+vV1k1MBkdX/Ne/
	kHG1Pn1bMtfxN51hKmtdMkJnLVr18sLcBW0v46O2sE87Y3t8//v91lM17PVf3b+t7uKztGJ5
	077nYicOXFDULAspFVScqT5Ddt/3Hu4lDOsrZ9Yf3TmtR2PqprqmcNuiy0osxRmJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267686>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-tag.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index bfba4ef..f5b267e 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -98,10 +98,13 @@ OPTIONS
 --sort=<type>::
 	Sort in a specific order. Supported type is "refname"
 	(lexicographic order), "version:refname" or "v:refname" (tag
-	names are treated as versions). Prepend "-" to reverse sort
-	order. When this option is not given, the sort order defaults to the
-	value configured for the 'tag.sort' variable if it exists, or
-	lexicographic order otherwise. See linkgit:git-config[1].
+	names are treated as versions). The "version:refname" sort
+	order can also be affected by the
+	"versionsort.prereleaseSuffix" configuration variable. Prepend
+	"-" to reverse sort order. When this option is not given, the
+	sort order defaults to the value configured for the 'tag.sort'
+	variable if it exists, or lexicographic order otherwise. See
+	linkgit:git-config[1].
 
 --column[=<options>]::
 --no-column::
-- 
2.1.4
