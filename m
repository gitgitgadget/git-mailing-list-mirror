From: martin f krafft <madduck@madduck.net>
Subject: Re: failing to send patches to the list
Date: Sat, 14 Jul 2007 08:52:42 +0200
Message-ID: <20070714065242.GA27136@lapse.madduck.net>
References: <20070713093050.GA18001@lapse.madduck.net> <20070713155516.GA2712@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 14 12:17:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9ehB-0003Ss-Um
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 12:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289AbXGNKRe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 06:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754598AbXGNKRe
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 06:17:34 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:56180 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819AbXGNKRb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 06:17:31 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 2FB7D895D77
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 12:17:30 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 27725-07 for <git@vger.kernel.org>;
	Sat, 14 Jul 2007 12:17:30 +0200 (CEST)
Received: from lapse.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 68097895D7C
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 12:17:29 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 879EE4FD41; Sat, 14 Jul 2007 08:52:42 +0200 (CEST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070713155516.GA2712@sigill.intra.peff.net>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-686 i686
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52464>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Jeff King <peff@peff.net> [2007.07.13.1755 +0200]:
> vger will reject messages without a message-id. git-format-patch by
> default does not generate a message-id, so unless sendmail generates one
> on the fly, that is your problem.
>=20
> In general, git-format-patch output is probably not suitable for direct
> sending...have you looked at git-send-email?

I just ran a test and found out: sendmail does generate a message ID
on the fly on the client, so this cannot be the problem.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
http://www.transnationalrepublic.org/

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGmHK6IgvIgzMMSnURAhm0AJ9yVDCsLPC8smYD9SW53o+oRuu7pgCgspn2
/M2DoJ9tAdTP6jNp4iM424s=
=LTRo
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
