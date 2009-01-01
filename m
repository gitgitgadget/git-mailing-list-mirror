From: jidanni@jidanni.org
Subject: Subject: [PATCH] Documentation/git-merge: deprecated syntax moved to end
Date: Fri, 02 Jan 2009 02:41:52 +0800
Message-ID: <87bpuqvpfz.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 01 19:52:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LISeL-0006lP-8r
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 19:52:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756724AbZAASuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 13:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756722AbZAASuj
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 13:50:39 -0500
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:53689 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751741AbZAASui (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jan 2009 13:50:38 -0500
Received: from jidanni.org (122-127-33-68.dynamic.hinet.net [122.127.33.68])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id 3520ED25E0;
	Thu,  1 Jan 2009 10:50:36 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104307>

Moving the deprecated syntax moved to the end of the document.
Or please at least stamp it *deprecated* in the SYNOPSIS, in case the
user reads no further down the page.

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 Documentation/git-merge.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index a3ac828..e619c9f 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -11,18 +11,12 @@ SYNOPSIS
 [verse]
 'git merge' [-n] [--stat] [--no-commit] [--squash] [-s <strategy>]...
 	[-m <msg>] <remote>...
-'git merge' <msg> HEAD <remote>...
 
 DESCRIPTION
 -----------
 This is the top-level interface to the merge machinery
 which drives multiple merge strategy scripts.
 
-The second syntax (<msg> `HEAD` <remote>) is supported for
-historical reasons.  Do not use it from the command line or in
-new scripts.  It is the same as `git merge -m <msg> <remote>`.
-
-
 OPTIONS
 -------
 include::merge-options.txt[]
@@ -211,6 +205,12 @@ You can work through the conflict with a number of tools:
    common ancestor, 'git show :2:filename' shows the HEAD
    version and 'git show :3:filename' shows the remote version.
 
+DEPRECATED SYNTAX
+-----------------
+There also as a `git merge <msg> HEAD <remote>...` syntax supported
+for historical reasons. Do not use it from the command line or in new
+scripts. It is the same as `git merge -m <msg> <remote>`.
+
 SEE ALSO
 --------
 linkgit:git-fmt-merge-msg[1], linkgit:git-pull[1],
-- 
1.6.0.6
