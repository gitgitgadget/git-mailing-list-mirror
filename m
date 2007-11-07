From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: [PATCH] Fix mistakes in the documentation of git-add --interactive.
Date: Wed,  7 Nov 2007 19:20:03 +0100
Message-ID: <1194459603-7988-1-git-send-email-tsuna@lrde.epita.fr>
Cc: gitster@pobox.com, Benoit Sigoure <tsuna@lrde.epita.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 07 19:20:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IppVq-0002Nb-7N
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 19:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbXKGSUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 13:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752357AbXKGSUK
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 13:20:10 -0500
Received: from 1.139.39-62.rev.gaoland.net ([62.39.139.1]:61196 "EHLO
	tsunaxbook.lrde.epita.fr" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752087AbXKGSUJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Nov 2007 13:20:09 -0500
Received: by tsunaxbook.lrde.epita.fr (Postfix, from userid 501)
	id DA2B4C80EAE; Wed,  7 Nov 2007 19:20:03 +0100 (CET)
X-Mailer: git-send-email 1.5.3.4.398.g859b
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63844>

This patch fixes a couple of language issues in the documentation
of the `patch' sub-command of git-add --interactive.

Signed-off-by: Benoit Sigoure <tsuna@lrde.epita.fr>
---
 Documentation/git-add.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 963e1ab..f7c02ff 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -202,8 +202,8 @@ patch::
 
        y - add the change from that hunk to index
        n - do not add the change from that hunk to index
-       a - add the change from that hunk and all the rest to index
-       d - do not the change from that hunk nor any of the rest to index
+       a - add the change from that hunk and all the remaining ones
+       d - do not the add change from that hunk and skip the remaining ones
        j - do not decide on this hunk now, and view the next
            undecided hunk
        J - do not decide on this hunk now, and view the next hunk
@@ -211,8 +211,8 @@ patch::
            undecided hunk
        K - do not decide on this hunk now, and view the previous hunk
 +
-After deciding the fate for all hunks, if there is any hunk
-that was chosen, the index is updated with the selected hunks.
+After deciding the fate of each hunk, the index is updated with the selected
+ones.
 
 diff::
 
-- 
1.5.3.4.398.g859b
