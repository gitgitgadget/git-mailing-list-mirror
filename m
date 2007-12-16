From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 6/6] whitespace: fix config.txt description of indent-with-non-tab
Date: Sun, 16 Dec 2007 11:31:42 -0500
Message-ID: <1197822702-5262-7-git-send-email-bfields@citi.umich.edu>
References: <B54C9483-90BE-4B45-A3B7-39FACF0E9F62@wincent.com>
 <1197822702-5262-1-git-send-email-bfields@citi.umich.edu>
 <1197822702-5262-2-git-send-email-bfields@citi.umich.edu>
 <1197822702-5262-3-git-send-email-bfields@citi.umich.edu>
 <1197822702-5262-4-git-send-email-bfields@citi.umich.edu>
 <1197822702-5262-5-git-send-email-bfields@citi.umich.edu>
 <1197822702-5262-6-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 17:32:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3wPX-0006dk-V1
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 17:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933175AbXLPQbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 11:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933208AbXLPQbw
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 11:31:52 -0500
Received: from mail.fieldses.org ([66.93.2.214]:60087 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933049AbXLPQbo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 11:31:44 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1J3wP1-0001Qt-55; Sun, 16 Dec 2007 11:31:43 -0500
X-Mailer: git-send-email debian.1.5.3.7.1-dirty
In-Reply-To: <1197822702-5262-6-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68467>

Fix garbled description.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/config.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fabe7f8..ce16fc7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -307,7 +307,7 @@ core.whitespace::
   before a tab character in the initial indent part of the line as an
   error (enabled by default).
 * `indent-with-non-tab` treats a line that is indented with 8 or more
-  space characters that can be replaced with tab characters.
+  space characters as an error (not enabled by default).
 
 alias.*::
 	Command aliases for the gitlink:git[1] command wrapper - e.g.
-- 
1.5.4.rc0.41.gf723
