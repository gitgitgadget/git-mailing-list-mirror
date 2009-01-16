From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] Documentation: let asciidoc align related options
Date: Fri, 16 Jan 2009 22:42:33 +0100
Message-ID: <200901162242.34020.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 16 22:43:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNwTf-0002B1-0O
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 22:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760182AbZAPVl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 16:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756576AbZAPVl4
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 16:41:56 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:55992 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbZAPVlz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 16:41:55 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 3E23EFBD1E2F;
	Fri, 16 Jan 2009 22:41:54 +0100 (CET)
Received: from [89.59.106.25] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LNwRu-0002BE-00; Fri, 16 Jan 2009 22:41:54 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19Goked3hSULSbqL+91ihg23ddbVKu55iZJG/Ff
	6DzYN+gIC9yApkjUI/pe11VF7daetNSc64dk6IIhYdZXaCNaHE
	1/9iCQt4cGkr7VzXI+Yw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106000>

Command line options can share the same paragraph of description, if
they are related or synonymous. In these cases they should be written
among each other, so that asciidoc can format them itself.

This also fixes the description of the -t option in git-mergetool.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

	I'm not quite sure about the options in git-diff-files, maybe
	there is a better solution. But at least I think, additional
	words between the options should be avoided, because they add
	confusion.

 Documentation/git-diff-files.txt |    5 ++++-
 Documentation/git-mergetool.txt  |    6 ++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
index 5c8c1d9..c526141 100644
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -21,7 +21,10 @@ OPTIONS
 -------
 include::diff-options.txt[]
 
--1 -2 -3 or --base --ours --theirs, and -0::
+-1 --base::
+-2 --ours::
+-3 --theirs::
+-0::
 	Diff against the "base" version, "our branch" or "their
 	branch" respectively.  With these options, diffs for
 	merged entries are not shown.
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 4c0ffec..5d3c632 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -22,7 +22,8 @@ with merge conflicts.
 
 OPTIONS
 -------
--t or --tool=<tool>::
+-t <tool>::
+--tool=<tool>::
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
 	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge, and opendiff
@@ -60,7 +61,8 @@ variable `mergetool.<tool>.trustExitCode` can be set to `true`.
 Otherwise, 'git-mergetool' will prompt the user to indicate the
 success of the resolution after the custom tool has exited.
 
--y or --no-prompt::
+-y::
+--no-prompt::
 	Don't prompt before each invocation of the merge resolution
 	program.
 
-- 
1.6.1.35.g0c23
