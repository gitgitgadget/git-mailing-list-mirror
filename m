From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [patch 01/11] Fix typo: comitter->committer
Date: Fri, 16 Sep 2005 21:35:11 +0200
Message-ID: <20050916193511.18681.24189.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 21:39:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGM2K-0005kZ-LC
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 21:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVIPTiM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 15:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbVIPTiL
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 15:38:11 -0400
Received: from ppp-62-11-79-165.dialup.tiscali.it ([62.11.79.165]:25227 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1750705AbVIPTiK
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 15:38:10 -0400
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id 3620328467;
	Fri, 16 Sep 2005 21:35:12 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8715>

Found casually in commit.__init__, while profiling stg series.
And yes, I went checking that git has no typo.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 stgit/git.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -56,7 +56,7 @@ class Commit:
                 self.__parent = field[1]
             if field[0] == 'author':
                 self.__author = field[1]
-            if field[0] == 'comitter':
+            if field[0] == 'committer':
                 self.__committer = field[1]
         self.__log = ''.join(lines[i:])
 
