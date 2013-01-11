From: Ishayahu Lastov <meoc-it@mail.ru>
Subject: Fwd: git checkout doesn't work?
Date: Fri, 11 Jan 2013 10:46:29 +0400
Message-ID: <CAJ52sWkf+ZkLUdLw1ornVt5E2af3w1YSqhkOajTWxvTPKvkAJg@mail.gmail.com>
References: <CAJ52sWkhQDhaZxjp4vxdwSX8HGYMqaXW=gZ-d6atUDKSjHg=yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 07:47:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtYOU-0000tA-WD
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 07:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541Ab3AKGqv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2013 01:46:51 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:56743 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110Ab3AKGqu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jan 2013 01:46:50 -0500
Received: by mail-lb0-f179.google.com with SMTP id gm13so1082939lbb.38
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 22:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=PGHPYcV/tQpaggb7a1EwqvX/GrXTXcnhr9Hi2Aq4i34=;
        b=B8npa4AbhhCBewl62ijsclzcgoz5mHcnLU+2b7KWkamPLeUKbGm/k2cvOJVRrFweKs
         N0oHWC4vBZ0jLYZ8YOAFFf+WA6bjC7t7zJazONZUbXXAkUrLsYtqVN8moYRlSu4yvFxV
         il/1KDjY3H3Qq3sUV6XUuWJJSbYkt5cmcqEu7/wTNXCHe1AQNOJWZWU4GR26NKpjGAfe
         u6lBKVxnmY6yKEsPaRXm8JTdAhgw4A/G1mLopow0CFZjcwwe/fccr0h8HIamwo88Xj+i
         +laMZlGTQK26gPdfgEhsUUau846o9z7AUe4Wco1Ba+Vj1ZFUcLlsGvXV3WZDGGgSJuxz
         UTSQ==
Received: by 10.152.112.36 with SMTP id in4mr72023443lab.35.1357886809090;
 Thu, 10 Jan 2013 22:46:49 -0800 (PST)
Received: by 10.114.77.138 with HTTP; Thu, 10 Jan 2013 22:46:29 -0800 (PST)
In-Reply-To: <CAJ52sWkhQDhaZxjp4vxdwSX8HGYMqaXW=gZ-d6atUDKSjHg=yw@mail.gmail.com>
X-Google-Sender-Auth: YF1TYpIVKAOIhyg3wYi8rg_Tric
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213182>

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
