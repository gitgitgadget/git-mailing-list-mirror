From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v2 01/14] Update directory listing API doc to match code
Date: Thu, 20 Sep 2012 20:46:10 +0100
Message-ID: <1348170383-15751-2-git-send-email-git@adamspiers.org>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
 <1348170383-15751-1-git-send-email-git@adamspiers.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 21:46:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEmhy-0000NV-G9
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 21:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699Ab2ITTq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 15:46:28 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:46168 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751Ab2ITTq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 15:46:27 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 5FC402E5DC;
	Thu, 20 Sep 2012 20:46:25 +0100 (BST)
X-Mailer: git-send-email 1.7.12.147.g6d168f4
In-Reply-To: <1348170383-15751-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206072>

7c4c97c0ac turned the flags in struct dir_struct into a single bitfield
variable, but forgot to update this document.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 Documentation/technical/api-directory-listing.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
index add6f43..0356d25 100644
--- a/Documentation/technical/api-directory-listing.txt
+++ b/Documentation/technical/api-directory-listing.txt
@@ -17,24 +17,24 @@ options are:
 	The name of the file to be read in each directory for excluded
 	files (typically `.gitignore`).
 
-`collect_ignored`::
+`flags`::
 
-	Include paths that are to be excluded in the result.
+	A bit-field of options:
 
-`show_ignored`::
+`DIR_SHOW_IGNORED`:::
 
 	The traversal is for finding just ignored files, not unignored
 	files.
 
-`show_other_directories`::
+`DIR_SHOW_OTHER_DIRECTORIES`:::
 
 	Include a directory that is not tracked.
 
-`hide_empty_directories`::
+`DIR_HIDE_EMPTY_DIRECTORIES`:::
 
 	Do not include a directory that is not tracked and is empty.
 
-`no_gitlinks`::
+`DIR_NO_GITLINKS`:::
 
 	If set, recurse into a directory that looks like a git
 	directory.  Otherwise it is shown as a directory.
-- 
1.7.12.147.g6d168f4
