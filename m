From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Document git aliases support
Date: Wed, 07 Jun 2006 20:43:50 +0200
Message-ID: <20060607184350.31338.46653.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 07 20:44:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fo30J-0006I0-2P
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 20:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWFGSnj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 14:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWFGSnj
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 14:43:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47239 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750708AbWFGSnj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jun 2006 14:43:39 -0400
Received: (qmail 31356 invoked from network); 7 Jun 2006 20:43:50 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 7 Jun 2006 20:43:50 +0200
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21451>

This patch ports and modifies appropriately the git aliases documentation
from my patch, shall it rest in peace.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/config.txt |    7 +++++++
 Documentation/git.txt    |    3 +++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c861c6c..ad9ec3e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -91,6 +91,13 @@ core.warnAmbiguousRefs::
 	If true, git will warn you if the ref name you passed it is ambiguous
 	and might match multiple refs in the .git/refs/ tree. True by default.
 
+alias.*::
+	Command aliases for the gitlink:git[1] command wrapper - e.g.
+	after defining "alias.last = cat-file commit HEAD", the invocation
+	"git last" is equivalent to "git cat-file commit HEAD". You cannot
+	override even existing command names with aliases. Arguments are
+	split by spaces, the usual shell quoting and escaping is supported.
+
 apply.whitespace::
 	Tells `git-apply` how to handle whitespaces, in the same way
 	as the '--whitespace' option. See gitlink:git-apply[1].
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 24ca55d..e474bdf 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -21,6 +21,9 @@ link:everyday.html[Everyday Git] for a u
 "man git-commandname" for documentation of each command.  CVS users may
 also want to read link:cvs-migration.html[CVS migration].
 
+The COMMAND is either a name of a Git command (see below) or an alias
+as defined in the configuration file (see gitlink:git-repo-config[1]).
+
 OPTIONS
 -------
 --version::
