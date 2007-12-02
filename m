From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] Resurrect peek-remote
Date: Sat,  1 Dec 2007 23:45:58 -0800
Message-ID: <1196581559-1614-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 02 08:49:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyjZs-0004U3-Q6
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 08:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbXLBHqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 02:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbXLBHqE
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 02:46:04 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56174 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbXLBHqD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 02:46:03 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 0AED62EF
	for <git@vger.kernel.org>; Sun,  2 Dec 2007 02:46:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id A6DE39A3B5
	for <git@vger.kernel.org>; Sun,  2 Dec 2007 02:46:22 -0500 (EST)
X-Mailer: git-send-email 1.5.3.6.2090.g4ece0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66767>

8951d7c1f1ae38f34617b6c2490bf65e73e371f7 (Build in ls-remote) made
peek-remote as a synonym to ls-remote by enhancing the latter, but
at the same time actually _removed_ it, before we officially gave
removal notice.  This was bad.

Resurrect it for v1.5.4.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index a7e44a3..c35c870 100644
--- a/Makefile
+++ b/Makefile
@@ -259,7 +259,7 @@ EXTRA_PROGRAMS =
 BUILT_INS = \
 	git-format-patch$X git-show$X git-whatchanged$X git-cherry$X \
 	git-get-tar-commit-id$X git-init$X git-repo-config$X \
-	git-fsck-objects$X git-cherry-pick$X \
+	git-fsck-objects$X git-cherry-pick$X git-peek-remote$X \
 	$(patsubst builtin-%.o,git-%$X,$(BUILTIN_OBJS))
 
 # what 'all' will build and 'install' will install, in gitexecdir
-- 
1.5.3.6.2090.g4ece0
