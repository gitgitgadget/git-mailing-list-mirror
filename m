From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 6/7] gitview.txt: improve asciidoc markup
Date: Fri, 25 Aug 2006 03:06:50 +0200
Message-ID: <20060825010650.GG4069@diku.dk>
References: <20060818084545.GB4717@diku.dk> <7virkqbcq3.fsf@assigned-by-dhcp.cox.net> <20060825005655.GB4069@diku.dk> <20060825005820.GC4069@diku.dk> <20060825010149.GD4069@diku.dk> <20060825010458.GE4069@diku.dk> <20060825010548.GF4069@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 25 03:07:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGQA5-00060T-Iq
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 03:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422808AbWHYBGz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 21:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422809AbWHYBGz
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 21:06:55 -0400
Received: from [130.225.96.91] ([130.225.96.91]:22673 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1422808AbWHYBGy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Aug 2006 21:06:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id CE15D77007C;
	Fri, 25 Aug 2006 03:06:51 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26330-01; Fri, 25 Aug 2006 03:06:50 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 367AB770079;
	Fri, 25 Aug 2006 03:06:50 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 136796DF84F; Fri, 25 Aug 2006 03:05:32 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 20579629FB; Fri, 25 Aug 2006 03:06:50 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060825010548.GF4069@diku.dk>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25989>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 contrib/gitview/gitview.txt |   56 +++++++++++++++++++++++++------------------
 1 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/contrib/gitview/gitview.txt b/contrib/gitview/gitview.txt
index 6924df2..77c29de 100644
--- a/contrib/gitview/gitview.txt
+++ b/contrib/gitview/gitview.txt
@@ -7,40 +7,50 @@ gitview - A GTK based repository browser
 
 SYNOPSIS
 --------
-'gitview'  [options] [args]
+'gitview' [options] [args]
 
 DESCRIPTION
 ---------
 
-Dependencies
+Dependencies:
 
 * Python 2.4
 * PyGTK 2.8 or later
 * PyCairo 1.0 or later
 
 OPTIONS
-------
-	--without-diff
-		If the user doesn't want to list the commit diffs in the main window. This may speed up the repository browsing.
-
-	<args>
-		All the valid option for git-rev-list(1)
-	Key Bindings:
-	F4:
-		To maximize the window
-	F5:
-		To reread references.
-	F11:
-		Full screen
-	F12:
-		Leave full screen
+-------
+--without-diff::
+
+	If the user doesn't want to list the commit diffs in the main window.
+	This may speed up the repository browsing.
+
+<args>::
+
+	All the valid option for gitlink:git-rev-list[1].
+
+Key Bindings
+------------
+F4::
+	To maximize the window
+
+F5::
+	To reread references.
+
+F11::
+	Full screen
+
+F12::
+	Leave full screen
 
 EXAMPLES
-------
-	gitview v2.6.12.. include/scsi drivers/scsi
-	  Show as the changes since version v2.6.12 that changed any file in the include/scsi
-	  or drivers/scsi subdirectories
+--------
+
+gitview v2.6.12.. include/scsi drivers/scsi::
+
+	Show as the changes since version v2.6.12 that changed any file in the
+	include/scsi or drivers/scsi subdirectories
 
-	gitview --since=2.weeks.ago
-	  Show the changes during the last two weeks
+gitview --since=2.weeks.ago::
 
+	Show the changes during the last two weeks
-- 
1.4.2.GIT

-- 
Jonas Fonseca
