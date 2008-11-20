From: martin f krafft <madduck@debian.org>
Subject: Re: [PATCH] Allow help/--help/-h to be run outside of a TopGit repo
Date: Thu, 20 Nov 2008 16:11:00 +0100
Organization: The Debian project
Message-ID: <20081120151100.GA2354@piper.oerlikon.madduck.net>
References: <1227181594-15123-1-git-send-email-madduck@debian.org> <20081120142702.GG10491@machine.or.cz> <20081120145511.GD29789@piper.oerlikon.madduck.net> <20081120150832.GI10491@machine.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Nov 20 16:13:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3BCr-0000Hr-Az
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 16:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755009AbYKTPLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 10:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755177AbYKTPLL
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 10:11:11 -0500
Received: from clegg.madduck.net ([193.242.105.96]:33667 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754918AbYKTPLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 10:11:09 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 7BBA51D40A9;
	Thu, 20 Nov 2008 16:11:02 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id D4D2A9F34F;
	Thu, 20 Nov 2008 16:11:00 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 3C08B45F4; Thu, 20 Nov 2008 16:11:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081120150832.GI10491@machine.or.cz>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.26-1-amd64 x86_64
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.1/8653/Thu Nov 20 10:04:07 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101449>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Petr Baudis <pasky@suse.cz> [2008.11.20.1608 +0100]:
> What is that?

http://en.wikipedia.org/wiki/Law_of_Demeter

In the context of our discussion, it basically means that if
should_do_help calls do_help, then we cannot test should_do_help
independently (without mocking out do_help, which is plain ugly).
Not that we have a testing infrastructure (yet) anyway, but...

> > True, but then we are parsing command lines. Would you be opposed to
> > a getopt (POSIX) approach to normalising/parsing the command line?
>=20
> No. :-)

Good. I will see what I can do about this. In the mean time, I will
just leave things as they are.

--=20
 .''`.   martin f. krafft <madduck@debian.org>
: :'  :  proud Debian developer, author, administrator, and user
`. `'`   http://people.debian.org/~madduck - http://debiansystem.info
  `-  Debian - when you have better things to do than fixing systems
=20
windoze nt crashed.
i am the blue screen of death.
no one hears your screams.

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkklfgMACgkQIgvIgzMMSnUfQgCeLziy1+WoOvF7BHmLUp8hZpDY
sh0AoNvRrGZVwXTbZLOMiP9+gB01UDiG
=nj84
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
