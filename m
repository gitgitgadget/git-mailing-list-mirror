From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH 6/7] Documentation: mention branches rather than heads
Date: Wed, 29 Oct 2008 21:25:44 +0100
Message-ID: <1225311945-17100-7-git-send-email-mail@cup.kalibalik.dk>
References: <1225311945-17100-1-git-send-email-mail@cup.kalibalik.dk>
 <1225311945-17100-2-git-send-email-mail@cup.kalibalik.dk>
 <1225311945-17100-3-git-send-email-mail@cup.kalibalik.dk>
 <1225311945-17100-4-git-send-email-mail@cup.kalibalik.dk>
 <1225311945-17100-5-git-send-email-mail@cup.kalibalik.dk>
 <1225311945-17100-6-git-send-email-mail@cup.kalibalik.dk>
Cc: gitster@pobox.com, Anders Melchiorsen <mail@cup.kalibalik.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 29 21:28:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvHeB-0006P1-2c
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 21:28:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270AbYJ2UZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 16:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754531AbYJ2UZ5
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 16:25:57 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:42699 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754270AbYJ2UZt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 16:25:49 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id D222814087;
	Wed, 29 Oct 2008 21:25:49 +0100 (CET)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 3385714083;
	Wed, 29 Oct 2008 21:25:49 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2.514.g23abd3
In-Reply-To: <1225311945-17100-6-git-send-email-mail@cup.kalibalik.dk>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99404>

Most of the git push page talks about branches, so make it consistent
also in this paragraph.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---
 Documentation/git-push.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 52035db..4e339c7 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -53,8 +53,8 @@ Pushing an empty <src> allows you to delete the <dst> ref from
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
