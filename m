From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git submodule documentation: typo fix
Date: Sun, 20 Jul 2008 00:28:54 +0200
Message-ID: <1216506534-27649-1-git-send-email-vmiklos@frugalware.org>
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 00:29:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKKvk-0006nq-No
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 00:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624AbYGSW2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 18:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753527AbYGSW2d
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 18:28:33 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:43047 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbYGSW2c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 18:28:32 -0400
Received: from vmobile.example.net (dsl5401C7D0.pool.t-online.hu [84.1.199.208])
	by yugo.frugalware.org (Postfix) with ESMTP id F2ED31DDC5B;
	Sun, 20 Jul 2008 00:28:28 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 08B341AB590; Sun, 20 Jul 2008 00:28:54 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.450.g8d367.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89140>

The current status of submodules can be queried using the 'status' (and
not the 'submodule') subcommand.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/git-submodule.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index bb4e6fb..e849858 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -34,7 +34,7 @@ When adding a new submodule to the tree, the 'add' subcommand is to be used.
 However, when pulling a tree containing submodules, these will not be checked
 out by default; the 'init' and 'update' subcommands will maintain submodules
 checked out and at appropriate revision in your working tree. You can inspect
-the current status of your submodules using the 'submodule' subcommand and get
+the current status of your submodules using the 'status' subcommand and get
 an overview of changes 'update' would perform using the 'summary' subcommand.
 
 
-- 
1.5.6.2.450.g8d367.dirty
