From: "Zorba" <cr@altmore.co.uk>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-) [Scanned]
Date: Wed, 31 Dec 2008 12:03:03 -0000
Message-ID: <gjfn28$3k2$4@ger.gmane.org>
References: <BB5F02FD3789B54E8964D38D6775E718242D35@ALTMORE-SVR.altmore.local> <alpine.LNX.1.00.0812302143210.19665@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 31 13:07:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHzrL-0004oh-9n
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 13:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755550AbYLaMDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 07:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755450AbYLaMDd
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 07:03:33 -0500
Received: from main.gmane.org ([80.91.229.2]:52436 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754142AbYLaMDc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 07:03:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHznL-0006An-QT
	for git@vger.kernel.org; Wed, 31 Dec 2008 12:03:27 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 12:03:27 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 12:03:27 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81.135.227.136
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104268>

Ok, starting from scratch, new dir, new repo

I can now get $ git checkout <version> to work (see extract below, missed 
the first few lines due to exceeding buffer)

The difference with the instance when I found "errors" is that that time I'd 
run $ git checkout <version> .
a few times first, which as I now know, would have been making updates to 
the index all along.

I presume this is what screwed things up for the normal checkout situation, 
because when I ran $ git checkout <version> on all the versions, there were 
always less files than I expected in the working dir

Still not sure if I can trust $ git checkout <version>...

Why should

$ git checkout <version> .

screw things up for

$ git checkout <version>

?
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

BC

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ cat > AC.txt
AC


conorr@KINKLADZE /w/GITPLATFORM/swproj
$ cat > C.txt
C

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ ls
ABC.txt  AC.txt  BC.txt  C.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git init
Initialized empty Git repository in w:/GITPLATFORM/swproj/.git/

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git add ABC.txt AC.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git commit -m "version A"
Created initial commit 8ce0d2c: version A
 2 files changed, 3 insertions(+), 0 deletions(-)
 create mode 100644 ABC.txt
 create mode 100644 AC.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git tag versiona 8ce0

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git rm AC.txt
rm 'AC.txt'

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ ls
ABC.txt  BC.txt  C.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git add BC.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       deleted:    AC.txt
#       new file:   BC.txt
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       C.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git commit -m "version B"
Created commit fad9c29: version B
 2 files changed, 1 insertions(+), 2 deletions(-)
 delete mode 100644 AC.txt
 create mode 100644 BC.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git tag versionB fad9

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ ls
ABC.txt  BC.txt  C.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ cat > AC.txt
AC

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ ls
ABC.txt  AC.txt  BC.txt  C.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git commit -m "version C"
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       AC.txt
#       C.txt
nothing added to commit but untracked files present (use "git add" to track)

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ // mistake - forgot to stage changes
sh.exe": //: is a directory

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git reset --hard versionB
HEAD is now at fad9c29 version B

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ ls
ABC.txt  AC.txt  BC.txt  C.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git add *c*.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       new file:   AC.txt
#       new file:   C.txt
#

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git commit -m "version C"
Created commit 9cf73cb: version C
 2 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 AC.txt
 create mode 100644 C.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git tag versionC 9cf7

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ ls
ABC.txt  AC.txt  BC.txt  C.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git rm *.*
rm 'ABC.txt'
rm 'AC.txt'
rm 'BC.txt'
rm 'C.txt'

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ ls

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git commit -m "version D"
Created commit 8e4b5be: version D
 4 files changed, 0 insertions(+), 4 deletions(-)
 delete mode 100644 ABC.txt
 delete mode 100644 AC.txt
 delete mode 100644 BC.txt
 delete mode 100644 C.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git tag versionD 8e4b

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git status
# On branch master
nothing to commit (working directory clean)

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ gitk

conorr@KINKLADZE /w/GITPLATFORM/swproj
<sionA = ABC.txt, AC.txt, version B = ABC.txt, BC.txt
sh.exe": //: is a directory

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ cat > commet.txt// gitk confirms that versionA = ABC.txt, AC.txt,
sh.exe": commet.txt//: No such file or directory

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ cat > comment.txt
gitk confirms that:
versionA = ABC.txt, AC.txt
versionB = ABC.txt, BC.txt
versionC = ABC.txt, AC.txt, BC.txt, C.txt
versionD =

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ gitk

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git show
WARNING: terminal is not fully functional
commit 8e4b5bed1faadc608fc114e62bf1859b6bbed4a0
Author: Conor Rafferty <cr@altmore.co.uk>
Date:   Wed Dec 31 11:40:45 2008 +0000

    version D

diff --git a/ABC.txt b/ABC.txt
deleted file mode 100644
index 83871a5..0000000
--- a/ABC.txt
+++ /dev/null
@@ -1 +0,0 @@
-ABC
diff --git a/AC.txt b/AC.txt
deleted file mode 100644
index 9eadfae..0000000
--- a/AC.txt
+++ /dev/null
@@ -1 +0,0 @@
-AC
diff --git a/BC.txt b/BC.txt
deleted file mode 100644
index b3ac6f5..0000000
--- a/BC.txt
+++ /dev/null
@@ -1 +0,0 @@
-BC
diff --git a/C.txt b/C.txt
deleted file mode 100644
index 06a63fe..0000000
--- a/C.txt
+++ /dev/null
@@ -1 +0,0 @@
-C
(END)
conorr@KINKLADZE /w/GITPLATFORM/swproj
$

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git checkout versionA
Note: moving to "versionA" which isn't a local branch
If you want to create a new branch from this checkout, you may do so
(now or later) by using -b with the checkout command again. Example:
  git checkout -b <new_branch_name>
HEAD is now at 8ce0d2c... version A

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ ls
ABC.txt  AC.txt  comment.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git checkout versionB
Previous HEAD position was 8ce0d2c... version A
HEAD is now at fad9c29... version B

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ ls
ABC.txt  BC.txt  comment.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git checkout versionC
Previous HEAD position was fad9c29... version B
HEAD is now at 9cf73cb... version C

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ ls
ABC.txt  AC.txt  BC.txt  C.txt  comment.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git checkout versionD
Previous HEAD position was 9cf73cb... version C
HEAD is now at 8e4b5be... version D

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ ls
comment.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ rm *.*

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ ls

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git checkout versionA
Previous HEAD position was 8e4b5be... version D
HEAD is now at 8ce0d2c... version A

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ ls
ABC.txt  AC.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git checkout versionB
Previous HEAD position was 8ce0d2c... version A
HEAD is now at fad9c29... version B

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ ls
ABC.txt  BC.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git checkout versionC
Previous HEAD position was fad9c29... version B
HEAD is now at 9cf73cb... version C

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ ls
ABC.txt  AC.txt  BC.txt  C.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git checkout versionD
Previous HEAD position was 9cf73cb... version C
HEAD is now at 8e4b5be... version D

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ ls

conorr@KINKLADZE /w/GITPLATFORM/swproj
$

"Daniel Barkalow" <barkalow@iabervon.org> wrote in message
>
>> wtf is wrong with
>>
>> git checkout <something>
>>
>> ??
>>
>> ** It doesn't reliably put the files that were in that revision into the
>> working directory - a fairly major flaw, for what I'm using SCM for (and
>> 80% of the market IMHO)
>
> It certainly does for me; I rely on it pretty much constantly. Can you
> give a sequence of commands (ideally the whole sequence from the "git
> init") that leads to a difference?
