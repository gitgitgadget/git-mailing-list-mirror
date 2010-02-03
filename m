From: martin f krafft <madduck@madduck.net>
Subject: Re: Reacting to new commits in a poll-mirror
Date: Wed, 3 Feb 2010 14:10:50 +1300
Message-ID: <20100203011050.GA23249@lapse.rw.madduck.net>
References: <20100202220234.GA17107@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 02:11:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcTlr-0006hb-6g
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 02:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089Ab0BCBLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 20:11:01 -0500
Received: from clegg.madduck.net ([193.242.105.96]:50382 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756033Ab0BCBLA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 20:11:00 -0500
Received: from lapse.rw.madduck.net (lapse.nz.madduck.net [IPv6:2001:4428:234::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id DF5C51D4097
	for <git@vger.kernel.org>; Wed,  3 Feb 2010 02:10:54 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id BD2CCFF; Wed,  3 Feb 2010 14:10:50 +1300 (NZDT)
Content-Disposition: inline
In-Reply-To: <20100202220234.GA17107@lapse.rw.madduck.net>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.32-trunk-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.95.3 at clegg
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138796>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach martin f krafft <madduck@madduck.net> [2010.02.03.1102 +1300]:
> I am trying to set up Patchwork-Git integration on host A for
> a project whose Git repo is on host B. I thought I could use
> a mirror (git clone --mirror) on A and regularly fetch from B, but
> I cannot find a way (hook) to make Git on A react to new commits it
> fetched from B.

One way is to have a mirror on A, as well as a second repo: first,
fetch to synchronise the mirror, the push to the second repo, where
the post-receive hook will get executed. Works, but it's hackish.
I'd much rather have hooks react right away to the fetch.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"life is what happens to you while you're busy making other plans."
                                                        -- john lennon
=20
spamtraps: madduck.bogus@madduck.net

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEAREDAAYFAktozREACgkQIgvIgzMMSnUvGACgvMFjDtoxM39TeA9ALGXIV4t5
eZkAoMQkC4GB/sHl5QREzBa0X5YwfRZU
=df1d
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
