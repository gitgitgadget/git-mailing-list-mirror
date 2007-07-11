From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH] update-server-info: honor core.sharedRepository
Date: Wed, 11 Jul 2007 15:56:56 +0200
Message-ID: <20070711135656.GA28593@piper.oerlikon.madduck.net>
References: <Pine.LNX.4.64.0707111338360.4516@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 11 15:57:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8cgq-0004eY-0W
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 15:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757861AbXGKN5I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 09:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756738AbXGKN5H
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 09:57:07 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:55754 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756028AbXGKN5G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 09:57:06 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 4EC3E895D78;
	Wed, 11 Jul 2007 15:56:58 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 31570-08; Wed, 11 Jul 2007 15:56:58 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 9B1E7895D73;
	Wed, 11 Jul 2007 15:56:57 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id F36269F15D;
	Wed, 11 Jul 2007 15:56:56 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id BDA0943FC; Wed, 11 Jul 2007 15:56:56 +0200 (CEST)
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707111338360.4516@racer.site>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52160>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Johannes Schindelin <Johannes.Schindelin@gmx.de> [2007.07.11.14=
39 +0200]:
> Earlier, update-server-info used the umask, even if
> core.sharedRepository =3D 1.
>=20
> Noticed by madduck on IRC.
> 	Does this work for you?

Yes, it does, but only if I put =3D all/group into the config. init-db
--shared=3Dall however sets core.sharedRepository=3D2, and then
update-server-info produces a 0660 file.

This may be another bug...

Thanks!

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"even if you persuade me, you won't persuade me."
                                                       -- aristophanes

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGlOGoIgvIgzMMSnURAsCIAJ9eOUPlPDOs8NBcKxFN2kd7yMDbYgCgtdDR
+rUQRwYcLzVJgxu/VemEOjA=
=MpsH
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
