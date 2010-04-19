From: Yves Caniou <yves.caniou@ens-lyon.fr>
Subject: Re: Compilation pb of git-1.7.0.5
Date: Mon, 19 Apr 2010 10:50:33 +0200
Organization: ENS-LIP
Message-ID: <201004191050.33790.yves.caniou@ens-lyon.fr>
References: <201004190759.15032.yves.caniou@ens-lyon.fr> <i2kfabb9a1e1004182326w32b1ce9ak2ada640ce30cc945@mail.gmail.com> <4BCC163E.3050808@drmicha.warpmail.net>
Reply-To: yves.caniou@ens-lyon.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Apr 19 10:52:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3mio-0008Fn-Bx
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 10:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273Ab0DSIwp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Apr 2010 04:52:45 -0400
Received: from jabiru.ens-lyon.fr ([140.77.51.2]:38885 "EHLO
	jabiru.ens-lyon.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab0DSIwo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Apr 2010 04:52:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by jabiru.ens-lyon.fr (Postfix) with ESMTP id 35C96AFAA5;
	Mon, 19 Apr 2010 10:52:43 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.1 (20080629) (Debian) at ens-lyon.fr
Received: from jabiru.ens-lyon.fr ([127.0.0.1])
	by localhost (jabiru.ens-lyon.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wCDXYKINB+dA; Mon, 19 Apr 2010 10:52:38 +0200 (CEST)
Received: from [133.11.204.119] (unknown [133.11.204.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by jabiru.ens-lyon.fr (Postfix) with ESMTPSA id 1B7EEAFAA7;
	Mon, 19 Apr 2010 10:52:37 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <4BCC163E.3050808@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145284>

Le Monday 19 April 2010 10:37:18 Michael J Gruber, vous avez =C3=A9crit=
=C2=A0:
> Sverre Rabbelier venit, vidit, dixit 19.04.2010 08:26:
> > Heya,
> >
> > On Mon, Apr 19, 2010 at 07:59, Yves Caniou <yves.caniou@ens-lyon.fr=
>=20
wrote:
> >> After the ./configure --prefix=3D$HOME/git, the make all gives me
> >
> > Which revision are you trying to compile? Also, it's probably more
> > helpful to just post the result of 'make all' verbatim, rather than
> > snippets.
>
> ...and try to use make directly rather than configure, which isn't
> maintained that well.

That's what I did, but maybe you didn't saw my mail. It works fine, bec=
ause Cc=20
doesn't overide gcc. So I can install. I don't know if you want to look=
 at=20
the errors or not, but if not, maybe adding some info in known issues?

> I wonder whether we should hide configure somehow. If you see a Makef=
ile
> and configure and don't know the project, the natural impulse is to u=
se
> configure before make.
>
> Michael

Indeed, the natural reflex is to make a ./configure --help to have the=20
options, and use ./configure. I saw the first lines in the INSTALL file=
,=20
describing "make prefix=3D" but just made like I'm used to.

Thx.

=2EYves.
