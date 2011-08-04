From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 05/23] git-check-attr: Add missing "&&"
Date: Thu,  4 Aug 2011 06:36:15 +0200
Message-ID: <1312432593-9841-6-git-send-email-mhagger@alum.mit.edu>
References: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 06:37:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QopgD-0005IJ-V9
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390Ab1HDEhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:37:05 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39640 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab1HDEg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:36:59 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB339.dip.t-dialin.net [84.190.179.57])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p744agHj029203;
	Thu, 4 Aug 2011 06:36:55 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178672>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t0003-attributes.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 8c76b79..dae76b3 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -35,7 +35,7 @@ test_expect_success 'setup' '
 		echo "h test=a/b/h" &&
 		echo "d/* test=a/b/d/*"
 		echo "d/yes notest"
-	) >a/b/.gitattributes
+	) >a/b/.gitattributes &&
 	(
 		echo "global test=global"
 	) >"$HOME"/global-gitattributes
-- 
1.7.6.8.gd2879
