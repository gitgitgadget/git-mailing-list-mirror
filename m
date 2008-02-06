From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] INSTALL: git-merge no longer uses cpio
Date: Wed, 6 Feb 2008 07:03:53 +0000
Message-ID: <20080206070353.6559.qmail@2b033f98573ecd.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 08:04:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMeKH-0004dj-4T
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 08:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856AbYBFHDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 02:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754303AbYBFHDg
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 02:03:36 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:44786 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753761AbYBFHDg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 02:03:36 -0500
Received: (qmail 6560 invoked by uid 1000); 6 Feb 2008 07:03:53 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72760>

Since a64d7784e830b3140e7d0f2b45cb3d8fafb84cca git merge doesn't use cpio
anymore, adapt the documentation.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 INSTALL |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/INSTALL b/INSTALL
index f1eb404..6f3bcb4 100644
--- a/INSTALL
+++ b/INSTALL
@@ -79,8 +79,8 @@ Issues of note:
 	- "perl" and POSIX-compliant shells are needed to use most of
 	  the barebone Porcelainish scripts.
 
-	- "cpio" is used by git-merge for saving and restoring the index,
-	  and by git-clone when doing a local (possibly hardlinked) clone.
+	- "cpio" is used by git-clone when doing a local (possibly
+	  hardlinked) clone.
 
  - Some platform specific issues are dealt with Makefile rules,
    but depending on your specific installation, you may not
-- 
1.5.4
