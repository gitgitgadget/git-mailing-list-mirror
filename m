From: Johan Herland <johan@herland.net>
Subject: [PATCH 03/15] git-note: (Administrivia) Add git-note to Makefile,
 .gitignore, etc.
Date: Sun, 27 May 2007 16:11:02 +0200
Message-ID: <200705271611.02280.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <alpine.LFD.0.98.0705101116480.3986@woody.linux-foundation.org>
 <200705271608.02122.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 16:11:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsJSh-0006lT-H7
	for gcvg-git@gmane.org; Sun, 27 May 2007 16:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893AbXE0OLI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 10:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754014AbXE0OLH
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 10:11:07 -0400
Received: from smtp.getmail.no ([84.208.20.33]:47817 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753727AbXE0OLG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 10:11:06 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIP00003E2H4V00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:11:05 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP004XIE2E9PC0@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:11:02 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP000CHE2EJB50@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:11:02 +0200 (CEST)
In-reply-to: <200705271608.02122.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48543>

Teach Makefile, .gitignore, Documentation/cmd-list.perl and
generate-cmdlist.sh on the existence of the git-note command.

The patch also does some unrelated whitespace cleanup in
Documentation/cmd-list.perl and an alphabetizing fix in .gitignore,
just to keep things neat and tidy.

Signed-off-by: Johan Herland <johan@herland.net>
---
 .gitignore                  |    3 ++-
 Documentation/cmd-list.perl |    5 +++--
 Makefile                    |    2 +-
 generate-cmdlist.sh         |    1 +
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/.gitignore b/.gitignore
index 4dc0c39..0f34b94 100644
--- a/.gitignore
+++ b/.gitignore
@@ -82,8 +82,9 @@ git-merge-subtree
 git-mergetool
 git-mktag
 git-mktree
-git-name-rev
 git-mv
+git-name-rev
+git-note
 git-pack-redundant
 git-pack-objects
 git-pack-refs
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 443802a..dc7e8b3 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -103,13 +103,13 @@ git-diff-files                          plumbinginterrogators
 git-diff-index                          plumbinginterrogators
 git-diff                                mainporcelain
 git-diff-tree                           plumbinginterrogators
-git-fast-import				ancillarymanipulators
+git-fast-import                         ancillarymanipulators
 git-fetch                               mainporcelain
 git-fetch-pack                          synchingrepositories
 git-fmt-merge-msg                       purehelpers
 git-for-each-ref                        plumbinginterrogators
 git-format-patch                        mainporcelain
-git-fsck	                        ancillaryinterrogators
+git-fsck                                ancillaryinterrogators
 git-gc                                  mainporcelain
 git-get-tar-commit-id                   ancillaryinterrogators
 git-grep                                mainporcelain
@@ -140,6 +140,7 @@ git-mktag                               plumbingmanipulators
 git-mktree                              plumbingmanipulators
 git-mv                                  mainporcelain
 git-name-rev                            plumbinginterrogators
+git-note                                mainporcelain
 git-pack-objects                        plumbingmanipulators
 git-pack-redundant                      plumbinginterrogators
 git-pack-refs                           ancillarymanipulators
diff --git a/Makefile b/Makefile
index 29243c6..c2f9f22 100644
--- a/Makefile
+++ b/Makefile
@@ -209,7 +209,7 @@ SCRIPT_SH = \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh \
-	git-lost-found.sh git-quiltimport.sh
+	git-lost-found.sh git-quiltimport.sh git-note.sh
 
 SCRIPT_PERL = \
 	git-add--interactive.perl \
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 975777f..0a37fd0 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -26,6 +26,7 @@ init
 log
 merge
 mv
+note
 prune
 pull
 push
-- 
1.5.2.101.gee49f
