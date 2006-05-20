From: Santi <sbejar@gmail.com>
Subject: [PATCH] Document that diff/diff-tree accept any number of trees.
Date: Sat, 20 May 2006 22:51:03 +0200
Message-ID: <8aa486160605201351y4734993dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat May 20 22:51:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhYPx-0005ZB-6G
	for gcvg-git@gmane.org; Sat, 20 May 2006 22:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWETUvF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 20 May 2006 16:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWETUvF
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 16:51:05 -0400
Received: from wx-out-0102.google.com ([66.249.82.192]:59334 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751483AbWETUvE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 May 2006 16:51:04 -0400
Received: by wx-out-0102.google.com with SMTP id s6so676007wxc
        for <git@vger.kernel.org>; Sat, 20 May 2006 13:51:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BnYC7FxZ0aNf7mPSYGN0VC9FaN5Of/3fCDRxVWqbvfSdOTxPpiVznsvojLsb8sT/DYSxObbtDcpO5l09L6H1+PdKR2t1edbO0ki0BaWzKkM+W4q8A+F65H5uUOftdYnABIe2BhFJbXvC+vLBiZFQx7u1UkvyqFSozVIGGmWK3TQ=
Received: by 10.70.11.2 with SMTP id 2mr3589484wxk;
        Sat, 20 May 2006 13:51:03 -0700 (PDT)
Received: by 10.70.45.14 with HTTP; Sat, 20 May 2006 13:51:03 -0700 (PDT)
To: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20395>

Signed-off-by: Santi B=E9jar <sbejar@gmail.com>


---

b98780e10df65bf9b37b4368d97bac53b5371170
 Documentation/git-diff-tree.txt |    5 ++++-
 Documentation/git-diff.txt      |    4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)

b98780e10df65bf9b37b4368d97bac53b5371170
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-t=
ree.txt
index 906830d..3141ad8 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git-diff-tree' [--stdin] [-m] [-s] [-v] [--no-commit-id] [--pretty]
              [-t] [-r] [-c | --cc] [--root] [<common diff options>]
-             <tree-ish> [<tree-ish>] [<path>...]
+             <tree-ish>... [<path>...]

 DESCRIPTION
 -----------
@@ -20,6 +20,9 @@ Compares the content and mode of the blo
 If there is only one <tree-ish> given, the commit is compared with its=
 parents
 (see --stdin below).

+If three or more <tree-ish> are given, it shows the differences from e=
ach of
+the <tree-ish> to the first one simultaneously (see -c below).
+
 Note that "git-diff-tree" can use the tree encapsulated in a commit ob=
ject.

 OPTIONS
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 7267bcd..1842d7a 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -8,7 +8,7 @@ git-diff - Show changes between commits,

 SYNOPSIS
 --------
-'git-diff' [ --diff-options ] <ent>{0,2} [<path>...]
+'git-diff' [ --diff-options ] [<ent>...] [<path>...]

 DESCRIPTION
 -----------
@@ -25,7 +25,7 @@ the number of ents given to the command.
   `--cached` can be given to compare the index file and
   the named tree.

-* When two <ent>s are given, these two trees are compared
+* When two or more <ent>s are given, these trees are compared
   using `git-diff-tree`.

 OPTIONS
--
1.3.3.g5b1bb
