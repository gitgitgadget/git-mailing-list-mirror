From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Fix t9000-init.sh - comment for initial commit is different
Date: Thu, 09 Feb 2006 05:01:49 -0500
Message-ID: <1139479309.2966.23.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Feb 09 11:02:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F78ch-0003m4-Kp
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 11:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422656AbWBIKBz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 05:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422652AbWBIKBz
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 05:01:55 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:43669 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1422656AbWBIKBy
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 05:01:54 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1F78ca-0001wb-Lu
	for git@vger.kernel.org; Thu, 09 Feb 2006 05:01:52 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1F78cY-0000hP-6f; Thu, 09 Feb 2006 05:01:50 -0500
To: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-Mailer: Evolution 2.5.90 (2.5.90-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15801>

[PATCH] Fix t9000-init.sh - comment for initial commit is different

Comment for initial commit has "Initial commit" prepended to it now. 
Update test to match.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 t/t9000-init.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/t9000-init.sh b/t/t9000-init.sh
index aef2587..b3b9df3 100755
--- a/t/t9000-init.sh
+++ b/t/t9000-init.sh
@@ -37,7 +37,8 @@ test_expect_success 'initialize with the
 test_expect_success 'check if we have a commit' \
 	'[ -s .git/refs/heads/master ] && cg-object-id -c HEAD'
 test_expect_success 'check if the commit is proper' \
-	'[ "$(git-cat-file commit HEAD | sed -n '\''/^parent/q; /^$/{n; :a p; n; b a}'\'')" = "silly commit message" ]'
+	'[ "$(git-cat-file commit HEAD | sed -n '\''/^parent/q; /^$/{n; :a p; n; b a}'\'')" = "Initial commit
+silly commit message" ]'
 test_expect_success 'check if we have populated index' \
 	'[ "$(git-ls-files | tr '\''\n'\'' " ")" = "file1 file2 " ]'
 test_expect_success 'blow away the repository' \

-- 
Regards,
Pavel Roskin
