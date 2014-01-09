From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 2/6] Update giteveryday.txt to fit man page formatting
Date: Thu,  9 Jan 2014 23:13:08 +0000
Message-ID: <1389309192-5748-3-git-send-email-philipoakley@iee.org>
References: <1389309192-5748-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 10 00:13:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1On4-0004Tw-3N
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 00:13:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756400AbaAIXNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 18:13:18 -0500
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:25602 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756165AbaAIXNL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jan 2014 18:13:11 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AngGAMssz1JOl3JU/2dsb2JhbABZgws4gwK3FYEPF3SCJgEFVjMISTkeBhOICMMmF48MhDcEqiyDLTw
X-IPAS-Result: AngGAMssz1JOl3JU/2dsb2JhbABZgws4gwK3FYEPF3SCJgEFVjMISTkeBhOICMMmF48MhDcEqiyDLTw
X-IronPort-AV: E=Sophos;i="4.95,634,1384300800"; 
   d="scan'208";a="94708968"
Received: from host-78-151-114-84.as13285.net (HELO localhost) ([78.151.114.84])
  by out1.ip07ir2.opaltelecom.net with ESMTP; 09 Jan 2014 23:12:59 +0000
X-Mailer: git-send-email 1.8.3.msysgit.0
In-Reply-To: <1389309192-5748-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240289>

Add standard man page section titles.
Also adjust anchor text markup for man page format.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/giteveryday.txt | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/Documentation/giteveryday.txt b/Documentation/giteveryday.txt
index 2a18c1f..2939458 100644
--- a/Documentation/giteveryday.txt
+++ b/Documentation/giteveryday.txt
@@ -1,22 +1,33 @@
+giteveryday(7)
+===============
+
+NAME
+----
+giteveryday - A useful minimum set of commands for Everyday Git 
+
+SYNOPSIS
+--------
+
 Everyday Git With 20 Commands Or So
-===================================
 
-<<Individual Developer (Standalone)>> commands are essential for
+DESCRIPTION
+-----------
+<<STANDALONE,Individual Developer (Standalone)>> commands are essential for
 anybody who makes a commit, even for somebody who works alone.
 
 If you work with other people, you will need commands listed in
-the <<Individual Developer (Participant)>> section as well.
+the <<PARTICIPANT,Individual Developer (Participant)>> section as well.
 
-People who play the <<Integrator>> role need to learn some more
+People who play the <<INTEGRATOR,Integrator>> role need to learn some more
 commands in addition to the above.
 
-<<Repository Administration>> commands are for system
+<<ADMINISTRATION,Repository Administration>> commands are for system
 administrators who are responsible for the care and feeding
 of Git repositories.
 
 
-Individual Developer (Standalone)[[Individual Developer (Standalone)]]
-----------------------------------------------------------------------
+Individual Developer (Standalone)[[STANDALONE]]
+-----------------------------------------------
 
 A standalone individual developer does not exchange patches with
 other people, and works alone in a single repository, using the
@@ -104,8 +115,8 @@ combined and include `--max-count=10` (show 10 commits),
 directory, since `v2.43` tag.
 
 
-Individual Developer (Participant)[[Individual Developer (Participant)]]
-------------------------------------------------------------------------
+Individual Developer (Participant)[[PARTICIPANT]]
+-------------------------------------------------
 
 A developer working as a participant in a group project needs to
 learn how to communicate with others, and uses these commands in
@@ -205,7 +216,7 @@ tag.
 without a formal "merging".
 
 
-Integrator[[Integrator]]
+Integrator[[INTEGRATOR]]
 ------------------------
 
 A fairly central person acting as the integrator in a group
@@ -292,8 +303,8 @@ everything `ko-next` has.
 <13> push the tag out, too.
 
 
-Repository Administration[[Repository Administration]]
-------------------------------------------------------
+Repository Administration[[ADMINISTRATION]]
+-------------------------------------------
 
 A repository administrator uses the following tools to set up
 and maintain access to the repository by developers.
@@ -411,3 +422,7 @@ ftp> cp -r .git /home/user/myproject.git
 +
 <1> make sure your info/refs and objects/info/packs are up-to-date
 <2> upload to public HTTP server hosted by your ISP.
+
+GIT
+---
+Part of the linkgit:git[1] suite
\ No newline at end of file
-- 
1.8.3.msysgit.0
