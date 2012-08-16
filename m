From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 01/12] git p4 test: remove bash-ism of combined export/assignment
Date: Thu, 16 Aug 2012 19:35:03 -0400
Message-ID: <1345160114-27654-2-git-send-email-pw@padd.com>
References: <1345160114-27654-1-git-send-email-pw@padd.com>
Cc: Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 01:35:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T29bM-0002Wg-Ee
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 01:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902Ab2HPXfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 19:35:39 -0400
Received: from honk.padd.com ([74.3.171.149]:47753 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223Ab2HPXfi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 19:35:38 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id C48C7D27;
	Thu, 16 Aug 2012 16:35:37 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id BCC9B313FD; Thu, 16 Aug 2012 19:35:34 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.rc2.111.g96f7c73
In-Reply-To: <1345160114-27654-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 2d753ab..482eeac 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -26,9 +26,10 @@ testid=${this_test#t}
 git_p4_test_start=9800
 P4DPORT=$((10669 + ($testid - $git_p4_test_start)))
 
-export P4PORT=localhost:$P4DPORT
-export P4CLIENT=client
-export P4EDITOR=:
+P4PORT=localhost:$P4DPORT
+P4CLIENT=client
+P4EDITOR=:
+export P4PORT P4CLIENT P4EDITOR
 
 db="$TRASH_DIRECTORY/db"
 cli=$(test-path-utils real_path "$TRASH_DIRECTORY/cli")
-- 
1.7.11.4
