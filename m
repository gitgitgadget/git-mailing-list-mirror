From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Give git-am back the ability to add Signed-off-by lines.
Date: Tue, 6 Nov 2007 21:33:58 +0100
Message-ID: <200711062133.58903.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 21:34:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpV7r-0007lm-GO
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 21:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930AbXKFUeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 15:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754778AbXKFUeD
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 15:34:03 -0500
Received: from smtp5.srv.eunet.at ([193.154.160.227]:52890 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754704AbXKFUeB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 15:34:01 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 0E95613A85C;
	Tue,  6 Nov 2007 21:34:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id B492D59EB3;
	Tue,  6 Nov 2007 21:33:59 +0100 (CET)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63722>

This was lost in the migration to git-rev-parse --parseopt by commit
78443d90491c1b82afdffc3d5d2ab8c1a58928b5.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 876b973..e5af955 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -131,7 +131,7 @@ do
 		binary=t ;;
 	-3|--3way)
 		threeway=t ;;
-	-s--signoff)
+	-s|--signoff)
 		sign=t ;;
 	-u|--utf8)
 		utf8=t ;; # this is now default
-- 
1.5.3.4.315.g2ce38
