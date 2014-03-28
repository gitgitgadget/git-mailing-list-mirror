From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC] submodule: change submodule.<name>.branch default from
 master to HEAD
Date: Fri, 28 Mar 2014 10:10:59 -0700
Message-ID: <20140328171059.GJ25485@odin.tremily.us>
References: <20140328030556.GD25485@odin.tremily.us>
 <c66d89d854407469b6fd223213a09e5d60eeec0a.1395977055.git.wking@tremily.us>
 <CAPig+cT7tmxvYz+sLQY68SgF6osM+pAj-gFb7xvyuH+Gnw5xrg@mail.gmail.com>
 <20140328035255.GF25485@odin.tremily.us>
 <20140328035827.GG25485@odin.tremily.us>
 <5335AA0E.7000001@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ah9ph+G2cWRpKogL"
Cc: Eric Sunshine <sunshine@sunshineco.com>, Git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 28 18:11:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTaJD-0000Gz-1H
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 18:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbaC1RLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 13:11:04 -0400
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:47801
	"EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751819AbaC1RLD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Mar 2014 13:11:03 -0400
Received: from omta07.westchester.pa.mail.comcast.net ([76.96.62.59])
	by qmta03.westchester.pa.mail.comcast.net with comcast
	id j4yu1n0061GhbT8535B1mi; Fri, 28 Mar 2014 17:11:01 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta07.westchester.pa.mail.comcast.net with comcast
	id j5B01n009152l3L3T5B0YY; Fri, 28 Mar 2014 17:11:01 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id D116210DEC61; Fri, 28 Mar 2014 10:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1396026659; bh=hXKXDWggtWvjQCowgZV/awUe+apjo/Pc3CT8SXERaJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=beps6afO+oMOtJcr3jYceT4gaS9QfH7iFP2PBQnzJOmNGP9S6ZI6ugXopoqP8jjdm
	 3x5gxEkcCoMhH3pO2HI0xv8cS7heH9ecOI8D9SutBoYpprIqPmHs4PcSulQiE6KemW
	 eN3Rqusjy/T5FnNMYNeEwASCgvhGxx6GVesrRaqY=
Content-Disposition: inline
In-Reply-To: <5335AA0E.7000001@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1396026661;
	bh=9fkxPY0S8F5zQKObpq5UeGU3aHR0yHRss9u57Qyde8o=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=fEMw1MHWT4igtT6xpZYYxxQfwGLYablvNMcSHgN7eyzmUzXoCJ45X/tpyyiWPHLMv
	 4g5j6M5VrOW6cp1eHnk/LEv9+4mPNHrYmMzzazEVpRNyFuHvGZTQ413/Pq+Lq0gzEE
	 ritnY78Xl1D0FOj3xSzgVfvQVG8RKsxQqr/uiF3PlAcGyg7bVnUsrnTmWmvG88EkFn
	 BMi8itBTkr1mHQyjq+PwrlP36ti6tzEf/z0rDEEjWX9AkC4zzW2+TSyq55MqOXQgD+
	 5jIRDcv3bKu3zRD/T4eemuSCXdBqORt/gz2da9K3N2XuB/aiAk29lesvjTw2OWwR4o
	 0wN0L+aXGw4rg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245399>


--Ah9ph+G2cWRpKogL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2014 at 05:57:50PM +0100, Jens Lehmann wrote:
> Am 28.03.2014 04:58, schrieb W. Trevor King:
> > On Thu, Mar 27, 2014 at 08:52:55PM -0700, W. Trevor King wrote:
> >> No the remote branch is in the upstream subproject.  I suppose I meant
> >> =E2=80=9Cthe submodule's remote-tracking branch following the upstream
> >> subproject's HEAD which we just fetched so it's fairly current=E2=80=
=9D ;).
> >=20
> > Hmm, maybe we should change the existing =E2=80=9Cupstream submodule=E2=
=80=9D to
> > =E2=80=9Cupstream subproject=E2=80=9D for consistency?
>=20
> For me it's still an "upstream submodule" ...

We have a few existing =E2=80=9C[upstream] subproject=E2=80=9D references t=
hough.  I
prefer subproject, because the submodule's upstream repository is
likely a bare repo and not a submodule itself.  It's also possible
(likely?) that the upstream repository is a stand-alone project, and
not designed to always be a submodule.  However, =E2=80=9Cupstream submodul=
e=E2=80=9D
and =E2=80=9Csubmodule's upstream=E2=80=9D are both clear enough, and if th=
ey're the
consensus phrasing, I'd rather standardize on them than jump back and
forth between phrasings in the docs.  I can write up a patch that
shifts us to consistently use one form, once we decide what that
should be (although I'm happy to let someone else write the patch too
;).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--Ah9ph+G2cWRpKogL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNa0iAAoJEKKfehoaNkbtbkwP/3FBEpA6xsnGLOJWe/QEcspI
i/MiGuRxiMzJsaE2pAi/FmYzO49fqTK2s/iDhDib8hqRH61g6KmEN63s+DZYJaE7
TD/CyRy2fGterkPtqME0w7Fm3S5SevJ+YZt39lr+V3g4L5lOfClb2K1EmHEzgpnQ
GqIiKzUaqDqHnerXDRdFe9yCPqSG79fl6fLfSS3JqFtPGA3+dhWhgOJAey6yrEno
Mmm6BsCd6WjJe8fG9T/wADG7WBwgdDSfjelVcf/wwpc2aEs0VW5uNM4tWmJevJYk
sANPHVHmcYKkd6N5lO49YPRL5BcTDEplA9e1otf14Erq7xnuDeSH8SjE8dF5B1Bp
VBKFPiuyG7+5JoAu7RnwAjDE0aqb3HMeUyEYip6XFFV2UNO5s91K+NY0VbTn6WI4
NER3cIJK1DASly0/Z45nCgIp8YQdW7NqemBY86w52Bgu1uax5POA9Xg11eYDhiOi
2YCcQRrQ9ptWL/K4HGGi/f89iWJhz3OuAsJ8SqhISFFi9M08BLjoUTarVpczi+3J
4pUr8lBq6b+zaUMcJ9dUm3tuxXtvMJvGtrtAVhANMdnw09P8U28OPmaXUoyLcivC
FLoSyuW8DprqhxRB/Z37uNT6mIAq5YdVlY4n8IwuKCOUiH8JS3+qaPO8+ZujjpSy
nmtiGcv7aoe74l4bEfql
=H+xu
-----END PGP SIGNATURE-----

--Ah9ph+G2cWRpKogL--
