From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/8] fsck-objects: work from subdirectory.
Date: Sat, 26 Nov 2005 01:56:49 -0800
Message-ID: <7v7jav68bi.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
	<200511210026.30280.Josef.Weidendorfer@gmx.de>
	<200511221831.03954.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
	<438371E8.2030701@op5.se>
	<Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
	<7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
	<Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
	<43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 26 10:57:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efwne-0002Ng-Q7
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 10:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVKZJ4w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 04:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVKZJ4w
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 04:56:52 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:39156 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750810AbVKZJ4v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2005 04:56:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051126095611.BRNN6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 26 Nov 2005 04:56:11 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12770>

Not much point making it work from subdirectory, but for a
consistency make it so.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 fsck-objects.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

applies-to: 802056c105a0cb936137f141a8e6e546224f3a07
1bd646921ec7278fad9a38281678227769046291
diff --git a/fsck-objects.c b/fsck-objects.c
index 0433a1d..90e638e 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -431,6 +431,8 @@ int main(int argc, char **argv)
 {
 	int i, heads;
 
+	setup_git_directory();
+
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
---
0.99.9.GIT
