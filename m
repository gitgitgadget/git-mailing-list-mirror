From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH] cherry-pick/revert: make usage say '<commit-ish>...'
Date: Mon, 22 Apr 2013 18:57:37 +0300
Message-ID: <1366646257-27648-1-git-send-email-kevin@bracey.fi>
Cc: Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 22 18:07:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUJHE-0006qy-Ms
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 18:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076Ab3DVQHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 12:07:33 -0400
Received: from 13.mo3.mail-out.ovh.net ([188.165.33.202]:38292 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752885Ab3DVQHc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 12:07:32 -0400
Received: from mail91.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 21091FF897A
	for <git@vger.kernel.org>; Mon, 22 Apr 2013 17:57:52 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 22 Apr 2013 17:57:51 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 22 Apr 2013 17:57:50 +0200
X-Ovh-Mailout: 178.32.228.3 (mo3.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.255.g39c5835
X-Ovh-Tracer-Id: 6772850890507063518
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrfeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.500066/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrfeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222035>

The usage string for cherry-pick and revert has never been updated to
reflect their ability to handle multiple commits. Other documentation is
already correct.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 builtin/revert.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index c5e36b9..0401fdb 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -19,13 +19,13 @@
  */
 
 static const char * const revert_usage[] = {
-	N_("git revert [options] <commit-ish>"),
+	N_("git revert [options] <commit-ish>..."),
 	N_("git revert <subcommand>"),
 	NULL
 };
 
 static const char * const cherry_pick_usage[] = {
-	N_("git cherry-pick [options] <commit-ish>"),
+	N_("git cherry-pick [options] <commit-ish>..."),
 	N_("git cherry-pick <subcommand>"),
 	NULL
 };
-- 
1.8.2.255.g39c5835
