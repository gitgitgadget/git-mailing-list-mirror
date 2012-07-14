From: =?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?= <stepnem@gmail.com>
Subject: [PATCH] doc: A few minor copy edits.
Date: Sun, 15 Jul 2012 00:20:36 +0200
Message-ID: <1342304436-29499-1-git-send-email-stepnem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jul 15 00:20:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqAhk-0003Dm-C5
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 00:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab2GNWUo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jul 2012 18:20:44 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63638 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab2GNWUm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2012 18:20:42 -0400
Received: by wgbdr13 with SMTP id dr13so4174521wgb.1
        for <git@vger.kernel.org>; Sat, 14 Jul 2012 15:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=1v8H6mR+8ty3Ei+Awckn//AKRbAmE56PGwbvkPSnNyk=;
        b=oLBQ/50MF2XjQaivMuGHkKMTWzW5z40LT0U8idkksdfJhCobnr81YlbRliSGgMRKjh
         y6kJMCaDbN1PglvhMqsTFhGMFB5/TOxbakKYR0nerNIaIxQp49XpT6TkOYzy+LgfnYyV
         6exucsUPZT4Jxyq5UKMBFJof38fPZB2toYFnntAsIzfBuQPSeDNf2Zn+XSm7/rvy6NUI
         yCj0I+g4pxdi1xQ3/F72CYf7snPkTRQCyFR9pQSEl4ca0xZ36WH4rlQwfmILFO6Nao2C
         kGXgfuOtD859s/fIoOy0V6BHiRlcS09rhAPZbSaFi6fEa/OcxZiTJgUz3WHCSltiTytS
         +NbA==
Received: by 10.217.1.8 with SMTP id m8mr3158380wes.118.1342304440463;
        Sat, 14 Jul 2012 15:20:40 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz. [90.177.119.176])
        by mx.google.com with ESMTPS id w7sm12145232wiz.0.2012.07.14.15.20.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 14 Jul 2012 15:20:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201461>

- (glossary) the quotes around the Wikipedia URL prevented its
  linkification in frontends that support it; remove them

- (manual) newer version (SHA-1) =3D=3D following, older =3D=3D precedi=
ng, not
  the other way around

- trivial typo and wording fixes

Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>
---
 Documentation/git-merge.txt        |    2 +-
 Documentation/git-rebase.txt       |    2 +-
 Documentation/glossary-content.txt |    2 +-
 Documentation/rev-list-options.txt |    2 +-
 Documentation/user-manual.txt      |   12 ++++++------
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 3ceefb8..20f9228 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -181,7 +181,7 @@ final result verbatim.  When both sides made change=
s to the same area,
 however, git cannot randomly pick one side over the other, and asks yo=
u to
 resolve it by leaving what both sides did to that area.
=20
-By default, git uses the same style as that is used by "merge" program
+By default, git uses the same style as the one used by the "merge" pro=
gram
 from the RCS suite to present such a conflicted hunk, like this:
=20
 ------------
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 2d71e4b..2cab7e2 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -273,7 +273,7 @@ which makes little sense.
 	Pass the <strategy-option> through to the merge strategy.
 	This implies `--merge` and, if no strategy has been
 	specified, `-s recursive`.  Note the reversal of 'ours' and
-	'theirs' as noted in above for the `-m` option.
+	'theirs' as noted above for the `-m` option.
=20
 -q::
 --quiet::
diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
index 3595b58..f928b57 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -117,7 +117,7 @@ to point at the new commit.
=20
 [[def_ent]]ent::
 	Favorite synonym to "<<def_tree-ish,tree-ish>>" by some total geeks. =
See
-	`http://en.wikipedia.org/wiki/Ent_(Middle-earth)` for an in-depth
+	http://en.wikipedia.org/wiki/Ent_(Middle-earth) for an in-depth
 	explanation. Avoid this term, not to confuse people.
=20
 [[def_evil_merge]]evil merge::
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
index 84e34b1..d9b2b5b 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -760,7 +760,7 @@ options may be given. See linkgit:git-diff-files[1]=
 for more options.
=20
 --cc::
=20
-	This flag implies the '-c' options and further compresses the
+	This flag implies the '-c' option and further compresses the
 	patch output by omitting uninteresting hunks whose contents in
 	the parents have only two variants and the merge result picks
 	one of them without modification.
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.=
txt
index 02ed566..03d95dc 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2870,7 +2870,7 @@ $ git fetch example
 You can also add a "+" to force the update each time:
=20
 -------------------------------------------------
-$ git config remote.example.fetch +master:ref/remotes/example/master
+$ git config remote.example.fetch +master:refs/remotes/example/master
 -------------------------------------------------
=20
 Don't do this unless you're sure you won't mind "git fetch" possibly
@@ -2966,7 +2966,7 @@ As you can see, a commit is defined by:
=20
 - a tree: The SHA-1 name of a tree object (as defined below), represen=
ting
   the contents of a directory at a certain point in time.
-- parent(s): The SHA-1 name of some number of commits which represent =
the
+- parent(s): The SHA-1 name(s) of some number of commits which represe=
nt the
   immediately previous step(s) in the history of the project.  The
   example above has one parent; merge commits may have more than
   one.  A commit with no parents is called a "root" commit, and
@@ -3363,8 +3363,8 @@ Date:
 :100644 100644 oldsha... 4b9458b... M somedirectory/myfile
 ------------------------------------------------
=20
-This tells you that the immediately preceding version of the file was
-"newsha", and that the immediately following version was "oldsha".
+This tells you that the immediately following version of the file was
+"newsha", and that the immediately preceding version was "oldsha".
 You also know the commit messages that went with the change from oldsh=
a
 to 4b9458b and with the change from 4b9458b to newsha.
=20
@@ -4035,8 +4035,8 @@ $ git ls-files --unmerged
 Each line of the `git ls-files --unmerged` output begins with
 the blob mode bits, blob SHA-1, 'stage number', and the
 filename.  The 'stage number' is git's way to say which tree it
-came from: stage 1 corresponds to `$orig` tree, stage 2 `HEAD`
-tree, and stage3 `$target` tree.
+came from: stage 1 corresponds to the `$orig` tree, stage 2 to
+the `HEAD` tree, and stage 3 to the `$target` tree.
=20
 Earlier we said that trivial merges are done inside
 `git read-tree -m`.  For example, if the file did not change
--=20
1.7.10.4
