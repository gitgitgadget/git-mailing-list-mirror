From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v3 01/19] api-directory-listing.txt: update to match code
Date: Thu, 27 Dec 2012 02:32:20 +0000
Message-ID: <1356575558-2674-2-git-send-email-git@adamspiers.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 27 03:34:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To3ID-0006l1-0b
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 03:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921Ab2L0Ccm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 21:32:42 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:53761 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738Ab2L0Cck (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 21:32:40 -0500
Received: from localhost (host-2-103-56-128.as13285.net [2.103.56.128])
	by coral.adamspiers.org (Postfix) with ESMTPSA id DA0402E5E4
	for <git@vger.kernel.org>; Thu, 27 Dec 2012 02:32:39 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.2.249.g31c7954
In-Reply-To: <1356575558-2674-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212185>

7c4c97c0ac turned the flags in struct dir_struct into a single bitfield
variable, but forgot to update this document.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
For some reason this patch was dropped from the v2 series when it was
applied to the 'pu' branch.

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
1.7.11.2.249.g31c7954
