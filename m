From: martin f krafft <madduck@madduck.net>
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 14:21:07 +0100
Message-ID: <20081120132107.GA27571@piper.oerlikon.madduck.net>
References: <20081119113752.GA13611@ravenclaw.codelibre.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Cc: git@vger.kernel.org
To: Roger Leigh <rleigh@codelibre.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 14:22:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L39UO-0003Gd-RW
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 14:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747AbYKTNVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 08:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754746AbYKTNVS
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 08:21:18 -0500
Received: from clegg.madduck.net ([193.242.105.96]:48523 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754616AbYKTNVR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 08:21:17 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id C456B1D40AF;
	Thu, 20 Nov 2008 14:21:09 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id A324B9F34F;
	Thu, 20 Nov 2008 14:21:07 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 1FA5E45F4; Thu, 20 Nov 2008 14:21:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081119113752.GA13611@ravenclaw.codelibre.net>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.26-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.1/8653/Thu Nov 20 10:04:07 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101426>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Roger Leigh <rleigh@codelibre.net> [2008.11.19.1237 +0100]:
> These are provided by upstream so that end users don't need these tools
> installed (particularly docbook, since the toolchain is so flaky on
> different systems).  However, the fact that git isn't storing the
> mtime of the files confuses make, so it then tries to regenerate these
> (already up-to-date) files, and fails in the process since the tools
> aren't available.

I don't get it. Why are end users running make in the first place?
Why aren't those in the build-dependencies?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
it is better to have loft and lost
than to never have loft at all.
                                                       -- groucho marx
=20
spamtraps: madduck.bogus@madduck.net

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkklZD0ACgkQIgvIgzMMSnW6gQCffErQ3upPEoGlyHqvbRYa3mi/
+sgAoMNhoxTz1wDDLOO+8WcfIbcdhP24
=ZuyD
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
