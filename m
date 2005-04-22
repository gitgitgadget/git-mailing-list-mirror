From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: Pulling linux-2.6.git with gitinit.sh and gitpull.sh fails
Date: Fri, 22 Apr 2005 16:00:22 +0200
Message-ID: <1114178422.29271.12.camel@nosferatu.lan>
References: <200504221442.29488.rhys@rhyshardwick.co.uk>
	 <1114177940.29271.9.camel@nosferatu.lan>
	 <200504221450.48196.rhys@rhyshardwick.co.uk>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Ly8Af8Di5CHIg+GOudYv"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 15:55:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOya2-0001NM-Eo
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 15:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVDVN4p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 09:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVDVN4p
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 09:56:45 -0400
Received: from ctb-mesg5.saix.net ([196.25.240.77]:24205 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S261863AbVDVN4d
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 09:56:33 -0400
Received: from gateway.lan (wblv-146-254-56.telkomadsl.co.za [165.146.254.56])
	by ctb-mesg5.saix.net (Postfix) with ESMTP id 62E6571DD;
	Fri, 22 Apr 2005 15:56:23 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 8DE1D3A2430;
	Fri, 22 Apr 2005 16:02:44 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 15319-02; Fri, 22 Apr 2005 16:02:39 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 3DAD23A241A;
	Fri, 22 Apr 2005 16:02:39 +0200 (SAST)
To: rhys@rhyshardwick.co.uk
In-Reply-To: <200504221450.48196.rhys@rhyshardwick.co.uk>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-Ly8Af8Di5CHIg+GOudYv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-22 at 14:50 +0100, Rhys Hardwick wrote:
> On Friday 22 Apr 2005 14:52, Martin Schlemmer wrote:
> > On Fri, 2005-04-22 at 14:42 +0100, Rhys Hardwick wrote:
> > > Hey there,
> > >
> > > I am trying to pull the latest repository of the linux-2.6 git from
> > > Linus' rsync mirror.
> > >
> > > Here is the shell:
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > rhys@metatron:~/repo/linux-2.6.repo$ gitinit.sh
> > > rsync://www.kernel.org/pub/linux/kernel/people/torvalds/linux-2.6.git
> > > defaulting to local storage area
> > > gitpull.sh: unknown remote
> > > gitinit.sh: pull failed
> > > rhys@metatron:~/repo/linux-2.6.repo$ rm -r .git
> > > rhys@metatron:~/repo/linux-2.6.repo$ gitinit.sh
> > > www.kernel.org/pub/linux/kernel/people/torvalds/linux-2.6.git
> > > defaulting to local storage area
> > > gitpull.sh: unknown remote
> > > gitinit.sh: pull failed
> > > rhys@metatron:~/repo/linux-2.6.repo$
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Any idea why this is not working?
> >
> > Try:
> >
> >  $ git init
> > rsync://www.kernel.org/pub/linux/kernel/people/torvalds/linux-2.6.git
>=20
> Exactly the same, sorry.....
>=20

With latest git-pasky, after blowing the .git directory?  I am not sure
(and have not checked) that git will do the right thing if you retry
without clearing.


--=20
Martin Schlemmer


--=-Ly8Af8Di5CHIg+GOudYv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCaQN2qburzKaJYLYRAkpQAJ9Uz/Bru/zMnLIkS/oMCCTibnjupQCfSudV
La2MejTrwvnDBzkSoTSW0NQ=
=Wvsg
-----END PGP SIGNATURE-----

--=-Ly8Af8Di5CHIg+GOudYv--

