From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git show doesn't work on file names with square brackets
Date: Sat, 6 Feb 2016 17:10:54 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602061708220.2964@virtualbox>
References: <6A7D4447-AC25-4591-9DA7-CD153198EC64@jetbrains.com> <alpine.DEB.2.20.1602061518220.2964@virtualbox> <25D155FA-6F05-425C-AB2D-7F0B44E0D1C5@jetbrains.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-114684782-1454775055=:2964"
Cc: git <git@vger.kernel.org>
To: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 17:11:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aS5SY-0000Tm-56
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 17:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbcBFQK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 11:10:59 -0500
Received: from mout.gmx.net ([212.227.15.18]:50459 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbcBFQK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 11:10:58 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M24ap-1aCblE2Kpn-00u3Bw; Sat, 06 Feb 2016 17:10:55
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <25D155FA-6F05-425C-AB2D-7F0B44E0D1C5@jetbrains.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:sQ0aQx4Hm/ALJUL6uVpkGVdX68mIK4Pxu0aBlXQMHLCXQHg3Ul4
 C1Rv3FzdsT9LiWuCFQ5dlil1cvsrzzieuJC+l+bW4MvSbQlk1oT1RREC7gTAD1ohJPiWLeK
 rhEnnQ6uSZ0WpmBhszb6lWz3cr7pOJNP4pwLRqgFNyygK71vqizlQ+j87ZvMGF9Od2uG/jU
 eFmM6vAsfkk0uZg6NjsfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Iuusjt4YlTI=:/BPgssKQskUoxtgF8KwrTh
 EspgXyheCr0iBk2fwSQygmF0paVs6bHZSytfI++jNILTGUvt+TuiFTe6UKMUUQYeoj4zE5cez
 3XVQRgcZEXZHCvgy/PhNaEt5QQ54PNphZbyKPQCfuQ9uryjFtnwY5lV7669n63ZyvgN0Nrm3T
 LfsxfecyYMvULZlP2erP9WE8t6dFMeVg664Mrd1r9Yzu+tyvggV0spjLchJ0Zgc9AjPVZZMxN
 /zX6mgz5gDUw95ajv8m3rEqhsW4HpE8HvUmbS+qz4S7PJ1djA2Ii386pROCD+pZCZvRDfSc+h
 7chSalf6EWxVK3SHU+v3gTNCZtdMPQE1fdwth4bG5c9Wh9CSSSq56R9sUeWFQaYSTlbvbvKR/
 ZSZXy/UyEhYrMqz4xMUnQNKRgUuAKFK7ckxEHUXxW0wUHS0NyHQcGWgnOXiWW7+sn3+LnM2hZ
 by25J+42uYZwrpHunVMn31sZH6MFfKzpg/IBru9BZKB7KD70yD0UG67TxqbDYg0+j4Sy8CJOm
 DlIUSlOVRLPQYtMjyr8lo9h/9TE4Ng9piVKKRfV3LC/cGiXKb783SGh0FUzPgS7FwejYND+wQ
 qG85xySstnJPc+o42D/MD9v/sty7opW7w1E6HvE5EebFX24plDUCCAAwPewq7PrpBY8sYeBZ5
 uQK16KmBXsNE0WOr2Pm5bW8ZjxePHhxuh3y6F/vElFn/CLysmm40Y8o3jA2A0WNAus9H14uAg
 3HhITLnOfnBguV/YBPWaAy3Bei8uH7WzdS1uHe30zkaHhybytdJ1/H83u/C1Vc24YpnaZITM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285698>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-114684782-1454775055=:2964
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kirill,

On Sat, 6 Feb 2016, Kirill Likhodedov wrote:

> > On 06 Feb 2016, at 17:21 , Johannes Schindelin <Johannes.Schindelin@gmx=
=2Ede> wrote:
> >=20
> > This is expected behavior of the Bash you are using. The commands that =
I
> > think would reflect your intentions would be:
> >=20
> > =09git init brackets
> > =09cd brackets
> > =09echo 'asd' > 'bra[ckets].txt'
> > =09git add 'bra[ckets].txt'
> > =09git commit -m initial
> > =09git show 'HEAD:bra[ckets].txt=E2=80=99
>=20
>=20
> Nope. This command sequence doesn=E2=80=99t work for me: the same error i=
s returned:
>=20
>     # git show 'HEAD:bra[ckets].txt'
>     fatal: ambiguous argument 'HEAD:bra[ckets].txt': both revision and fi=
lename

Whoops. Sorry. I actually ran those commands now and it is true that it
still does not work, which is funny. Especially since

=09git show 'HEAD:bra[ckets].txt' --

actually *does* work.

Ciao,
Johannes
--8323329-114684782-1454775055=:2964--
