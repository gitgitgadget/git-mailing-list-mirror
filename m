From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH 3/2] Document the fact that git-svn now runs git-gc
Date: Fri, 5 Oct 2007 09:15:22 -0700
Message-ID: <20071005161522.GA12545@midwinter.com>
References: <47066255.6080500@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 18:15:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idppr-0000qH-KB
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 18:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756929AbXJEQPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 12:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754572AbXJEQPX
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 12:15:23 -0400
Received: from tater.midwinter.com ([216.32.86.90]:53659 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751495AbXJEQPX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 12:15:23 -0400
Received: (qmail 12835 invoked by uid 1001); 5 Oct 2007 16:15:22 -0000
Content-Disposition: inline
In-Reply-To: <47066255.6080500@midwinter.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60102>

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---
 Documentation/git-svn.txt |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index e157c6a..26f0f39 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -125,7 +125,15 @@ and have no uncommitted changes.
 	alternative to HEAD.
 	This is advantageous over 'set-tree' (below) because it produces
 	cleaner, more linear history.
-+
+
+When the commit is finished, gitlink:git-gc[1] is run with the
+`--prune` and `--auto` options to clean up the git object database,
+including removing old unreachable objects (some of which are
+created by the process of committing to SVN.) Set the `gc.auto`
+config option to 0 if you don't want your repository to be cleaned,
+e.g., because you are intentionally keeping unreachable objects in
+your repository.
+
 --no-rebase;;
 	After committing, do not rebase or reset.
 --
-- 
1.5.3.4.203.gcc61a
