From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH] topgit tg push feature
Date: Sat, 9 May 2009 12:36:25 +0200
Message-ID: <20090509103625.GC13344@lapse.rw.madduck.net>
References: <20090425161300.GD19142@gmx.de> <20090425163447.GE19142@gmx.de> <20090505093448.GC16524@gmx.de> <20090507045904.GA2068@gmx.de> <36ca99e90905062245w1ec78828ice5ed18161b6ec43@mail.gmail.com> <20090507084355.GA11680@pengutronix.de> <36ca99e90905070250l656f8879g87eb27c09db2cd42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
To: Bert Wesarg <bert.wesarg@googlemail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, Marc Weber <marco-oweber@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 09 12:37:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2jw5-0007Ad-2I
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 12:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbZEIKgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 06:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbZEIKgn
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 06:36:43 -0400
Received: from clegg.madduck.net ([193.242.105.96]:60935 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbZEIKgm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 06:36:42 -0400
Received: from lapse.rw.madduck.net (unknown [IPv6:2001:41e0:ff7c:0:214:a4ff:fe04:eadc])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 2F9351D409B;
	Sat,  9 May 2009 12:36:26 +0200 (CEST)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 5FA5D808A; Sat,  9 May 2009 12:36:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <36ca99e90905070250l656f8879g87eb27c09db2cd42@mail.gmail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.29-1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/9348/Sat May  9 04:35:20 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118656>


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Marc, can you send an updated patch?

I would be interested in investigating this feature, which could be
very useful in the context of the discussion in
http://bugs.debian.org/505303 and
http://marc.info/?l=3Dvcs-pkg&m=3D124186459805688&w=3D2 about deleting
branches, specifically preventing their re-publication. tg-push
should allow us to get rid of the push refspecs in the repo config
and return to the default of ':', thus preventing a normal push from
pushing tips not already present remotely.

I'd still prefer tg-push integrated in git-push (e.g. by way of
"related branches" which are always pushed alongside a normal
branch), but that's not going to happen any time soon, I am sure...

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
windoze nt crashed.
i am the blue screen of death.
no one hears your screams.
=20
spamtraps: madduck.bogus@madduck.net

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoFXKcACgkQIgvIgzMMSnWIwwCeL1SnDMyOkZl6cBoVdshcHmFJ
4+AAn2M3mSSAyR6C2QkK/b88coUOQzLL
=UHdT
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--
