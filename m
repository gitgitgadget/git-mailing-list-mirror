From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 3/7] Documentation: clarify track/no-track option.
Date: Mon, 16 Apr 2007 00:37:12 -0400
Message-ID: <7375.23060893199$1176698257@news.gmane.org>
References: <11766982362087-git-send-email->
 <11766982361830-git-send-email->
 <1176698236722-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 06:37:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdIy2-0008Sb-1D
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 06:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754484AbXDPEhW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 00:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754489AbXDPEhU
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 00:37:20 -0400
Received: from mail.fieldses.org ([66.93.2.214]:36495 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754484AbXDPEhS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 00:37:18 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HdIxo-0005YV-NF; Mon, 16 Apr 2007 00:37:16 -0400
X-Mailer: git-send-email 1.5.1.1.98.gedb4f
In-Reply-To: <1176698236722-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44573>

From: J. Bruce Fields <bfields@pad.(none)>

Fix the description of the --no-track option so it no longer says the
opposite of what was intended.  Also mention branch.autosetupmerge
explicitly.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/git-checkout.txt |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 2ead493..337b3d5 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -49,13 +49,17 @@ OPTIONS
 
 --track::
 	When -b is given and a branch is created off a remote branch,
-	setup so that git-pull will automatically retrieve data from
-	the remote branch.
+	set up configuration so that git-pull will automatically
+	retrieve data from the remote branch.  Set the
+	branch.autosetupmerge configuration variable to true if you
+	want git-checkout and git-branch to always behave as if
+	'--track' were given.
 
 --no-track::
 	When -b is given and a branch is created off a remote branch,
-	force that git-pull will automatically retrieve data from
-	the remote branch independent of the configuration settings.
+	set up configuration so that git-pull will not retrieve data
+	from the remote branch, ignoring the branch.autosetupmerge
+	configuration variable.
 
 -l::
 	Create the new branch's ref log.  This activates recording of
-- 
1.5.1.1.98.gedb4f
