From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 2/3] Documentation: fix --no-verify documentation for "git commit"
Date: Sat,  8 Dec 2007 12:38:08 +0100
Message-ID: <1197113889-16243-3-git-send-email-win@wincent.com>
References: <1197113889-16243-1-git-send-email-win@wincent.com>
 <1197113889-16243-2-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, krh@redhat.com,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 12:39:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0y1m-0002SN-N6
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 12:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368AbXLHLiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 06:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753362AbXLHLiu
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 06:38:50 -0500
Received: from wincent.com ([72.3.236.74]:34211 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753189AbXLHLit (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 06:38:49 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB8BcAAB021147;
	Sat, 8 Dec 2007 05:38:14 -0600
X-Mailer: git-send-email 1.5.3.7.1115.gaa595
In-Reply-To: <1197113889-16243-2-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67544>

The documentation for the --no-verify switch should mention the
commit-msg hook, not just the pre-commit hook.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 Documentation/git-commit.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 4bb2791..4261384 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -86,7 +86,7 @@ OPTIONS
 	Add Signed-off-by line at the end of the commit message.
 
 --no-verify::
-	This option bypasses the pre-commit hook.
+	This option bypasses the pre-commit and commit-msg hooks.
 	See also link:hooks.html[hooks].
 
 --allow-empty::
-- 
1.5.3.7.1115.gaa595
