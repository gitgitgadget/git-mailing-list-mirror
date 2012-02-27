From: mhagger@alum.mit.edu
Subject: [PATCH 2/2] post-receive-email: match up $LOGBEGIN..$LOGEND pairs correctly
Date: Mon, 27 Feb 2012 19:34:10 +0100
Message-ID: <1330367650-23091-3-git-send-email-mhagger@alum.mit.edu>
References: <1330367650-23091-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, "Kevin P. Fleming" <kpfleming@digium.com>,
	Andy Parkins <andyparkins@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 19:34:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S25P5-0004iB-88
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 19:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563Ab2B0Se0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 13:34:26 -0500
Received: from mail.berlin.jpk.com ([212.222.128.130]:54187 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523Ab2B0SeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 13:34:25 -0500
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1S25Nx-00065x-Kp; Mon, 27 Feb 2012 19:33:21 +0100
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1330367650-23091-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191646>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 contrib/hooks/post-receive-email |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index ac2e0ed..01af9df 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -460,7 +460,7 @@ generate_delete_branch_email()
 {
 	echo "       was  $oldrev"
 	echo ""
-	echo $LOGEND
+	echo $LOGBEGIN
 	git show -s --pretty=oneline $oldrev
 	echo $LOGEND
 }
@@ -560,7 +560,7 @@ generate_delete_atag_email()
 {
 	echo "       was  $oldrev"
 	echo ""
-	echo $LOGEND
+	echo $LOGBEGIN
 	git show -s --pretty=oneline $oldrev
 	echo $LOGEND
 }
@@ -625,7 +625,7 @@ generate_delete_general_email()
 {
 	echo "       was  $oldrev"
 	echo ""
-	echo $LOGEND
+	echo $LOGBEGIN
 	git show -s --pretty=oneline $oldrev
 	echo $LOGEND
 }
-- 
1.7.9
