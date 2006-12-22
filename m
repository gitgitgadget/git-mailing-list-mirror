From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Use git-merge-file in git-merge-one-file, too
Date: Fri, 22 Dec 2006 03:20:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612220320340.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Dec 22 03:21:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxa1s-0004Yj-3W
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 03:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945911AbWLVCU5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 21:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945916AbWLVCU5
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 21:20:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:36557 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1945911AbWLVCU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 21:20:56 -0500
Received: (qmail invoked by alias); 22 Dec 2006 02:20:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 22 Dec 2006 03:20:55 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35120>


Would you believe? I edited git-merge-one-file (note the missing ".sh"!)
when I submitted the patch which became commit e2b7008752...

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-merge-one-file.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index c49e4c6..7d62d79 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -104,7 +104,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 	# Be careful for funny filename such as "-L" in "$4", which
 	# would confuse "merge" greatly.
 	src1=`git-unpack-file $2`
-	merge "$src1" "$orig" "$src2"
+	git-merge-file "$src1" "$orig" "$src2"
 	ret=$?
 
 	# Create the working tree file, using "our tree" version from the
-- 
1.4.4.2.gd74c-dirty
