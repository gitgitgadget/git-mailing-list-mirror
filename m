From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH 3/4] Documentation: mention branches rather than heads
Date: Sun, 18 Jan 2009 15:36:57 +0100
Message-ID: <1232289418-25627-4-git-send-email-mail@cup.kalibalik.dk>
References: <1232289418-25627-1-git-send-email-mail@cup.kalibalik.dk>
 <1232289418-25627-2-git-send-email-mail@cup.kalibalik.dk>
 <1232289418-25627-3-git-send-email-mail@cup.kalibalik.dk>
Cc: git@vger.kernel.org, Anders Melchiorsen <mail@cup.kalibalik.dk>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 18 15:38:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOYnU-0002Y3-Fw
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 15:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762222AbZAROhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 09:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762055AbZAROhL
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 09:37:11 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:46802 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760494AbZAROhC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 09:37:02 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id E186030881;
	Sun, 18 Jan 2009 15:36:24 +0100 (CET)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 680B130013;
	Sun, 18 Jan 2009 15:36:23 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2.514.g23abd3
In-Reply-To: <1232289418-25627-3-git-send-email-mail@cup.kalibalik.dk>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106196>

Most of the git push page talks about branches, so make it consistent
also in this paragraph.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---
 Documentation/git-push.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 6d3c711..a7a6f4c 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -57,8 +57,8 @@ Pushing an empty <src> allows you to delete the <dst> ref from
 the remote repository.
 +
 The special refspec `:` (or `+:` to allow non-fast forward updates)
-directs git to push "matching" heads: for every head that exists on
-the local side, the remote side is updated if a head of the same name
+directs git to push "matching" branches: for every branch that exists on
+the local side, the remote side is updated if a branch of the same name
 already exists on the remote side.  This is the default operation mode
 if no explicit refspec is found (that is neither on the command line
 nor in any Push line of the corresponding remotes file---see below).
-- 
1.6.0.2.514.g23abd3
