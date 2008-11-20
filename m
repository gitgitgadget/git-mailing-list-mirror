From: martin f krafft <madduck@debian.org>
Subject: Re: [PATCH] Allow help/--help/-h to be run outside of a TopGit repo
Date: Thu, 20 Nov 2008 15:55:11 +0100
Organization: The Debian project
Message-ID: <20081120145511.GD29789@piper.oerlikon.madduck.net>
References: <1227181594-15123-1-git-send-email-madduck@debian.org> <20081120142702.GG10491@machine.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Nov 20 15:57:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3Ay0-0001WU-Jn
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 15:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758274AbYKTOzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 09:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756878AbYKTOzY
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 09:55:24 -0500
Received: from clegg.madduck.net ([193.242.105.96]:59446 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757645AbYKTOzW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 09:55:22 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id E530F1D40A9;
	Thu, 20 Nov 2008 15:55:13 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 8B0579F34F;
	Thu, 20 Nov 2008 15:55:12 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id E9C6F45F5; Thu, 20 Nov 2008 15:55:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081120142702.GG10491@machine.or.cz>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.26-1-amd64 x86_64
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.1/8653/Thu Nov 20 10:04:07 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101445>


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Petr Baudis <pasky@suse.cz> [2008.11.20.1527 +0100]:
> Why is this so complicated? Can't you just do_help from
> should_do_help()?

Yes, I could, but that would be in conflict with my understanding of
the Law of Demeter.

> The overall semantics seems strange anyway, though - it seems that
> 'tg mail --help -r' will try to show help for '-r' instead of
> 'mail'.

True, but then we are parsing command lines. Would you be opposed to
a getopt (POSIX) approach to normalising/parsing the command line?

Cheers,

--=20
 .''`.   martin f. krafft <madduck@debian.org>
: :'  :  proud Debian developer, author, administrator, and user
`. `'`   http://people.debian.org/~madduck - http://debiansystem.info
  `-  Debian - when you have better things to do than fixing systems
=20
this space intentionally left occupied.

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkklek8ACgkQIgvIgzMMSnXSgQCgvoWbN6nolVuserqaTPIcY5aN
oP0An3tuYGT3ZqCmp2U9AnkBEOlT0d4/
=yTjS
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--
