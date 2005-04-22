From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: Pulling linux-2.6.git with gitinit.sh and gitpull.sh fails
Date: Fri, 22 Apr 2005 17:22:37 +0200
Message-ID: <1114183357.29271.31.camel@nosferatu.lan>
References: <200504221442.29488.rhys@rhyshardwick.co.uk>
	 <1114181091.29271.27.camel@nosferatu.lan>
	 <200504221543.43210.rhys@rhyshardwick.co.uk>
	 <200504221554.04749.rhys@rhyshardwick.co.uk>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9fHH+VfBR7Sj8uLImD/c"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 17:20:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOzuv-0000mS-RD
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 17:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVDVPV4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 11:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVDVPVu
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 11:21:50 -0400
Received: from ctb-mesg7.saix.net ([196.25.240.79]:38566 "EHLO
	ctb-mesg7.saix.net") by vger.kernel.org with ESMTP id S262049AbVDVPSo
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 11:18:44 -0400
Received: from gateway.lan (wblv-146-254-56.telkomadsl.co.za [165.146.254.56])
	by ctb-mesg7.saix.net (Postfix) with ESMTP id 74321C056;
	Fri, 22 Apr 2005 17:18:38 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 9F7F03A246F;
	Fri, 22 Apr 2005 17:24:59 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12107-14; Fri, 22 Apr 2005 17:24:54 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id DC21B3A2430;
	Fri, 22 Apr 2005 17:24:53 +0200 (SAST)
To: rhys@rhyshardwick.co.uk
In-Reply-To: <200504221554.04749.rhys@rhyshardwick.co.uk>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-9fHH+VfBR7Sj8uLImD/c
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-22 at 15:54 +0100, Rhys Hardwick wrote:
> On Friday 22 Apr 2005 15:43, Rhys Hardwick wrote:
> > On Friday 22 Apr 2005 15:44, Martin Schlemmer wrote:
> > > On Fri, 2005-04-22 at 15:30 +0100, Rhys Hardwick wrote:
> > > > On Friday 22 Apr 2005 15:00, Martin Schlemmer wrote:
> > > > > On Fri, 2005-04-22 at 14:50 +0100, Rhys Hardwick wrote:
> > > > > > On Friday 22 Apr 2005 14:52, Martin Schlemmer wrote:
> > > > > > > On Fri, 2005-04-22 at 14:42 +0100, Rhys Hardwick wrote:
> > > > > > > > Hey there,
> > > > > > > >
> > > > > > > > I am trying to pull the latest repository of the linux-2.6 =
git
> > > > > > > > from Linus' rsync mirror.
> > > > > > > >
> > > > > > > > Here is the shell:
> > > > > > > >
> > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > >
> > > > > > > > rhys@metatron:~/repo/linux-2.6.repo$ gitinit.sh
> > > > > > > > rsync://www.kernel.org/pub/linux/kernel/people/torvalds/lin=
ux-2
> > > > > > > >.6 .git defaulting to local storage area
> > > > > > > > gitpull.sh: unknown remote
> > > > > > > > gitinit.sh: pull failed
> > > > > > > > rhys@metatron:~/repo/linux-2.6.repo$ rm -r .git
> > > > > > > > rhys@metatron:~/repo/linux-2.6.repo$ gitinit.sh
> > > > > > > > www.kernel.org/pub/linux/kernel/people/torvalds/linux-2.6.g=
it
> > > > > > > > defaulting to local storage area
> > > > > > > > gitpull.sh: unknown remote
> > > > > > > > gitinit.sh: pull failed
> > > > > > > > rhys@metatron:~/repo/linux-2.6.repo$
> > > > > > > >
> > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > >
> > > > > > > > Any idea why this is not working?
> > > > > > >
> > > > > > > Try:
> > > > > > >
> > > > > > >  $ git init
> > > > > > > rsync://www.kernel.org/pub/linux/kernel/people/torvalds/linux=
-2.6
> > > > > > >.g it
> > > > > >
> > > > > > Exactly the same, sorry.....
> > > > >
> > > > > With latest git-pasky, after blowing the .git directory?  I am no=
t
> > > > > sure (and have not checked) that git will do the right thing if y=
ou
> > > > > retry without clearing.
> > > >
> > > > Yes to all the above.  I pulled the latest today, and make && make
> > > > install. Also, I have tried it with a .git in place, deleted, in th=
e
> > > > unpacked 2.6.11-r3 source, all of the above!
> > > >
> > > > >From what I can gather, it must happen in an empty directory, and =
that
> > > > > is what
> > > >
> > > > the top two examples are.
> > >
> > > Really weird.  I tested it my side before doing my last reply.  Maybe
> > > Petr will know.
> >
> > Hopefully!
> >
> > Thanks for the help anywho.....
> >
> > Rhys
>=20
> I think I have some more information.  If you remove the -e from the orig=
ins=20
> file, and put the name at the start of the line, it suddenly works!!!
>=20
> Cool,
>=20
> Not sure what was going on there, but hey, Petr will work it out!
>=20

Seems your /bin/sh do not support 'echo -e' ... Know what provides
your /bin/sh (I think ash at least do support it)?

Petr, I think you should really start to consider going full bash?


--=20
Martin Schlemmer


--=-9fHH+VfBR7Sj8uLImD/c
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCaRa9qburzKaJYLYRAt3LAJsG4hoW/kH8AvojXSe0MjrX9SyshgCgh1AB
BvlXnmSVIXSPLi6CNFyNJCA=
=QNIJ
-----END PGP SIGNATURE-----

--=-9fHH+VfBR7Sj8uLImD/c--

