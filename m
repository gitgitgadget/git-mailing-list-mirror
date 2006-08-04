From: Uwe Zeisberger <Uwe_Zeisberger@digi.com>
Subject: [PATCH] Document rev-list's option --mergegit@vger.kernel.org
Date: Fri, 4 Aug 2006 10:11:15 +0200
Message-ID: <20060804081114.GA32338@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 04 10:11:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8umS-0007S8-UK
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 10:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161100AbWHDILg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 04:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161102AbWHDILg
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 04:11:36 -0400
Received: from mail29.messagelabs.com ([216.82.249.147]:23733 "HELO
	mail29.messagelabs.com") by vger.kernel.org with SMTP
	id S1161100AbWHDILf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 04:11:35 -0400
X-VirusChecked: Checked
X-Env-Sender: Uwe_Zeisberger@digi.com
X-Msg-Ref: server-22.tower-29.messagelabs.com!1154679094!22086593!1
X-StarScan-Version: 5.5.10.7; banners=-,-,-
X-Originating-IP: [66.77.174.21]
Received: (qmail 12649 invoked from network); 4 Aug 2006 08:11:34 -0000
Received: from unknown (HELO owa.digi.com) (66.77.174.21)
  by server-22.tower-29.messagelabs.com with SMTP; 4 Aug 2006 08:11:34 -0000
Received: from mtk-sms-mail01.digi.com ([10.10.8.120]) by owa.digi.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 4 Aug 2006 03:11:34 -0500
Received: from dor-sms-mail1.digi.com ([10.49.1.105]) by mtk-sms-mail01.digi.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 4 Aug 2006 03:11:33 -0500
Received: from io.fsforth.de ([192.168.40.169]) by dor-sms-mail1.digi.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 4 Aug 2006 10:11:32 +0200
Received: by io.fsforth.de (Postfix, from userid 1080)
	id 8A602E198; Fri,  4 Aug 2006 10:11:15 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
X-OriginalArrivalTime: 04 Aug 2006 08:11:32.0271 (UTC) FILETIME=[987CEBF0:01C6B79D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24780>

Signed-off-by: Uwe Zeisberger <Uwe_Zeisberger@digi.com>
---
The description is not very verbose, but at least it is mentioned now.

 Documentation/git-rev-list.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index f60eacd..dd9fff1 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -22,6 +22,7 @@ SYNOPSIS
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
 	     [ \--pretty | \--header ]
 	     [ \--bisect ]
+	     [ \--merge ]
 	     <commit>... [ \-- <paths>... ]
 
 DESCRIPTION
@@ -123,6 +124,10 @@ OPTIONS
 	topological order (i.e. descendant commits are shown
 	before their parents).
 
+--merge::
+	After a failed merge, show refs that touch files having a
+	conflict and don't exist on all heads to merge.
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
-- 
1.4.2.rc2.gb63f


-- 
Uwe Zeisberger
FS Forth-Systeme GmbH, A Digi International Company
Kueferstrasse 8, D-79206 Breisach, Germany
Phone: +49 (7667) 908 0 Fax: +49 (7667) 908 200
Web: www.fsforth.de, www.digi.com
