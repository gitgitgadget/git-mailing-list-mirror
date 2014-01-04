From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] Documentation/gitmodules: Only 'update' and 'url' are
 required
Date: Sat, 4 Jan 2014 14:59:16 -0800
Message-ID: <20140104225916.GB3156@odin.tremily.us>
References: <20140104221754.GB5697@book-mint>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat Jan 04 23:59:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzaBz-0007ML-6O
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jan 2014 23:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755AbaADW7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jan 2014 17:59:21 -0500
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:33888
	"EHLO qmta05.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754545AbaADW7U (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jan 2014 17:59:20 -0500
Received: from omta20.westchester.pa.mail.comcast.net ([76.96.62.71])
	by qmta05.westchester.pa.mail.comcast.net with comcast
	id 9yfU1n0021YDfWL55yzKW8; Sat, 04 Jan 2014 22:59:19 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta20.westchester.pa.mail.comcast.net with comcast
	id 9yzH1n00n152l3L3gyzJWv; Sat, 04 Jan 2014 22:59:19 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 10843E780A7; Sat,  4 Jan 2014 14:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1388876357; bh=ubFnSW7bg1yNl6K5IrMe3sCpBPVrAmT+duYDlJYZ+bw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ncrBT0UnGyJ/2pVsOmwPeXsiAjU2HF74LY8ezV/4fhGMnP4vI5OXWBZjo2gMLIh3v
	 NuDjq4AJ5pSPdE6qrV7GeGl/CcxlSZMPD/Y+PhDmwGfLagwrNqQwhJHdC/Gy7Jm6gI
	 wY/ORVu0fU4yQMAjRwRuO1oBWJ60cc0jkocfzlak=
Content-Disposition: inline
In-Reply-To: <20140104221754.GB5697@book-mint>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1388876359;
	bh=NnXiDmuU0Di+gqdtuNTphSjHt6tFSBY+fkunl5ZTSOo=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=eyqywqXpcIx1xfI/z6Clglj7LpKqm/N+aZsGM1XWtdcd9UX4cfsndclaPP/N8hoLo
	 BWse/TMJPi5+T7BYaxQ09XgTv6Hq9paxpaokPxm1koIt8GXy39C0QGByyxrMga1xcV
	 3I+xtiNwa+VjG5n1gOPIdRXHTkDbyf5QFeTRXgBcoqtqHAXS/C7EhygOo2qlfw3MsM
	 bhA/SXmQCDflLo12UoIb6QiGcMXmDuy3Xn+IE+WPpJka4tsE3KHAD5bEn40pIzHF4y
	 z7cJLDvE4x76xDp5mCtw7Nd+RF+7JD6fp8/wwogUyYcriOh33FzsVTrve9nUbJvjZU
	 msQCdl1vdF73w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239951>


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 04, 2014 at 11:17:54PM +0100, Heiko Voigt wrote:
> On Fri, Jan 03, 2014 at 10:31:22AM -0800, W. Trevor King wrote:
> > Before this commit, all the settings fell under the initial "Each
> > submodule section also contains the following required keys:".  The
> > example shows sections with just 'update' and 'url' entries, but we
>=20
> You mean:
>=20
> 	...with just 'path' and 'url' entries...

Oops, yes.  And in the summary/subject as well.  I can submit a v2 if
folks want, or just deputize Junio to fix it if/when this is applied.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSyJJDAAoJEKKfehoaNkbt+EgP+waJ1TchUkBzKVNvxpVPFjEp
aihu3c9r/PppFC+jrBixhEdLzYVXf0AJMdWtS/VNN1Y0022iFkIv6IjG6ZF1xZ5u
UGeqOyucZW8OSqO2JT21SNeKRIZTz9e90Cn7wqK1/pTfqZRmu+ePzJXdnq7LRcFv
9Fd+ISGEAadEnsNPI56+O0Fo6lk+jhw0c5b0Hta3Tg8Ne7e/w9X8MKbJUSBrqvkO
F1iPqdUDpDnyleNjqQ3zxlm/8u3h1gTgY4EQTw6iAXwJoD+7A5kSb+foycblWycf
f082mOsbGH4GvQ/6SwVIX04F6Iliu9IRiXSMg9aBUcsRxD66ofiF65bJ9K8fngaO
SHryKD//ZZPDQsTBTPzStDXIUwkAIdtcK+19dLwLjY+/aSOBQGre1Z2YnucmZWyc
5pfCaVFu69qIyv4EN1R2A6fxP7obXpHVsBkFvUzp7jXQfRHXA7QGpNnUaGIFSSIZ
iI/y1L9cmb9N/94PlnGKdu1t0FSjoplAOrHRGeg3NpLjlNnYJbKTGbwxbO9GIqOo
q4GksFZGU6yEhteJ0lSkl8GEfZq++jsBUGNv53GgjqepKbkyKpx3j1jq9/8ieFdT
6bu/LfqDX2akl0StJcCK7AXsOhn4tddK2f5i/EN0mQlvXlB9Dg4ZEe7TXV1hHMkF
adPIDvvY57H6esLrao9g
=Y2Lc
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
