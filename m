From: Dirk Wallenstein <halsmit@t-online.de>
Subject: [PATCH] howto: Use all-space indentation in ASCII art
Date: Mon, 15 Jul 2013 18:46:58 +0200
Message-ID: <20130715164658.GA8675@bottich>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Thomas Ackermann <th.acker@arcor.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 19:04:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UymCJ-0002kV-8R
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 19:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933397Ab3GORET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 13:04:19 -0400
Received: from mailout02.t-online.de ([194.25.134.17]:43517 "EHLO
	mailout02.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932687Ab3GORES (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 13:04:18 -0400
X-Greylist: delayed 1031 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jul 2013 13:04:17 EDT
Received: from fwd57.aul.t-online.de (fwd57.aul.t-online.de )
	by mailout02.t-online.de with smtp 
	id 1UylvU-0004No-N3; Mon, 15 Jul 2013 18:47:04 +0200
Received: from localhost (TcbRu6Z1Qhkno2oF8QLUVRVBJJY2MVcZYb4drd7dbTfAl4XPCyE5kvPvtbTZ11YQ3T@[178.202.219.43]) by fwd57.t-online.de
	with esmtp id 1UylvQ-1rTiOu0; Mon, 15 Jul 2013 18:47:00 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ID: TcbRu6Z1Qhkno2oF8QLUVRVBJJY2MVcZYb4drd7dbTfAl4XPCyE5kvPvtbTZ11YQ3T
X-TOI-MSGID: 487a5aa5-070a-4c88-a3a4-3ab2e9a41851
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230490>

Keep the sketch aligned independent of the tabstop width used.

Signed-off-by: Dirk Wallenstein <halsmit@t-online.de>
---
 Documentation/howto/revert-a-faulty-merge.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/howto/revert-a-faulty-merge.txt b/Documentation/howto/revert-a-faulty-merge.txt
index 075418e..4b75bfc 100644
--- a/Documentation/howto/revert-a-faulty-merge.txt
+++ b/Documentation/howto/revert-a-faulty-merge.txt
@@ -30,7 +30,7 @@ The history immediately after the "revert of the merge" would look like
 this:
 
  ---o---o---o---M---x---x---W
-	       /
+               /
        ---A---B
 
 where A and B are on the side development that was not so good, M is the
@@ -47,7 +47,7 @@ After the developers of the side branch fix their mistakes, the history
 may look like this:
 
  ---o---o---o---M---x---x---W---x
-	       /
+               /
        ---A---B-------------------C---D
 
 where C and D are to fix what was broken in A and B, and you may already
@@ -81,7 +81,7 @@ In such a situation, you would want to first revert the previous revert,
 which would make the history look like this:
 
  ---o---o---o---M---x---x---W---x---Y
-	       /
+               /
        ---A---B-------------------C---D
 
 where Y is the revert of W.  Such a "revert of the revert" can be done
@@ -93,14 +93,14 @@ This history would (ignoring possible conflicts between what W and W..Y
 changed) be equivalent to not having W nor Y at all in the history:
 
  ---o---o---o---M---x---x-------x----
-	       /
+               /
        ---A---B-------------------C---D
 
 and merging the side branch again will not have conflict arising from an
 earlier revert and revert of the revert.
 
  ---o---o---o---M---x---x-------x-------*
-	       /                       /
+               /                       /
        ---A---B-------------------C---D
 
 Of course the changes made in C and D still can conflict with what was
@@ -111,13 +111,13 @@ faulty A and B, and redone the changes on top of the updated mainline
 after the revert, the history would have looked like this:
 
  ---o---o---o---M---x---x---W---x---x
-	       /                 \
+               /                 \
        ---A---B                   A'--B'--C'
 
 If you reverted the revert in such a case as in the previous example:
 
  ---o---o---o---M---x---x---W---x---x---Y---*
-	       /                 \         /
+               /                 \         /
        ---A---B                   A'--B'--C'
 
 where Y is the revert of W, A' and B' are rerolled A and B, and there may
@@ -129,7 +129,7 @@ lot of overlapping changes that result in conflicts.  So do not do "revert
 of revert" blindly without thinking..
 
  ---o---o---o---M---x---x---W---x---x
-	       /                 \
+               /                 \
        ---A---B                   A'--B'--C'
 
 In the history with rebased side branch, W (and M) are behind the merge
-- 
1.8.3.2.50.g531c8dd
