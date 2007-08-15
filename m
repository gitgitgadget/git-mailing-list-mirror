From: martin f krafft <madduck@madduck.net>
Subject: Re: (Resend)[PATCH] git-svn: Translate invalid characters in
	refname
Date: Thu, 16 Aug 2007 00:53:29 +0200
Message-ID: <20070815225329.GA9174@piper.oerlikon.madduck.net>
References: <f8k9q5$927$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 00:53:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILRk7-0007mO-Im
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 00:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765461AbXHOWxd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 18:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763952AbXHOWxc
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 18:53:32 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:49067 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444AbXHOWxb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 18:53:31 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 38B4C895F77
	for <git@vger.kernel.org>; Thu, 16 Aug 2007 00:53:30 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 19152-02 for <git@vger.kernel.org>;
	Thu, 16 Aug 2007 00:53:30 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id EF101895D92
	for <git@vger.kernel.org>; Thu, 16 Aug 2007 00:53:29 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 521929F171
	for <git@vger.kernel.org>; Thu, 16 Aug 2007 00:53:29 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 278BB43F9; Thu, 16 Aug 2007 00:53:29 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <f8k9q5$927$1@sea.gmane.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55965>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Robert Ewald <robert.ewald@nov.com> [2007.07.30.1108 +0200]:
> In git some characters are invalid as documented
> in git-check-ref-format. In subversion these characters might
> be valid, so a translation is required.
>=20
> This patch does this translation by url escaping characters, that
> are not allowed.

Have you worked more on this? I am back now and could test it on
various svn imports. Just want to make sure I have the latest
version.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"we should have a volleyballocracy.
 we elect a six-pack of presidents.
 each one serves until they screw up,
 at which point they rotate."
                                                      -- dennis miller
=20
spamtraps: madduck.bogus@madduck.net

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGw4PpIgvIgzMMSnURAuuaAJ97ErB7lGfratx2n7cpn+m7vVwp4ACeOMix
liXI8mtFcxcMEnlugh+VhzA=
=xsJf
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
