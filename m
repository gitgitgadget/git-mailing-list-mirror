From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] update 'git rebase' documentation
Date: Mon, 10 Mar 2008 15:38:33 +0100
Message-ID: <1205159913-19925-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 15:39:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYjAI-0003DD-4e
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 15:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbYCJOig convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Mar 2008 10:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbYCJOig
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 10:38:36 -0400
Received: from francis.fzi.de ([141.21.7.5]:39090 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750885AbYCJOif (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 10:38:35 -0400
Received: from fzi.de ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 10 Mar 2008 15:38:32 +0100
X-Mailer: git-send-email 1.5.4.4.481.g5075
X-OriginalArrivalTime: 10 Mar 2008 14:38:32.0832 (UTC) FILETIME=[6A435800:01C882BC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76730>

Being in the project's top directory when starting or continuing a
rebase is not necessary since 533b70390e540de4e0faed4823ee561c8368e5ec

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/git-rebase.txt |    3 +--
 git-rebase.sh                |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 4b10304..e0412e0 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -262,8 +262,7 @@ hook if one exists.  You can use this hook to do sa=
nity checks and
 reject the rebase if it isn't appropriate.  Please see the template
 pre-rebase hook script for an example.
=20
-You must be in the top directory of your project to start (or continue=
)
-a rebase.  Upon completion, <branch> will be the current branch.
+Upon completion, <branch> will be the current branch.
=20
 INTERACTIVE MODE
 ----------------
diff --git a/git-rebase.sh b/git-rebase.sh
index 452c5e7..ff66af3 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -18,8 +18,7 @@ original <branch> and remove the .dotest working file=
s, use the command
 git rebase --abort instead.
=20
 Note that if <branch> is not specified on the command line, the
-currently checked out branch is used.  You must be in the top
-directory of your project to start (or continue) a rebase.
+currently checked out branch is used.
=20
 Example:       git-rebase master~1 topic
=20
--=20
1.5.4.4.481.g5075
