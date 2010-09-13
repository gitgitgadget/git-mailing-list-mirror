From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: [PATCH] Documentation: Refer to git-commit-tree in git-filter-branch help
Date: Mon, 13 Sep 2010 08:59:54 -0600
Message-ID: <1284389994-16892-1-git-send-email-wjl@icecavern.net>
Cc: "Wesley J. Landaker" <wjl@icecavern.net>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 13 17:00:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvAW2-0006Ek-Jh
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 17:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244Ab0IMPAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 11:00:07 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:45116 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751307Ab0IMPAG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 11:00:06 -0400
Received: from jenova.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 440193647A;
	Mon, 13 Sep 2010 09:00:01 -0600 (MDT)
Received: from tonberry.icecavern.net (tonberry.icecavern.net [10.0.0.9])
	by jenova.icecavern.net (Postfix) with ESMTP id 465BD74C197;
	Mon, 13 Sep 2010 08:59:58 -0600 (MDT)
Received: by tonberry.icecavern.net (Postfix, from userid 1000)
	id 2DC922FD55; Mon, 13 Sep 2010 08:59:58 -0600 (MDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156095>

Currently, the help for git filter-branch refers users of --env-filter
to git-commit for information about environment variables affecting
commits. However, this information is not contained in the git-commit
help, but is very explicitly detailed in git-commit-tree.

Signed-off-by: Wesley J. Landaker <wjl@icecavern.net>
---
 Documentation/git-filter-branch.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 020028c..c32e489 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -81,7 +81,7 @@ OPTIONS
 	This filter may be used if you only need to modify the environment
 	in which the commit will be performed.  Specifically, you might
 	want to rewrite the author/committer name/email/time environment
-	variables (see linkgit:git-commit[1] for details).  Do not forget
+	variables (see linkgit:git-commit-tree[1] for details).  Do not forget
 	to re-export the variables.
 
 --tree-filter <command>::
-- 
1.7.1
