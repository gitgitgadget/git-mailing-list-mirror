From: Edmundo Carmona <eantoranz@gmail.com>
Subject: [PATCH 2/2] checkout: adjust documentation to the two new options
Date: Sat, 24 Oct 2015 09:00:10 -0600
Message-ID: <1445698810-22726-1-git-send-email-eantoranz@gmail.com>
Cc: Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 24 17:00:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zq0J1-0006vU-Cw
	for gcvg-git-2@plane.gmane.org; Sat, 24 Oct 2015 17:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbbJXPAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2015 11:00:24 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:34582 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbbJXPAX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2015 11:00:23 -0400
Received: by ykdr3 with SMTP id r3so146962459ykd.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2015 08:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=zFpkijloZzkBK2zt5nYVb1fg6VvpoZRXSJ396a2ZADE=;
        b=Hz//qbjaVvK9v5kbr2auPKK+s3NNKqBg3o9a0ZllLN3o04qjJzejFX7KaNePyLSViv
         XsEjek94fZ+sFFPvCoucHQlTirOt2i01H8VQsaf9rdHQUP6hKPuTHl0CyFyulVpnrywl
         IlqPGtQ+4cDi0tE8ymhC+5n4+3WxQgy/alzZ8Ky5keAlUfUMJYHMSTgsS+mg4/oqyv8B
         X3QTZ2mqqO1fLZqAlyeK+5VX6IAWSr7ezrp8n/kmFsJ17c67RlzuhYdbRdZabZK2Uls7
         HrXEe3UySJ0vfiOdarKoof5XR22I0c9fOmJoRBAiPWXUuKRjF6I/IvEq2Gz45QCknWY+
         gQQQ==
X-Received: by 10.129.114.86 with SMTP id n83mr19331407ywc.332.1445698822736;
        Sat, 24 Oct 2015 08:00:22 -0700 (PDT)
Received: from linuxerio.cabletica.com (ip14-190-15-186.ct.co.cr. [186.15.190.14])
        by smtp.gmail.com with ESMTPSA id b133sm13110784ywc.39.2015.10.24.08.00.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Oct 2015 08:00:20 -0700 (PDT)
X-Mailer: git-send-email 2.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280125>

From: Edmundo Carmona Antoranz <eantoranz@gmail.com>

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 Documentation/git-checkout.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index e269fb1..4ff270c 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -250,6 +250,16 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 	out anyway. In other words, the ref can be held by more than one
 	worktree.
 
+--progress-no-tty
+	By default, git will refuse to write progress information if it
+	detects it's not connected to a tty. In order to avoid this check,
+	this option can be used.
+
+--progress-lf
+	By default, git will write progress information using "carriage
+	return" (ascii 0x0d) so that it stays on a single line. This
+	option will make git print progress information on separate lines.
+
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
 	when prepended with "refs/heads/", is a valid ref), then that
-- 
2.6.1
