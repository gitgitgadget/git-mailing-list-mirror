From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Fix typo in release notes for 1.6.0.3
Date: Mon, 29 Sep 2008 16:58:08 +0200
Message-ID: <1222700288-29717-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Sep 29 17:00:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkKDb-0000OH-Gx
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 16:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbYI2O6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 10:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbYI2O6L
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 10:58:11 -0400
Received: from virgo.iok.hu ([193.202.89.103]:60108 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940AbYI2O6K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 10:58:10 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 253AA58134;
	Mon, 29 Sep 2008 16:58:09 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 197F94465E;
	Mon, 29 Sep 2008 16:58:09 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 0A73D11901A1; Mon, 29 Sep 2008 16:58:09 +0200 (CEST)
X-Mailer: git-send-email 1.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97015>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

 Documentation/RelNotes-1.6.0.3.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/RelNotes-1.6.0.3.txt b/Documentation/RelNotes-1.6.0.3.txt
index 46e13a4..a374690 100644
--- a/Documentation/RelNotes-1.6.0.3.txt
+++ b/Documentation/RelNotes-1.6.0.3.txt
@@ -16,7 +16,7 @@ Fixes since v1.6.0.2
 * Behaviour of "git diff --quiet" was inconsistent with "diff --exit-code"
   with the output redirected to /dev/null.
 
-* "git stash apply sash@{1}" was fixed to error out.  Prior versions
+* "git stash apply stash@{1}" was fixed to error out.  Prior versions
   would have applied stash@{0} incorrectly.
 
 * "git for-each-ref --format=%(subject)" fixed for commits with no
-- 
1.6.0
