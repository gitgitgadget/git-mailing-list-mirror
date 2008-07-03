From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH 15/15] manpages: use teletype font for sample command lines
Date: Thu, 3 Jul 2008 01:06:23 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807030059170.16085@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
 <7viqvqov01.fsf@gitster.siamese.dyndns.org> <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Olivier Marin <dkr+ml.git@free.fr>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 09:03:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEIpu-0003HF-4J
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 09:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755635AbYGCHAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 03:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754023AbYGCG6V
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:58:21 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:45596 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755158AbYGCGHh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 02:07:37 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m6366ONP024923;
	Thu, 3 Jul 2008 01:06:24 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m6366Nji019794;
	Thu, 3 Jul 2008 01:06:23 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87237>

I think that some of these uses of italics were meant to be
rendered in quotation marks, anyway.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 Documentation/git-gui.txt          |    2 +-
 Documentation/git-help.txt         |    2 +-
 Documentation/git-reflog.txt       |    4 ++--
 Documentation/git.txt              |    4 ++--
 Documentation/gitcore-tutorial.txt |    2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index a73201d..0e650f4 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -71,7 +71,7 @@ git gui citool::
 
 git citool::
 
-	Same as 'git gui citool' (above).
+	Same as `git gui citool` (above).
 
 git gui browser maint::
 
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index d5b20f8..f414583 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -23,7 +23,7 @@ If a git command is named, a manual page for that command is brought
 up. The 'man' program is used by default for this purpose, but this
 can be overridden by other options or configuration variables.
 
-Note that 'git --help ...' is identical as 'git help ...' because the
+Note that `git --help ...` is identical to `git help ...` because the
 former is internally converted into the latter.
 
 OPTIONS
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 1710626..146d7f5 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -36,7 +36,7 @@ The subcommand "show" (which is also the default, in the absence of any
 subcommands) will take all the normal log options, and show the log of
 the reference provided in the command-line (or `HEAD`, by default).
 The reflog will cover all recent actions (HEAD reflog records branch switching
-as well).  It is an alias for 'git log -g --abbrev-commit --pretty=oneline';
+as well).  It is an alias for `git log -g --abbrev-commit --pretty=oneline`;
 see linkgit:git-log[1].
 
 The reflog is useful in various git commands, to specify the old value
@@ -46,7 +46,7 @@ point to one week ago", and so on. See linkgit:git-rev-parse[1] for
 more details.
 
 To delete single entries from the reflog, use the subcommand "delete"
-and specify the _exact_ entry (e.g. ``git reflog delete master@\{2\}'').
+and specify the _exact_ entry (e.g. "`git reflog delete master@\{2\}`").
 
 
 OPTIONS
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 4d54791..92c0884 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -135,8 +135,8 @@ OPTIONS
 +
 Other options are available to control how the manual page is
 displayed. See linkgit:git-help[1] for more information,
-because 'git --help ...' is converted internally into 'git
-help ...'.
+because `git --help ...` is converted internally into `git
+help ...`.
 
 --exec-path::
 	Path to wherever your core git programs are installed.
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index dd6a268..a2b9293 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1655,7 +1655,7 @@ branch before these two merges by resetting it to 'master~2':
 $ git reset --hard master~2
 ------------
 
-You can make sure 'git show-branch' matches the state before
+You can make sure `git show-branch` matches the state before
 those two 'git-merge' you just did.  Then, instead of running
 two 'git-merge' commands in a row, you would merge these two
 branch heads (this is known as 'making an Octopus'):
-- 
1.5.5.GIT
