From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] In Examples, explain option -r and refer to git-rev-list[1]
Date: Sun, 26 Aug 2007 18:40:26 +0300
Organization: Private
Message-ID: <r6lqfgnp.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 26 17:36:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPKA8-0007z5-Ce
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 17:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbXHZPgZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 11:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbXHZPgZ
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 11:36:25 -0400
Received: from main.gmane.org ([80.91.229.2]:51781 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751879AbXHZPgY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 11:36:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IPKA2-0007ea-3T
	for git@vger.kernel.org; Sun, 26 Aug 2007 17:36:22 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 26 Aug 2007 17:36:22 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 26 Aug 2007 17:36:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:N4+ApgAg8ohg2Sdegq8fRSeQM7c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56691>

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-log.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 49bb539..aa42f0e 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -76,7 +76,8 @@ git log -r --name-status release..test::
 
 	Show the commits that are in the "test" branch but not yet
 	in the "release" branch, along with the list of paths
-	each commit modifies.
+	each commit modifies. Opton -r (see gitlink:git-rev-list[1])
+        descends recursively.
 
 Discussion
 ----------
-- 
1.5.3.rc5
