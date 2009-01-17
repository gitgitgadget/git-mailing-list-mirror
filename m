From: jidanni@jidanni.org
Subject: [PATCH] git-checkout(1) mention fate of extraneous files
Date: Sat, 17 Jan 2009 08:36:17 +0800
Message-ID: <87k58u4vlq.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 01:37:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNzC4-00007t-Mj
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 01:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbZAQAgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 19:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbZAQAgV
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 19:36:21 -0500
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:54279 "EHLO
	homiemail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751200AbZAQAgU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jan 2009 19:36:20 -0500
Received: from jidanni.org (122-127-36-179.dynamic.hinet.net [122.127.36.179])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a5.g.dreamhost.com (Postfix) with ESMTP id 59D1E9C4E5
	for <git@vger.kernel.org>; Fri, 16 Jan 2009 16:36:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106006>

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 Documentation/git-checkout.txt |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 9cd5151..bce31c7 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -14,12 +14,13 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-When <paths> are not given, this command switches branches by
-updating the index and working tree to reflect the specified
-branch, <branch>, and updating HEAD to be <branch> or, if
-specified, <new_branch>.  Using -b will cause <new_branch> to
-be created; in this case you can use the --track or --no-track
-options, which will be passed to `git branch`.
+When <paths> are not given, this command switches branches by updating
+the index and working tree to reflect the specified branch, <branch>,
+and updating HEAD to be <branch> or, if specified, <new_branch>. (No
+extraneous files present are deleted, use linkgit:git-clean[1] for a
+pristine checkout.) Using -b will cause <new_branch> to be created; in
+this case you can use the --track or --no-track options, which will be
+passed to `git branch`.
 
 As a convenience, --track will default to create a branch whose
 name is constructed from the specified branch name by stripping
-- 
1.6.0.6
