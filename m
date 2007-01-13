From: Junio C Hamano <junkio@cox.net>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sat, 13 Jan 2007 12:25:41 -0800
Message-ID: <7vwt3qk722.fsf@assigned-by-dhcp.cox.net>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com>
	<7virfct737.fsf@assigned-by-dhcp.cox.net>
	<slrneqfnb8.a6s.Peter.B.Baumann@xp.machine.xx>
	<7vejq0t4ij.fsf@assigned-by-dhcp.cox.net>
	<20070112210403.GB6262@xp.machine.xx>
	<7v7ivrpx9y.fsf@assigned-by-dhcp.cox.net>
	<87y7o6x60w.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0701131340040.2577@xanadu.home>
	<87wt3qwwm0.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 21:25:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5pRh-00011a-OX
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 21:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422784AbXAMUZn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 15:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422785AbXAMUZn
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 15:25:43 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:46621 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422784AbXAMUZm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 15:25:42 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070113202541.SCQ16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Sat, 13 Jan 2007 15:25:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id AkRx1W00q1kojtg0000000; Sat, 13 Jan 2007 15:25:58 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87wt3qwwm0.wl%cworth@cworth.org> (Carl Worth's message of "Sat,
	13 Jan 2007 11:32:55 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36768>

Carl Worth <cworth@cworth.org> writes:

> So the documentation of "commit -a" being implemented with "add" just
> plain doesn't make sense---and this is causing confusion.

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index cb081cd..b4528d7 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -32,7 +32,8 @@ methods:
 
 4. by using the -a switch with the 'commit' command to automatically "add"
    changes from all known files i.e. files that have already been committed
-   before, and perform the actual commit.
+   before, and to automatically "rm" files that have been
+   removed from the working tree, and perform the actual commit.
 
 The gitlink:git-status[1] command can be used to obtain a
 summary of what is included by any of the above for the next
