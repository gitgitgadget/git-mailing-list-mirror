From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] Documentation: fix links to "everyday.html"
Date: Fri, 14 Nov 2008 13:26:47 +0100
Message-ID: <20081114132647.34d9dc57.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 13:26:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0xkP-0004Qs-Sb
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 13:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbYKNMYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 07:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbYKNMYj
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 07:24:39 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:47539 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbYKNMYi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 07:24:38 -0500
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id A064B12B6B3;
	Fri, 14 Nov 2008 13:24:36 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g19.free.fr (Postfix) with SMTP id 6C82F12B6EA;
	Fri, 14 Nov 2008 13:24:36 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100965>

In some places the links are wrong. They should be:
"link:everyday.html", instead of: "linkgit:everyday[7]".
This patch fixes that.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/gitcore-tutorial.txt |    6 ++++--
 Documentation/gitglossary.txt      |    6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

	The purpose of this patch series is to make "git help"
	more visible in the tutorials.

	"git help" was discussed during the GitTogether'08 and
	many people said that "git help" should be improved to
	have more newby friendly features. The problem is that
	if it is not visible in the first place, there is no
	point of improving it.

	The first patch in this series is just a link fix.

diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index a417e59..61fc5d7 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1690,8 +1690,10 @@ to follow, not easier.
 
 SEE ALSO
 --------
-linkgit:gittutorial[7], linkgit:gittutorial-2[7],
-linkgit:everyday[7], linkgit:gitcvs-migration[7],
+linkgit:gittutorial[7],
+linkgit:gittutorial-2[7],
+linkgit:gitcvs-migration[7],
+link:everyday.html[Everyday git],
 link:user-manual.html[The Git User's Manual]
 
 GIT
diff --git a/Documentation/gitglossary.txt b/Documentation/gitglossary.txt
index 565719e..d77a45a 100644
--- a/Documentation/gitglossary.txt
+++ b/Documentation/gitglossary.txt
@@ -16,8 +16,10 @@ include::glossary-content.txt[]
 
 SEE ALSO
 --------
-linkgit:gittutorial[7], linkgit:gittutorial-2[7],
-linkgit:everyday[7], linkgit:gitcvs-migration[7],
+linkgit:gittutorial[7],
+linkgit:gittutorial-2[7],
+linkgit:gitcvs-migration[7],
+link:everyday.html[Everyday git],
 link:user-manual.html[The Git User's Manual]
 
 GIT
-- 
1.6.0.4.617.g621cb
