From: martin f krafft <madduck@madduck.net>
Subject: Re: TopGit: how to deal with upstream inclusion
Date: Wed, 24 Sep 2008 13:21:15 +0200
Message-ID: <20080924112115.GA14841@piper.oerlikon.madduck.net>
References: <20080914203043.GA4872@lapse.rw.madduck.net> <20080914210316.GJ10360@machine.or.cz> <20080919170406.GA22849@lapse.rw.madduck.net> <20080921141924.GI10360@machine.or.cz> <20080923063550.GC19084@piper.oerlikon.madduck.net> <20080923095528.GR10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
To: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 24 13:22:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiSS3-00068N-O5
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 13:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbYIXLV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 07:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbYIXLV0
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 07:21:26 -0400
Received: from clegg.madduck.net ([193.242.105.96]:55008 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbYIXLV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 07:21:26 -0400
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id AEAE91D40A6;
	Wed, 24 Sep 2008 13:21:16 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id C08E69F207;
	Wed, 24 Sep 2008 13:21:15 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 8B54144B3; Wed, 24 Sep 2008 13:21:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080923095528.GR10360@machine.or.cz>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.26-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94/8323/Wed Sep 24 09:57:37 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96629>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Petr Baudis <pasky@suse.cz> [2008.09.23.1155 +0200]:
> > Well, but what if upstream implemented our solution slightly
> > differently, and if it's only because they used tabs instead of
> > spaces? We wouldn't want -s ours then, huh?
>=20
> You still would want to get tabs in other patches that depended on
> the merged one, no? Otherwise tg patch output will produce patches
> that do not apply and tg export will change the tabs back to
> spaces.

I would want to have to resolve all dependent branches and change
them to use tabs, right. But since I used spaces and they used tabs,
using -s ours would give preference to spaces, no?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
the reason the mainstream is thought of as a stream
is because it is so shallow.
=20
spamtraps: madduck.bogus@madduck.net

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjaIqsACgkQIgvIgzMMSnWSHACg1wXyS8NeoFofKLnfXTIksDeR
KPYAoLVUfyJ4T2bFuNaHGd10DM4p3uol
=23Tv
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
