From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/5] Documentation: bisect: reformat some paragraphs.
Date: Sat, 24 Mar 2007 06:29:58 +0100
Message-ID: <20070324062958.12bb520c.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 24 06:22:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUyhT-0006pE-OB
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 06:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbXCXFVp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 01:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbXCXFVp
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 01:21:45 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:60706 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751766AbXCXFVo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 01:21:44 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 7D0DBB5A3C;
	Sat, 24 Mar 2007 06:21:42 +0100 (CET)
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42975>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-bisect.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index b7cd715..a77fbe8 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -122,17 +122,17 @@ like this:
 $ git bisect start arch/i386 include/asm-i386
 ------------
 
-If you have a script that can tell if the current
-source code is good or bad, you can automatically bisect using:
+If you have a script that can tell if the current source code is good
+or bad, you can automatically bisect using:
 
 ------------
 $ git bisect run my_script
 ------------
 
-Note that the "run" script (`my_script` in the above example)
-should exit with code 0 in
-case the current source code is good and with a code between 1 and 127
-(included) in case the current source code is bad.
+Note that the "run" script (`my_script` in the above example) should
+exit with code 0 in case the current source code is good and with a
+code between 1 and 127 (included) in case the current source code is
+bad.
 
 Any other exit code (a program that does "exit(-1)" leaves $? = 255,
 see exit(3) manual page, the value is chopped with "& 0377") will
-- 
1.5.1.rc1.14.ge96a-dirty
