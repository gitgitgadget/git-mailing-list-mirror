From: martin f krafft <madduck@madduck.net>
Subject: Re: hiding a certain file from gitweb
Date: Wed, 22 Aug 2007 00:40:17 +0200
Message-ID: <20070821224017.GA20263@piper.oerlikon.madduck.net>
References: <20070821190225.GA7133@piper.oerlikon.madduck.net> <85veb8mubx.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
To: git discussion list <git@vger.kernel.org>,
	David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Aug 22 00:40:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INcP7-0002aB-BK
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 00:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbXHUWkZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 18:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754304AbXHUWkZ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 18:40:25 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:36173 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030AbXHUWkY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 18:40:24 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id B900A895D98;
	Wed, 22 Aug 2007 00:40:22 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 09682-09; Wed, 22 Aug 2007 00:40:22 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 50445895D92;
	Wed, 22 Aug 2007 00:40:18 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 6159D9F16A;
	Wed, 22 Aug 2007 00:40:17 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 28FE143F4; Wed, 22 Aug 2007 00:40:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <85veb8mubx.fsf@lola.goethe.zz>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56338>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach David Kastrup <dak@gnu.org> [2007.08.21.2349 +0200]:
> > one of my colleagues checked a file with thousands of email
> > addresses into git and pushed the commit, so now the file is on
> > gitweb. This was quite a while ago and we have over 500 commits and
> > several branches between now and then.
>=20
> This sounds like you would be ok with the file never having been
> committed.  Use git-filter-branch for that.

This is awesome functionality =E2=80=94 apart from the fact that I'd like to
keep the file in the repo, just not on gitweb. But we already
figured out a way to deal with the situation internally.

Thanks for showing me this tool.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"getting a scsi chain working is perfectly simple if you remember that
 there must be exactly three terminations: one on one end of the
 cable, one on the far end, and the goat, terminated over the scsi
 chain with a silver-handled knife whilst burning *black* candles."
                                                     -- anthony deboer
=20
spamtraps: madduck.bogus@madduck.net

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGy2nRIgvIgzMMSnURArOyAJ4+t1FNJtD4M8nlDy/gLbHEI1Wz3QCcCErS
tfpaKrlS1AV1GF9B/wnc+rY=
=dVml
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
