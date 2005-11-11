From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Reference technical/trivial-merge.txt in git-read-tree documentation
Date: Fri, 11 Nov 2005 21:51:40 +0100
Message-ID: <20051111205140.5719.68724.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 11 21:53:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EafsB-0004z9-G9
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 21:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbVKKUvp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 15:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVKKUvo
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 15:51:44 -0500
Received: from w241.dkm.cz ([62.24.88.241]:53943 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751194AbVKKUvo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 15:51:44 -0500
Received: (qmail 5738 invoked from network); 11 Nov 2005 21:51:41 +0100
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 11 Nov 2005 21:51:41 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11634>

That file, with the so valuable (and so confusing) tables describing
the precise resolution rules git-read-tree follows, silently sat in
the corner and almost noone knew about it (well, I didn't, at least).
This references it from the git-read-tree documentation, so that there
is some chance that interested people will find it.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-read-tree.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 7db5fb5..ff17bad 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -55,6 +55,12 @@ merge, a single tree merge if only 1 tre
 fast-forward merge with 2 trees, or a 3-way merge if 3 trees are
 provided.
 
+The detailed listing of the precise automatic resolution rules
+git-read-tree follows can be found in 'technical/trivial-merge.txt'.
+It is in part redundant with what you will find below since the
+fellow documenters cannot decide which of the descriptions is more
+confusing and remove the other one.
+
 
 Single Tree Merge
 ~~~~~~~~~~~~~~~~~
