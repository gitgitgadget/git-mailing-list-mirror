From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: Pulling linux-2.6.git with gitinit.sh and gitpull.sh fails
Date: Fri, 22 Apr 2005 16:44:51 +0200
Message-ID: <1114181091.29271.27.camel@nosferatu.lan>
References: <200504221442.29488.rhys@rhyshardwick.co.uk>
	 <200504221450.48196.rhys@rhyshardwick.co.uk>
	 <1114178422.29271.12.camel@nosferatu.lan>
	 <200504221530.32645.rhys@rhyshardwick.co.uk>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HX4TFkq1ot+lLlvtx+6R"
Content-Transfer-Encoding: 8bit
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 16:37:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOzGz-000105-0X
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 16:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVDVOlU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 10:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVDVOlU
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 10:41:20 -0400
Received: from ctb-mesg3.saix.net ([196.25.240.75]:63217 "EHLO
	ctb-mesg3.saix.net") by vger.kernel.org with ESMTP id S261949AbVDVOk7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 10:40:59 -0400
Received: from gateway.lan (wblv-146-254-56.telkomadsl.co.za [165.146.254.56])
	by ctb-mesg3.saix.net (Postfix) with ESMTP id 130503CD5;
	Fri, 22 Apr 2005 16:40:51 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id C72F73A2430;
	Fri, 22 Apr 2005 16:47:12 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10970-09; Fri, 22 Apr 2005 16:47:07 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 738103A241A;
	Fri, 22 Apr 2005 16:47:07 +0200 (SAST)
To: rhys@rhyshardwick.co.uk
In-Reply-To: <200504221530.32645.rhys@rhyshardwick.co.uk>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-HX4TFkq1ot+lLlvtx+6R
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-22 at 15:30 +0100, Rhys Hardwick wrote:
> On Friday 22 Apr 2005 15:00, Martin Schlemmer wrote:
> > On Fri, 2005-04-22 at 14:50 +0100, Rhys Hardwick wrote:
> > > On Friday 22 Apr 2005 14:52, Martin Schlemmer wrote:
> > > > On Fri, 2005-04-22 at 14:42 +0100, Rhys Hardwick wrote:
> > > > > Hey there,
> > > > >
> > > > > I am trying to pull the latest repository of the linux-2.6 git fr=
om
> > > > > Linus' rsync mirror.
> > > > >
> > > > > Here is the shell:
> > > > >
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > rhys@metatron:~/repo/linux-2.6.repo$ gitinit.sh
> > > > > rsync://www.kernel.org/pub/linux/kernel/people/torvalds/linux-2.6=
.git
> > > > > defaulting to local storage area
> > > > > gitpull.sh: unknown remote
> > > > > gitinit.sh: pull failed
> > > > > rhys@metatron:~/repo/linux-2.6.repo$ rm -r .git
> > > > > rhys@metatron:~/repo/linux-2.6.repo$ gitinit.sh
> > > > > www.kernel.org/pub/linux/kernel/people/torvalds/linux-2.6.git
> > > > > defaulting to local storage area
> > > > > gitpull.sh: unknown remote
> > > > > gitinit.sh: pull failed
> > > > > rhys@metatron:~/repo/linux-2.6.repo$
> > > > >
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > Any idea why this is not working?
> > > >
> > > > Try:
> > > >
> > > >  $ git init
> > > > rsync://www.kernel.org/pub/linux/kernel/people/torvalds/linux-2.6.g=
it
> > >
> > > Exactly the same, sorry.....
> >
> > With latest git-pasky, after blowing the .git directory?  I am not sure
> > (and have not checked) that git will do the right thing if you retry
> > without clearing.
>=20
> Yes to all the above.  I pulled the latest today, and make && make instal=
l. =20
> Also, I have tried it with a .git in place, deleted, in the unpacked=20
> 2.6.11-r3 source, all of the above!
>=20
> >From what I can gather, it must happen in an empty directory, and that i=
s what=20
> the top two examples are.
>=20

Really weird.  I tested it my side before doing my last reply.  Maybe
Petr will know.


--=20
Martin Schlemmer


--=-HX4TFkq1ot+lLlvtx+6R
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCaQ3iqburzKaJYLYRAgr+AKCWrXHH7aL4TIFZLvr1RGTvQvVVXgCfYt42
F0fgDIdx2cmvElzpitUEIGM=
=fq2F
-----END PGP SIGNATURE-----

--=-HX4TFkq1ot+lLlvtx+6R--

