From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] git-tar-tree: small doc update
Date: Fri, 27 May 2005 23:20:32 +0200
Message-ID: <20050527212032.GB17478@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 23:19:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbmEP-0000YG-Dv
	for gcvg-git@gmane.org; Fri, 27 May 2005 23:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbVE0VUy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 17:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbVE0VUy
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 17:20:54 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:30881 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262600AbVE0VUf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 17:20:35 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 75BE339F; Fri, 27 May 2005 23:20:32 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Update git-tar-tree documenation a teensy bit: document where the file
times come from and correct author section.  I'll take the blame for
that contraption, if you don't mind. ;)

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

Index: Documentation/git-tar-tree.txt
===================================================================
--- fa5c736eeabbead4a4c024051d104930d836092a/Documentation/git-tar-tree.txt  (mode:100644)
+++ ff1cce79554723d915cb45315fda2d56a1c5ea04/Documentation/git-tar-tree.txt  (mode:100644)
@@ -17,10 +17,14 @@
 When <base> is specified it is added as a leading path as the files in the
 generated tar archive.
 
+When the given ID is a tree ID then all the files in the archive get
+their mtime set to the current time.  When called with the ID of a commit
+object the commit time recorded therein is used instead.
+
 
 Author
 ------
-Written by Linus Torvalds <torvalds@osdl.org>
+Written by Rene Scharfe.
 
 Documentation
 --------------
