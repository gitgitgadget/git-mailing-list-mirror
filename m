From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] link to HTML version of external doc if available
Date: Sat, 12 May 2007 11:47:38 -0700
Message-ID: <7v3b21281h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: J Bruce Fields <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sat May 12 20:47:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmwd7-0007Sx-BM
	for gcvg-git@gmane.org; Sat, 12 May 2007 20:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754989AbXELSrk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 14:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754958AbXELSrk
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 14:47:40 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:43811 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612AbXELSrj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 14:47:39 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512184739.DOGQ26353.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 12 May 2007 14:47:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id yJnd1W00H1kojtg0000000; Sat, 12 May 2007 14:47:38 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47071>

Currently 

$ git grep '\([^t]\|^\)'link: user-manual.txt

gives four hits that refer to .txt version of the documentation
set, but at least "hooks" and "cvs-migration" have HTML variants
installed, so refer to them instead.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * The other two are howto/setup-git-server-over-http and
   technical/pack-format.txt

 Documentation/user-manual.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 13db969..a7abeaa 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1875,7 +1875,7 @@ $ chmod a+x hooks/post-update
 
 (For an explanation of the last two lines, see
 gitlink:git-update-server-info[1], and the documentation
-link:hooks.txt[Hooks used by git].)
+link:hooks.html[Hooks used by git].)
 
 Advertise the url of proj.git.  Anybody else should then be able to
 clone or pull from that url, for example with a commandline like:
@@ -1959,7 +1959,7 @@ Setting up a shared repository
 Another way to collaborate is by using a model similar to that
 commonly used in CVS, where several developers with special rights
 all push to and pull from a single shared repository.  See
-link:cvs-migration.txt[git for CVS users] for instructions on how to
+link:cvs-migration.html[git for CVS users] for instructions on how to
 set this up.
 
 [[setting-up-gitweb]]
