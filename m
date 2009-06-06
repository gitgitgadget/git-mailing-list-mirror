From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation: refer to gitworkflows(7) from tutorial and git(1)
Date: Sat,  6 Jun 2009 15:11:07 +0200
Message-ID: <9bb279ebf19c2b71c3b817f45b5a7e22496d6881.1244292346.git.trast@student.ethz.ch>
References: <86ws7qkuv3.fsf@blue.stonehenge.com>
Cc: git@vger.kernel.org, "Randal L. Schwartz" <merlyn@stonehenge.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 15:11:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCvgW-0000MP-PN
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 15:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239AbZFFNLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 09:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753860AbZFFNLP
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 09:11:15 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:13217 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753205AbZFFNLP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 09:11:15 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 6 Jun 2009 15:11:02 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 6 Jun 2009 15:11:01 +0200
X-Mailer: git-send-email 1.6.3.2.297.g3a54
In-Reply-To: <86ws7qkuv3.fsf@blue.stonehenge.com>
X-OriginalArrivalTime: 06 Jun 2009 13:11:01.0552 (UTC) FILETIME=[3D625B00:01C9E6A8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120916>

Add references to the gitworkflows(7) manpage added in f948dd8
(Documentation: add manpage about workflows, 2008-10-19) to both
gittutorial(1) and git(1), so that new users might actually discover
and read it.

Noticed by Randal L. Schwartz.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Mea culpa, obviously...


 Documentation/git.txt         |    5 ++++-
 Documentation/gittutorial.txt |    4 ++++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 68ce6e0..56d4770 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -232,6 +232,8 @@ The link:user-manual.html#git-concepts[git concepts chapter of the
 user-manual] and linkgit:gitcore-tutorial[7] both provide
 introductions to the underlying git architecture.
 
+See linkgit:gitworkflows[7] for an overview of recommended workflows.
+
 See also the link:howto-index.html[howto] documents for some useful
 examples.
 
@@ -649,7 +651,8 @@ SEE ALSO
 linkgit:gittutorial[7], linkgit:gittutorial-2[7],
 link:everyday.html[Everyday Git], linkgit:gitcvs-migration[7],
 linkgit:gitglossary[7], linkgit:gitcore-tutorial[7],
-linkgit:gitcli[7], link:user-manual.html[The Git User's Manual]
+linkgit:gitcli[7], link:user-manual.html[The Git User's Manual],
+linkgit:gitworkflows[7]
 
 GIT
 ---
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index c5d5596..c7fa949 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -650,6 +650,9 @@ digressions that may be interesting at this point are:
     smart enough to perform a close-to-optimal search even in the
     case of complex non-linear history with lots of merged branches.
 
+  * linkgit:gitworkflows[7]: Gives an overview of recommended
+    workflows.
+
   * link:everyday.html[Everyday GIT with 20 Commands Or So]
 
   * linkgit:gitcvs-migration[7]: Git for CVS users.
@@ -661,6 +664,7 @@ linkgit:gitcvs-migration[7],
 linkgit:gitcore-tutorial[7],
 linkgit:gitglossary[7],
 linkgit:git-help[1],
+linkgit:gitworkflows[7],
 link:everyday.html[Everyday git],
 link:user-manual.html[The Git User's Manual]
 
-- 
1.6.3.2.297.g3a54
