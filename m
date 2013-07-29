From: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH] Documentation: fix typos in man pages
Date: Mon, 29 Jul 2013 23:15:43 +0200
Message-ID: <1375132543-20361-1-git-send-email-oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 29 23:16:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3unb-0007ay-Gp
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 23:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427Ab3G2VQF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jul 2013 17:16:05 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:34736 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755461Ab3G2VQD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 17:16:03 -0400
Received: by mail-lb0-f171.google.com with SMTP id t13so1446182lbd.16
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 14:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=8TW8Tx69l0JFm31Rmi3A8pRFtpCVU+Vn2I3+9Q1SYcQ=;
        b=Qrb2nSldYlsKcFFymyWHdqHJgcjXap2xNLwv0B1cppduKvg7jYXCfb1tHXD4UfT8dS
         9XaSwj6U78WlBZKjMzDZbRFRzSVOD7UWdVoJXpWdeatiaoCMfDm+d868+XXzCOHP5prd
         9aaM5/hLq34ZRei9DZNxtpbdmIqdVtlFF5kT93nSJI3FAvtQxwX9pbSwrJG4UPIrKl0Y
         x+vnBFGsJ/aIJxAiOGQzupHVdw2ZqGs05dKH4eV9WdlCfZYCL+N2Kbrh+zMOSwA8r3tT
         GKjtkXFcCJ4VQhn25JbXOuqgWWY4j4jyT1X/U/xV8Nu5aRw2swnqM/z+FwDeTQdbtY/3
         SMnA==
X-Received: by 10.152.163.101 with SMTP id yh5mr23205446lab.9.1375132561954;
        Mon, 29 Jul 2013 14:16:01 -0700 (PDT)
Received: from osse-w760.lan (147.137.202.84.customer.cdi.no. [84.202.137.147])
        by mx.google.com with ESMTPSA id m14sm6841807lbl.1.2013.07.29.14.16.00
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 14:16:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231331>

Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
---
I thought I'd take part in the typo fixing frenzy :)

I have some other potential typos lines up. Right now the docs refer to=
 both
'filesystem' and 'file system', as well as both 'testsuite' and 'test s=
uite'. I
think words like these are generally split in English but I'm not sure.

There are also some words that I think look better with with a dash, e.=
g.
'trade-off'. Should I just send these as a patch too instead of jabberi=
ng on
about it?

 Documentation/git-check-ignore.txt | 2 +-
 Documentation/git-clone.txt        | 2 +-
 Documentation/git-daemon.txt       | 2 +-
 Documentation/git-diff.txt         | 2 +-
 Documentation/gitcli.txt           | 2 +-
 Documentation/githooks.txt         | 2 +-
 Documentation/gitweb.conf.txt      | 4 ++--
 Documentation/user-manual.txt      | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-che=
ck-ignore.txt
index d2df487..5354301 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -35,7 +35,7 @@ OPTIONS
 	Read file names from stdin instead of from the command-line.
=20
 -z::
-	The output format is modified to be machine-parseable (see
+	The output format is modified to be machine-parsable (see
 	below).  If `--stdin` is also given, input paths are separated
 	with a NUL character instead of a linefeed character.
=20
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 450f158..3865658 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -213,7 +213,7 @@ objects from the source repository into a pack in t=
he cloned repository.
 --separate-git-dir=3D<git dir>::
 	Instead of placing the cloned repository where it is supposed
 	to be, place the cloned repository at the specified directory,
-	then make a filesytem-agnostic Git symbolic link to there.
+	then make a filesystem-agnostic Git symbolic link to there.
 	The result is Git repository can be separated from working
 	tree.
=20
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.tx=
t
index 223f731..a3283e1 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -189,7 +189,7 @@ Git configuration files in that directory are reada=
ble by `<user>`.
 	service by exiting with a non-zero status (or to allow it by
 	exiting with a zero status).  It can also look at the $REMOTE_ADDR
 	and $REMOTE_PORT environment variables to learn about the
-	requestor when making this decision.
+	requester when making this decision.
 +
 The external command can optionally write a single line to its
 standard output to be sent to the requestor as an error message when
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 78d6d50..fe42bf6 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -39,7 +39,7 @@ directories. This behavior can be forced by --no-inde=
x.
 	commit relative to the named <commit>.  Typically you
 	would want comparison with the latest commit, so if you
 	do not give <commit>, it defaults to HEAD.
-	If HEAD does not exist (e.g. unborned branches) and
+	If HEAD does not exist (e.g. unborn branches) and
 	<commit> is not given, it shows all staged changes.
 	--staged is a synonym of --cached.
=20
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 9ac5088..670c285 100644
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
index 305db63..5945d7a 100644
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
index fe723e4..618345d 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3807,7 +3807,7 @@ like so:
 $ git update-index filename
 -------------------------------------------------
=20
-but to avoid common mistakes with filename globbing etc, the command
+but to avoid common mistakes with filename globbing etc., the command
 will not normally add totally new entries or remove old entries,
 i.e. it will normally just update existing cache entries.
=20
--=20
1.8.2.2
