From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] Documentation: remove '\' from front of options in githooks
	doc
Date: Tue, 30 Sep 2008 15:37:11 +0200
Message-ID: <1222781831-6620-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 30 15:38:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkfQo-0001DF-OB
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 15:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbYI3NhP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Sep 2008 09:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbYI3NhO
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 09:37:14 -0400
Received: from francis.fzi.de ([141.21.7.5]:32369 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751489AbYI3NhN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 09:37:13 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 30 Sep 2008 15:37:11 +0200
X-Mailer: git-send-email 1.6.0.2.448.g0c4e5
X-OriginalArrivalTime: 30 Sep 2008 13:37:11.0351 (UTC) FILETIME=[A432EC70:01C92301]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97119>

=2E.. because they show up in the man and html outputs.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/githooks.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 046a2a7..5bb7b33 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -66,7 +66,7 @@ pre-commit
 ----------
=20
 This hook is invoked by 'git-commit', and can be bypassed
-with `\--no-verify` option.  It takes no parameter, and is
+with `--no-verify` option.  It takes no parameter, and is
 invoked before obtaining the proposed commit log message and
 making a commit.  Exiting with non-zero status from this script
 causes the 'git-commit' to abort.
@@ -87,17 +87,17 @@ default log message, and before the editor is start=
ed.
=20
 It takes one to three parameters.  The first is the name of the file
 that the commit log message.  The second is the source of the commit
-message, and can be: `message` (if a `\-m` or `\-F` option was
-given); `template` (if a `\-t` option was given or the
+message, and can be: `message` (if a `-m` or `-F` option was
+given); `template` (if a `-t` option was given or the
 configuration option `commit.template` is set); `merge` (if the
 commit is a merge or a `.git/MERGE_MSG` file exists); `squash`
 (if a `.git/SQUASH_MSG` file exists); or `commit`, followed by
-a commit SHA1 (if a `\-c`, `\-C` or `\--amend` option was given).
+a commit SHA1 (if a `-c`, `-C` or `--amend` option was given).
=20
 If the exit status is non-zero, 'git-commit' will abort.
=20
 The purpose of the hook is to edit the message file in place, and
-it is not suppressed by the `\--no-verify` option.  A non-zero exit
+it is not suppressed by the `--no-verify` option.  A non-zero exit
 means a failure of the hook and aborts the commit.  It should not
 be used as replacement for pre-commit hook.
=20
@@ -108,7 +108,7 @@ commit-msg
 ----------
=20
 This hook is invoked by 'git-commit', and can be bypassed
-with `\--no-verify` option.  It takes a single parameter, the
+with `--no-verify` option.  It takes a single parameter, the
 name of the file that holds the proposed commit log message.
 Exiting with non-zero status causes the 'git-commit' to
 abort.
--=20
1.6.0.2.448.g0c4e5
