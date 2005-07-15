From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 4/6] Update the list of diagnostics for git-commit-tree
Date: Thu, 14 Jul 2005 18:57:53 -0600
Message-ID: <m1fyugyjfy.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 02:58:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtEWy-0002fP-Dr
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 02:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263140AbVGOA6O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 20:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbVGOA6N
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 20:58:13 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17341 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263140AbVGOA6J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 20:58:09 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6F0vsSl020873;
	Thu, 14 Jul 2005 18:57:54 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6F0vrqR020872;
	Thu, 14 Jul 2005 18:57:53 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

With the recent work on setup_ident() there are
a few more possible diagnostic messages form git-commit-tree

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 Documentation/git-commit-tree.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

3dccd7f0c9e3cbc8bc17d3af01f9f1d273090082
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -68,6 +68,10 @@ Diagnostics
 -----------
 You don't exist. Go away!::
     The passwd(5) gecos field couldn't be read
+Your parents must have hated you!::
+    The password(5) gecos field is longer than a giant static buffer.
+Your sysadmin must have hate you!::
+    The password(5) name field is longer than a giant static buffer.
 
 See Also
 --------
