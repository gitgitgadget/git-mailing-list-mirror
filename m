From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 1/3] Documentation: use 'keyid' consistently, not 'key-id'
Date: Sat, 19 Sep 2015 09:47:48 +0200
Message-ID: <1442648870-22511-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1442588510-7379-1-git-send-email-Matthieu.Moy@imag.fr>
 <1442648870-22511-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Alastair McGowan-Douglas <altreus@altre.us>,
	Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Sep 19 09:48:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdCsm-0008NY-1S
	for gcvg-git-2@plane.gmane.org; Sat, 19 Sep 2015 09:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627AbbISHsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Sep 2015 03:48:10 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60973 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753271AbbISHsH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Sep 2015 03:48:07 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t8J7lqVg004100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 19 Sep 2015 09:47:53 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8J7lrjt023788;
	Sat, 19 Sep 2015 09:47:53 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1ZdCsD-0005va-DL; Sat, 19 Sep 2015 09:47:53 +0200
X-Mailer: git-send-email 2.5.0.402.g8854c44
In-Reply-To: <1442648870-22511-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 19 Sep 2015 09:47:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8J7lqVg004100
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1443253674.35944@vUkm+18h9t7el/Q/aKjEcw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278233>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-cherry-pick.txt |  6 +++---
 Documentation/git-commit.txt      |  2 +-
 Documentation/git-merge.txt       |  2 +-
 Documentation/git-revert.txt      |  6 +++---
 Documentation/git-tag.txt         | 18 +++++++++---------
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 1147c71..66ab297 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff]
-		  [-S[<key-id>]] <commit>...
+		  [-S[<keyid>]] <commit>...
 'git cherry-pick' --continue
 'git cherry-pick' --quit
 'git cherry-pick' --abort
@@ -101,8 +101,8 @@ effect to your index in a row.
 --signoff::
 	Add Signed-off-by line at the end of the commit message.
 
--S[<key-id>]::
---gpg-sign[=<key-id>]::
+-S[<keyid>]::
+--gpg-sign[=<keyid>]::
 	GPG-sign commits.
 
 --ff::
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 904dafa..51c63d6 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
-	   [-i | -o] [-S[<key-id>]] [--] [<file>...]
+	   [-i | -o] [-S[<keyid>]] [--] [<file>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index a62d672..98bf7b1 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
-	[-s <strategy>] [-X <strategy-option>] [-S[<key-id>]]
+	[-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
 	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
 'git merge' <msg> HEAD <commit>...
 'git merge' --abort
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index cceb5f2..9eb83f0 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -8,7 +8,7 @@ git-revert - Revert some existing commits
 SYNOPSIS
 --------
 [verse]
-'git revert' [--[no-]edit] [-n] [-m parent-number] [-s] [-S[<key-id>]] <commit>...
+'git revert' [--[no-]edit] [-n] [-m parent-number] [-s] [-S[<keyid>]] <commit>...
 'git revert' --continue
 'git revert' --quit
 'git revert' --abort
@@ -80,8 +80,8 @@ more details.
 This is useful when reverting more than one commits'
 effect to your index in a row.
 
--S[<key-id>]::
---gpg-sign[=<key-id>]::
+-S[<keyid>]::
+--gpg-sign[=<keyid>]::
 	GPG-sign commits.
 
 -s::
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 84f6496..08b4dfb 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -9,7 +9,7 @@ git-tag - Create, list, delete or verify a tag object signed with GPG
 SYNOPSIS
 --------
 [verse]
-'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]
+'git tag' [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>]
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
@@ -24,19 +24,19 @@ to delete, list or verify tags.
 
 Unless `-f` is given, the named tag must not yet exist.
 
-If one of `-a`, `-s`, or `-u <key-id>` is passed, the command
+If one of `-a`, `-s`, or `-u <keyid>` is passed, the command
 creates a 'tag' object, and requires a tag message.  Unless
 `-m <msg>` or `-F <file>` is given, an editor is started for the user to type
 in the tag message.
 
-If `-m <msg>` or `-F <file>` is given and `-a`, `-s`, and `-u <key-id>`
+If `-m <msg>` or `-F <file>` is given and `-a`, `-s`, and `-u <keyid>`
 are absent, `-a` is implied.
 
 Otherwise just a tag reference for the SHA-1 object name of the commit object is
 created (i.e. a lightweight tag).
 
 A GnuPG signed tag object will be created when `-s` or `-u
-<key-id>` is used.  When `-u <key-id>` is not used, the
+<keyid>` is used.  When `-u <keyid>` is not used, the
 committer identity for the current user is used to find the
 GnuPG key for signing. 	The configuration variable `gpg.program`
 is used to specify custom GnuPG binary.
@@ -63,8 +63,8 @@ OPTIONS
 --sign::
 	Make a GPG-signed tag, using the default e-mail address's key.
 
--u <key-id>::
---local-user=<key-id>::
+-u <keyid>::
+--local-user=<keyid>::
 	Make a GPG-signed tag, using the given key.
 
 -f::
@@ -125,14 +125,14 @@ This option is only applicable when listing tags without annotation lines.
 	Use the given tag message (instead of prompting).
 	If multiple `-m` options are given, their values are
 	concatenated as separate paragraphs.
-	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
+	Implies `-a` if none of `-a`, `-s`, or `-u <keyid>`
 	is given.
 
 -F <file>::
 --file=<file>::
 	Take the tag message from the given file.  Use '-' to
 	read the message from the standard input.
-	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
+	Implies `-a` if none of `-a`, `-s`, or `-u <keyid>`
 	is given.
 
 --cleanup=<mode>::
@@ -166,7 +166,7 @@ it in the repository configuration as follows:
 
 -------------------------------------
 [user]
-    signingKey = <gpg-key-id>
+    signingKey = <gpg-keyid>
 -------------------------------------
 
 
-- 
2.5.0.402.g8854c44
