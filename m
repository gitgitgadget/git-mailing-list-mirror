From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] ninor corrections to release notes
Date: Tue, 13 Feb 2007 22:25:08 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702132222470.1757@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 04:25:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHAlq-0004dF-3O
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 04:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbXBNDZK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 22:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbXBNDZK
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 22:25:10 -0500
Received: from relais.videotron.ca ([24.201.245.36]:27430 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932295AbXBNDZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 22:25:09 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDF007X2O5WCG80@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 13 Feb 2007 22:25:08 -0500 (EST)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39613>

Update section about warning when leaving a detached head.

Also fix a few indentations that weren't like the rest of the file.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

Bah....  too late for the real release but still.

diff --git a/Documentation/RelNotes-1.5.0.txt b/Documentation/RelNotes-1.5.0.txt
index 84e7eaf..f0120e1 100644
--- a/Documentation/RelNotes-1.5.0.txt
+++ b/Documentation/RelNotes-1.5.0.txt
@@ -94,8 +94,8 @@ Updates in v1.5.0 since v1.4.4 series
    entries for selected paths.
 
  - git-update-index is much less visible.  Many suggestions to
-  use the command in git output and documentation have now been
-  replaced by simpler commands such as "git add" or "git rm".
+   use the command in git output and documentation have now been
+   replaced by simpler commands such as "git add" or "git rm".
 
 
 * Repository layout and objects transfer
@@ -291,12 +291,10 @@ Updates in v1.5.0 since v1.4.4 series
    reset" to jump to arbitrary commit, while still keeping your
    HEAD detached.
 
-   Going back to attached state (i.e. on a particular branch) by
-   "git checkout $branch" can lose the current stat you arrived
-   in these ways, and "git checkout" refuses when the detached
-   HEAD is not pointed by any existing ref (an existing branch,
-   a remote tracking branch or a tag).  This safety can be
-   overridden with "git checkout -f $branch".
+   Remember that a detached state is volatile, i.e. it will be forgotten
+   as soon as you move away from it with the checkout or reset command,
+   unless a branch is created from it as mentioned above.  It is also
+   possible to rescue a lost detached state from the HEAD reflog.
 
 
 * Packed refs
@@ -411,14 +409,14 @@ Updates in v1.5.0 since v1.4.4 series
 
 * Foreign SCM interfaces
 
-  - git-svn now requires the Perl SVN:: libraries, the
-    command-line backend was too slow and limited.
+ - git-svn now requires the Perl SVN:: libraries, the
+   command-line backend was too slow and limited.
 
-  - the 'commit' subcommand of git-svn has been renamed to
-    'set-tree', and 'dcommit' is the recommended replacement for
-    day-to-day work.
+ - the 'commit' subcommand of git-svn has been renamed to
+   'set-tree', and 'dcommit' is the recommended replacement for
+   day-to-day work.
 
-  - git fast-import backend.
+ - git fast-import backend.
 
 
 * User support
