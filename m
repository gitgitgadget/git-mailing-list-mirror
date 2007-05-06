From: Michael Spang <mspang@uwaterloo.ca>
Subject: [PATCH 3/3] Fix minor documentation errors
Date: Sun, 06 May 2007 14:09:34 -0400
Message-ID: <463E19DE.8070305@uwaterloo.ca>
References: <463E1705.2090201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 06 20:09:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HklB6-00068r-Py
	for gcvg-git@gmane.org; Sun, 06 May 2007 20:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880AbXEFSJp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 14:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754871AbXEFSJp
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 14:09:45 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:63891 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754880AbXEFSJo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 14:09:44 -0400
Received: from [10.100.100.102] (rn-wan3a10.uwaterloo.ca [129.97.219.111])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id l46I9efe023575
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 May 2007 14:09:41 -0400 (EDT)
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <463E1705.2090201@gmail.com>
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Sun, 06 May 2007 14:09:41 -0400 (EDT)
X-Miltered: at minos with ID 463E19E4.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: ClamAV version 0.90.2, clamav-milter version 0.90.2 on localhost
X-Virus-Status: Clean
X-UUID: 3847232d-d806-4d26-85e4-26709bb6f7f6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46355>

- git-ls-files.txt: typo in description of --ignored
- git-clean.txt: s/forceRequire/requireForce/

Signed-off-by: Michael Spang <mspang@uwaterloo.ca>
---
 Documentation/git-clean.txt    |    2 +-
 Documentation/git-ls-files.txt |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 5aff026..e3252d5 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -26,7 +26,7 @@ OPTIONS
 	Remove untracked directories in addition to untracked files.
 
 -f::
-	If the git configuration specifies clean.forceRequire as true,
+	If the git configuration specifies clean.requireForce as true,
 	git-clean will refuse to run unless given -f or -n.
 
 -n::
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 79e0b7b..076cebc 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -42,8 +42,8 @@ OPTIONS
 	Show other files in the output
 
 -i|--ignored::
-	Show ignored files in the output
-	Note the this also reverses any exclude list present.
+	Show ignored files in the output.
+	Note that this also reverses any exclude list present.
 
 -s|--stage::
 	Show stage files in the output
