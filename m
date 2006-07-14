From: Alp Toker <alp@atoker.com>
Subject: [PATCH] Documentation: Fix ssh:// URLs in generated documentation
Date: Fri, 14 Jul 2006 11:24:47 +0100
Message-ID: <1152872688966-git-send-email-alp@atoker.com>
References: <11528726881431-git-send-email-alp@atoker.com>
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Jul 14 12:24:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1Kqs-0002gy-R8
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 12:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbWGNKYv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 06:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161025AbWGNKYv
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 06:24:51 -0400
Received: from host-84-9-44-142.bulldogdsl.com ([84.9.44.142]:34567 "EHLO
	ndesk.org") by vger.kernel.org with ESMTP id S1161023AbWGNKYt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jul 2006 06:24:49 -0400
Received: by ndesk.org (Postfix, from userid 1000)
	id 506CC88EFF; Fri, 14 Jul 2006 11:24:48 +0100 (BST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.g28ec
In-Reply-To: <11528726881431-git-send-email-alp@atoker.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23884>

Commit c3f17061be95de3498449a548e93883aebff23d6 was causing warnings
during doc generation due to bad asciidoc markup.

This resulted in "ssh://[user@]host.xz/path/to/repo.git/" being rendered
as "host.xz/path/to/repo.git/" in the man pages and html output.

This patch converts sections listing URL formats to verbatim.

Signed-off-by: Alp Toker <alp@atoker.com>
---
 Documentation/urls.txt |   30 ++++++++++++------------------
 1 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 9abec80..a071915 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -4,33 +4,27 @@ GIT URLS[[URLS]]
 One of the following notations can be used
 to name the remote repository:
 
-===============================================================
-- rsync://host.xz/path/to/repo.git/
-- http://host.xz/path/to/repo.git/
-- https://host.xz/path/to/repo.git/
-- git://host.xz/path/to/repo.git/
-- git://host.xz/~user/path/to/repo.git/
-- ssh://[user@]host.xz/path/to/repo.git/
-- ssh://[user@]host.xz/~user/path/to/repo.git/
-- ssh://[user@]host.xz/~/path/to/repo.git
-===============================================================
+	rsync://host.xz/path/to/repo.git/
+	http://host.xz/path/to/repo.git/
+	https://host.xz/path/to/repo.git/
+	git://host.xz/path/to/repo.git/
+	git://host.xz/~user/path/to/repo.git/
+	ssh://[user@]host.xz/path/to/repo.git/
+	ssh://[user@]host.xz/~user/path/to/repo.git/
+	ssh://[user@]host.xz/~/path/to/repo.git
 
 SSH Is the default transport protocol and also supports an
 scp-like syntax.  Both syntaxes support username expansion,
 as does the native git protocol. The following three are
 identical to the last three above, respectively:
 
-===============================================================
-- host.xz:/path/to/repo.git/
-- host.xz:~user/path/to/repo.git/
-- host.xz:path/to/repo.git
-===============================================================
+	host.xz:/path/to/repo.git/
+	host.xz:~user/path/to/repo.git/
+	host.xz:path/to/repo.git
 
 To sync with a local directory, use:
 
-===============================================================
-- /path/to/repo.git/
-===============================================================
+	/path/to/repo.git/
 
 REMOTES
 -------
-- 
1.4.1.g28ec
