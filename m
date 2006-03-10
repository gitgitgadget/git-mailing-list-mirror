From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Fix testsuite to account for removed dot
Date: Fri, 10 Mar 2006 16:21:05 -0500
Message-ID: <20060310212105.22842.97865.stgit@dv.roinet.com>
X-From: git-owner@vger.kernel.org Fri Mar 10 22:21:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHp31-0002sH-BI
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 22:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbWCJVVL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 16:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752043AbWCJVVL
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 16:21:11 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:142 "EHLO fencepost.gnu.org")
	by vger.kernel.org with ESMTP id S1752048AbWCJVVI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Mar 2006 16:21:08 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FHp2o-0002GY-MK
	for git@vger.kernel.org; Fri, 10 Mar 2006 16:21:06 -0500
Received: from localhost.roinet.com ([127.0.0.1] helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1FHp2n-0005wb-Ma
	for git@vger.kernel.org; Fri, 10 Mar 2006 16:21:05 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17482>

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 t/t1200-tutorial.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
index c8a85f9..1002413 100755
--- a/t/t1200-tutorial.sh
+++ b/t/t1200-tutorial.sh
@@ -128,7 +128,7 @@ test_expect_success 'git show-branch' 'c
 git checkout mybranch
 
 cat > resolve.expect << EOF
-Updating from VARIABLE to VARIABLE.
+Updating from VARIABLE to VARIABLE
  example |    1 +
  hello   |    1 +
  2 files changed, 2 insertions(+), 0 deletions(-)
