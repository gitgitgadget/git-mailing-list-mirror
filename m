From: Avi Kivity <avi@qumranet.com>
Subject: [PATCH] Document git rev-list --first-parent
Date: Mon, 24 Dec 2007 10:20:50 +0200
Message-ID: <1198484450-16454-1-git-send-email-avi@qumranet.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 24 09:21:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6iYp-0003XK-IJ
	for gcvg-git-2@gmane.org; Mon, 24 Dec 2007 09:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbXLXIUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2007 03:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbXLXIUv
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Dec 2007 03:20:51 -0500
Received: from il.qumranet.com ([82.166.9.18]:54632 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797AbXLXIUv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2007 03:20:51 -0500
Received: by il.qumranet.com (Postfix, from userid 500)
	id 17F9DA0009; Mon, 24 Dec 2007 10:20:50 +0200 (IST)
X-Mailer: git-send-email 1.5.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69204>

Document git rev-list's --first-parent option.  Documentation taken from
git log.

Signed-off-by: Avi Kivity <avi@qumranet.com>
---
 Documentation/git-rev-list.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index a03f9fe..b049086 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 	     [ \--min-age=timestamp ]
 	     [ \--sparse ]
 	     [ \--no-merges ]
+	     [ \--first-parent ]
 	     [ \--remove-empty ]
 	     [ \--full-history ]
 	     [ \--not ]
@@ -256,6 +257,11 @@ limiting may be applied.
 
 	Do not print commits with more than one parent.
 
+--first-parent::
+	Follow only the first parent commit upon seeing a merge
+	commit.  This  option gives a better overview of the
+	evolution of a particular branch.
+
 --not::
 
 	Reverses the meaning of the '{caret}' prefix (or lack thereof)
-- 
1.5.3.7
