From: martin f krafft <madduck@debian.org>
Subject: Re: [TopGit PATCH] Check for help invocation before setup
Date: Thu, 20 Nov 2008 12:48:13 +0100
Organization: The Debian project
Message-ID: <20081120114813.GA8401@piper.oerlikon.madduck.net>
References: <1227110623-4474-1-git-send-email-madduck@debian.org> <1227110623-4474-2-git-send-email-madduck@debian.org> <20081119182436.GB10544@machine.or.cz> <20081119183234.GA19781@piper.oerlikon.madduck.net> <20081119183902.GX10491@machine.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Cc: git discussion list <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Nov 20 12:49:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L382T-00049M-Us
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 12:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbYKTLsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 06:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752494AbYKTLsX
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 06:48:23 -0500
Received: from clegg.madduck.net ([193.242.105.96]:47788 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbYKTLsW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 06:48:22 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id C4D0C1D40AF;
	Thu, 20 Nov 2008 12:48:14 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 6B3DA9F34F;
	Thu, 20 Nov 2008 12:48:13 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 2738D45F4; Thu, 20 Nov 2008 12:48:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081119183902.GX10491@machine.or.cz>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.26-1-amd64 x86_64
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.1/8653/Thu Nov 20 10:04:07 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101408>


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Petr Baudis <pasky@suse.cz> [2008.11.19.1939 +0100]:
> Oh, oops - I missed the loop, I should get some lunch. ;-)
> Thus, something like this?
>=20
> 	check_help() { while [ -n "$1" ]; do ...; shift; done }
> 	check_help "$@"

Why didn't I think of that???

I just sent an updated patch without threading, sorry. tg-mail just
fires without confirmation... :/

--=20
 .''`.   martin f. krafft <madduck@debian.org>
: :'  :  proud Debian developer, author, administrator, and user
`. `'`   http://people.debian.org/~madduck - http://debiansystem.info
  `-  Debian - when you have better things to do than fixing systems
=20
"the pure and simple truth is rarely pure and never simple."
                                                      -- oscar wilde

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkklTnoACgkQIgvIgzMMSnWAyACgvNQn2Esmfue7yPBd/kuawZ8R
ZPkAoL1/iAMZNIWKZvumDoqj4EszoUwR
=34cL
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
