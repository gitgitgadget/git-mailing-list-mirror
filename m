From: Alp Toker <alp@atoker.com>
Subject: [PATCH] Revert "Documentation: Fix ssh://[user@]host.xz URL"
Date: Fri, 14 Jul 2006 11:24:46 +0100
Message-ID: <11528726881431-git-send-email-alp@atoker.com>
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Jul 14 12:24:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1Kqt-0002gy-Su
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 12:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbWGNKYu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 06:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161025AbWGNKYu
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 06:24:50 -0400
Received: from host-84-9-44-142.bulldogdsl.com ([84.9.44.142]:33287 "EHLO
	ndesk.org") by vger.kernel.org with ESMTP id S1161024AbWGNKYt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jul 2006 06:24:49 -0400
Received: by ndesk.org (Postfix, from userid 1000)
	id 2E09F88EA8; Fri, 14 Jul 2006 11:24:48 +0100 (BST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.g28ec
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23883>

This reverts commit 8d5e26848d0ddd5063f078b0c34c6c48b68d0d94.

The patch did not eliminate warnings caused by bad asciidoc markup.
Nor did it correct the generated output, which remains unchanged.

Signed-off-by: Alp Toker <alp@atoker.com>
---
 Documentation/urls.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 93378d2..9abec80 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -10,9 +10,9 @@ to name the remote repository:
 - https://host.xz/path/to/repo.git/
 - git://host.xz/path/to/repo.git/
 - git://host.xz/~user/path/to/repo.git/
-- ssh://+++[user@+++]host.xz/path/to/repo.git/
-- ssh://+++[user@+++]host.xz/~user/path/to/repo.git/
-- ssh://+++[user@+++]host.xz/~/path/to/repo.git
+- ssh://[user@]host.xz/path/to/repo.git/
+- ssh://[user@]host.xz/~user/path/to/repo.git/
+- ssh://[user@]host.xz/~/path/to/repo.git
 ===============================================================
 
 SSH Is the default transport protocol and also supports an
-- 
1.4.1.g28ec
