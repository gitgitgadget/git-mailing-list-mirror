From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-fetch: document automatic tag following.
Date: Fri, 09 Feb 2007 16:14:12 -0800
Message-ID: <7vireaq36z.fsf_-_@assigned-by-dhcp.cox.net>
References: <1170933407.15431.38.camel@okra.transitives.com>
	<81b0412b0702090133qa4eb0c0v6a2d309fe9653a3f@mail.gmail.com>
	<7v4ppurka1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Alex Bennee" <kernel-hacker@bennee.com>, git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 10 01:14:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFfsj-0000Fm-8h
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 01:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946784AbXBJAOQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 19:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946785AbXBJAOQ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 19:14:16 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:34058 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946784AbXBJAON (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 19:14:13 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070210001414.YHMH21668.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 9 Feb 2007 19:14:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id McEC1W00K1kojtg0000000; Fri, 09 Feb 2007 19:14:12 -0500
In-Reply-To: <7v4ppurka1.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 09 Feb 2007 15:19:50 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39203>

I've added this to the documentation.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-fetch.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 7ecf240..5fbeab7 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -20,6 +20,14 @@ The ref names and their object names of fetched refs are stored
 in `.git/FETCH_HEAD`.  This information is left for a later merge
 operation done by "git merge".
 
+When <refspec> stores the fetched result in tracking branches,
+the tags that point at these branches are automatically
+followed.  This is done by first fetching from the remote using
+the given <refspec>s, and if the repository has objects that are
+pointed by remote tags that it does not yet have, then fetch
+those missing tags.  If the other end has tags that point at
+branches you are not interested in, you will not get them.
+
 
 OPTIONS
 -------
-- 
1.5.0.rc4.16.g9e258
