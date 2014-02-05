From: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH] Documentation: fix typos in man pages
Date: Wed,  5 Feb 2014 23:19:43 +0100
Message-ID: <1391638783-10686-1-git-send-email-oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 05 23:19:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBAp4-0006qj-Nv
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 23:19:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756238AbaBEWTz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Feb 2014 17:19:55 -0500
Received: from mail-wg0-f51.google.com ([74.125.82.51]:47346 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754674AbaBEWTw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 17:19:52 -0500
Received: by mail-wg0-f51.google.com with SMTP id z12so748193wgg.30
        for <git@vger.kernel.org>; Wed, 05 Feb 2014 14:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Bx8oXxjntTqJtIBEtvCW2Gt2y8bwhApCWH1qVqs59HA=;
        b=AzXNWBTmjm9p62weqJp7BtWOsarIxbotntsp6ieYwg3AJcULJpUSOUmoRXW4qePoRW
         myGTmWZAHhntyci4ebAO4OBgmxRxeHb5oiJsxYDTDjAy8RW7cPmG5MtQAhs8wTF9AiA0
         Tcc9cagpy5so6PFYRgqxvz+06bNBqSzXL0dr+S5XPMPeifYaZrx4uWje4ERlq9mfnVSa
         XAxWmfDL1N3/dRiKcjKZlmeOjgx1XdoYMyd1COfRr2gdjs9bJzTT6+aurRZl3G4ijgtz
         rRqY6Qt5/LcLujL9eMJnCYhl5CpL4agD1l4/HlY5sI0knPrGeAB3mzoErQqSAukh08MQ
         UHkQ==
X-Received: by 10.180.72.239 with SMTP id g15mr18862342wiv.45.1391638791354;
        Wed, 05 Feb 2014 14:19:51 -0800 (PST)
Received: from localhost.localdomain (80.156.189.109.customer.cdi.no. [109.189.156.80])
        by mx.google.com with ESMTPSA id t6sm49584777wix.4.2014.02.05.14.19.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Feb 2014 14:19:50 -0800 (PST)
X-Mailer: git-send-email 1.8.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241669>

Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
---

In July I sent in some typo fixes but it halted in a discussion on UK
vs. US English and so forth ($gmane/231331). There were some actual typ=
o
fixes in there though (in addition to the "opinionated typo fixes").

Powering up my old laptop for the first time in months I noticed that I
had them idling in a branch, and that incidentally none of them has bee=
n
fixed. Hopefully I've managed to seperate the genuine typo fixes from
the rest.

 Documentation/git-clone.txt   | 2 +-
 Documentation/git-diff.txt    | 2 +-
 Documentation/gitcli.txt      | 2 +-
 Documentation/githooks.txt    | 2 +-
 Documentation/gitweb.conf.txt | 4 ++--
 Documentation/user-manual.txt | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 4987857..bf3dac0 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -208,7 +208,7 @@ objects from the source repository into a pack in t=
he cloned repository.
 --separate-git-dir=3D<git dir>::
 	Instead of placing the cloned repository where it is supposed
 	to be, place the cloned repository at the specified directory,
-	then make a filesytem-agnostic Git symbolic link to there.
+	then make a filesystem-agnostic Git symbolic link to there.
 	The result is Git repository can be separated from working
 	tree.
=20
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 33fbd8c..56fb7e5 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -44,7 +44,7 @@ two blob objects, or changes between two files on dis=
k.
 	commit relative to the named <commit>.  Typically you
 	would want comparison with the latest commit, so if you
 	do not give <commit>, it defaults to HEAD.
-	If HEAD does not exist (e.g. unborned branches) and
+	If HEAD does not exist (e.g. unborn branches) and
 	<commit> is not given, it shows all staged changes.
 	--staged is a synonym of --cached.
=20
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 3f33ca5..1c3e109 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -28,7 +28,7 @@ arguments.  Here are the rules:
    they can be disambiguated by placing `--` between them.
    E.g. `git diff -- HEAD` is, "I have a file called HEAD in my work
    tree.  Please show changes between the version I staged in the inde=
x
-   and what I have in the work tree for that file". not "show differen=
ce
+   and what I have in the work tree for that file", not "show differen=
ce
    between the HEAD commit and the work tree as a whole".  You can say
    `git diff HEAD --` to ask for the latter.
=20
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index d48bf4d..d954bf6 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -251,7 +251,7 @@ three parameters:
=20
  - the name of the ref being updated,
  - the old object name stored in the ref,
- - and the new objectname to be stored in the ref.
+ - and the new object name to be stored in the ref.
=20
 A zero exit from the update hook allows the ref to be updated.
 Exiting with a non-zero status prevents 'git-receive-pack'
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.=
txt
index db4154f..952f503 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -630,13 +630,13 @@ need to set this element to empty list i.e. `[]`.
=20
 override::
 	If this field has a true value then the given feature is
-	overriddable, which means that it can be configured
+	overridable, which means that it can be configured
 	(or enabled/disabled) on a per-repository basis.
 +
 Usually given "<feature>" is configurable via the `gitweb.<feature>`
 config variable in the per-repository Git configuration file.
 +
-*Note* that no feature is overriddable by default.
+*Note* that no feature is overridable by default.
=20
 sub::
 	Internal detail of implementation.  What is important is that
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.=
txt
index 248dcab..d4f9804 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3795,7 +3795,7 @@ like so:
 $ git update-index filename
 -------------------------------------------------
=20
-but to avoid common mistakes with filename globbing etc, the command
+but to avoid common mistakes with filename globbing etc., the command
 will not normally add totally new entries or remove old entries,
 i.e. it will normally just update existing cache entries.
=20
--=20
1.8.5
