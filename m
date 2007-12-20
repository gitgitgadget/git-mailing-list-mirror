From: Jeff King <peff@peff.net>
Subject: [PATCH] clean up 1.5.4 release notes
Date: Thu, 20 Dec 2007 07:11:25 -0500
Message-ID: <20071220121124.GA417@coredump.intra.peff.net>
References: <7vhciers0o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 13:12:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5KGQ-0001Ne-2e
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 13:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762437AbXLTMLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 07:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762790AbXLTMLa
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 07:11:30 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2972 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762902AbXLTML1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 07:11:27 -0500
Received: (qmail 9085 invoked by uid 111); 20 Dec 2007 12:11:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 20 Dec 2007 07:11:26 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Dec 2007 07:11:25 -0500
Content-Disposition: inline
In-Reply-To: <7vhciers0o.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68996>

Mostly typo and small grammatical fixes with one or two rewordings for
clarity.  But note the important fix for status.relativepaths.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/RelNotes-1.5.4.txt |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/Documentation/RelNotes-1.5.4.txt b/Documentation/RelNotes-1.5.4.txt
index cd79124..4a5d060 100644
--- a/Documentation/RelNotes-1.5.4.txt
+++ b/Documentation/RelNotes-1.5.4.txt
@@ -14,28 +14,28 @@ Removal
 Deprecation notices
 -------------------
 
- * Next feature release of git (this change is scheduled for v1.6.0)
+ * The next feature release of git (this change is scheduled for v1.6.0)
    will by default install dashed form of commands (e.g. "git-commit")
    outside of users' normal $PATH, and will install only selected
    commands ("git" itself, and "gitk") in $PATH.  This implies:
 
-   - Using dashed form of git commands (e.g. "git-commit") from the
+   - Using dashed forms of git commands (e.g. "git-commit") from the
      command line has been informally deprecated since early 2006, but
      now it officially is, and will be removed in the future.  Use
-     dashless form (e.g. "git commit") instead.
+     dashless forms (e.g. "git commit") instead.
 
-   - Using dashed from from your scripts, without first prepending the
+   - Using dashed forms from your scripts, without first prepending the
      return value from "git --exec-path" to the scripts' PATH, has been
      informally deprecated since early 2006, but now it officially is.
 
-   - Use of dashed form with "PATH=$(git --exec-path):$PATH; export
+   - Use of dashed forms with "PATH=$(git --exec-path):$PATH; export
      PATH" early in your script is not deprecated with this change.
 
   Users are strongly encouraged to adjust their habits and scripts now
   to prepare for this.
 
  * The post-receive hook was introduced in March 2007 to supersede
-   post-update hook, primarily to overcome the command line length
+   the post-update hook, primarily to overcome the command line length
    limitation of the latter.  Use of post-update hook will be deprecated
    in future versions of git, starting from v1.6.0.
 
@@ -43,10 +43,11 @@ Deprecation notices
    option, and will be removed in the future.
 
  * "git peek-remote" is deprecated, as "git ls-remote" was written in C
-   and works for all transports, and will be removed in the future.
+   and works for all transports; "git peek-remote" will be removed in
+   the future.
 
  * From v1.6.0, the repack.usedeltabaseoffset config option will default
-   to true, which will give denser packfile (i.e. more efficient storage).
+   to true, which will give denser packfiles (i.e. more efficient storage).
    The downside is that git older than version 1.4.4 will not be able
    to directly use a repository packed using this setting.
 
@@ -67,7 +68,7 @@ Updates since v1.5.3
  * gitk is now merged as a subdirectory of git.git project, in
    preparation for its i18n.
 
- * progress display from many commands are a lot nicer to the eye.
+ * progress displays from many commands are a lot nicer to the eye.
    Transfer commands show throughput data.
 
  * many commands that pay attention to per-directory .gitignore now do
@@ -76,12 +77,12 @@ Updates since v1.5.3
  * Output processing for '--pretty=format:<user format>' has been
    optimized.
 
- * Rename detection of diff family, while detecting exact matches, has
+ * Rename detection of diff family while detecting exact matches has
    been greatly optimized.
 
- * Rename detection of diff family tries to make more naturally looking
-   pairing.  Earlier if more than one identical rename sources were
-   found in the preimage, they were picked pretty much at random.
+ * Rename detection of diff family tries to make more natural looking
+   pairing.  Earlier, if multiple identical rename sources were
+   found in the preimage, the source used was picked pretty much at random.
 
  * Value "true" for color.diff and color.status configuration used to
    mean "always" (even when the output is not going to a terminal).
@@ -114,7 +115,7 @@ Updates since v1.5.3
 
  * "git rebase --interactive" mode can now work on detached HEAD.
 
- * Other minor to serious bugs in "git rebase -i" has been fixed.
+ * Other minor to serious bugs in "git rebase -i" have been fixed.
 
  * "git rebase" now detaches head during its operation, so after a
    successful "git rebase" operation, the reflog entry branch@{1} for
@@ -245,7 +246,7 @@ Updates since v1.5.3
  * The format "git show" outputs an annotated tag has been updated to
    include "Tagger: " and "Date: " lines from the tag itself.  Strictly
    speaking this is a backward incompatible change, but this is a
-   reasonable usability fix and people's script shouldn't have been
+   reasonable usability fix and people's scripts shouldn't have been
    relying on the exact output from "git show" Porcelain anyway.
 
  * "git cvsexportcommit" learned -w option to specify and switch to the
@@ -281,7 +282,7 @@ Updates since v1.5.3
    makes copy-and-pasting for git-checkout/git-add/git-rm easier.  The
    traditional behaviour to show the full path relative to the top of
    the work tree can be had by setting status.relativepaths
-   configuration variable to true.
+   configuration variable to false.
 
  * "git blame" kept text for each annotated revision in core needlessly;
    this has been corrected.
-- 
1.5.4.rc1.1095.g7251f
