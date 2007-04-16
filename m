From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 2/7] Documentation: clarify git-checkout -f, minor editing
Date: Mon, 16 Apr 2007 00:37:11 -0400
Message-ID: <9733.45415336571$1176698256@news.gmane.org>
References: <11766982362087-git-send-email->
 <11766982361830-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 06:37:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdIy1-0008Sb-Du
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 06:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483AbXDPEhU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 00:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754489AbXDPEhT
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 00:37:19 -0400
Received: from mail.fieldses.org ([66.93.2.214]:36494 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754483AbXDPEhS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 00:37:18 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HdIxo-0005YT-JY; Mon, 16 Apr 2007 00:37:16 -0400
X-Mailer: git-send-email 1.5.1.1.98.gedb4f
In-Reply-To: <11766982361830-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44572>

From: J. Bruce Fields <bfields@pad.(none)>

"Force a re-read of everything" doesn't mean much to me.

Also some minor grammar fixes.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/git-checkout.txt |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index f5b2d50..2ead493 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -23,9 +23,9 @@ options, which will be passed to `git branch`.
 
 When <paths> are given, this command does *not* switch
 branches.  It updates the named paths in the working tree from
-the index file (i.e. it runs `git-checkout-index -f -u`), or a
-named commit.  In
-this case, `-f` and `-b` options are meaningless and giving
+the index file (i.e. it runs `git-checkout-index -f -u`), or
+from a named commit.  In
+this case, the `-f` and `-b` options are meaningless and giving
 either of them results in an error.  <tree-ish> argument can be
 used to specify a specific tree-ish (i.e. commit, tag or tree)
 to update the index for the given paths before updating the
@@ -38,7 +38,8 @@ OPTIONS
 	Quiet, supress feedback messages.
 
 -f::
-	Force a re-read of everything.
+	Proceed even if the index or the working tree differs
+	from HEAD.
 
 -b::
 	Create a new branch named <new_branch> and start it at
-- 
1.5.1.1.98.gedb4f
