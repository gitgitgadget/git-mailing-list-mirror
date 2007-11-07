From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: [PATCH] Fix mistakes in the documentation of git-add --interactive.
Date: Wed,  7 Nov 2007 23:02:27 +0100
Message-ID: <1194472947-8601-1-git-send-email-tsuna@lrde.epita.fr>
References: <200711072150.18751.barra_cuda@katamail.com>
Cc: gitster@pobox.com, Benoit Sigoure <tsuna@lrde.epita.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 07 23:03:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipszv-0007Uf-Az
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 23:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759346AbXKGWCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 17:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759348AbXKGWCe
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 17:02:34 -0500
Received: from quanta.tsunanet.net ([82.229.223.213]:61564 "EHLO
	quanta.tsunanet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759328AbXKGWCd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 17:02:33 -0500
Received: by quanta.tsunanet.net (Postfix, from userid 501)
	id 4AD81C81A46; Wed,  7 Nov 2007 23:02:27 +0100 (CET)
X-Mailer: git-send-email 1.5.3.4.398.g859b
In-Reply-To: <200711072150.18751.barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63870>

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
