From: Benedikt Andreas Koeppel <bkoeppel@ee.ethz.ch>
Subject: Modified files directly after clone
Date: Tue, 9 Mar 2010 21:26:03 +0100
Message-ID: <7416BCB6-306F-4BC1-913C-1208746DA93E@ee.ethz.ch>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 09 21:36:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np6A2-0002U9-3x
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 21:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755361Ab0CIUgJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Mar 2010 15:36:09 -0500
Received: from smtp.ee.ethz.ch ([129.132.2.219]:51096 "EHLO smtp.ee.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755244Ab0CIUgH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Mar 2010 15:36:07 -0500
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Mar 2010 15:36:07 EST
Received: from localhost (localhost [127.0.0.1])
	by smtp.ee.ethz.ch (Postfix) with ESMTP id 16631D9394
	for <git@vger.kernel.org>; Tue,  9 Mar 2010 21:26:05 +0100 (MET)
X-Virus-Scanned: by amavisd-new on smtp.ee.ethz.ch
Received: from smtp.ee.ethz.ch ([127.0.0.1])
	by localhost (.ee.ethz.ch [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id FqMumlQX9m-p for <git@vger.kernel.org>;
	Tue,  9 Mar 2010 21:26:04 +0100 (MET)
Received: from [192.168.2.105] (84-75-183-84.dclient.hispeed.ch [84.75.183.84])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: bkoeppel)
	by smtp.ee.ethz.ch (Postfix) with ESMTPSA id AAF17D938F
	for <git@vger.kernel.org>; Tue,  9 Mar 2010 21:26:04 +0100 (MET)
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141847>

Dear Sir/Madam,

I'm experiencing a strange problem with one of my GIT repositories. The=
 repo is hosted on my Debian 5 server with gitosis. I clone the repo to=
 my Mac OS X 10.6 notebook. Directly after cloning the repository, ther=
e are already some modified files which are "Changed but not updated".

This is how I do it:=20

=3D=3D=3D=3D bash start =3D=3D=3D=3D
beninb:Desktop beni$ mkdir tmp
beninb:Desktop beni$ cd tmp
beninb:tmp beni$ git clone git@gmuasch:ife-maemo.git git
Initialized empty Git repository in /Users/beni/Desktop/tmp/git/.git/
remote: Counting objects: 43316, done.
remote: Compressing objects: 100% (33045/33045), done.
remote: Total 43316 (delta 10942), reused 42064 (delta 9790)
Receiving objects: 100% (43316/43316), 518.25 MiB | 640 KiB/s, done.
Resolving deltas: 100% (10942/10942), done.
Checking out files: 100% (68385/68385), done.
beninb:tmp beni$ cd git/
beninb:git beni$ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
#
#	modified:   source/crn/toolbox/doc/html/classVector.html
#	modified:   source/maemo-beagle/www/files/maemo5-alpha/kernel-2.6.28/=
Documentation/IO-mapping.txt
# some more lines
#	modified:   source/maemo-beagle/www/files/maemo5-alpha/kernel-2.6.28/=
net/netfilter/xt_TCPMSS.c
#	modified:   source/maemo-kernel/kernel-2.6.28/Documentation/IO-mappin=
g.txt
# some more lines
#	modified:   source/maemo-kernel/kernel-2.6.28/net/netfilter/xt_TCPMSS=
=2Ec
#
no changes added to commit (use "git add" and/or "git commit -a")

=3D=3D=3D=3D bash end =3D=3D=3D=3D

"gmuasch" is an SSH-alias for my Debian server
git diff gives the following: http://pastie.org/861916

On my server, I'm running git version 1.6.2.4. Locally on my Mac, I hav=
e git version 1.6.2. But there were some commits done from Ubuntu 9.10 =
with git 1.7.0.1.

Those folders are SVN checkouts:
source/crn
source/maemo-beagle
But source/maemo-kernel is not a SVN checkout.

I tried the same procedure on a different machine (running Debian 5, gi=
t version 1.6.2.4), and did not have any modified files after cloning t=
he repo.=20



How can this happen? Does my Mac somehow interfere with the newly clone=
d repository?



Best Regards,
Benedikt K=F6ppel
