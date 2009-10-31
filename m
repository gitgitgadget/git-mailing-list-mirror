From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH 2/2] configure: allow user to set gitconfig, pager and editor
Date: Sat, 31 Oct 2009 16:41:35 -0400
Message-ID: <1257021695-21260-3-git-send-email-bwalton@artsci.utoronto.ca>
References: <1257021695-21260-1-git-send-email-bwalton@artsci.utoronto.ca>
 <1257021695-21260-2-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: gitster@pobox.com, jrnieder@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 31 21:41:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4Kln-00068J-Tl
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 21:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933242AbZJaUlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 16:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933236AbZJaUln
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 16:41:43 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:38886 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933230AbZJaUlj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 16:41:39 -0400
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:41963 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1N4Klc-0003LU-4y; Sat, 31 Oct 2009 16:41:44 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1N4Klc-0005bZ-2Y; Sat, 31 Oct 2009 16:41:44 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n9VKfitC021545;
	Sat, 31 Oct 2009 16:41:44 -0400
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1257021695-21260-2-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131856>

Use the new GIT_WITH_MAKE_VAR function to allow user specified
values for ETC_GITCONFIG, DEFAULT_PAGER and DEFAULT_EDITOR.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 configure.ac |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 2829dbb..d50d492 100644
--- a/configure.ac
+++ b/configure.ac
@@ -241,6 +241,16 @@ GIT_PARSE_WITH(iconv))
 # change being considered an inode change from the update-index perspective.
 
 #
+# Allow user to set ETC_GITCONFIG variable
+GIT_WITH_MAKE_VAR(gitconfig, ETC_GITCONFIG)
+#
+# Allow user to set the default pager
+GIT_WITH_MAKE_VAR(pager, DEFAULT_PAGER)
+#
+# Allow user to set the default editor
+GIT_WITH_MAKE_VAR(editor, DEFAULT_EDITOR)
+
+#
 # Define SHELL_PATH to provide path to shell.
 GIT_ARG_SET_PATH(shell)
 #
-- 
1.6.5
