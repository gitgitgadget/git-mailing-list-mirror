From: "Josh England" <jjengla@sandia.gov>
Subject: [PATCH] Minor usage update in setgitperms.perl
Date: Tue,  9 Oct 2007 10:04:42 -0600
Message-ID: <1191945882-21878-1-git-send-email-jjengla@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Josh England" <jjengla@sandia.gov>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 18:06:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfHag-0001Dc-QS
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 18:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145AbXJIQFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 12:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754290AbXJIQFh
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 12:05:37 -0400
Received: from mm04snlnto.sandia.gov ([132.175.109.21]:2045 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbXJIQFg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 12:05:36 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Tue, 09 Oct 2007 10:05:24 -0600
X-Server-Uuid: 6CEB1540-FE13-491B-9872-FD67060ED864
Received: from ES23SNLNT.srn.sandia.gov (ec04snlnt.sandia.gov
 [134.253.164.156] (may be forged)) by mailgate.sandia.gov (
 8.14.1/8.14.1) with ESMTP id l99G5OdD025563 for <git@vger.kernel.org>;
 Tue, 9 Oct 2007 10:05:24 -0600
Received: from ef02snlnt.srn.sandia.gov ([134.253.164.132]) by
 ES23SNLNT.srn.sandia.gov with Microsoft SMTPSVC(6.0.3790.3959); Tue, 9
 Oct 2007 10:05:24 -0600
Received: from truth ([134.253.45.6]) by ef02snlnt.srn.sandia.gov with
 Microsoft SMTPSVC(6.0.3790.3959); Tue, 9 Oct 2007 10:05:22 -0600
Received: by truth (sSMTP sendmail emulation); Tue, 9 Oct 2007 10:04:42
 -0600
X-Mailer: git-send-email 1.5.3.2.111.g5166-dirty
X-OriginalArrivalTime: 09 Oct 2007 16:05:23.0020 (UTC)
 FILETIME=[329330C0:01C80A8E]
X-TMWD-Spam-Summary: TS=20071009160527; SEV=2.2.2; DFV=B2007100913;
 IFV=2.0.4,4.0-9; AIF=B2007100913; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230342E34373042413643372E303038313A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007100913_5.02.0125_4.0-9
X-WSS-ID: 6B15794E2A0295893-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60420>

Signed-off-by: Josh England <jjengla@sandia.gov>
---
 contrib/hooks/setgitperms.perl |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/contrib/hooks/setgitperms.perl b/contrib/hooks/setgitperms.perl
index 5e3b89d..bd48e27 100644
--- a/contrib/hooks/setgitperms.perl
+++ b/contrib/hooks/setgitperms.perl
@@ -8,13 +8,14 @@
 # To save permissions/ownership data, place this script in your .git/hooks
 # directory and enable a `pre-commit` hook with the following lines:
 #      #!/bin/sh
-#     . git-sh-setup
+#     SUBDIRECTORY_OK=1 . git-sh-setup
 #     $GIT_DIR/hooks/setgitperms.perl -r
 #
 # To restore permissions/ownership data, place this script in your .git/hooks
-# directory and enable a `post-merge` hook with the following lines:
+# directory and enable a `post-merge` and `post-checkout` hook with the
+# following lines:
 #      #!/bin/sh
-#     . git-sh-setup
+#     SUBDIRECTORY_OK=1 . git-sh-setup
 #     $GIT_DIR/hooks/setgitperms.perl -w
 #
 use strict;
-- 
1.5.3.2.111.g5166-dirty
