From: Arup Rakshit <aruprakshit@rocketmail.com>
Subject: Re: untracked file deleted from the master branch, when checked out to it from a local branch
Date: Wed, 21 May 2014 00:10:47 +0630
Organization: CognitiveClouds
Message-ID: <2654529.8c5AhJCJsq@linux-wzza.site>
References: <2525467.KRXv8a3gWS@linux-wzza.site> <2726779.MFtIaLB4b4@linux-wzza.site> <xmqqk39gz4tw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 20:40:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmoxk-0002Yp-Bt
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 20:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbaETSk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 14:40:28 -0400
Received: from nm25-vm4.bullet.mail.sg3.yahoo.com ([106.10.151.99]:23787 "EHLO
	nm25-vm4.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751499AbaETSk1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 May 2014 14:40:27 -0400
Received: from [106.10.166.115] by nm25.bullet.mail.sg3.yahoo.com with NNFMP; 20 May 2014 18:40:25 -0000
Received: from [106.10.167.150] by tm4.bullet.mail.sg3.yahoo.com with NNFMP; 20 May 2014 18:40:25 -0000
Received: from [127.0.0.1] by smtp123.mail.sg3.yahoo.com with NNFMP; 20 May 2014 18:40:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s1024; t=1400611225; bh=VTF++SziaCmgxkoQiA/aot3UeJvXzZXzhpGqLMvNwgo=; h=X-Yahoo-Newman-Id:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:X-Rocket-Received:From:To:Subject:Date:Message-ID:Organization:User-Agent:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type; b=m63l4SArh7zK2eaOiOhE8PVqM9Tfwj8fmonVIzmkinqziB9tIKlcs0nID2j7gaL22U6ixl+tbe/68/7qfIjrhnkiPuprnJpQtM4EYN3F84ZVzvQq4R9Pr/qcW728cnIUK0h4ZT16Zt+eilDAL0/qOhmw15yL2BImqSP9xGVotfM=
X-Yahoo-Newman-Id: 789603.38537.bm@smtp123.mail.sg3.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: tGORTR8VM1lhdqLec3Ubn5CeG7pjrKuoMbo4JHPpzRgvqHq
 z2sVO59T5e6FNt2V3CWlH9P8Ko3U8eskN5Jj2QT6SOcgYGdvc2OyY9Ut4AK2
 RKXMjaFJ0amyQ9wdA.VBYeXoOPTrtt.7bLR8V2zbmmMj3sl6SrKEyYi0wIoS
 vFpimjMkB0_GjxVAZFpzoZ_GC5aRYHgBnbsZVmCXCrFDcklThaBno7yZSL5x
 1sDroUiGdQQqNt3GFGjJrRKQd_elrr3pvon778KS3zQ7a8.v1sSSPu6Qep6R
 CKG.liUkrhqRad_OLPlA3tOWp9H9bk.HK8njiRH1fxKsgWiRBhD5fb3hLojE
 ERCpN_URZokKGolO4eFJa19UV6j4WY.anFfEdKr1psn4VpnUlJVUBnOeQVmm
 ZkopEqqyNsxc7U1xwLTk7tZrTcmXL9bMBx4.FitchmAtSbDzLesAQo4Iq6j6
 tMLTvRgNWMYTOcRAN.hSYpihvGgWN76puknTLn_0DEaoqtSbAdmpBBT8NCCY
 zhX0HEg9TGaFJqRmsk4QtnPlNd4R72nA7m7Msrg--
X-Yahoo-SMTP: _NAuC72swBDpdridK5c7mltfXc1K.nFhPY5jXEZ4Gfdya8Gn_0nN
X-Rocket-Received: from linux-wzza.site (aruprakshit@101.222.245.191 with plain [106.10.150.171])
        by smtp123.mail.sg3.yahoo.com with SMTP; 20 May 2014 11:40:25 -0700 PDT
User-Agent: KMail/4.11.5 (Linux/3.11.10-7-default; KDE/4.11.5; i686; ; )
In-Reply-To: <xmqqk39gz4tw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249724>

On Tuesday, May 20, 2014 11:24:11 AM you wrote:
> Arup Rakshit <aruprakshit@rocketmail.com> writes:
> 
> Untracked files and modifications to files in your working directory
> do not belong to your current branch.  This is to allow you, after
> starting to work on one branch then realizing that the changes and
> additions you are making do not belong there, to switch to a more
> appropriate branch at that point without losing your work so far,
> taking these changes and additions with you to the branch you want
> to commit your changes to.
> 
Now, It makes sense. I gave it another try and this time I walk from back to 
front.

Now you can see, that I have created, a new file called *file.txt*, in the 
*master branch*. Now I went to a new branch and made some changes there in the 
newly created file. This time I didn't add it or commit too. I just came back 
to *master branch*. Now if I do *ls*,  can see the file is present in the 
*master* branch.

arup@linux-wzza:~/Git_tutorial> ls
test.txt
arup@linux-wzza:~/Git_tutorial> echo "hello" > file.txt
arup@linux-wzza:~/Git_tutorial> ls
file.txt  test.txt
arup@linux-wzza:~/Git_tutorial> git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       file.txt
nothing added to commit but untracked files present (use "git add" to track)
arup@linux-wzza:~/Git_tutorial> cat file.txt
hello
arup@linux-wzza:~/Git_tutorial> git checkout -b "file_branch"
Switched to a new branch 'file_branch'
arup@linux-wzza:~/Git_tutorial> cat file.txt
hello
arup@linux-wzza:~/Git_tutorial> echo "hello World" > file.txt
arup@linux-wzza:~/Git_tutorial> cat file.txt
hello World
arup@linux-wzza:~/Git_tutorial> git status
# On branch file_branch
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       file.txt
nothing added to commit but untracked files present (use "git add" to track)
arup@linux-wzza:~/Git_tutorial> git checkout master
Switched to branch 'master'
arup@linux-wzza:~/Git_tutorial> ls
file.txt  test.txt
arup@linux-wzza:~/Git_tutorial> cat file.txt
hello World
arup@linux-wzza:~/Git_tutorial>


-- 
===============
Regards,
Arup Rakshit
