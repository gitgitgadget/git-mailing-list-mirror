From: Philip Oakley <philipoakley@iee.org>
Subject: [RFC/PATCH 2/2] doc: command line interface (cli) dot-repository dwimmery
Date: Sun, 19 May 2013 12:54:09 +0100
Message-ID: <1368964449-2724-3-git-send-email-philipoakley@iee.org>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 19 13:54:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue2Bf-00070D-Nc
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754392Ab3ESLyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 07:54:00 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:61293 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754295Ab3ESLx6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 07:53:58 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtULAIK8mFFZ8YNG/2dsb2JhbABbgwiDAr5kBAF9F3SCIAEFVjMISTkeBhOIEbt5jgSBJINUA6h4gxA7
X-IronPort-AV: E=Sophos;i="4.87,703,1363132800"; 
   d="scan'208";a="419128446"
Received: from host-89-241-131-70.as13285.net (HELO localhost) ([89.241.131.70])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 19 May 2013 12:53:57 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1368964449-2724-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224869>

The Git cli will generally accept dot '.' (period) as equivalent
to the current repository when appropriate. Tell the reader of this
'do what I mean' (dwim)mery action.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/gitcli.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 9ac5088..64bb386 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -59,6 +59,10 @@ working tree.  After running `git add hello.c; rm hello.c`, you will _not_
 see `hello.c` in your working tree with the former, but with the latter
 you will.
 
+Just as, by convention, the filesystem '.' refers to the current directory,
+using a '.' (period) as a repository name in Git (a dot-repository) refers
+to your local repository.
+
 Here are the rules regarding the "flags" that you should follow when you are
 scripting Git:
 
-- 
1.8.1.msysgit.1
