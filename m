From: =?utf-8?q?Steve=20Fr=C3=A9cinaux?= <code@istique.net>
Subject: [PATCH] Add a notice to the doc of git-ls-tree.
Date: Mon, 21 Jul 2008 00:25:35 +0200
Message-ID: <1216592735-23789-1-git-send-email-code@istique.net>
Cc: =?utf-8?q?Steve=20Fr=C3=A9cinaux?= <code@istique.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 00:57:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKhqa-0002Bq-VG
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 00:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbYGTW4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 18:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752815AbYGTW4q
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 18:56:46 -0400
Received: from smtp-out.mobistar.be ([80.12.204.214]:10237 "EHLO
	smtp-out.mobistar.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbYGTW4o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 18:56:44 -0400
Received: from meplus.info (localhost [127.0.0.1])
	by mwinf8113.mobistar.be (SMTP Server) with ESMTP id 7C0BA1D002865;
	Mon, 21 Jul 2008 00:26:03 +0200 (CEST)
Received: from localhost.localdomain (unknown [91.86.64.35])
	by mwinf8113.mobistar.be (SMTP Server) with ESMTP id 4E5201D00025D;
	Mon, 21 Jul 2008 00:26:03 +0200 (CEST)
X-ME-UUID: 20080720222603320.4E5201D00025D@mwinf8113.mobistar.be
X-ME-bounce-domain: mobistarmail.be
X-Mailer: git-send-email 1.5.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89256>

The notice covers this behaviour:
if you are in the git/ subdirectory of your repository, it will pick
the tree corresponding to that directory instead of the root one if you
specify the root tree object id.

Compare the output of both of those commands:
 git-ls-tree cb44e6571708aa2792c73a289d87586fe3c0c362
 git-cat-file -p cb44e6571708aa2792c73a289d87586fe3c0c362
---
 Documentation/git-ls-tree.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 1cdec22..7cba394 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -21,6 +21,10 @@ though - 'paths' denote just a list of patterns to match, e.g. so specifying
 directory name (without '-r') will behave differently, and order of the
 arguments does not matter.
 
+Note that if you give ls-tree the sha1 id of a parent of the tree
+corresponding to the directory you're in, it will resolve that tree and list
+its contents instead of listing the contents of the tree you gave.
+
 OPTIONS
 -------
 <tree-ish>::
-- 
1.5.6.2
