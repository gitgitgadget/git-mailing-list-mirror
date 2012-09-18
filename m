From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCHv2 8/8] Doc branch: show -vv option and alternative
Date: Wed, 19 Sep 2012 00:25:34 +0100
Message-ID: <1348010734-664-9-git-send-email-philipoakley@iee.org>
To: gitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 01:25:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE7AR-0005Mu-3D
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 01:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836Ab2IRXZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 19:25:00 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:27847 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752555Ab2IRXYt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Sep 2012 19:24:49 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgUFAOL+WFBZ8rU+/2dsb2JhbABFhSC3IoEJgn0cH4ECJBOIBJkJoU+SCwOmBIJn
X-IronPort-AV: E=Sophos;i="4.80,445,1344207600"; 
   d="scan'208";a="399027137"
Received: from host-89-242-181-62.as13285.net (HELO localhost) ([89.242.181.62])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 19 Sep 2012 00:24:47 +0100
X-Mailer: git-send-email 1.7.8.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205893>

Indicate that the -v option can be given twice in the short options.
Without it users pass over the option. Also indicate the alternate
'git remote show' method.

Signed-off-by: Philip Oakley <philipoakley@iee.org>

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
