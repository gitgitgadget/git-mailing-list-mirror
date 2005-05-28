From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: [PATCH] Document the --root switch of git-diff-tree (try 4)
Date: Sat, 28 May 2005 16:55:07 +0200
Message-ID: <20050528145507.GA21789@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat May 28 16:54:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dc2he-00074K-L8
	for gcvg-git@gmane.org; Sat, 28 May 2005 16:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbVE1Ozk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 10:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbVE1Ozj
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 10:55:39 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:13512 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262737AbVE1OzR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2005 10:55:17 -0400
Received: from faui00u.informatik.uni-erlangen.de (sithglan@faui00u.informatik.uni-erlangen.de [131.188.30.59])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4SEt7S8028622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 28 May 2005 14:55:07 GMT
Received: (from sithglan@localhost)
	by faui00u.informatik.uni-erlangen.de (8.13.4/8.12.3/Debian-8) id j4SEt7lo021792;
	Sat, 28 May 2005 16:55:07 +0200
To: Linus Torvalds <torvalds@osdl.org>, GIT <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

diff-tree a63bd10cbec0978c4d1d0076db4f06c52c670449 (from 8310c2c0b585d3ac35a275f795e15fd9887e8b7d)
Author: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Date:   Sat May 28 16:37:28 2005 +0200
    
    [PATCH] Document the --root switch of git-diff-tree
    
    Signed-off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>

diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -54,6 +54,10 @@ OPTIONS
 -z::
 	\0 line termination on output
 
+--root::
+	When '--root' is specified the initial commit will be shown as a big
+	creation event. This is equivalent to a diff against the NULL tree.
+
 --stdin::
 	When '--stdin' is specified, the command does not take
 	<tree-ish> arguments from the command line.  Instead, it
