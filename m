From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 8/8] Doc branch: show -vv option and alternative
Date: Sun, 16 Sep 2012 11:58:03 +0100
Message-ID: <1347793083-4136-9-git-send-email-philipoakley@iee.org>
To: gitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 16 14:29:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDDyq-00039h-KG
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 14:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506Ab2IPM3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 08:29:36 -0400
Received: from smtp2go.com ([207.58.142.213]:59338 "EHLO smtp2go.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472Ab2IPM3g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 08:29:36 -0400
X-Mailer: git-send-email 1.7.8.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205612>

Indicate that the -v option can be given twice in the short options.
Without it users pass over the option. Also indicate the alternate
'git remote show' method.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---

the option to show where a branch's remote is located should not be buried
within an option.

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 9c1d2f1..cc7f54c 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -130,12 +130,13 @@ This option is only applicable in non-verbose mode.
 	Activate the list mode. `git branch <pattern>` would try to create a branch,
 	use `git branch --list <pattern>` to list matching branches.
 
--v::
+-v, -vv::
 --verbose::
 	When in list mode,
 	show sha1 and commit subject line for each head, along with
 	relationship to upstream branch (if any). If given twice, print
-	the name of the upstream branch, as well.
+	the name of the upstream branch, as well (see also `git remote
+	show <remote>`).
 
 -q::
 --quiet::
-- 
1.7.8.msysgit.0
