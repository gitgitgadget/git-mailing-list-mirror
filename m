From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] git(7): move gitk(1) to the list of porcelain commands
Date: Fri, 1 Sep 2006 01:15:38 +0200
Message-ID: <20060831231538.GF482@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Sep 01 01:15:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIvlC-0005gW-SA
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 01:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWHaXPn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 19:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWHaXPn
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 19:15:43 -0400
Received: from [130.225.96.91] ([130.225.96.91]:49295 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S964815AbWHaXPn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 19:15:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 379BC77004C
	for <git@vger.kernel.org>; Fri,  1 Sep 2006 01:15:40 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08706-17 for <git@vger.kernel.org>; Fri,  1 Sep 2006 01:15:39 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 07579770007
	for <git@vger.kernel.org>; Fri,  1 Sep 2006 01:15:39 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 243B66DF893
	for <git@vger.kernel.org>; Fri,  1 Sep 2006 01:14:12 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id CD29162A06; Fri,  1 Sep 2006 01:15:38 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26288>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/git.txt |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

... in lack of a better place to put it.

Anyway, last patch from me for tonight.

diff --git a/Documentation/git.txt b/Documentation/git.txt
index a9c87e3..76b41c8 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -303,6 +303,9 @@ gitlink:git-format-patch[1]::
 gitlink:git-grep[1]::
 	Print lines matching a pattern.
 
+gitlink:gitk[1]::
+	The git repository browser.
+
 gitlink:git-log[1]::
 	Shows commit logs.
 
@@ -483,13 +486,6 @@ gitlink:git-stripspace[1]::
 	Filter out empty lines.
 
 
-Commands not yet documented
----------------------------
-
-gitlink:gitk[1]::
-	The gitk repository browser.
-
-
 Configuration Mechanism
 -----------------------
 
-- 
Jonas Fonseca
