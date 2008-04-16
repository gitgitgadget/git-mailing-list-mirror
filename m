From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 01/12] doc: moved merge.* config variables into separate
	merge-config.txt
Date: Wed, 16 Apr 2008 02:39:00 +0200
Message-ID: <1208306351-20922-2-git-send-email-szeder@ira.uka.de>
References: <7vzls7so8m.fsf@gitster.siamese.dyndns.org>
	<1208306351-20922-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 07:38:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlvgw-0007Zm-PM
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 02:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754442AbYDPAjR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Apr 2008 20:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753091AbYDPAjQ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 20:39:16 -0400
Received: from moutng.kundenserver.de ([212.227.126.174]:50428 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbYDPAjO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 20:39:14 -0400
Received: from [127.0.1.1] (p5B13305D.dip0.t-ipconnect.de [91.19.48.93])
	by mrelayeu.kundenserver.de (node=mrelayeu0) with ESMTP (Nemesis)
	id 0MKwh2-1Jlvg81ZsU-0007Hd; Wed, 16 Apr 2008 02:39:13 +0200
X-Mailer: git-send-email 1.5.5.76.g546c
In-Reply-To: <1208306351-20922-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX185tw/enTdNBp55HaVh0kf9vrb/E47VaYgSiuy
 s9vBVcBpchgLSoajbVHjE16yZp1zsIohfigwqvqmxRXRBkUCiU
 GFUnVxC7VHcvOjJ9cqA6Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79665>

Include the new file from config.txt and git-merge.txt.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/config.txt       |   32 +-------------------------------
 Documentation/git-merge.txt    |   13 +------------
 Documentation/merge-config.txt |   31 +++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/merge-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fe43b12..bef6127 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -768,37 +768,7 @@ man.viewer::
 	Specify the programs that may be used to display help in the
 	'man' format. See linkgit:git-help[1].
=20
-merge.summary::
-	Whether to include summaries of merged commits in newly created
-	merge commit messages. False by default.
-
-merge.tool::
-	Controls which merge resolution program is used by
-	linkgit:git-mergetool[1].  Valid built-in values are: "kdiff3",
-	"tkdiff", "meld", "xxdiff", "emerge", "vimdiff", "gvimdiff", and
-	"opendiff".  Any other value is treated is custom merge tool
-	and there must be a corresponing mergetool.<tool>.cmd option.
-
-merge.verbosity::
-	Controls the amount of output shown by the recursive merge
-	strategy.  Level 0 outputs nothing except a final error
-	message if conflicts were detected. Level 1 outputs only
-	conflicts, 2 outputs conflicts and file changes.  Level 5 and
-	above outputs debugging information.  The default is level 2.
-	Can be overridden by 'GIT_MERGE_VERBOSITY' environment variable.
-
-merge.<driver>.name::
-	Defines a human readable name for a custom low-level
-	merge driver.  See linkgit:gitattributes[5] for details.
-
-merge.<driver>.driver::
-	Defines the command that implements a custom low-level
-	merge driver.  See linkgit:gitattributes[5] for details.
-
-merge.<driver>.recursive::
-	Names a low-level merge driver to be used when
-	performing an internal merge between common ancestors.
-	See linkgit:gitattributes[5] for details.
+include::merge-config.txt[]
=20
 mergetool.<tool>.path::
 	Override the path for the given tool.  This is useful in case
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index c136b10..821e21b 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -46,18 +46,7 @@ linkgit:git-reset[1].
=20
 CONFIGURATION
 -------------
-
-merge.summary::
-	Whether to include summaries of merged commits in newly
-	created merge commit. False by default.
-
-merge.verbosity::
-	Controls the amount of output shown by the recursive merge
-	strategy.  Level 0 outputs nothing except a final error
-	message if conflicts were detected. Level 1 outputs only
-	conflicts, 2 outputs conflicts and file changes.  Level 5 and
-	above outputs debugging information.  The default is level 2.
-	Can be overridden by 'GIT_MERGE_VERBOSITY' environment variable.
+include::merge-config.txt[]
=20
 branch.<name>.mergeoptions::
 	Sets default options for merging into branch <name>. The syntax and
diff --git a/Documentation/merge-config.txt b/Documentation/merge-confi=
g.txt
new file mode 100644
index 0000000..cc815cc
--- /dev/null
+++ b/Documentation/merge-config.txt
@@ -0,0 +1,31 @@
+merge.summary::
+	Whether to include summaries of merged commits in newly created
+	merge commit messages. False by default.
+
+merge.tool::
+	Controls which merge resolution program is used by
+	linkgit:git-mergetool[1].  Valid built-in values are: "kdiff3",
+	"tkdiff", "meld", "xxdiff", "emerge", "vimdiff", "gvimdiff", and
+	"opendiff".  Any other value is treated is custom merge tool
+	and there must be a corresponing mergetool.<tool>.cmd option.
+
+merge.verbosity::
+	Controls the amount of output shown by the recursive merge
+	strategy.  Level 0 outputs nothing except a final error
+	message if conflicts were detected. Level 1 outputs only
+	conflicts, 2 outputs conflicts and file changes.  Level 5 and
+	above outputs debugging information.  The default is level 2.
+	Can be overridden by 'GIT_MERGE_VERBOSITY' environment variable.
+
+merge.<driver>.name::
+	Defines a human readable name for a custom low-level
+	merge driver.  See linkgit:gitattributes[5] for details.
+
+merge.<driver>.driver::
+	Defines the command that implements a custom low-level
+	merge driver.  See linkgit:gitattributes[5] for details.
+
+merge.<driver>.recursive::
+	Names a low-level merge driver to be used when
+	performing an internal merge between common ancestors.
+	See linkgit:gitattributes[5] for details.
--=20
1.5.5.76.g546c
