From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Add missing spaces in warnings about default remote
Date: Sat, 03 Feb 2007 20:34:46 -0500
Message-ID: <20070204013446.11077.11798.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun Feb 04 02:34:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDWHL-00007N-8X
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 02:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbXBDBet (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 20:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751879AbXBDBet
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 20:34:49 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:36247 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbXBDBes (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 20:34:48 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HDWGE-0004jq-Is
	for git@vger.kernel.org; Sat, 03 Feb 2007 20:33:42 -0500
Received: from localhost ([127.0.0.1] helo=dv.roinet.com)
	by gnu.org with esmtp (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1HDWHG-0002sx-7Z; Sat, 03 Feb 2007 20:34:46 -0500
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38631>

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 stgit/stack.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 6f0f67a..96863c6 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -419,7 +419,7 @@ class Series(StgitObject):
             return value
         elif 'origin' in git.remotes_list():
             print 'Notice: no parent remote declared for stack "%s", defaulting to "origin".' \
-                  'Consider setting "branch.%s.remote" with "git repo-config".' \
+                  ' Consider setting "branch.%s.remote" with "git repo-config".' \
                   % (self.__name, self.__name)
             return 'origin'
         else:
@@ -434,7 +434,7 @@ class Series(StgitObject):
             return value
         elif git.rev_parse('heads/origin'):
             print 'Notice: no parent branch declared for stack "%s", defaulting to "heads/origin".' \
-                  'Consider setting "branch.%s.merge" with "git repo-config".' \
+                  ' Consider setting "branch.%s.merge" with "git repo-config".' \
                   % (self.__name, self.__name)
             return 'heads/origin'
         else:
