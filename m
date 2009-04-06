From: =?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCH] Documentation: Introduce "upstream branch"
Date: Tue,  7 Apr 2009 01:24:30 +0200
Message-ID: <1239060270-15307-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 01:26:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqyCl-0003I4-He
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 01:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837AbZDFXYm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 19:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753067AbZDFXYm
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 19:24:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:47959 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbZDFXYl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 19:24:41 -0400
Received: by fg-out-1718.google.com with SMTP id 16so308717fgg.17
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 16:24:39 -0700 (PDT)
Received: by 10.86.92.9 with SMTP id p9mr3592295fgb.15.1239060278767;
        Mon, 06 Apr 2009 16:24:38 -0700 (PDT)
Received: from localhost (p5B0D786D.dip.t-dialin.net [91.13.120.109])
        by mx.google.com with ESMTPS id l19sm136066fgb.21.2009.04.06.16.24.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Apr 2009 16:24:38 -0700 (PDT)
X-Mailer: git-send-email 1.6.1.258.g7ff14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115891>


Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
 Documentation/config.txt           |    2 +-
 Documentation/glossary-content.txt |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3afd124..f3ebd2f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1215,7 +1215,7 @@ push.default::
 * `matching` push all matching branches.
   All branches having the same name in both ends are considered to be
   matching. This is the default.
-* `tracking` push the current branch to the branch it is tracking.
+* `tracking` push the current branch to its upstream branch.
 * `current` push the current branch to a branch of the same name.
=20
 rebase.stat::
diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
index 4fc1cf1..86be3ae 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -449,6 +449,12 @@ This commit is referred to as a "merge commit", or=
 sometimes just a
 	An <<def_object,object>> which is not <<def_reachable,reachable>> fro=
m a
 	<<def_branch,branch>>, <<def_tag,tag>>, or any other reference.
=20
+[[def_upstream_branch]]upstream branch::
+	The default <<def_branch,branch>> that is merged/rebased into another
+	branch. It is configured via branch.<name>.remote and
+	branch.<name>.merge. If the upstream branch of 'A' is 'origin/B' it i=
s
+	sometimes refered as "'A' is tracking 'origin/B'".
+
 [[def_working_tree]]working tree::
 	The tree of actual checked out files.  The working tree is
 	normally equal to the <<def_HEAD,HEAD>> plus any local changes
--=20
1.6.1.258.g7ff14
