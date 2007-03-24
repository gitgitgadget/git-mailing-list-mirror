From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/5] Documentation: bisect: reword one paragraph.
Date: Sat, 24 Mar 2007 06:31:16 +0100
Message-ID: <20070324063116.1576005e.chriscool@tuxfamily.org>
References: <20070324061201.1b508fdb.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 24 06:23:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUyiX-0007N1-3L
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 06:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbXCXFXD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 01:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753380AbXCXFXC
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 01:23:02 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:60750 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752285AbXCXFXA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 01:23:00 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id BF7C4B55D3;
	Sat, 24 Mar 2007 06:22:59 +0100 (CET)
In-Reply-To: <20070324061201.1b508fdb.chriscool@tuxfamily.org>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42979>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-bisect.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index a77fbe8..4bd468e 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -134,9 +134,9 @@ exit with code 0 in case the current source code is good and with a
 code between 1 and 127 (included) in case the current source code is
 bad.
 
-Any other exit code (a program that does "exit(-1)" leaves $? = 255,
-see exit(3) manual page, the value is chopped with "& 0377") will
-abort the automatic bisect process.
+Any other exit code will abort the automatic bisect process. (A
+program that does "exit(-1)" leaves $? = 255, see exit(3) manual page,
+the value is chopped with "& 0377".)
 
 You may often find that during bisect you want to have near-constant
 tweaks (e.g., s/#define DEBUG 0/#define DEBUG 1/ in a header file, or
-- 
1.5.1.rc1.14.ge96a-dirty
