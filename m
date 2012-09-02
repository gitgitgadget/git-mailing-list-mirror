From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH 1/9] Update directory listing API doc to match code
Date: Sun,  2 Sep 2012 01:12:03 +0100
Message-ID: <1346544731-938-2-git-send-email-git@adamspiers.org>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 02:20:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7xvB-0001VH-A8
	for gcvg-git-2@plane.gmane.org; Sun, 02 Sep 2012 02:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754828Ab2IBATw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 20:19:52 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:55519 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167Ab2IBAS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 20:18:57 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id C733C2E5E3;
	Sun,  2 Sep 2012 01:12:12 +0100 (BST)
X-Mailer: git-send-email 1.7.12.155.ge5750d5.dirty
In-Reply-To: <1346544731-938-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204659>

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
1.7.12.155.ge5750d5.dirty
