From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Document commit.template configuration variable.
Date: Thu, 26 Jul 2007 16:34:59 -0400
Message-ID: <20070726203459.GA10283@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 22:35:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEA35-0007Sa-J1
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 22:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933939AbXGZUfA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 16:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760140AbXGZUfA
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 16:35:00 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:47835 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756499AbXGZUe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 16:34:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id 127131FFC243
	for <git@vger.kernel.org>; Thu, 26 Jul 2007 20:34:59 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53867>

Add it to the list in config.txt and explicitly say that the
--template option to git-commit overrides the configuration variable.
---

 d1cc130a5eb50d5bfe1e8b76cab3d8970fd70ad1 added a config var, but
 didn't add it to the full list.

 Documentation/config.txt     |    3 +++
 Documentation/git-commit.txt |    5 ++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index dd98d95..3135cb7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -393,6 +393,9 @@ color.status.<slot>::
 	or `untracked` (files which are not tracked by git). The values of
 	these variables may be specified as in color.branch.<slot>.
 
+commit.template::
+	Specify a file to use as the template for new commit messages.
+
 diff.renameLimit::
 	The number of files to consider when performing the copy/rename
 	detection; equivalent to the git diff option '-l'.
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 3f36c67..627994e 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -78,9 +78,8 @@ OPTIONS
 	Use the contents of the given file as the initial version
 	of the commit message. The editor is invoked and you can
 	make subsequent changes. If a message is specified using
-	the `-m` or `-F` options, this option has no effect. The
-	template file may also be specified using the `commit.template`
-	configuration variable.
+	the `-m` or `-F` options, this option has no effect. This
+	overrides the `commit.template` configuration variable.
 
 -s|--signoff::
 	Add Signed-off-by line at the end of the commit message.
-- 
1.5.3.rc2.38.g11308
