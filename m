From: =?UTF-8?B?Q2hyaXMg4oCcS3dwb2xza2HigJ0gV2Fycmljaw==?= 
	<kwpolska@gmail.com>
Subject: Git abuses qt4-ssh-askpass
Date: Sat, 10 May 2014 10:41:28 +0200
Message-ID: <CAMw+j7L1YkwjYZibOpuJDnC3FjaRZgBCKBMQcUyT9uRis3heFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 10 10:41:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wj2qi-0008H0-TP
	for gcvg-git-2@plane.gmane.org; Sat, 10 May 2014 10:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882AbaEJIlb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 May 2014 04:41:31 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:61469 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbaEJIl3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 May 2014 04:41:29 -0400
Received: by mail-ig0-f169.google.com with SMTP id hl10so2961080igb.2
        for <git@vger.kernel.org>; Sat, 10 May 2014 01:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=np1+dt4EIteaDxYCp9SC4NLUTPnOium1cQBmh8vWM/c=;
        b=qltjT0EcpB7CDYCIVErX8cXeRbF0KQXrpo9ObjY9TSHjzG+xEyFLcnStN4aQJAK3Ig
         jOYY6JX9VFsgT2ekr9oV/x4KwpDbhRpMhFiR416oOHYvPaIhlc3lq/2aHIN7lZzp0oSh
         9+U7+Hn38y0N4qpTaIJ69O+7mSvRJpNWhajd29pC6/+fMg4PL1ZOwgzlMe759fvYREMs
         IZTbv8y182ZJjIWJqDqHxM32M5HiGhl+S3lS5wRnDyAwq4+3PybwqfdQHBFmu6gK+ctO
         90xw84a76BDkAZ1o+RLoxOn/Tf6nSq6AOrEG0UCgGZNSlE1gWpsdusyrVbkzQkW3eROL
         Ctyw==
X-Received: by 10.50.79.161 with SMTP id k1mr19066032igx.31.1399711288600;
 Sat, 10 May 2014 01:41:28 -0700 (PDT)
Received: by 10.64.7.148 with HTTP; Sat, 10 May 2014 01:41:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248653>

Hello,

when I=E2=80=99m using the HTTPS protocol to access repositories, a win=
dow
from /usr/bin/qt4-ssh-askpass comes up.  It asks for my =E2=80=9CSSH pa=
ss
phrase=E2=80=9D, twice.  Sadly, it=E2=80=99s wrong.  The actual things =
it wants is the
username in the first case, and the password used to access the remote
repository (eg. my GitHub password) in the second question.  This is a
bug, and very misleading behavior.

--=20
Chris =E2=80=9CKwpolska=E2=80=9D Warrick <http://kwpolska.tk>
PGP: 5EAAEA16
stop html mail | always bottom-post | only UTF-8 makes sense
