From: Sloof Lirpa <sitemaster@cox.net>
Subject: [PATCH 3/3] Human friendly git: add another human readable option.
Date: Sun, 1 Apr 2007 00:00:00 +0000
Message-ID: <7vk5wx556z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamamo <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 01 02:30:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXnxZ-0007g9-M1
	for gcvg-git@gmane.org; Sun, 01 Apr 2007 02:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbXDAAaN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 20:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752843AbXDAAaN
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 20:30:13 -0400
Received: from fed1rmmtai108.cox.net ([68.230.241.52]:63180 "EHLO
	fed1rmmtai108.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817AbXDAAaM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 20:30:12 -0400
X-Greylist: delayed 1470 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Mar 2007 20:30:12 EDT
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070401000612.NBDT25613.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 31 Mar 2007 20:06:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id hc6B1W00H1kojtg0000000; Sat, 31 Mar 2007 20:06:12 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43575>

Building on top of the previous patches, this allows you to say:

	$ git, please nicely ls-files

to get a paginated output of ls-files.

Signed-off-by: Sloof Lirpa <sitemaster@cox.net>
---
 git.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index 7909fd3..9124998 100644
--- a/git.c
+++ b/git.c
@@ -42,6 +42,9 @@ static int handle_options(const char*** argv, int* argc)
 		if (!strcmp(cmd, "please"))
 			; /* no-op */
 
+		else if (!strcmp(cmd, "nicely"))
+			setup_pager();
+
 		else if (cmd[0] != '-')
 			break;
 
-- 
1.5.1.rc3.26.g4f01
