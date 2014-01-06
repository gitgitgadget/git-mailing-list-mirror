From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Mon, 6 Jan 2014 09:37:08 -0800
Message-ID: <20140106173708.GU3156@odin.tremily.us>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
 <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
 <CALas-ijwb+20dArOGCnZJSqEwU8+ufUpOEktUJ2hAOW_BLpgxw@mail.gmail.com>
 <20140106144708.GC27265@t2784.greatnet.de>
 <xmqqtxdhjbgp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ayym4vmyMU9P4uDb"
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Francesco Pretto <ceztko@gmail.com>, Git <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 18:37:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0E75-0000c1-6o
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 18:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755865AbaAFRhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 12:37:13 -0500
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:49236
	"EHLO qmta04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753592AbaAFRhL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 12:37:11 -0500
Received: from omta11.westchester.pa.mail.comcast.net ([76.96.62.36])
	by qmta04.westchester.pa.mail.comcast.net with comcast
	id Ad421n0050mv7h054hdAYM; Mon, 06 Jan 2014 17:37:10 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta11.westchester.pa.mail.comcast.net with comcast
	id Ahd91n002152l3L3Xhd9h3; Mon, 06 Jan 2014 17:37:10 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id A684BE9174C; Mon,  6 Jan 2014 09:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389029828; bh=mGKi8ISPiaOCkVtNmj+maW782pzfLW0YPGSc9c9nX8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NbkMdl6R0yD+GgI/IF5JttDEXpI5m4+BBCcv4eNPhyedXgbpY/11EEzppE90xYH0B
	 LTzseEHgxoEVlJ5W1vn8C98DnxjaN1AetUVYxXonIGceQ7MI4SUHE3/TBsyUukjHld
	 idwSCUkx5fYzCWC7RZyZoG/p14F/5ctEjoSOCsLc=
Content-Disposition: inline
In-Reply-To: <xmqqtxdhjbgp.fsf@gitster.dls.corp.google.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389029830;
	bh=1xqUNxFj0GXlvg0JoxCfoqpagHvqsvBmhCcaLdaLXRI=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=I6XK2ct1vKgIdBvqpL500AuHJpaWThYkNwKytTOksCUONG5aXdiowh9v+3l/gPkAu
	 q1xyWB6NygA/Tp8nI5pXmVMZaEel8VAVXUaMvfeXPbWIV02Ib8b6NaWTa95sR2C3Q+
	 yfSeoO89MFUp+9W72dCry8Ao67kRX++H7Pk0MIgclOCu8WepacZPbrhHhahQosp9Sy
	 sr8ITMwTu71uGCECx18OJBM203Daw+tHirDPXbSR5OxZCTIyqK3v25p5rCspc9Podu
	 UZihhCZ3N13Sb+yFMMor753TJ/voto9/5JWQKCOA0thTNk//3994qOOTTKyMPLSn4+
	 ZEo/1oInqvrXg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240035>


--Ayym4vmyMU9P4uDb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2014 at 08:56:22AM -0800, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> > Yes, why would you do a git pull in a submodule? Don't you want to do
> > something like
> >
> > 	git checkout -t -b dev/my-topic origin/master
> >
> > to start your development?
>=20
> As long as origin/master contains the commit specified by the
> superproject, that would work, but it may be a good thing to use a
> mode of submodule.*.update that does not have to drop the user into
> a detached state in the first place.  I somehow thought that was
> what rebase (or merge) was about, that is, starting from the state
> where a branch is checked out in the submodule working tree, an
> update in the superproject would cause that branch checked out in
> the submodule brought up to date with respect to the commit
> specified in the superproject tree.

That is my understanding as well.  In fact, I don't think the
detached-HEAD-vs-branch distinction is important here, you can still
rebase your detached HEAD onto the superproject's referenced commit
(or origin/$branch with --remote).  This will also work for merge, and
should work for well-crafted !commands.

> And wouldn't it make it unnecessary to have a new "re-attach" option
> if such a mode that never have to detach is used?

I think so, but we currently don't have a "never detached" route for
folks that are cloning submodules via update (instead of via
'submodule add').  Currently, new clone-updates will always leave you
with a detached HEAD (unless you have branch-creation in your update
!command).  My patch aims to close this detached-HEAD gap, for folks
we expect will be doing local development, by creating an initial
branch at clone-update time.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--Ayym4vmyMU9P4uDb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSyunCAAoJEKKfehoaNkbtGWIP/0AQsDCHDOvItggx3dneSPV6
mhmkHO4ZmSgWe6qGAh05CGauDeXw5WIpZbzIWRFQkfvLYWbgF3r6HZdFhCZGHQaO
SYpP34sGKkZld8tnJd4OkQ8HydbrcDA1Ed+JitU5PmKo/j0L/3FbInp+OoqU6/Wv
8lpkF51kZ6uLjWbze4YH+sI379v8d/bC1lSSBjhccQ8r6oirKqceCKtc9NgIG6Ic
N4VnhNa93K1G3vTA3cmibNs+mEdR+/YVm0KNhKU6XUvR0w7i699jHmrEXluq4OJr
fTZS0Ml1MDeA4MbIFGLLl5mp4hDh11P39kHOUShsamlacw8f3a4NQmOsw0kmWu4C
rvlc/tVYMdZLOLHq1yDvc74ELGvYYe4ct7gj/DjoqAt7yVhh1RktdpHxUq5erhz8
rTSJPgfb/NClp/u2W9+yoXxL1Uq48FA7L4xpAQmBMPAaENiGZU8Ku9QR3kjB/BJ8
cEX333Qj0E5WpDHIqjZX88L/b2+kdRDeE/t8zXwDViXfAaBRs9JgKcEjm4dMxlph
GUIXHTOs3MfMfL5xnqRpH/lsgmuFYHPwUJgFjDMyeEUGtxa/izR/zXxziOtuO19D
1Hxyeznexf3xekkApSiYRcq+zKdI6OLwOzDWxVNZuvPyaz98Acku7yT9Jla+XJFR
ttoggcmMAuYqCKfz4DHF
=d5kN
-----END PGP SIGNATURE-----

--Ayym4vmyMU9P4uDb--
