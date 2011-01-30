From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Melo_de_Sampaio?= <jpmelos@gmail.com>
Subject: Remote branchs -- how can I check them out?
Date: Sun, 30 Jan 2011 13:05:07 -0200
Message-ID: <AANLkTin3Tfcf=WJHJdSA9TwhFXQfaMrnm5+YEWWjo=qj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 30 16:05:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjYqI-0008Pn-QL
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 16:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653Ab1A3PFL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jan 2011 10:05:11 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33396 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab1A3PFK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jan 2011 10:05:10 -0500
Received: by bwz15 with SMTP id 15so4570736bwz.19
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 07:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=HJzmeKPYGLJ7zeITYhndKs2QtAK5AGbH/67gEs+Rrsg=;
        b=Ya8E24uQOU0Mbqv/rUpyECiwqvjhA0DhyXgwy8LxSXUMV75FoSybrXIqR1+4OQVXzR
         IuZ0XVtPZ11aT5krZASl4c0YtTjW3vgL97oCwm11X82PQlCuvBWgr6dOcAnzdEtH/hs4
         SvX413uG3jjQfc1kAzXI6V3Ht0EjwfHwI1Zuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=vKZnlpzLUYB3HQyN08vuCxsJYHVlHOk4d1h/c470a3CcU3OOcaHpW145gALUBUZGiV
         u3comt337xvprUO++XN293fFcY8FRiw8hGpW8oTs36K6Q81DSEdRwj7fQjo6hnEVKTYQ
         IzEFTHxGpMtNR8Fx7igdGfQdPGtr/mDCBabOI=
Received: by 10.204.81.72 with SMTP id w8mr2217548bkk.205.1296399907212; Sun,
 30 Jan 2011 07:05:07 -0800 (PST)
Received: by 10.204.66.6 with HTTP; Sun, 30 Jan 2011 07:05:07 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165684>

Hello, people.

When I just cloned git using

    git clone git://git.kernel.org/pub/scm/git/git.git

and I type

    git branch

it shows me I have only the 'master' branch in my local repository

    * master

and when I type

    git branch -a

it shows that there's all these branches remotely

    * master
      remotes/origin/HEAD -> origin/master
      remotes/origin/html
      remotes/origin/maint
      remotes/origin/man
      remotes/origin/master
      remotes/origin/next
      remotes/origin/pu
      remotes/origin/todo

What do I have to do to be able to see what's in the 'maint', 'next'
and 'todo' branches, for example?

And by the way, what are those branches all about? Their names
suggests they are maintenance branches (where you keep backward
compatibility with an older version?), the next version of git (1.7.4
version?) and future features under implementation (the to-do list?).

Thank you for your time!

--=20
Jo=C3=A3o Paulo Melo de Sampaio
Computer Engineering Student @ UFSCar
Website: http://www.jpmelos.com
Twitter: twitter.com/jpmelos (@jpmelos)
