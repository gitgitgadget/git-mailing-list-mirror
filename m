From: Ryan Bilesky <rbilesky@gmail.com>
Subject: New To GIT have some (probably simple) newbie questions
Date: Mon, 4 Apr 2011 15:13:32 -0700
Message-ID: <BANLkTim=G0obXv9LjoT7nW9C=wpmJ=RAVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 00:13:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6s1r-0006wK-28
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 00:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755871Ab1DDWNh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Apr 2011 18:13:37 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61243 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755866Ab1DDWNe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Apr 2011 18:13:34 -0400
Received: by wya21 with SMTP id 21so5078056wya.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 15:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=ixBrmrz1L+Gf8QCPmauOcBl9HITb+BlLUDs4jRlrA/M=;
        b=Ivt8cfLcS1Pqz3jS5EBhaRGC6sKOnVtGjC7uMZRXRfNdW/YFgFmEBLl1XBP7aHAna/
         MOeLHscS/99eqRPeruIcW24+6d67yzzJws2kkOjCBszCP84Yw908gCBkSZL8+iYAc+Ht
         7pwX2wLysrq1QQVP3j70CVpbQi5BouTKs/d1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=F2JIs+afpMYJ+btoNQDdge9V5qPitb5TkdDnDNuwI1h83XIaUdn7pHWxP2DyEhZbOQ
         avmKrw8VvA6vvLrgEsDWIwQG3kdMrDLR1SFpFQmyVXeOMsYo/egxvVZt8hXaN4fp1DBH
         xZAsY6quBmHrC845wriIVLdpK2cmDiROI3Y5A=
Received: by 10.216.67.1 with SMTP id i1mr3766916wed.62.1301955212883; Mon, 04
 Apr 2011 15:13:32 -0700 (PDT)
Received: by 10.216.56.69 with HTTP; Mon, 4 Apr 2011 15:13:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170842>

Sorry if these questions seem simple but I am new to GIT, I've done
some searching about how it works but I still have some questions that
I hope someone on this list would be kind enough to answer.=A0 I am
using msysgit on Windows 7.

=46or some of my projects I have to comit changes to SVN.=A0 So I did s=
ome
research and found out how to use git-svn so I start by right clicking
on the directory I want to store my repository in, and I select Git
Bash Here.=A0 I enter in the comand

git-svn clone -s --username=3Dmyusername https://mysvnrepo/svn git

and that works and it creates a local git repository that is cloned
from the svn repo, then if I

git-svn dcommit

that keeps then synced up, but there is my first issue, manually
syncing, so I look at git hooks, so if I create a file called
post-commit in the hooks directory of my local git repo with the
following content

#!/bin/sh
git-svn dcommit

that should work to automatically sync my local git repo and the
remote svn repo upon me committing to git right?

What I have no clue how to do though it to get this to work with
another git repo, I mean I can use the gui to clone a git repo, but
how do I sync them up.=A0 The reason being is I use a git hosting
service where I want to mirror all my commit to, just as a backup
mostly.

How can I sync up my local git repo with the remote hosted repo AND
where necessary svn using svn-git?

My final question is a matter of work flow.=A0 I have a local it repos
on my machine using msysgit, as well as hosted git repos with an
online service.=A0 Since I am a single developer its easy to just sync
my commits back to the remote repo for each project I have.=A0 But if I
do get another developer or two to help me how does that work, do we
all just sync to the one hosted repo or should we all sync with
another too?=A0 And if so how do I sync with multiple git repos.

Thanks in advance for your help.
