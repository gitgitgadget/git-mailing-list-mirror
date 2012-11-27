From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH] Documentation/git-push.txt: fix typo in remote tracking branch path
Date: Mon, 26 Nov 2012 16:55:48 -0800
Message-ID: <1353977748-17110-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 01:56:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td9TM-0003sW-60
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 01:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757136Ab2K0A4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 19:56:08 -0500
Received: from hqemgate03.nvidia.com ([216.228.121.140]:9111 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849Ab2K0A4H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 19:56:07 -0500
Received: from hqnvupgp08.nvidia.com (Not Verified[216.228.121.13]) by hqemgate03.nvidia.com
	id <B50b410610000>; Mon, 26 Nov 2012 16:59:13 -0800
Received: from hqemhub02.nvidia.com ([172.17.108.22])
  by hqnvupgp08.nvidia.com (PGP Universal service);
  Mon, 26 Nov 2012 16:56:05 -0800
X-PGP-Universal: processed;
	by hqnvupgp08.nvidia.com on Mon, 26 Nov 2012 16:56:05 -0800
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub02.nvidia.com
 (172.20.150.31) with Microsoft SMTP Server id 8.3.279.1; Mon, 26 Nov 2012
 16:56:05 -0800
X-Mailer: git-send-email 1.7.8.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210520>

From: Brandon Casey <drafnel@gmail.com>

This example in the documentation seems to be trying to describe the likely
remote tracking branch that will be updated by a push to the "origin" remote
with the destination branch 'satellite/master', but it forgot to specify
the remote name in the path specification.

So,

   refs/remotes/satellite/master

should be spelled like

   refs/remotes/origin/satellite/master

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 Documentation/git-push.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index fe46c42..a18f929 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -387,8 +387,8 @@ the ones in the examples below) can be configured as the default for
 `git push origin master:satellite/master dev:satellite/dev`::
 	Use the source ref that matches `master` (e.g. `refs/heads/master`)
 	to update the ref that matches `satellite/master` (most probably
-	`refs/remotes/satellite/master`) in the `origin` repository, then
-	do the same for `dev` and `satellite/dev`.
+	`refs/remotes/origin/satellite/master`) in the `origin` repository,
+	then do the same for `dev` and `satellite/dev`.
 
 `git push origin HEAD:master`::
 	Push the current branch to the remote ref matching `master` in the
-- 
1.7.8.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
