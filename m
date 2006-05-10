From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cg-status -- disambiguate parameters
Date: Wed, 10 May 2006 17:02:17 +1200
Message-ID: <11472373372170-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed May 10 06:58:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdgmA-00030X-VU
	for gcvg-git@gmane.org; Wed, 10 May 2006 06:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWEJE6Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 00:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWEJE6Q
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 00:58:16 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:22722 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S964818AbWEJE6P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 May 2006 00:58:15 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1Fdgm5-0002CQ-4q; Wed, 10 May 2006 16:58:13 +1200
Received: from mltest ([127.0.0.1] helo=localhost.localdomain)
	by mltest with esmtp (Exim 3.36 #1 (Debian))
	id 1Fdgq1-0007zU-00; Wed, 10 May 2006 17:02:17 +1200
To: pasky@suse.cz, git@vger.kernel.org, peter.bulmer@catalyst.net.nz
X-Mailer: git-send-email 1.3.0.g9927-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19876>

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 cg-status |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

81fa6ce82f47e4973b172eddd6bb6f1b2f2bff93
diff --git a/cg-status b/cg-status
index 944f9c5..214d6cf 100755
--- a/cg-status
+++ b/cg-status
@@ -238,7 +238,7 @@ if [ "$workstatus" ]; then
 		git-diff-index HEAD -- "${basepath:-.}" | cut -f5- -d' ' | 
 		while IFS=$'\t' read -r mode file; do
 			if [ "$mode" = D ]; then
-				[ "$(git-diff-files "$file")" ] && mode=!
+				[ "$(git-diff-files -- "$file")" ] && mode=!
 			elif [ "$mode" = M ] && [ "$commitignore" ]; then
 				fgrep -qx "$file" "$_git/commit-ignore" && mode=m
 			fi
-- 
1.3.2.g82000
