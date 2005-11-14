From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 3/4] Fix a typo in "stg pick"
Date: Mon, 14 Nov 2005 11:50:59 -0500
Message-ID: <20051114165059.22202.93316.stgit@dexter.citi.umich.edu>
References: <20051114165007.22202.69803.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Nov 14 17:53:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbhXz-0002xN-HG
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 17:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbVKNQvA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 11:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbVKNQvA
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 11:51:00 -0500
Received: from citi.umich.edu ([141.211.133.111]:23612 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751192AbVKNQvA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 11:51:00 -0500
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id B4FA91BB9A
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 11:50:59 -0500 (EST)
To: git@vger.kernel.org
In-Reply-To: <20051114165007.22202.69803.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11822>

"Unknown" is misspelled.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 stgit/commands/pick.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/pick.py b/stgit/commands/pick.py
index 3c52a49..c01c799 100644
--- a/stgit/commands/pick.py
+++ b/stgit/commands/pick.py
@@ -64,7 +64,7 @@ def func(parser, options, args):
         elif len(patch_branch) == 2:
             patch = patch_branch[0]
         else:
-            raise CmdException, 'Unkown patch name'
+            raise CmdException, 'Unknown patch name'
 
     commit_id = git_id(commit_str)
     commit = git.Commit(commit_id)
