From: martin f krafft <madduck@madduck.net>
Subject: git-svn patch faulty (was: failing to send patches to the list)
Date: Fri, 13 Jul 2007 11:56:44 +0200
Message-ID: <20070713095644.GA26743@lapse.madduck.net>
References: <20070713093050.GA18001@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 13 11:57:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9Htl-00040R-TC
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 11:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbXGMJ41 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 05:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752396AbXGMJ40
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 05:56:26 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:48314 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbXGMJ4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 05:56:24 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id A2B3B895D6F
	for <git@vger.kernel.org>; Fri, 13 Jul 2007 11:56:18 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 20223-07 for <git@vger.kernel.org>;
	Fri, 13 Jul 2007 11:56:18 +0200 (CEST)
Received: from lapse.madduck.net (p549C364A.dip0.t-ipconnect.de [84.156.54.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id D8DCC895D6D
	for <git@vger.kernel.org>; Fri, 13 Jul 2007 11:56:17 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 72A4D4FD41; Fri, 13 Jul 2007 11:56:44 +0200 (CEST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070713093050.GA18001@lapse.madduck.net>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-686 i686
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52379>


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi there,

still not having figured out the problem with the list (and I did
contact postmaster@), I just discovered that in fact the patch only
handles git-svn clone, not git-svn init. Thus, it's best to ignore
it for now. I am sorry for not taking enough care before publishing
it.

The openssl-autodetect patch does work and is ready for inclusion,
if you agree.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"if builders built buildings the way
 programmers wrote programs,
 then the first woodpecker that came along
 would destroy civilization."
                                                  -- gerald weinberg

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGl0xcIgvIgzMMSnURAr2hAKCaMF8bzLLwAgHam6EuRVv+31dgagCfYft3
CbJM7miTew8mFlKabD+8EJc=
=hI/6
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
