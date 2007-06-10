From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] Softrefs: Add softrefs header file with API documentation
Date: Sun, 10 Jun 2007 00:43:26 -0700
Message-ID: <7vzm389rvl.fsf@assigned-by-dhcp.cox.net>
References: <200706040251.05286.johan@herland.net>
	<200706092019.13185.johan@herland.net>
	<200706092021.43314.johan@herland.net>
	<Pine.LNX.4.64.0706100750440.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 10 09:43:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxI5B-0006iU-RI
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 09:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761921AbXFJHn2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 03:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761747AbXFJHn2
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 03:43:28 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:51402 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761329AbXFJHn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 03:43:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070610074326.DPWN7825.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Jun 2007 03:43:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9jjT1X0041kojtg0000000; Sun, 10 Jun 2007 03:43:27 -0400
In-Reply-To: <Pine.LNX.4.64.0706100750440.4059@racer.site> (Johannes
	Schindelin's message of "Sun, 10 Jun 2007 07:58:49 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49663>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Besides, your lines are way too long. Yes, it is not in 
> Documentation/SubmittingPatches,...
> ... since you have to read the source to get acquainted 
> with it _anyway_, it would only be a duplication to have it in 
> SubmittingPatches, too.

Well, maybe we should do this.

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 01354c2..4bdfdfe 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -5,6 +5,7 @@ Checklist (and a short version for the impatient):
 	- make commits of logical units
 	- check for unnecessary whitespace with "git diff --check"
 	  before committing
+	- tab width is 8, the terminal is 80-columns wide.
 	- do not check in commented out code or unneeded files
 	- provide a meaningful commit message
 	- the first line of the commit message should be a short
@@ -82,6 +83,14 @@ option).
 Another thing: NULL pointers shall be written as NULL, not as 0.
 
 
+(1b) Tab width is 8, Terminal is 80-column wide.
+
+We generally follow the same coding style guidelines as the
+Linux kernel project.  Lines are indented with Tabs, each of
+which are 8 columns wide.  Lines should fit on 80-column wide
+terminals.
+
+
 (2) Generate your patch using git tools out of your commits.
 
 git based diff tools (git, Cogito, and StGIT included) generate
