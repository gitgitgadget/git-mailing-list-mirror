From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH] user-manual: Update for receive.denyCurrentBranch=refuse
Date: Fri, 08 Feb 2013 12:04:20 -0500
Message-ID: <d1f3f900d4886dca727a2176b606e3b76ef9369e.1360343016.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 19:05:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3sJo-0005eQ-5v
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 19:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946807Ab3BHSEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 13:04:37 -0500
Received: from vms173021pub.verizon.net ([206.46.173.21]:23370 "EHLO
	vms173021pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946702Ab3BHSEh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 13:04:37 -0500
X-Greylist: delayed 3602 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Feb 2013 13:04:37 EST
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173021.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MHW00A41VFA6W30@vms173021.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 08 Feb 2013 11:04:23 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 2C178877AAD; Fri,
 08 Feb 2013 12:04:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360343062; bh=8uoyeBf0t7m/sjLNSSqWw6QzNXXvR9UKxz34TE2/7Z4=;
	h=From:To:Cc:Subject:Date;
	b=Jk1mmlGRwNWgHntit0NYLjA+I0oykm7TG7mOhkQpV8Xz1JhOiE/e8FuutXHt3fzsc
 gkH8zaJx8hZ3pVo+UFMxkZduVAlAvOUQ8dxIDL2CDcmd5iN4si3VHY7YUKpd9ILstF
 e6o/YRSKeBQ1/pUi1rw68ll7cDM8zVgsCv7GdiFo=
X-Mailer: git-send-email 1.7.12.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215793>

From: "W. Trevor King" <wking@tremily.us>

acd2a45 (Refuse updating the current branch in a non-bare repository
via push, 2009-02-11) changed the default to refuse such a push, but
it forgot to update the docs.

7d182f5 (Documentation: receive.denyCurrentBranch defaults to
'refuse', 2010-03-17) updated Documentation/config.txt, but forgot to
update the user manual.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 5077e7c..8e55794 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1994,8 +1994,10 @@ handling this case.
 Note that the target of a "push" is normally a
 <<def_bare_repository,bare>> repository.  You can also push to a
 repository that has a checked-out working tree, but the working tree
-will not be updated by the push.  This may lead to unexpected results if
-the branch you push to is the currently checked-out branch!
+will not be updated by the push.  To protect against this, pushes to
+the currently checked-out branch of a repository are denied by
+default.  See the description of the receive.denyCurrentBranch option
+in linkgit:git-config[1] for details.
 
 As with `git fetch`, you may also set up configuration options to
 save typing; so, for example, after
-- 
1.8.1.336.g94702dd
