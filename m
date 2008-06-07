From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git-rebase -i: mention the short command aliases in the todo list
Date: Sat,  7 Jun 2008 18:20:19 +0200
Message-ID: <1212855619-5569-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 18:21:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K51AH-0003Y5-MK
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 18:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760725AbYFGQUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 12:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760311AbYFGQUU
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 12:20:20 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:39958 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759027AbYFGQUT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 12:20:19 -0400
Received: from vmobile.example.net (dsl5401CF9A.pool.t-online.hu [84.1.207.154])
	by yugo.frugalware.org (Postfix) with ESMTP id 0A2321DDC5B;
	Sat,  7 Jun 2008 18:20:17 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id B965018E2A7; Sat,  7 Jun 2008 18:20:19 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84213>

git rebase -i already supports 'p', 'e' and 's' as aliases for 'pick',
'edit' and 'squash', but one could know it only by reading the source
code. If a user rebases a lot, it's quite handy, so mention these short
forms as well.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 git-rebase--interactive.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0ca986f..a64d9d5 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -530,9 +530,9 @@ do
 # Rebase $SHORTUPSTREAM..$SHORTHEAD onto $SHORTONTO
 #
 # Commands:
-#  pick = use commit
-#  edit = use commit, but stop for amending
-#  squash = use commit, but meld into previous commit
+#  p, pick = use commit
+#  e, edit = use commit, but stop for amending
+#  s, squash = use commit, but meld into previous commit
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
-- 
1.5.6.rc0.dirty
