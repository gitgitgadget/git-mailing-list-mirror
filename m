From: martin f krafft <madduck@madduck.net>
Subject: Git commit hash clash prevention
Date: Thu, 2 Oct 2008 10:53:58 +0200
Message-ID: <20081002085358.GA5342@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 02 10:55:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlJy8-0007l7-9F
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 10:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010AbYJBIxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 04:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753987AbYJBIxy
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 04:53:54 -0400
Received: from clegg.madduck.net ([193.242.105.96]:38330 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010AbYJBIxx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 04:53:53 -0400
Received: from lapse.rw.madduck.net (unknown [IPv6:2001:a60:f069:0:20a:e4ff:fe30:4316])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id DEF011D40A6
	for <git@vger.kernel.org>; Thu,  2 Oct 2008 10:53:47 +0200 (CEST)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id A3B9280C3; Thu,  2 Oct 2008 09:53:58 +0100 (IST)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel
	2.6.24-etchnhalf.1+scoflowctrl.1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94/8370/Thu Oct  2 05:51:47 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97296>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

the other day during a workshop on Git, one of the attendants asked
about the scenario when two developers, Jane and David, both working
on the same project, both create a commit and the two just so happen
to have the same SHA-1. I realise that the likelihood of this
happening is about as high as the chance of <insert witty joke
here>, but it *is* possible, isn't it? Even though this is thus
somewhat academic, I am still very curious about it.

What happens when David now pulls from Jane? How does Git deal with
this?

I imagine it'll be able to distinguish the two commits based on
metadata, but won't the DAG get corrupted?

Cheers,

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"and no one sings me lullabies,
 and no one makes me close my eyes,
 and so i throw the windows wide,
 and call to you across the sky"
                                                   -- pink floyd, 1971
=20
spamtraps: madduck.bogus@madduck.net

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjkjCYACgkQIgvIgzMMSnUwOwCcC74x9gISyf1Ly4tVK7V1OE/P
YsIAoLE3czWviDDP+CRMIWHBu7Rg4MK+
=aCTX
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
