From: Ishayahu Lastov <meoc-it@mail.ru>
Subject: git checkout bug on Win7 x64
Date: Fri, 11 Jan 2013 11:30:01 +0400
Message-ID: <CAJ52sWnm23pLibG24PZm0UB=_tk7JahNx0c53E1udJG4D3yvvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 08:36:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtZ9h-00053p-Sx
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 08:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746Ab3AKHfi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2013 02:35:38 -0500
Received: from mail-la0-f44.google.com ([209.85.215.44]:44454 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401Ab3AKHfh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jan 2013 02:35:37 -0500
Received: by mail-la0-f44.google.com with SMTP id fr10so1479815lab.31
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 23:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=PGHPYcV/tQpaggb7a1EwqvX/GrXTXcnhr9Hi2Aq4i34=;
        b=xxFuKVg63VHgYOAoZy1mMKXulu/ZTfZmSAix0fF/5hNTYpsZxsACQkJRmYX78T/6XR
         1AYlTXAvRh9uS3UvvXS9zCQ4SUXtpRt4d0Q7yhUXBOKxg+qGAzr82LxopEvQr6pEDVgb
         yt+hZVtTcZVUi7K0z8lNPGvPLGj3mhagBwe+lb/zv8Nqah4WXOt9MqtF1lUcsFgwhc1q
         oyf8gz/rDAdBhUnYkD9fMd0Z5rTJsQRVGXSZnX0JqP4IUml6dhSPebGvqX7hGOrRS5ZO
         81/a2rp0krZmBngckyCUpkovlro08SrPbn9TFbbdzqxe/82rCaAJ8leiI+5ADXniu3qH
         1muQ==
Received: by 10.112.50.138 with SMTP id c10mr30580054lbo.104.1357889421442;
 Thu, 10 Jan 2013 23:30:21 -0800 (PST)
Received: by 10.114.77.138 with HTTP; Thu, 10 Jan 2013 23:30:01 -0800 (PST)
X-Google-Sender-Auth: E9tTC1FUHAeBbW4vFBshfl1so4k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213183>

This is my session on Win7 x64:
Microsoft Windows [Version 6.1.7601]
(c) =D0=9A=D0=BE=D1=80=D0=BF=D0=BE=D1=80=D0=B0=D1=86=D0=B8=D1=8F =D0=9C=
=D0=B0=D0=B9=D0=BA=D1=80=D0=BE=D1=81=D0=BE=D1=84=D1=82 (Microsoft Corp.=
), 2009. =D0=92=D1=81=D0=B5 =D0=BF=D1=80=D0=B0=D0=B2=D0=B0 =D0=B7=D0=B0=
=D1=89=D0=B8=D1=89=D0=B5=D0=BD=D1=8B.

C:\Dropbox\Dropbox\Wesnoth\Apocryphs>cd Apokryphs.Orks

C:\Dropbox\Dropbox\Wesnoth\Apocryphs\Apokryphs.Orks>git status
# On branch master
# Your branch is behind 'origin/master' by 3 commits, and can be fast-f=
orwarded.

#
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
#
#       modified:   scenarios/01_NothernVillage.cfg
#
no changes added to commit (use "git add" and/or "git commit -a")

C:\Dropbox\Dropbox\Wesnoth\Apocryphs\Apokryphs.Orks>cd scenarios

C:\Dropbox\Dropbox\Wesnoth\Apocryphs\Apokryphs.Orks\scenarios>git statu=
s
# On branch master
# Your branch is behind 'origin/master' by 3 commits, and can be fast-f=
orwarded.

#
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
#
#       modified:   01_NothernVillage.cfg
#
no changes added to commit (use "git add" and/or "git commit -a")

C:\Dropbox\Dropbox\Wesnoth\Apocryphs\Apokryphs.Orks\scenarios>git check=
out -- 01
_NothernVillage.cfg

C:\Dropbox\Dropbox\Wesnoth\Apocryphs\Apokryphs.Orks\scenarios>git statu=
s
# On branch master
# Your branch is behind 'origin/master' by 3 commits, and can be fast-f=
orwarded.

#
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
#
#       modified:   01_NothernVillage.cfg
#
no changes added to commit (use "git add" and/or "git commit -a")

C:\Dropbox\Dropbox\Wesnoth\Apocryphs\Apokryphs.Orks\scenarios>

As I understand after last "git checkout" in "git status" I should see
that I gave no changes. It looks like an bug, isn't it?

--

=D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D1=8F=D0=B9=D1=82=D0=B5, =D0=BF=D0=
=BE=D0=B6=D0=B0=D0=BB=D1=83=D0=B9=D1=81=D1=82=D0=B0, =D0=BF=D1=80=D0=B8=
 =D0=BE=D1=82=D0=B2=D0=B5=D1=82=D0=B5 =D0=B8=D1=81=D1=85=D0=BE=D0=B4=D0=
=BD=D1=8B=D0=B9 =D1=82=D0=B5=D0=BA=D1=81=D1=82 =D0=BF=D0=B8=D1=81=D1=8C=
=D0=BC=D0=B0

=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
=D0=BD=D0=B0=D1=87=D0=B0=D0=BB=D1=8C=D0=BD=D0=B8=D0=BA =D0=BE=D1=82=D0=B4=
=D0=B5=D0=BB=D0=B0 =D1=82=D0=B5=D1=85=D0=BD=D0=B8=D1=87=D0=B5=D1=81=D0=BA=
=D0=BE=D0=B9 =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=B6=D0=BA=D0=B8
=D0=9C=D0=BE=D1=81=D0=BA=D0=BE=D0=B2=D1=81=D0=BA=D0=BE=D0=B3=D0=BE =D0=95=
=D0=B2=D1=80=D0=B5=D0=B9=D1=81=D0=BA=D0=BE=D0=B3=D0=BE =D0=9E=D0=B1=D1=89=
=D0=B8=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE =D0=A6=D0=B5=D0=BD=D1=82=D1=80=D0=B0
=D0=98=D1=88=D0=B0=D1=8F=D1=83 =D0=9B=D0=B0=D1=81=D1=82=D0=BE=D0=B2
=D1=82=D0=B5=D0=BB=D0=B5=D1=84=D0=BE=D0=BD: +7-495-645-05-16
=D0=BC=D0=BE=D0=B1      : +7-901-569-81-86
=D1=81 12 =D0=B4=D0=BE 18, =D1=81 =D0=B2=D0=BE=D1=81=D0=BA=D1=80=D0=B5=D1=
=81=D0=B5=D0=BD=D1=8C=D1=8F =D0=BF=D0=BE =D1=87=D0=B5=D1=82=D0=B2=D0=B5=
=D1=80=D0=B3
