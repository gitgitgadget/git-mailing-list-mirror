From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] git-tar-tree: small doc update (resent)
Date: Thu, 2 Jun 2005 20:50:42 +0200
Message-ID: <20050602185042.GA3707@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 20:49:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdujU-0003y1-Jd
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 20:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVFBSut (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 14:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVFBSut
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 14:50:49 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:15240 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261232AbVFBSun (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2005 14:50:43 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 876DE4A9; Thu,  2 Jun 2005 20:50:42 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

git-tar-tree: document difference in behaviour w/ regard to tree vs. commit 
and correct author information.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

diff --git a/Documentation/git-tar-tree.txt b/Documentation/git-tar-tree.txt
--- a/Documentation/git-tar-tree.txt
+++ b/Documentation/git-tar-tree.txt
@@ -17,10 +17,17 @@ Creates a tar archive containing the tre
 When <base> is specified it is added as a leading path as the files in the
 generated tar archive.
 
+git-tar-tree behaves differently when given a tree ID versus when given
+a commit ID or tag ID.  In the first case the current time is used as
+modification time of each file in the archive.  In the latter case the
+commit time as recorded in the referenced commit object is used instead.
+Additionally the commit ID is stored in a global extended pax header.
+It can be extracted using git-get-tar-commit-id.
+
 
 Author
 ------
-Written by Linus Torvalds <torvalds@osdl.org>
+Written by Rene Scharfe.
 
 Documentation
 --------------
