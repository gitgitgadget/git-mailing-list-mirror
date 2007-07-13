From: martin f krafft <madduck@madduck.net>
Subject: git-svn: failure to clone logcheck's repo
Date: Fri, 13 Jul 2007 11:36:22 +0200
Message-ID: <20070713093622.GA21001@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 13 11:36:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9HZH-0006F6-8u
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 11:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762336AbXGMJf4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 05:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761714AbXGMJf4
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 05:35:56 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:44677 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759312AbXGMJfz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 05:35:55 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id B9090895D6F
	for <git@vger.kernel.org>; Fri, 13 Jul 2007 11:35:53 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 12255-05 for <git@vger.kernel.org>;
	Fri, 13 Jul 2007 11:35:53 +0200 (CEST)
Received: from lapse.madduck.net (p549C364A.dip0.t-ipconnect.de [84.156.54.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 42A62895D6D
	for <git@vger.kernel.org>; Fri, 13 Jul 2007 11:35:53 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id C69C94FD40; Fri, 13 Jul 2007 11:36:22 +0200 (CEST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-686 i686
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52375>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi list,

I am trying to access the logcheck repository with git-svn. Even
though I can happily clone the trunk:

  git-svn clone svn://svn.debian.org/svn/logcheck/logcheck/trunk git

as soon as I try to clone the entire thing with tags and branches:

  git-svn clone -T trunk -t tags -b branches
    svn://svn.debian.org/svn/logcheck/logcheck git

it barfs:

  Initialized empty Git repository in .git/
  Using higher level of URL: svn://svn.debian.org/svn/logcheck/logcheck =3D=
> svn://svn.debian.org/svn/logcheck
  r19 =3D 95d0625b6c62935cfd3e44ec7dca5b6f6b05ab44 (trunk)
  [...]
  r20 =3D a3e5240dcc4d064b46273584800d3ae7a1e21330 (trunk)
  Found possible branch point: svn://svn.debian.org/svn/logcheck/logcheck/t=
runk =3D> svn://svn.debian.org/svn/logcheck/logcheck/branches/VENDOR, 20
  Found branch parent: (VENDOR) a3e5240dcc4d064b46273584800d3ae7a1e21330
  Following parent with do_switch
  Successfully followed parent
  r21 =3D 0ffcb70923d77c1d24019362e1ed1cd18d05f235 (VENDOR)
  Malformed network data: Malformed network data at /usr/local/bin/git-svn =
line 1029

I think I'll be fine with *not* preserving logcheck's history when
I move it to git, but thought best to let you know since this may be
a bug in git-svn.

Cheers,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
windoze is the one-night-stand of operating systems;
you feel so cheap after having used it.

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGl0eWIgvIgzMMSnURAndCAJ9TqLVmofsb7KDklyX6Q74TgFlaFgCgyuFX
LyZNZoRdZRes+Rp0fwSVef8=
=GhoG
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
