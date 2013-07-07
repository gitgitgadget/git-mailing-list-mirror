From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Documentation: finding $(prefix)/etc/gitconfig when prefix = /usr
Date: Mon,  8 Jul 2013 00:00:02 +0200
Message-ID: <1373234402-6856-1-git-send-email-robin.rosenberg@dewire.com>
Cc: gitster@pobox.com, Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 08 00:06:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvx6L-0001VE-MK
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 00:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248Ab3GGWGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 18:06:34 -0400
Received: from smtp-gw11.han.skanova.net ([81.236.55.20]:59972 "EHLO
	smtp-gw11.han.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171Ab3GGWGd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 18:06:33 -0400
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jul 2013 18:06:33 EDT
Received: from localhost.localdomain (78.69.107.197) by smtp-gw11.han.skanova.net (8.5.133)
        id 516D05D201CA9B5E; Mon, 8 Jul 2013 00:00:11 +0200
X-Mailer: git-send-email 1.8.3.rc0.19.g7e6a0cc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229808>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 Documentation/git-config.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 9ae2508..3198d52 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -107,7 +107,8 @@ See also <<FILES>>.
 
 --system::
 	For writing options: write to system-wide $(prefix)/etc/gitconfig
-	rather than the repository .git/config.
+	rather than the repository .git/config. However, $(prefix) is /usr
+	then /etc/gitconfig is used.
 +
 For reading options: read only from system-wide $(prefix)/etc/gitconfig
 rather than from all available files.
@@ -214,7 +215,8 @@ $XDG_CONFIG_HOME/git/config::
 	file was added fairly recently.
 
 $(prefix)/etc/gitconfig::
-	System-wide configuration file.
+	System-wide configuration file, unless $(prefix) is /usr. In the
+	latter case /etc/gitconfig is used.
 
 If no further options are given, all reading options will read all of these
 files that are available. If the global or the system-wide configuration
-- 
1.8.3.rc0.19.g7e6a0cc
