From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [PATCH] Fix series mismerge
Date: Sun, 18 Sep 2005 18:47:12 +0200
Message-ID: <20050918164712.13735.86782.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 18:50:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH2M6-0003hL-N9
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 18:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVIRQtF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 12:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVIRQtF
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 12:49:05 -0400
Received: from ppp-62-11-72-222.dialup.tiscali.it ([62.11.72.222]:48323 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1751181AbVIRQtE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 12:49:04 -0400
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id E0ABB4392C;
	Sun, 18 Sep 2005 18:47:14 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8785>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Mismerge with my addition of -e. Sorry for not pulling that time.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 stgit/commands/series.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/stgit/commands/series.py b/stgit/commands/series.py
--- a/stgit/commands/series.py
+++ b/stgit/commands/series.py
@@ -32,8 +32,8 @@ with a '+' and the unapplied ones with a
 prefixed with a '>'. Empty patches are prefixed with a '0'."""
 
 options = [make_option('-b', '--branch',
-                       help = 'use BRANCH instead of the default one')]
-options = [make_option('-e', '--empty',
+                       help = 'use BRANCH instead of the default one'),
+           make_option('-e', '--empty',
                        help = 'check whether patches are empty '
                        '(much slower)',
                        action = 'store_true') ]
