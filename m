From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH] Add 'git-p4 commit' as an alias for 'git-p4 submit'
Date: Tue,  9 Oct 2007 16:16:09 +0200
Message-ID: <1191939369-18811-1-git-send-email-marius@trolltech.com>
Cc: simon@lst.de, Marius Storm-Olsen <marius@trolltech.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 16:17:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfFtQ-0003ZD-4r
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 16:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbXJIOQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 10:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbXJIOQy
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 10:16:54 -0400
Received: from esparsett.troll.no ([62.70.27.18]:51102 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbXJIOQx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 10:16:53 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 189A874290; Tue,  9 Oct 2007 16:16:52 +0200 (CEST)
Received: from localhost.localdomain (vrang.troll.no [10.3.4.57])
	by esparsett.troll.no (Postfix) with ESMTP
	id 01FAA74235; Tue,  9 Oct 2007 16:16:52 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.4.1155.gfe96ee-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60415>

Given that git uses 'commit', git-p4's 'sumbit' was a bit confusing at times;
often making me do 'git submit' and 'git-p4 commit' instead.

Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
---
 contrib/fast-import/git-p4 |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 557649a..52cd2a4 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1651,6 +1651,7 @@ def printUsage(commands):
 commands = {
     "debug" : P4Debug,
     "submit" : P4Submit,
+    "commit" : P4Submit,
     "sync" : P4Sync,
     "rebase" : P4Rebase,
     "clone" : P4Clone,
-- 
1.5.3.4.1155.gfe96ee-dirty
