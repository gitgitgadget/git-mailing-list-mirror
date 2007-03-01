From: Michael Coleman <tutufan@gmail.com>
Subject: [PATCH] fix various doc typos
Date: Wed, 28 Feb 2007 23:14:23 -0600
Message-ID: <11727260632334-git-send-email-tutufan@gmail.com>
Cc: Michael Coleman <tutufan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 06:14:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMdcb-0007Yh-Vt
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 06:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649AbXCAFO3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 00:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932651AbXCAFO2
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 00:14:28 -0500
Received: from nz-out-0506.google.com ([64.233.162.234]:10142 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932649AbXCAFO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 00:14:28 -0500
Received: by nz-out-0506.google.com with SMTP id s1so380981nze
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 21:14:27 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=tfEzOC4mcSWXRcawCgQRrDi0RXYuGoXxMZ+kyEYmjtWtGWg9FmZMMMZVlHHg0HWXOUzwxwkT0N+4a4RbchkT5hH97vB6sT9rgIrMeyB5yA2joYIcvpatJy3USNrk+CcxvDkHW4ytiB1V9nNuaLKRydg4/XHpVgc4Yeyhkd6DTOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=Ankym4x7L4xnrrzAR0rKk5q8ZF4JRxShLtEl8CWJLfSL93rt34E2eW73+z1v04UQkFuQJx327/C0kU6FbHub5Nfj2YSFWdih7jx1lY9KQ3hn78YIfVAxpJn42CzAo0CpOcIaHc8UkI9jzNOQb5azELrhDdm+YRiAtSVQLht+0pg=
Received: by 10.35.60.16 with SMTP id n16mr2390598pyk.1172726067484;
        Wed, 28 Feb 2007 21:14:27 -0800 (PST)
Received: from tutufan@gmail.com ( [69.154.17.234])
        by mx.google.com with ESMTP id c12sm6884526nzc.2007.02.28.21.14.25;
        Wed, 28 Feb 2007 21:14:26 -0800 (PST)
Received: by tutufan@gmail.com (sSMTP sendmail emulation); Wed, 28 Feb 2007 23:14:24 -0600
X-Mailer: git-send-email 1.5.0.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41037>

---
 Documentation/RelNotes-1.5.1.txt |    2 +-
 Documentation/git-bundle.txt     |    8 ++++----
 Documentation/git-svn.txt        |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/RelNotes-1.5.1.txt b/Documentation/RelNotes-1.5.1.txt
index 5ce385b..aa371be 100644
--- a/Documentation/RelNotes-1.5.1.txt
+++ b/Documentation/RelNotes-1.5.1.txt
@@ -50,7 +50,7 @@ Updates since v1.5.0
     LF at the end of lines.  Currently, which paths to consider
     'text' (i.e. be subjected to the autocrlf mechanism) is
     decided purely based on the contents, but the plan is to
-    allow users to explicitly override this heuristics based on
+    allow users to explicitly override this heuristic based on
     paths.
 
   - The behaviour of 'git-apply', when run in a subdirectory,
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 4ea9e85..92e7a68 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -19,7 +19,7 @@ DESCRIPTION
 Some workflows require that one or more branches of development on one
 machine be replicated on another machine, but the two machines cannot
 be directly connected so the interactive git protocols (git, ssh,
-rsync, http) cannot be used.  This command provides suport for
+rsync, http) cannot be used.  This command provides support for
 git-fetch and git-pull to operate by packaging objects and references
 in an archive at the originating machine, then importing those into
 another repository using gitlink:git-fetch[1] and gitlink:git-pull[1]
@@ -58,7 +58,7 @@ unbundle <file>::
        gitlink:git-fetch[1].
 
 [git-rev-list-args...]::
-       A list of arguments, accepatble to git-rev-parse and
+       A list of arguments, acceptable to git-rev-parse and
        git-rev-list, that specify the specific objects and references
        to transport.  For example, "master~10..master" causes the
        current master reference to be packaged along with all objects
@@ -70,7 +70,7 @@ unbundle <file>::
 [refname...]::
        A list of references used to limit the references reported as
        available. This is principally of use to git-fetch, which
-       expects to recieve only those references asked for and not
+       expects to receive only those references asked for and not
        necessarily everything in the pack (in this case, git-bundle is
        acting like gitlink:git-fetch-pack[1]).
 
@@ -87,7 +87,7 @@ specified explicitly (e.g., ^master~10), or implicitly (e.g.,
 master~10..master, master --since=10.days.ago).
 
 It is very important that the basis used be held by the destination.
-It is ok to err on the side of conservatism, causing the bundle file
+It is okay to err on the side of conservatism, causing the bundle file
 to contain objects already in the destination as these are ignored
 when unpacking at the destination.
 
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index cf094ca..87161ae 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -405,7 +405,7 @@ Tracking and contributing to an entire Subversion-managed project
 # with the appropriate name):
 	git reset --hard remotes/trunk
 # You may only dcommit to one branch/tag/trunk at a time.  The usage
-# of dcommit/rebase/show-ignore should be teh same as above.
+# of dcommit/rebase/show-ignore should be the same as above.
 ------------------------------------------------------------------------
 
 REBASE VS. PULL/MERGE
-- 
1.5.0.rc3
