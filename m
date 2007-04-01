From: Sloof Lirpa <sitemaster@cox.net>
Subject: [PATCH 1/3] Human friendly git: accept imperative mood.
Date: Sun, 1 Apr 2007 00:00:00 +0000
Message-ID: <7vmz1t557v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamamo <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 01 02:30:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXnxn-0007mg-Rr
	for gcvg-git@gmane.org; Sun, 01 Apr 2007 02:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822AbXDAAaS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 20:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752844AbXDAAaS
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 20:30:18 -0400
Received: from fed1rmmtai108.cox.net ([68.230.241.52]:63180 "EHLO
	fed1rmmtai108.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbXDAAaP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 20:30:15 -0400
X-Greylist: delayed 1470 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Mar 2007 20:30:12 EDT
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070401000541.PXHL24385.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 31 Mar 2007 20:05:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id hc5g1W0061kojtg0000000; Sat, 31 Mar 2007 20:05:41 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43577>

The traditional syntax in computerese to tell a person to do
something for us is:

	> thief, go west

With this patch, you can now say:

	$ git, fetch $URL

Signed-off-by: Sloof Lirpa <sitemaster@cox.net>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index b159ffd..2699cff 100644
--- a/Makefile
+++ b/Makefile
@@ -225,7 +225,7 @@ EXTRA_PROGRAMS =
 BUILT_INS = \
 	git-format-patch$X git-show$X git-whatchanged$X git-cherry$X \
 	git-get-tar-commit-id$X git-init$X git-repo-config$X \
-	git-fsck-objects$X git-cherry-pick$X \
+	git-fsck-objects$X git-cherry-pick$X git,$X \
 	$(patsubst builtin-%.o,git-%$X,$(BUILTIN_OBJS))
 
 # what 'all' will build and 'install' will install, in gitexecdir
-- 
1.5.1.rc3.26.g4f01
