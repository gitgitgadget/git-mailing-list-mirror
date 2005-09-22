From: Jon Loeliger <jdl@freescale.org>
Subject: PATCH Suggestion for Tutorial Change
Date: Thu, 22 Sep 2005 10:51:57 -0500
Message-ID: <E1EITMb-0001CX-D4@jdl.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 17:55:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EITNE-0004Vp-2y
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 17:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416AbVIVPwA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 11:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbVIVPwA
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 11:52:00 -0400
Received: from colo.jdl.com ([66.118.10.122]:26027 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1030416AbVIVPv7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 11:51:59 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EITMb-0001CX-D4
	for git@vger.kernel.org; Thu, 22 Sep 2005 10:51:58 -0500
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9131>


In the tutorial, there is a section entitled "Checking it out"
that shows how to use diff log and whatchanged to insect some
of the repository state.

As the phrase "checkout" ususally carries some baggage WRT
other revision control mechanism, I suggest that we re-title
this section something like "Inspecting Changes".


Signed-off-by: Jon Loeliger <jdl@freescale.com>
---


diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -432,8 +432,8 @@ message headers, and a few one-liners th
 commit itself (`git-commit`).


-Checking it out
----------------
+Inspecting Changes
+------------------

 While creating changes is useful, it's even more useful if you can tell
 later what changed. The most useful command for this is another of the
