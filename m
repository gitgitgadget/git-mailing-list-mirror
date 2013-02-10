From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 15/15] user-manual: Use --format=tar.gz to create a
 gzipped tarball
Date: Sun, 10 Feb 2013 17:32:40 -0500
Message-ID: <20130210223239.GE8377@odin.tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <92a02e35df3dab70928e56e6790417243beea2af.1360508415.git.wking@tremily.us>
 <7va9rbst37.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="G6nVm6DDWH/FONJq"
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:33:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4fSM-00009I-PR
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 23:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757021Ab3BJWcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 17:32:42 -0500
Received: from vms173015pub.verizon.net ([206.46.173.15]:44056 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756950Ab3BJWcl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 17:32:41 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI000G18ZYGWB30@vms173015.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 16:32:41 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 204AB879BB7; Sun,
 10 Feb 2013 17:32:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360535560; bh=cGHATvabV4soGjzTivOQ/ScrsCpbTQ447OA8AoBQFAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vp3bPwq1YJaj+JrwNzrUI4dzgcpSUrnhjuWnKspqKRYUUdyUzLGRG9thb9pETXs3j
 lK1hZ3CsLuE59oPhzqWHWj4KAxvsUZz37hIoUZscdZFXQHdXJCJhH9Sukr2/guFzJV
 ETwjosJhcYzp6hy9nHzPh2JJRGBtUOpVbRTVQ35Q=
Content-disposition: inline
In-reply-to: <7va9rbst37.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215957>


--G6nVm6DDWH/FONJq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 10, 2013 at 02:27:08PM -0800, Junio C Hamano wrote:
> This is a "meh" at least to me.  Unless it uses something like
>=20
> 	git archive -o latest.tar.gz --prefix=3Dproject/ HEAD
>        =20
> it is not all that interesting.

Great suggestion.  My original goal was to remove the pipe, but if we
can remove the redirection too, that's one less POSIX-ism for newbies
to wonder about ;).

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--G6nVm6DDWH/FONJq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRGCAHAAoJEEUbTsx0l5OM3i0QALzrbMyVCzNtQP/zKJ8jyMFL
U88hJyRqXOcFEjV4zPyJhbg8Gwf+Y96eKL3sIRShlbDQQi/BGsba/VkeYx6w19Wd
ENXc0eyZtwbIzNYZwez8ZGk+0qCzYgXJI8Hyc+/DZgq6HQuSK3OVDA5R0AV4CG6b
S+3q1GAiNFeSF0ETNURt6pnvjlitz6N2S/OPqqIhMKrGy7T91hov8s01wsmJfpL6
OTyz6cC8lHRH7sGRQnohq25E7hXUHNQT6QeBNUpLN/1hkjdx/LIcEYyeeeIy8ZmV
e6Xmf/T1J2STbktNHiDKzvSXuKxYyi9RP4Eywlt34qabxEVGmtWykjEG80RDOlx6
BrofG4IQhe5NIHLKo8S0OWcfcypGj2OTX1YJHa++ozk4bXPL/35Jrep61xL3RNfW
FUaabK1yaPDPWS79Lw0/3hz3zV5tcGuoKvQEpj2pD97dW/gkj4DEf11iejdyby3L
ApccfV6FEAg2bLcWGlTyS0vy3DdkgODYl07fpzBdGhRucC6nZPSkbNlciw3kWtuk
V5c3UxWHMLZOh3CofTb6eKmTtE82djV5qRSa/tCOw9hIeuyeOLscgMU70Div0Q4O
VBQ6TuQ4DsybeMuEd2+d8O52RcDRyqoxgTDGdJ+MyaAq3VDbV9KnHvO5YvafmNB/
pNml7r0VbhLBcPcFHxxC
=aOcO
-----END PGP SIGNATURE-----

--G6nVm6DDWH/FONJq--
