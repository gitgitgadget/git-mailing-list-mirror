From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/4] Documentation: --cherry-pick
Date: Tue, 10 Apr 2007 15:41:16 -0700
Message-ID: <7vabxfua2b.fsf_-_@assigned-by-dhcp.cox.net>
References: <1175686583.19898.68.camel@okra.transitives.com>
	<Pine.LNX.4.64.0704040744160.6730@woody.linux-foundation.org>
	<7vircbwfym.fsf@assigned-by-dhcp.cox.net>
	<7virc524cd.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 07:55:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbP2J-0001Y5-41
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 00:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030616AbXDJWlU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 18:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030723AbXDJWlT
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 18:41:19 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:54484 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030616AbXDJWlR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 18:41:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070410224117.MDVN1218.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Apr 2007 18:41:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id lahG1W00V1kojtg0000000; Tue, 10 Apr 2007 18:41:17 -0400
In-Reply-To: <7virc524cd.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 09 Apr 2007 04:07:46 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44191>

Document how to use --cherry-pick, using earlier documentation
update that adds an example to --left-right.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-rev-list.txt |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 12b71ed..77e068b 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -22,6 +22,7 @@ SYNOPSIS
 	     [ \--topo-order ]
 	     [ \--parents ]
 	     [ \--left-right ]
+	     [ \--cherry-pick ]
 	     [ \--encoding[=<encoding>] ]
 	     [ \--(author|committer|grep)=<pattern> ]
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
@@ -224,6 +225,20 @@ limiting may be applied.
 	In addition to the '<commit>' listed on the command
 	line, read them from the standard input.
 
+--cherry-pick::
+
+	Omit any commit that introduces the same change as
+	another commit on the "other side" when the set of
+	commits are limited with symmetric difference.
++
+For example, if you have two branches, `A` and `B`, a usual way
+to list all commits on only one side of them is with
+`--left-right`, like the example above in the description of
+that option.  It however shows the commits that were cherry-picked
+from the other branch (for example, "3rd on b" may be cherry-picked
+from branch A).  With this option, such pairs of commits are
+excluded from the output.
+
 -g, --walk-reflogs::
 
 	Instead of walking the commit ancestry chain, walk
-- 
1.5.1.777.gd14d3
