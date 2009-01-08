From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH (topgit) 1/2] Implement setup_pager just like in git
Date: Thu, 8 Jan 2009 15:06:50 +1300
Message-ID: <20090108020650.GC7345@lapse.rw.madduck.net>
References: <cover.1231254832.git.kirr@landau.phys.spbu.ru> <acaae74f79d385014e726b97f8258b2a0caa3dd0.1231254832.git.kirr@landau.phys.spbu.ru> <20090106203203.GA11274@lapse.rw.madduck.net> <20090107112754.GA15158@roro3> <36ca99e90901070624p2c102f3ey392ef813db9f9187@mail.gmail.com> <cover.1231254832.git.kirr@landau.phys.spbu.ru> <20090106203203.GA11274@lapse.rw.madduck.net> <20090107112754.GA15158@roro3> <200901071324.57222.trast@student.ethz.ch> <20090107220027.GA4946@roro3>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	Thomas Rast <trast@student.ethz.ch>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Petr Baudis <pasky@su
X-From: git-owner@vger.kernel.org Thu Jan 08 04:52:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKlwo-0008Ds-HE
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 04:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757649AbZAHDu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 22:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752528AbZAHDu4
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 22:50:56 -0500
Received: from clegg.madduck.net ([193.242.105.96]:49814 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792AbZAHDuz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 22:50:55 -0500
Received: from lapse.rw.madduck.net (unknown [IPv6:2404:130:0:a000:214:a4ff:fe04:eadc])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id CBF351D40AA;
	Thu,  8 Jan 2009 04:50:34 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 181EE8106; Thu,  8 Jan 2009 03:06:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090107220027.GA4946@roro3>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux 5.0 kernel 2.6.27-1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8842/Wed Jan  7 15:06:50 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104885>


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Kirill Smelkov <kirr@landau.phys.spbu.ru> [2009.01.08.1100 +130=
0]:
> > So I suppose you could use
> >=20
> >   ${GIT_PAGER-${PAGER-less}}
> >=20
> > or similar.
>=20
> Good eyes, thanks!
>=20
> I'll rework it.

I am not 100% on this, but I think nested {}'s are a bashism.

> On Wed, Jan 07, 2009 at 03:24:02PM +0100, Bert Wesarg wrote:
> > On Wed, Jan 7, 2009 at 12:27, Kirill Smelkov <kirr@landau.phys.spbu.ru>=
 wrote:
> > > Martin, thanks for your review.
> > > +       # atexit(close(1); wait pager)
> > > +       trap "exec >&-; rm "$_pager_fifo"; rmdir "$_pager_fifo_dir"; =
wait" EXIT
> > I think you need to escape the double quotes.
>=20
> Good eyes -- corrected and thanks!

You could also just use single quotes inside the double quotes.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"he gave me his card
 he said, 'call me if they die'
 i shook his hand and said goodbye
 ran out to the street
 when a bowling ball came down the road
 and knocked me off my feet"
                                                        -- bob dylan
=20
spamtraps: madduck.bogus@madduck.net

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkllX7YACgkQIgvIgzMMSnW9GACfVb8xBvVuJ/wLbZGNP0gQHSIJ
F0oAnRqJhpobwtDCzkNFeDVfU4Lt3guQ
=/Cng
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
