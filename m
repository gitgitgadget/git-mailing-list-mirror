From: arjen@yaph.org (Arjen Laarhoven)
Subject: [PATCH] Document 'opendiff' value in config.txt and git-mergetool.txt
Date: Thu, 3 May 2007 20:29:15 +0200
Message-ID: <20070503182915.GA29348@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 03 20:29:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjg3T-0001JQ-Ae
	for gcvg-git@gmane.org; Thu, 03 May 2007 20:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161552AbXECS3S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 14:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161548AbXECS3S
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 14:29:18 -0400
Received: from regex.yaph.org ([193.202.115.201]:42962 "EHLO regex.yaph.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161552AbXECS3R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 14:29:17 -0400
Received: by regex.yaph.org (Postfix, from userid 1000)
	id B44D35B7D2; Thu,  3 May 2007 20:29:15 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46094>


Signed-off-by: Arjen Laarhoven <arjen@yaph.org>
---
 Documentation/config.txt        |    2 +-
 Documentation/git-mergetool.txt |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c257cdf..24f9655 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -520,7 +520,7 @@ merge.summary::
 merge.tool::
 	Controls which merge resolution program is used by
 	gitlink:git-mergetool[l].  Valid values are: "kdiff3", "tkdiff",
-	"meld", "xxdiff", "emerge", "vimdiff"
+	"meld", "xxdiff", "emerge", "vimdiff", and "opendiff"
 
 merge.verbosity::
 	Controls the amount of output shown by the recursive merge
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 34288fe..add01e8 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -25,7 +25,7 @@ OPTIONS
 -t or --tool=<tool>::
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
-	kdiff3, tkdiff, meld, xxdiff, emerge, and vimdiff.
+	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, and opendiff
 +
 If a merge resolution program is not specified, 'git mergetool'
 will use the configuration variable merge.tool.  If the
-- 
1.5.2.rc1.3.g7a150
