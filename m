From: "Zorba" <cr@altmore.co.uk>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-)
Date: Tue, 30 Dec 2008 21:27:33 -0000
Message-ID: <gje3ok$gnc$4@ger.gmane.org>
References: <gj68a0$u56$3@ger.gmane.org> <gj6kqq$nvh$4@ger.gmane.org> <3ab397d0812291505v77824e6fvdecebc80f38a5f89@mail.gmail.com> <gjdh0r$n3c$4@ger.gmane.org> <gjdlcl$5no$4@ger.gmane.org> <gjdmm6$9oj$4@ger.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 22:29:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHm9b-0005Kd-UJ
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 22:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbYL3V2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 16:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752505AbYL3V2J
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 16:28:09 -0500
Received: from main.gmane.org ([80.91.229.2]:58390 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475AbYL3V2I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 16:28:08 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHm8A-00039X-Im
	for git@vger.kernel.org; Tue, 30 Dec 2008 21:28:05 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 21:28:02 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 21:28:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81.135.227.136
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
X-RFC2646: Format=Flowed; Response
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104208>

** REPRODUCING Possible bug
rebooted PC, opened a new git bash, and started from scratch - see console 
output below

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

Welcome to Git (version 1.6.0.2-preview20080923)


Run 'git help git' to display the help index.
Run 'git help <command>' to display help for specific commands.

conorr@KINKLADZE /w/GITPLATFORM
$ mkdir swproj

conorr@KINKLADZE /w/GITPLATFORM
$ cd swproj

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ cat > ABC.txt
ABC

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ cat > BC.txt
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
$ git add *a*.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git commit -m "version A"
Created initial commit 2b88490: version A
 2 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 ABC.txt
 create mode 100644 AC.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git tag versionA 2b88

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git rm AC.txt
rm 'AC.txt'

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
Created commit c1e1cf8: version B
 2 files changed, 1 insertions(+), 1 deletions(-)
 delete mode 100644 AC.txt
 create mode 100644 BC.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git tag versionB c1e1

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git add *c*.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git commit -m "version C"
Created commit 66c62fd: version C
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 C.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git tag versionC 66c6

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ rm *.*

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ ls

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git commit -a -m "version D"
Created commit eee4a13: version D
 3 files changed, 0 insertions(+), 3 deletions(-)
 delete mode 100644 ABC.txt
 delete mode 100644 BC.txt
 delete mode 100644 C.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git tag versionD eee4

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git status
# On branch master
nothing to commit (working directory clean)

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git checkout versionA .

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ ls
ABC.txt  AC.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ rm *.*

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git checkout versionB .

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ ls
ABC.txt  AC.txt  BC.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ rm *.*

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git checkout versionC .

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ ls
ABC.txt  AC.txt  BC.txt  C.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ rm *.*

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ git checkout versionD .

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ ls
ABC.txt  AC.txt  BC.txt  C.txt

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ gitk

conorr@KINKLADZE /w/GITPLATFORM/swproj
$ comment: gitk shows that versionA & C are correct, but B & D are wrong
