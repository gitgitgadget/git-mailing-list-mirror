From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 1/2] Follow the more popular highlighting convention in
	git-mergetool doc
Date: Sat, 8 Mar 2008 20:46:34 +0000
Message-ID: <b4c3c2a6ee8fbc73d9c4f4582cc9c4ae6e58b15e.1205008859.git.charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 21:47:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY5xN-0008O1-Cu
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 21:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbYCHUqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 15:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbYCHUqw
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 15:46:52 -0500
Received: from pih-relay06.plus.net ([212.159.14.133]:60532 "EHLO
	pih-relay06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbYCHUqw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 15:46:52 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay06.plus.net with esmtp (Exim) id 1JY5wH-0000Zx-50; Sat, 08 Mar 2008 20:46:41 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m28KkYTS019723;
	Sat, 8 Mar 2008 20:46:34 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m28KkYTo019722;
	Sat, 8 Mar 2008 20:46:34 GMT
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Plusnet-Relay: 2004e3a0f7486c5234690d4783a8b633
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76582>

Signed-off-by: Charles Bailey <charles@hashpling.org>
---

I've just noticed that the only documentation for the new mergetool
functionality is hidden in 'git help config' which is a little obscure.
These two patches rectify this by adding documentation to 'git help
mergetool'.

I've also switched some quotes to backticks to follow what seems to be
the more popular quoting convention in the git documentation, but as I'm
not an expert in how the docs work in all format perhaps someone can
correct me and I can update the patch.

 Documentation/git-mergetool.txt |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 50f106e..ac8969c 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -12,12 +12,12 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Use 'git mergetool' to run one of several merge utilities to resolve
+Use `git mergetool` to run one of several merge utilities to resolve
 merge conflicts.  It is typically run after linkgit:git-merge[1].
 
 If one or more <file> parameters are given, the merge tool program will
 be run to resolve differences on each file.  If no <file> names are
-specified, 'git mergetool' will run the merge tool program on every file
+specified, `git mergetool` will run the merge tool program on every file
 with merge conflicts.
 
 OPTIONS
@@ -27,16 +27,16 @@ OPTIONS
 	Valid merge tools are:
 	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge, and opendiff
 +
-If a merge resolution program is not specified, 'git mergetool'
-will use the configuration variable merge.tool.  If the
-configuration variable merge.tool is not set, 'git mergetool'
+If a merge resolution program is not specified, `git mergetool`
+will use the configuration variable `merge.tool`.  If the
+configuration variable `merge.tool` is not set, `git mergetool`
 will pick a suitable default.
 +
 You can explicitly provide a full path to the tool by setting the
-configuration variable mergetool.<tool>.path. For example, you
+configuration variable `mergetool.<tool>.path`. For example, you
 can configure the absolute path to kdiff3 by setting
-mergetool.kdiff3.path. Otherwise, 'git mergetool' assumes the tool
-is available in PATH.
+`mergetool.kdiff3.path`. Otherwise, `git mergetool` assumes the
+tool is available in PATH.
 
 Author
 ------
-- 
1.5.4.3.432.g5ecfc

