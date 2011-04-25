From: Valentin Haenel <valentin.haenel@gmx.de>
Subject: [PATCH] git-svn.txt: fix usage of --add-author-from
Date: Mon, 25 Apr 2011 23:36:15 +0200
Message-ID: <1303767375-14887-1-git-send-email-valentin.haenel@gmx.de>
References: <20110425210623.GB13953@dcvr.yhbt.net>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Valentin Haenel <valentin.haenel@gmx.de>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Apr 25 23:38:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QETUK-0001Zm-5P
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 23:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756108Ab1DYVia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 17:38:30 -0400
Received: from kudu.in-berlin.de ([192.109.42.123]:54486 "EHLO
	kudu.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265Ab1DYVia (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 17:38:30 -0400
Received: from kudu.in-berlin.de (localhost [127.0.0.1])
	by kudu.in-berlin.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p3PLcPNX015082;
	Mon, 25 Apr 2011 23:38:25 +0200
Received: (from esc@localhost)
	by kudu.in-berlin.de (8.14.3/8.14.3/Submit) id p3PLcOum015081;
	Mon, 25 Apr 2011 23:38:24 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <20110425210623.GB13953@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172049>

The option '--add-author-from' is used in 'commit-diff', 'set-tree', and
'dcommit'

Signed-off-by: Valentin Haenel <valentin.haenel@gmx.de>
Acked-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 5c75d71..4865007 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -567,7 +567,7 @@ creating the branch or tag.
 	in the log message and use that as the author string.
 	When committing to svn from git (as part of commit or dcommit
 --add-author-from::
-	When committing to svn from git (as part of 'commit' or 'dcommit'
+	When committing to svn from git (as part of 'commit-diff', 'set-tree' or 'dcommit'
 	operations), if the existing log message doesn't already have a
 	`From:` or `Signed-off-by:` line, append a `From:` line based on the
 	git commit's author string.  If you use this, then `--use-log-author`
-- 
1.7.1
