From: =?UTF-8?q?Matthias=20Kr=C3=BCger?= <matthias.krueger@famsik.de>
Subject: [PATCH] git help config: s/insn/instruction/
Date: Wed, 27 Mar 2013 23:53:50 +0100
Message-ID: <1364424830-17108-1-git-send-email-matthias.krueger@famsik.de>
Cc: matthias.krueger@famsik.de, kumbayo84@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 28 00:25:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKzic-0008TW-2l
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 00:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585Ab3C0XYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 19:24:54 -0400
Received: from www.hamsked.org ([109.75.188.246]:56080 "EHLO www.hamsked.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753461Ab3C0XYy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 19:24:54 -0400
X-Greylist: delayed 1847 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Mar 2013 19:24:53 EDT
Received: from www.hamsked.org ([109.75.188.246] helo=localhost.localdomain)
	by www.hamsked.org with esmtp (Exim 4.72)
	(envelope-from <matthias.krueger@famsik.de>)
	id 1UKzEI-0003Dt-Cn; Wed, 27 Mar 2013 23:54:02 +0100
X-Mailer: git-send-email 1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219359>

"insn" appears to be an in-code abbreviation and should not appear in manual/help pages.
---
 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c1f435f..f79184c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -555,7 +555,7 @@ core.commentchar::
 	(default '#').
 
 sequence.editor::
-	Text editor used by `git rebase -i` for editing the rebase insn file.
+	Text editor used by `git rebase -i` for editing the rebase instruction file.
 	The value is meant to be interpreted by the shell when it is used.
 	It can be overridden by the `GIT_SEQUENCE_EDITOR` environment variable.
 	When not configured the default commit message editor is used instead.
-- 
1.8.2
