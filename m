From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH 4/4] Documentation: avoid using undefined parameters
Date: Sun, 18 Jan 2009 15:36:58 +0100
Message-ID: <1232289418-25627-5-git-send-email-mail@cup.kalibalik.dk>
References: <1232289418-25627-1-git-send-email-mail@cup.kalibalik.dk>
 <1232289418-25627-2-git-send-email-mail@cup.kalibalik.dk>
 <1232289418-25627-3-git-send-email-mail@cup.kalibalik.dk>
 <1232289418-25627-4-git-send-email-mail@cup.kalibalik.dk>
Cc: git@vger.kernel.org, Anders Melchiorsen <mail@cup.kalibalik.dk>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 18 15:38:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOYnS-0002Y3-FC
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 15:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761533AbZAROhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 09:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760846AbZAROhE
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 09:37:04 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:46799 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759932AbZAROhB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 09:37:01 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 9224C30B4D;
	Sun, 18 Jan 2009 15:36:24 +0100 (CET)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id A36463087C;
	Sun, 18 Jan 2009 15:36:23 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2.514.g23abd3
In-Reply-To: <1232289418-25627-4-git-send-email-mail@cup.kalibalik.dk>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106194>

The <ref> parameter has not been introduced, so rewrite to
avoid it.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---
 Documentation/git-push.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index a7a6f4c..7b27dc6 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -50,8 +50,8 @@ even if it does not result in a fast forward update.
 +
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
 +
-A parameter <ref> without a colon pushes the <ref> from the source
-repository to the destination repository under the same name.
+A lonely <src> parameter (without a colon and a destination) pushes
+the <src> to the same name in the destination repository.
 +
 Pushing an empty <src> allows you to delete the <dst> ref from
 the remote repository.
-- 
1.6.0.2.514.g23abd3
