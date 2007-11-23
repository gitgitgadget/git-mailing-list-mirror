From: David Symonds <dsymonds@gmail.com>
Subject: [PATCH] Update RelNotes for 1.5.4 to reflect change in git-status output.
Date: Fri, 23 Nov 2007 22:13:23 +1100
Message-ID: <1195816403642-git-send-email-dsymonds@gmail.com>
Cc: git@vger.kernel.org, David Symonds <dsymonds@gmail.com>
To: Junio Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 12:13:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvWTm-00049K-84
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 12:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755484AbXKWLNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 06:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755467AbXKWLNb
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 06:13:31 -0500
Received: from ipmail05.adl2.internode.on.net ([203.16.214.145]:7765 "EHLO
	ipmail05.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755236AbXKWLNa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Nov 2007 06:13:30 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAJtDRkd5LDXQ/2dsb2JhbACBWw
X-IronPort-AV: E=Sophos;i="4.21,456,1188743400"; 
   d="scan'208";a="447039"
Received: from ppp121-44-53-208.lns10.syd7.internode.on.net (HELO localhost.localdomain) ([121.44.53.208])
  by ipmail05.adl2.internode.on.net with ESMTP; 23 Nov 2007 21:43:28 +1030
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65893>

Signed-off-by: David Symonds <dsymonds@gmail.com>
---
 Documentation/RelNotes-1.5.4.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/RelNotes-1.5.4.txt b/Documentation/RelNotes-1.5.4.txt
index a4a2a7f..70d1d6c 100644
--- a/Documentation/RelNotes-1.5.4.txt
+++ b/Documentation/RelNotes-1.5.4.txt
@@ -86,6 +86,10 @@ Updates since v1.5.3
    to allow checking out a path outside the current directory
    without cd'ing up.
 
+ * "git status" from a subdirectory now shows relative paths
+   which makes copy-and-pasting for git-checkout/git-add/git-rm
+   easier.
+
  * Output processing for '--pretty=format:<user format>' has
    been optimized.
 
-- 
1.5.3.1
