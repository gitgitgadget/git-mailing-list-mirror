From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH 2/4] Documentation: remove a redundant elaboration
Date: Sun, 18 Jan 2009 15:36:56 +0100
Message-ID: <1232289418-25627-3-git-send-email-mail@cup.kalibalik.dk>
References: <1232289418-25627-1-git-send-email-mail@cup.kalibalik.dk>
 <1232289418-25627-2-git-send-email-mail@cup.kalibalik.dk>
Cc: git@vger.kernel.org, Anders Melchiorsen <mail@cup.kalibalik.dk>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 18 15:38:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOYnT-0002Y3-QS
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 15:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762158AbZAROhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 09:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760846AbZAROhI
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 09:37:08 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:46793 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754313AbZAROhA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 09:37:00 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id CA27D30B53;
	Sun, 18 Jan 2009 15:36:23 +0100 (CET)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 5519E30B4D;
	Sun, 18 Jan 2009 15:36:23 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2.514.g23abd3
In-Reply-To: <1232289418-25627-2-git-send-email-mail@cup.kalibalik.dk>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106195>

The comment in parentheses is wrong, as one has to leave out both the
colon and <dst>. This situation is covered by the section a few lines
down:

  A parameter <ref> without a colon pushes the <ref> from the source
  repository to the destination repository under the same name.

So, just remove the parentheses.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---
 Documentation/git-push.txt |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 8bfa7cb..6d3c711 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -44,8 +44,7 @@ tip of `master` branch); see linkgit:git-rev-parse[1]) that you
 want to push.  The <dst> side represents the destination location.
 +
 The local ref that matches <src> is used
-to fast forward the remote ref that matches <dst> (or, if no <dst> was
-specified, the same ref that <src> referred to locally).  If
+to fast forward the remote ref that matches <dst>.  If
 the optional leading plus `+` is used, the remote ref is updated
 even if it does not result in a fast forward update.
 +
-- 
1.6.0.2.514.g23abd3
