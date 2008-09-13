From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Cosmetical command name fix
Date: Sat, 13 Sep 2008 19:31:31 +0300
Message-ID: <20080913163131.GA5145@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 13 18:32:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeY3K-0006CF-OD
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 18:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbYIMQbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2008 12:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751744AbYIMQbd
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Sep 2008 12:31:33 -0400
Received: from zakalwe.fi ([80.83.5.154]:47327 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781AbYIMQbd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2008 12:31:33 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id CD2E12BC73; Sat, 13 Sep 2008 19:31:31 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95808>

If we came from git.c the first arg would be "archive".
"git-archive" isn't a bug because cmd_archive() doesn't check
the first arg.

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
---
 builtin-tar-tree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index edcf72a..dd7326a 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -28,7 +28,7 @@ int cmd_tar_tree(int argc, const char **argv, const char *prefix)
 	char *basedir_arg;
 	int nargc = 0;
 
-	nargv[nargc++] = "git-archive";
+	nargv[nargc++] = "archive";
 	nargv[nargc++] = "--format=tar";
 
 	if (2 <= argc && !prefixcmp(argv[1], "--remote=")) {
-- 
1.6.0.1
