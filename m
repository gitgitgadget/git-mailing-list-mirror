From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] gitk(1): mention --all
Date: Wed, 20 Sep 2006 12:23:41 +0200
Message-ID: <20060920102341.GB26173@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Sep 20 12:23:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPzF8-0004fx-1t
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 12:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWITKXr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 06:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbWITKXr
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 06:23:47 -0400
Received: from [130.225.96.91] ([130.225.96.91]:61637 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751014AbWITKXq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 06:23:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 68C9F7700A5
	for <git@vger.kernel.org>; Wed, 20 Sep 2006 12:23:43 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19068-01 for <git@vger.kernel.org>; Wed, 20 Sep 2006 12:23:42 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 3CA7277009E
	for <git@vger.kernel.org>; Wed, 20 Sep 2006 12:23:42 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 3818C6DF845
	for <git@vger.kernel.org>; Wed, 20 Sep 2006 12:21:51 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 2306362A34; Wed, 20 Sep 2006 12:23:42 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27336>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/gitk.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

Someone on #git asked for --all and it probably deserves to be mentioned
in gitk(1).

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 23be005..f1aeb07 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -37,6 +37,10 @@ frequently used options.
 
 	Show commits older than a specific date.
 
+--all::
+
+	Show all branches.
+
 <revs>::
 
 	Limit the revisions to show. This can be either a single revision
@@ -63,6 +67,11 @@ gitk --since="2 weeks ago" \-- gitk::
 	The "--" is necessary to avoid confusion with the *branch* named
 	'gitk'
 
+gitk --max-count=100 --all -- Makefile::
+
+	Show at most 100 changes made to the file 'Makefile'. Instead of only
+	looking for changes in the current branch look in all branches.
+
 See Also
 --------
 'qgit(1)'::
-- 
1.4.2.1.gca4e

-- 
Jonas Fonseca
