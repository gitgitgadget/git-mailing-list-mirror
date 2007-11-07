From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: [PATCH v3] Fix mistakes in the documentation of git-add --interactive.
Date: Wed,  7 Nov 2007 23:31:08 +0100
Message-ID: <1194474668-8837-1-git-send-email-tsuna@lrde.epita.fr>
References: <Pine.LNX.4.64.0711072224200.4362@racer.site>
Cc: gitster@pobox.com, Benoit Sigoure <tsuna@lrde.epita.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 07 23:31:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IptQq-0008GS-BF
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 23:31:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757673AbXKGWbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 17:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757550AbXKGWbP
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 17:31:15 -0500
Received: from quanta.tsunanet.net ([82.229.223.213]:61618 "EHLO
	quanta.tsunanet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756565AbXKGWbO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 17:31:14 -0500
Received: by quanta.tsunanet.net (Postfix, from userid 501)
	id 2BC3BC81BD9; Wed,  7 Nov 2007 23:31:08 +0100 (CET)
X-Mailer: git-send-email 1.5.3.4.398.g859b
In-Reply-To: <Pine.LNX.4.64.0711072224200.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63878>

This patch fixes a couple of language issues in the documentation
of the `patch' sub-command of git-add --interactive.

Signed-off-by: Benoit Sigoure <tsuna@lrde.epita.fr>
---
Use better wording proposed by Dscho.

 Documentation/git-add.txt |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 963e1ab..3117798 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -201,9 +201,9 @@ patch::
   the change of each hunk.  You can say:
 
        y - add the change from that hunk to index
-       n - do not add the change from that hunk to index
-       a - add the change from that hunk and all the rest to index
-       d - do not the change from that hunk nor any of the rest to index
+       n - skip this hunk
+       a - add the change from that hunk and all the remaining ones
+       d - skip this hunk, as well as the remaining ones
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
