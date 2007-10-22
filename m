From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/9] rev-list documentation: add "--bisect-all".
Date: Mon, 22 Oct 2007 07:48:11 +0200
Message-ID: <20071022074811.9f5db559.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 07:41:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijq2U-0007Sc-4h
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 07:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbXJVFlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 01:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbXJVFlJ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 01:41:09 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:36130 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139AbXJVFlI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 01:41:08 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 513611AB2C9;
	Mon, 22 Oct 2007 07:41:07 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 130331AB2AE;
	Mon, 22 Oct 2007 07:41:07 +0200 (CEST)
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61939>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-rev-list.txt |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 7cd0e89..4852804 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -34,6 +34,7 @@ SYNOPSIS
 	     [ \--pretty | \--header ]
 	     [ \--bisect ]
 	     [ \--bisect-vars ]
+	     [ \--bisect-all ]
 	     [ \--merge ]
 	     [ \--reverse ]
 	     [ \--walk-reflogs ]
@@ -354,6 +355,21 @@ the expected number of commits to be tested if `bisect_rev`
 turns out to be bad to `bisect_bad`, and the number of commits
 we are bisecting right now to `bisect_all`.
 
+--bisect-all::
+
+This outputs all the commit objects between the included and excluded
+commits, ordered by their distance to the included and excluded
+commits. The farthest from them is displayed first. (This is the only
+one displayed by `--bisect`.)
+
+This is useful because it makes it easy to choose a good commit to
+test when you want to avoid to test some of them for some reason (they
+may not compile for example).
+
+This option can be used along with `--bisect-vars`, in this case,
+after all the sorted commit objects, there will be the same text as if
+`--bisect-vars` had been used alone.
+
 --
 
 Commit Ordering
-- 
1.5.3.3.136.g591d1-dirty
