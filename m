From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH] topgit tg push feature
Date: Mon, 11 May 2009 09:25:07 +0200
Message-ID: <20090511072507.GA24235@lapse.rw.madduck.net>
References: <20090425161300.GD19142@gmx.de> <20090425163447.GE19142@gmx.de> <20090505093448.GC16524@gmx.de> <20090507045904.GA2068@gmx.de> <36ca99e90905062245w1ec78828ice5ed18161b6ec43@mail.gmail.com> <20090507084355.GA11680@pengutronix.de> <36ca99e90905070250l656f8879g87eb27c09db2cd42@mail.gmail.com> <20090509103625.GC13344@lapse.rw.madduck.net> <20090509190910.GA9655@gmx.de> <20090511032813.GA15540@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 09:27:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3PvK-0005HE-Dx
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 09:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbZEKH1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 03:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbZEKH1e
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 03:27:34 -0400
Received: from clegg.madduck.net ([193.242.105.96]:48804 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbZEKH1d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 03:27:33 -0400
Received: from lapse.rw.madduck.net (lapse.rw.madduck.net [IPv6:2001:41e0:ff3a::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id E99001D409B;
	Mon, 11 May 2009 09:27:25 +0200 (CEST)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id EE96A8073; Mon, 11 May 2009 09:25:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090511032813.GA15540@gmx.de>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.30-rc4-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/9351/Mon May 11 04:59:11 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118778>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Marc Weber <marco-oweber@gmx.de> [2009.05.11.0528 +0200]:
>   >I also like the true/false style, its also useable with the current 's=
cheme':
>   >    $tgish_deps_only && ... =20
>   great idea. true/false are sh builtins. adopted. I still prefer
>   [ foo -a bar ]; or [ foo -o bar ]; for readability.

The patch looks good, I am going to test it now, I hope.

Quick comment: -a and -o are not POSIX-compliant, use [ "$foo" ] ||
[ "$bar" ] instead.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
the early bird may get the worm,
but the second mouse gets the cheese in the trap.
=20
spamtraps: madduck.bogus@madduck.net

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEAREDAAYFAkoH0tMACgkQIgvIgzMMSnXDGQCeKa7BSJwdnj48g7AINW5dPyZR
nKkAoJkJ9GR2sZ5guVwVUGAN2qAQfCaZ
=gt0t
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
