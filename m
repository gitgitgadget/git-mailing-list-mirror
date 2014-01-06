From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Sun, 5 Jan 2014 16:33:14 -0800
Message-ID: <20140106003314.GL3156@odin.tremily.us>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
 <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
 <20140105194850.GA2994@book.hvoigt.net>
 <20140105212458.GG3156@odin.tremily.us>
 <20140105225733.GB4660@book.hvoigt.net>
 <20140105233943.GJ3156@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nrXiCraHbXeog9mY"
Cc: Git <git@vger.kernel.org>, Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Jan 06 01:33:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vzy8A-0001SV-CR
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 01:33:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbaAFAdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 19:33:18 -0500
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:56487
	"EHLO qmta07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751454AbaAFAdR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jan 2014 19:33:17 -0500
Received: from omta05.westchester.pa.mail.comcast.net ([76.96.62.43])
	by qmta07.westchester.pa.mail.comcast.net with comcast
	id AQ5w1n0050vyq2s57QZGN0; Mon, 06 Jan 2014 00:33:16 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta05.westchester.pa.mail.comcast.net with comcast
	id AQZF1n00E152l3L3RQZF3W; Mon, 06 Jan 2014 00:33:16 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id D289AE8BCDE; Sun,  5 Jan 2014 16:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1388968394; bh=wW75h9rXCk0GETZibJe8nOfhQ5w+jg7ywfr4wSVjRCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kL2wDBKxhLJ4/kgBIT6wWMql/VlwI2IWoACqmur3t1sT+Xsb2KrwignS5rVaH+okD
	 rmZ6Uzn/b9sey97a9HD9FxGIaLoADw4pby+Lth6RSVnt03iP/4UgtCpREiWwMKwyoy
	 vGTq00aj8tvr3o66H25aycF0Qa7lPS+oB/nIVhKw=
Content-Disposition: inline
In-Reply-To: <20140105233943.GJ3156@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1388968396;
	bh=kimaO7ECPSLoODlJQZlzZBwP4qDrj6mnz3JGfP+Jw/o=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=kUi2j2M7WPKtkvd06D/Fc4KtyysIMxeEm1RqgMhZ95vLeBQD1SdYy7WiXfcyOGupH
	 zztAMaEwbJJzDxPl6dK3atPA6vXseoEJouEj32NbOufYRvzJzIzt8M+71ayS4LTjyA
	 3fYJC2WHDHFKzXMQsBFIGnXfdz2DvnMLc2X1FK08FNnpFfKYsRdEpSifsS8P8dANk4
	 WjaPrr9CdIeYMydz3m6Ep7Xe9pf4lACG6GQB29HMqbjGIAb8qXRVhZPAyfegWtpz/Q
	 HEzzoH/Hge8UzB583Mx4crxe0KGKkc20y7+F1wLMCLB0DiNQCj7QhZF6cjfsr0EOZA
	 l7gDJpgIBjqeQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239984>


--nrXiCraHbXeog9mY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 05, 2014 at 03:39:43PM -0800, W. Trevor King wrote:
> On Sun, Jan 05, 2014 at 11:57:33PM +0100, Heiko Voigt wrote:
> > The reason why one would set a branch option here is to share the
> > superproject branch with colleagues. He can make sure they can
> > always fetch and checkout the submodule even though the branch there
> > is still under cleanup and thus will be rebased often. The commit
> > referenced by sha1 would not be available to a developer fetching
> > after a rebase.
>=20
> Yeah, floating gitlinks are something else.  I'd be happy to have
> that functionality (gitlinks pointing to references) be built into
> gitlinks themselves, not added as an additional layer in the
> submodule script.  This "gitlinked sha1 rebased out of existence"
> scenario is the first I've heard where I think gitlinked references
> would be useful.

On the other hand, if the subproject has such a rebase, a superproject
dev can hop into an existing checkout, update around the rebase, add a
superproject commit with the fixed sha1, and push that for other
superproject devs.  The only people who would need *automatic* rebase
recovery would be superproject devs update-cloning the subproject.
That's a small enough cross-section that I don't think it deserves the
ambiguity of gitlink-to-reference.  In that case, all you really need
is a way to force a recovery gitlink (i.e. add a 'commit' object to
the tree by hand).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--nrXiCraHbXeog9mY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSyfnIAAoJEKKfehoaNkbt19gQAIXzdM0pfGQWSehylWq3/88I
/YxGh11oWR8fTOiTHr5+ccTzWOtEo63aROPGS5bhhf4wfaCIXF3zPVPjX32K1IED
kIpt/N45l/rbP+XI6Den5LtIcwzwJqqpSbN/hv+g/Pgk37Sm3tfOdWNKdGkbv/hw
LEegaPKv1dpKawGdASfyuGs67jOl5gslvAETI1AZDXznfmgA73+jonUf2fqXC4x1
RWs+aO2KuzghQVuKTVBf9nfxc8merpNU2ZqN+GDxuNTMWz82biv6GkyO8W9INmyn
xJhgZnU+JfxB5XU3sXefb/gdG5TyHKklOI/t7gOcpuwWQIb93sNJNNoDO4S8oLEk
w5wbczJLKAbwYRlMyF377C9VGgVOsEtRf9wpROHS4khEq8v5aVGmo0AXVdXl+8ed
2KGFm1XBT7VROrfekb06oZwQyPqbj2LKvk5F3hx4O5C8XEG1VyV1lI3pp6nXA+V4
CSctSX3YR8R4ScROixBxYWxx2sJdZ8DZAIHXeFZCBu1zvo5no8W84LTnBsU3nOT8
pwXBqiZh7oW57sdl84ClY5TDJAWf8cjJiPmmGOwR88VbYkQBT0iRNIKweB+5HOIw
bfL2Kdiz5+fymTV8U/1iiLdOeltw8xzhXwspOXKiQU6VhAh/QhkzUEojQ2d7Hpec
Cf5sU0uh5tBtp0n71ESo
=4U3K
-----END PGP SIGNATURE-----

--nrXiCraHbXeog9mY--
