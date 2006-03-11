From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-export: document the -r option
Date: Sat, 11 Mar 2006 14:13:51 +0100
Message-ID: <20060311131351.GB26418@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 11 14:13:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FI3uv-0008UY-OK
	for gcvg-git@gmane.org; Sat, 11 Mar 2006 14:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWCKNNy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Mar 2006 08:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWCKNNy
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Mar 2006 08:13:54 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:26543 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751064AbWCKNNy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Mar 2006 08:13:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 31977770037;
	Sat, 11 Mar 2006 14:13:53 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12106-08; Sat, 11 Mar 2006 14:13:51 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 9AD0277000A;
	Sat, 11 Mar 2006 14:13:51 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 2EC1D6DF8B9; Sat, 11 Mar 2006 14:12:26 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 8768861DD9; Sat, 11 Mar 2006 14:13:51 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17501>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
commit 4ac3822d222d8562a4cf4ac1edac1e2d60d40535
tree da406621cea613a71e3d46ce71bd629ce5d709d4
parent 129519d0f337f83699bad485dec105a6528961a2
author Jonas Fonseca <fonseca@diku.dk> Sat, 11 Mar 2006 13:56:42 +0100
committer Jonas Fonseca <fonseca@antimatter.localdomain> Sat, 11 Mar 2006 13:56:42 +0100

 cg-export |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/cg-export b/cg-export
index 7acc1a0..cf9f0fd 100755
--- a/cg-export
+++ b/cg-export
@@ -9,6 +9,11 @@
 # The destination can be either a `.tar`, `.tar.gz`, `.tar.bz2` or `.tgz`
 # for generating a tarball. Other destination specifiers are assumed
 # to be directory names, and the tree is exported to the given directory.
+#
+# OPTIONS
+# -------
+# -r TREE_ID:: Specify the tree version to export
+#	Base the export on the given tree.
 
 USAGE="cg-export [-r TREE_ID] DESTFILE"
 _git_requires_root=1

-- 
Jonas Fonseca
