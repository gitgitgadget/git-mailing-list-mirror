From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: add space after "W:" prefix in warning
Date: Thu, 30 Oct 2014 08:36:46 +0000
Message-ID: <1414658206-12629-2-git-send-email-normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 30 09:36:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjlDy-0004gS-Bm
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 09:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758496AbaJ3Igu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 04:36:50 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59014 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754161AbaJ3Igs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 04:36:48 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0754F1F7EC
	for <git@vger.kernel.org>; Thu, 30 Oct 2014 08:36:47 +0000 (UTC)
X-Mailer: git-send-email 2.1.2.568.g4ae9a7b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

And minor reformatting while we're in the area.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 perl/Git/SVN.pm | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 893b9a8..d9a52a5 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1798,12 +1798,10 @@ sub find_extra_svn_parents {
 		       );
 
 		if ($ninc) {
-			warn "W:svn cherry-pick ignored ($spec) - missing " .
+			warn "W: svn cherry-pick ignored ($spec) - missing " .
 				"$ninc commit(s) (eg $ifirst)\n";
 		} else {
-			warn
-				"Found merge parent ($spec): ",
-					$merge_tip, "\n";
+			warn "Found merge parent ($spec): ", $merge_tip, "\n";
 			push @new_parents, $merge_tip;
 		}
 	}
-- 
EW
