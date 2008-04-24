From: Bart Trojanowski <bart@jukie.net>
Subject: [PATCH] make git-status use a pager
Date: Wed, 23 Apr 2008 20:57:48 -0400
Message-ID: <1208998668-28770-1-git-send-email-bart@jukie.net>
Cc: Bart Trojanowski <bart@jukie.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 03:13:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Joq1b-0004GC-0J
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 03:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbYDXBMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 21:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753277AbYDXBMg
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 21:12:36 -0400
Received: from tau.jukie.net ([216.239.93.128]:34401 "EHLO tau.jukie.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752831AbYDXBMf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 21:12:35 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Apr 2008 21:12:35 EDT
Received: by tau.jukie.net (Postfix, from userid 1000)
	id 2FCC3C00CA2; Wed, 23 Apr 2008 20:57:48 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.7.1150.g149d432
In-Reply-To: <>
References: <>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80279>

make git status act similar to git log and git diff by presenting long
output in a pager.

Signed-off-by: Bart Trojanowski <bart@jukie.net>
---
 git.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index c4e4644..89b431f 100644
--- a/git.c
+++ b/git.c
@@ -347,7 +347,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "shortlog", cmd_shortlog, USE_PAGER },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
-		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
+		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE | USE_PAGER },
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 		{ "tag", cmd_tag, RUN_SETUP },
-- 
1.5.5.1.80.g0f8afae
