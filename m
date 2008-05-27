From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] t5700-clone-reference: Quote $U
Date: Tue, 27 May 2008 09:36:22 +0200
Message-ID: <1211873782-28487-1-git-send-email-johannes.sixt@telecom.at>
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 27 09:37:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0tkJ-00024X-Dm
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 09:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756592AbYE0Hgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 03:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756523AbYE0Hgb
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 03:36:31 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:34592 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756543AbYE0Hga (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 03:36:30 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1K0tjL-0006bG-CU; Tue, 27 May 2008 09:36:26 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 06C83546; Tue, 27 May 2008 09:36:22 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id D2F79FA46; Tue, 27 May 2008 09:36:22 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.125.gb9f88
X-Spam-Score: -0.8 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_60=1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82984>

The new "trash directory" bites again.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 t/t5700-clone-reference.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index e1ca730..1c10916 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -52,13 +52,13 @@ diff expected current'
 
 cd "$base_dir"
 
-rm -f $U
+rm -f "$U"
 
 test_expect_success 'cloning with reference (no -l -s)' \
-'GIT_DEBUG_SEND_PACK=3 git clone --reference B "file://$(pwd)/A" D 3>$U'
+'GIT_DEBUG_SEND_PACK=3 git clone --reference B "file://$(pwd)/A" D 3>"$U"'
 
 test_expect_success 'fetched no objects' \
-'! grep "^want" $U'
+'! grep "^want" "$U"'
 
 cd "$base_dir"
 
-- 
1.5.5.1.125.gb9f88
