From: jdl@freescale.com
Subject: PATCH Fix tutorial reference to git-*-scripts.
Date: Fri, 09 Sep 2005 09:11:35 -0500
Message-ID: <E1EDjbL-0003pZ-DT@jdl.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 16:14:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDjcD-00070F-W6
	for gcvg-git@gmane.org; Fri, 09 Sep 2005 16:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbVIIOLq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Sep 2005 10:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbVIIOLq
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Sep 2005 10:11:46 -0400
Received: from jdl.com ([66.118.10.122]:53723 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S964889AbVIIOLp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2005 10:11:45 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EDjbL-0003pZ-DT
	for git@vger.kernel.org; Fri, 09 Sep 2005 09:11:36 -0500
To: git@vger.kernel.org
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8238>

There was a lingering reference to the git-*-scripts in
the tutorial.  This patch reworks that paragraph a bit.


Signed-off-by: Jon Loeliger <jdl@freescale.com>
---


diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -608,11 +608,11 @@ The above can also be written as simply
 	git reset
 
 and in fact a lot of the common git command combinations can be scripted
-with the `git xyz` interfaces, and you can learn things by just looking
-at what the `git-*-script` scripts do (`git reset` is the above two lines
-implemented in `git-reset`, but some things like `git status` and
-`git commit` are slightly more complex scripts around the basic git
-commands). 
+with the `git xyz` interfaces.  You can learn things by just looking
+at what the various git scripts do.  For example, `git reset` is the
+above two lines implemented in `git-reset`, but some things like
+`git status` and `git commit` are slightly more complex scripts around
+the basic git commands.
 
 Many (most?) public remote repositories will not contain any of
 the checked out files or even an index file, and will *only* contain the
