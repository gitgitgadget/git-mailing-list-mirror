From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Documentation/gitignore.txt: Clarify gitignore vs tracked
	files
Date: Thu, 17 Jul 2008 18:36:32 +0200
Message-ID: <20080717163622.12592.29919.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 17 18:38:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJWUr-0007eL-1u
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 18:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755824AbYGQQgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 12:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755338AbYGQQgi
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 12:36:38 -0400
Received: from [212.249.11.140] ([212.249.11.140]:49287 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755178AbYGQQgi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 12:36:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id 1555F2AC73C;
	Thu, 17 Jul 2008 18:36:33 +0200 (CEST)
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88877>

Explain more carefully that `.gitignore` concerns only untracked files
and there is no way to make git ignore local changes in already tracked
files.

This is currently probably one of the top FAQs at #git and the documentation
could be more explicit about this.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/gitignore.txt |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index fc0efd8..ac3c776 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -13,9 +13,12 @@ DESCRIPTION
 -----------
 
 A `gitignore` file specifies intentionally untracked files that
-git should ignore.  Each line in a `gitignore` file specifies a
-pattern.
+git should ignore.
+Note that all the `gitignore` files really concern only files
+that are not already tracked by git; there is no direct mechanism
+to make git ignore your local modifications in already tracked files.
 
+Each line in a `gitignore` file specifies a pattern.
 When deciding whether to ignore a path, git normally checks
 `gitignore` patterns from multiple sources, with the following
 order of precedence, from highest to lowest (within one level of
