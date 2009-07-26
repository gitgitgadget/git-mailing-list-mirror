From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Fix documentation: "fmt-merge-msg" and "mv" are no longer scripts
Date: Sun, 26 Jul 2009 19:08:29 +0300
Message-ID: <20090726160829.GA22834@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 26 18:30:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MV6c0-0005zN-GI
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 18:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804AbZGZQaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 12:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753802AbZGZQaB
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 12:30:01 -0400
Received: from zakalwe.fi ([80.83.5.154]:36342 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753801AbZGZQaB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 12:30:01 -0400
X-Greylist: delayed 1291 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Jul 2009 12:30:00 EDT
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 61C4E2C328; Sun, 26 Jul 2009 19:08:29 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124128>

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
---
 Documentation/git-fmt-merge-msg.txt |    2 +-
 Documentation/git-mv.txt            |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 1c24796..0067805 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -18,7 +18,7 @@ Takes the list of merged objects on stdin and produces a suitable
 commit message to be used for the merge commit, usually to be
 passed as the '<merge-message>' argument of 'git-merge'.
 
-This script is intended mostly for internal use by scripts
+This command is intended mostly for internal use by scripts
 automatically invoking 'git-merge'.
 
 OPTIONS
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index 9c56602..63b4365 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-This script is used to move or rename a file, directory or symlink.
+Move or rename a file, directory or symlink.
 
  git mv [-f] [-n] <source> <destination>
  git mv [-f] [-n] [-k] <source> ... <destination directory>
-- 
1.6.1.2
