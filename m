From: Simon Hausmann <simon@lst.de>
Subject: [PATCH] git-new-workdir: Fix shell warning about operator == used with test.
Date: Mon, 25 Jun 2007 13:04:26 +0200
Message-ID: <200706251304.28886.simon@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jun 25 12:59:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2mIP-0004zw-91
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 12:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbXFYK7r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 06:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbXFYK7r
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 06:59:47 -0400
Received: from esparsett.troll.no ([62.70.27.18]:36278 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbXFYK7r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 06:59:47 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 153BB742EF; Mon, 25 Jun 2007 12:59:46 +0200 (CEST)
Received: from rhea.troll.no (rhea.troll.no [10.3.4.5])
	by esparsett.troll.no (Postfix) with ESMTP
	id 0812774257; Mon, 25 Jun 2007 12:59:46 +0200 (CEST)
X-Length: 840
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50889>

Use = instead of == with test to test for equality.

Signed-off-by: Simon Hausmann <simon@lst.de>
---
 contrib/workdir/git-new-workdir |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
index 709b2a3..3ff6bd1 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -24,7 +24,7 @@ git_dir=$(cd "$orig_git" 2>/dev/null &&
   git rev-parse --git-dir 2>/dev/null) ||
   die "\"$orig_git\" is not a git repository!"
 
-if test "$git_dir" == ".git"
+if test "$git_dir" = ".git"
 then
 	git_dir="$orig_git/.git"
 fi
-- 
1.5.2.2.549.gaeb59
