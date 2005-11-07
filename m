From: Jon Loeliger <jdl@freescale.com>
Subject: [PATCH] Add --tags documentation, scraped from JC mail.
Date: Mon, 07 Nov 2005 08:03:30 -0600
Message-ID: <E1EZ7as-00063X-K8@jdl.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 15:05:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZ7b3-00069q-CC
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 15:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbVKGODi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 09:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbVKGODi
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 09:03:38 -0500
Received: from colo.jdl.com ([66.118.10.122]:50882 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S964822AbVKGODi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 09:03:38 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EZ7as-00063X-K8
	for git@vger.kernel.org; Mon, 07 Nov 2005 08:03:31 -0600
To: git@vger.kernel.org
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11262>


Signed-off-by: Jon Loeliger <jdl@freescale.com>

---

Thin territory here for me.  Feel free to alter if not right! :-)
Also notice the lonely --force option still...


 Documentation/fetch-options.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

applies-to: e7ff595f1fb6068b11a3a2c7eb71110faea998b8
839bbee0c81567d3f951b0cff3b2b855af6e1a99
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 12d12b2..0e502ae 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -6,6 +6,9 @@
 -f, \--force::
 
 -t, \--tags::
+	By default, the git core utilities will not fetch and store
+	tags under the same name as the remote repository;  ask it
+	to do so using `--tags`.
 
 -u, \--update-head-ok::
 	By default `git-fetch` refuses to update the head which
---
0.99.9.GIT
