From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 5/5] Teach GIT-VERSION-GEN about the .git file
Date: Sun, 17 Feb 2008 23:14:16 +0100
Message-ID: <1203286456-26033-6-git-send-email-hjemli@gmail.com>
References: <1203286456-26033-1-git-send-email-hjemli@gmail.com>
 <1203286456-26033-2-git-send-email-hjemli@gmail.com>
 <1203286456-26033-3-git-send-email-hjemli@gmail.com>
 <1203286456-26033-4-git-send-email-hjemli@gmail.com>
 <1203286456-26033-5-git-send-email-hjemli@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 23:16:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQroF-0004Gc-E3
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 23:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372AbYBQWPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 17:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753523AbYBQWPw
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 17:15:52 -0500
Received: from mail49.e.nsc.no ([193.213.115.49]:36756 "EHLO mail49.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753034AbYBQWPv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 17:15:51 -0500
Received: from localhost.localdomain (ti231210a341-0179.bb.online.no [88.88.168.179])
	by mail49.nsc.no (8.13.8/8.13.5) with ESMTP id m1HMFTkt007281;
	Sun, 17 Feb 2008 23:15:33 +0100 (MET)
X-Mailer: git-send-email 1.5.4.1.188.gfde78
In-Reply-To: <1203286456-26033-5-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74191>

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 GIT-VERSION-GEN |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 38a3273..2432a4f 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -11,7 +11,7 @@ LF='
 if test -f version
 then
 	VN=$(cat version) || VN="$DEF_VER"
-elif test -d .git &&
+elif test -d .git -o -f .git &&
 	VN=$(git describe --abbrev=4 HEAD 2>/dev/null) &&
 	case "$VN" in
 	*$LF*) (exit 1) ;;
-- 
1.5.4.1.188.gdfa6c
