From: Andrew Ruder <andy@aeruder.net>
Subject: [PATCH] Add policy on user-interface changes
Date: Mon, 16 Apr 2007 00:35:25 -0500
Message-ID: <20070416053525.GA18821@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, andy@aeruder.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 08:08:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdKNe-0003sL-JK
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 08:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbXDPGH7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 02:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753962AbXDPGH7
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 02:07:59 -0400
Received: from www.aeruder.net ([65.254.53.245]:4031 "EHLO aeruder.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753667AbXDPGH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 02:07:59 -0400
X-Greylist: delayed 1952 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Apr 2007 02:07:59 EDT
Received: from aeruder.net (localhost [127.0.0.1])
	by aeruder.net (Postfix) with ESMTP id 55F774010A;
	Mon, 16 Apr 2007 00:35:26 -0500 (CDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44586>

Documentation/SubmittingPatches: Add note that all user interface changes
should include associated documentation updates.

Signed-off-by: Andrew Ruder <andy@aeruder.net>
---
 Documentation/SubmittingPatches |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 131bcff..2386f49 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -22,6 +22,9 @@ Checklist (and a short version for the impatient):
 	- provide additional information (which is unsuitable for
 	  the commit message) between the "---" and the diffstat
 	- send the patch to the list _and_ the maintainer
+	- if you change, add, or remove a command line option or
+	  make some other user interface change, the associated
+	  documentation should be updated as well.
 
 Long version:
 
-- 
1.5.1.1.98.gedb4f-dirty
