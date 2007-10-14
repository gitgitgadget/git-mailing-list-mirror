From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Update manpages to reflect new short and long option aliases
Date: Sun, 14 Oct 2007 16:10:42 +0200
Message-ID: <20071014141042.GA21197@diku.dk>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org> <1192282153-26684-2-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Oct 14 16:16:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih4Ge-0008GM-T7
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 16:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbXJNOQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 10:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753252AbXJNOQU
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 10:16:20 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:36391 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750930AbXJNOQT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 10:16:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id E135F7E8084;
	Sun, 14 Oct 2007 16:16:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id titdeKT2Ao-0; Sun, 14 Oct 2007 16:16:16 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 85A5352C346;
	Sun, 14 Oct 2007 16:10:42 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id B9D3E6DFAB2; Sun, 14 Oct 2007 16:10:36 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 64D485B8001; Sun, 14 Oct 2007 16:10:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1192282153-26684-2-git-send-email-madcoder@debian.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60850>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/git-add.txt          |    4 ++--
 Documentation/git-branch.txt       |    2 +-
 Documentation/git-mv.txt           |    2 +-
 Documentation/git-rm.txt           |    4 ++--
 Documentation/git-symbolic-ref.txt |    2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

 Maybe this should wait, but it is just to document that this series (as
 of the version in your git tree) also adds new option aliases.
 
 BTW, I didn't bother to change the synopsis lines but maybe I should.

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 2fe7355..963e1ab 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -50,10 +50,10 @@ OPTIONS
 	and `dir/file2`) can be given to add all files in the
 	directory, recursively.
 
--n::
+-n, \--dry-run::
         Don't actually add the file(s), just show if they exist.
 
--v::
+-v, \--verbose::
         Be verbose.
 
 -f::
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index b7285bc..5e81aa4 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -85,7 +85,7 @@ OPTIONS
 -a::
 	List both remote-tracking branches and local branches.
 
--v::
+-v, --verbose::
 	Show sha1 and commit subject line for each head.
 
 --abbrev=<length>::
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index 2c9cf74..3b8ca76 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -34,7 +34,7 @@ OPTIONS
 	condition. An error happens when a source is neither existing nor
         controlled by GIT, or when it would overwrite an existing
         file unless '-f' is given.
--n::
+-n, \--dry-run::
 	Do nothing; only show what would happen
 
 
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index be61a82..48c1d97 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -30,7 +30,7 @@ OPTIONS
 -f::
 	Override the up-to-date check.
 
--n::
+-n, \--dry-run::
         Don't actually remove the file(s), just show if they exist in
         the index.
 
@@ -51,7 +51,7 @@ OPTIONS
 \--ignore-unmatch::
 	Exit with a zero status even if no files matched.
 
-\--quiet::
+-q, \--quiet::
 	git-rm normally outputs one line (in the form of an "rm" command)
 	for each file removed. This option suppresses that output.
 
diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.txt
index a88f722..694caba 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -26,7 +26,7 @@ a regular file whose contents is `ref: refs/heads/master`.
 OPTIONS
 -------
 
--q::
+-q, --quiet::
 	Do not issue an error message if the <name> is not a
 	symbolic ref but a detached HEAD; instead exit with
 	non-zero status silently.
-- 
1.5.3.4.1166.gf076

-- 
Jonas Fonseca
