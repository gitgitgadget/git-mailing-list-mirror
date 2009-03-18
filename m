From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 1/3] rebase: fix typo (force_rebas -> force-rebas)
Date: Wed, 18 Mar 2009 19:05:56 +0100
Message-ID: <1237399558-27289-1-git-send-email-barra_cuda@katamail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 18:59:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk03L-0000s2-CI
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 18:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322AbZCRR5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 13:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755123AbZCRR5c
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 13:57:32 -0400
Received: from smtp.katamail.com ([62.149.157.154]:53113 "HELO smtp2.aruba.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754143AbZCRR5b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 13:57:31 -0400
Received: (qmail 21837 invoked by uid 89); 18 Mar 2009 17:57:24 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.57.140)
  by smtp2-pc with SMTP; 18 Mar 2009 17:57:23 -0000
X-Mailer: git-send-email 1.6.2.22.gc2ac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113642>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 git-rebase.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index d38ab0b..e38d68a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -315,7 +315,7 @@ do
 	--root)
 		rebase_root=t
 		;;
-	-f|--f|--fo|--for|--forc|force|--force-r|--force-re|--force-reb|--force-reba|--force_rebas|--force-rebase)
+	-f|--f|--fo|--for|--forc|force|--force-r|--force-re|--force-reb|--force-reba|--force-rebas|--force-rebase)
 		force_rebase=t
 		;;
 	-*)
-- 
1.6.2.22.gc2ac
