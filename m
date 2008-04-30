From: Florian Ragwitz <rafl@debian.org>
Subject: [PATCH] filter-branch: Documentation fix.
Date: Wed, 30 Apr 2008 09:47:43 +0200
Message-ID: <1209541663-21177-1-git-send-email-rafl@debian.org>
Cc: Florian Ragwitz <rafl@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 10:25:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr7cc-0003Wy-Kz
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 10:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756876AbYD3IYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 04:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756830AbYD3IYO
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 04:24:14 -0400
Received: from weedy.perldition.org ([85.10.210.75]:59149 "EHLO
	weedy.perldition.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756765AbYD3IYM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 04:24:12 -0400
X-Greylist: delayed 2184 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Apr 2008 04:24:12 EDT
Received: from p4fd74639.dip0.t-ipconnect.de ([79.215.70.57]:40656 helo=ata.xb.lan)
	by weedy.perldition.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60)
	(envelope-from <rafl@perldition.org>)
	id 1Jr71W-0003wK-O2; Wed, 30 Apr 2008 09:46:42 +0200
Received: from rafl by ata.xb.lan with local (Exim 4.69)
	(envelope-from <rafl@ata.xb.lan>)
	id 1Jr72V-0005WY-T6; Wed, 30 Apr 2008 09:47:43 +0200
X-Mailer: git-send-email 1.5.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80808>

It's --msg-filter, not --message-filter.

Signed-off-by: Florian Ragwitz <rafl@debian.org>
---
 Documentation/git-filter-branch.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 2a78549..6454e49 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -243,12 +243,12 @@ committed a merge between P1 and P2, it will be propagated properly
 and all children of the merge will become merge commits with P1,P2
 as their parents instead of the merge commit.
 
-You can rewrite the commit log messages using `--message-filter`.  For
+You can rewrite the commit log messages using `--msg-filter`.  For
 example, `git-svn-id` strings in a repository created by `git-svn` can
 be removed this way:
 
 -------------------------------------------------------
-git filter-branch --message-filter '
+git filter-branch --msg-filter '
 	sed -e "/^git-svn-id:/d"
 '
 -------------------------------------------------------
-- 
1.5.5.1
