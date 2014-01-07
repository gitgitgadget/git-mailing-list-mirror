From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Tue, 7 Jan 2014 13:37:39 -0800
Message-ID: <20140107213739.GA29954@odin.tremily.us>
References: <CALas-iizoBjTu2KSXsZExNeLz5hxbzoNNGgYLMP9SmDH+kt9Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Git <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 22:37:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0eLN-0004VR-1K
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 22:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982AbaAGVhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 16:37:46 -0500
Received: from qmta06.westchester.pa.mail.comcast.net ([76.96.62.56]:60498
	"EHLO qmta06.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753493AbaAGVho (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jan 2014 16:37:44 -0500
Received: from omta12.westchester.pa.mail.comcast.net ([76.96.62.44])
	by qmta06.westchester.pa.mail.comcast.net with comcast
	id B9NC1n0010xGWP8569dj9K; Tue, 07 Jan 2014 21:37:43 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta12.westchester.pa.mail.comcast.net with comcast
	id B9dh1n00f152l3L3Y9diZx; Tue, 07 Jan 2014 21:37:43 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id D5636EAA474; Tue,  7 Jan 2014 13:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389130659; bh=4vf529Z9YhFhSor//suTjaKjz57qoyb4BuE6rxxAS8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=DtmI0VGdJVS9vdE4GzxfCpu5pfojxSDUwxKsy4biJA8JKkoh1Jz6VFHJ4U8dK8J9e
	 pIk+LlEpNLku6bpiO8iTSBAq70d2yT8gPQzs7r2SHif+FTIiVhV8L664rVdq/XJkDj
	 KE1LVnMbyv0aKOtsiD/6Kb3BBRW6J19oz5ilec8o=
Content-Disposition: inline
In-Reply-To: <CALas-iizoBjTu2KSXsZExNeLz5hxbzoNNGgYLMP9SmDH+kt9Vw@mail.gmail.com>
 <CALas-ihLbODY6idQizsvH-U6OFRnC6e5=WRB6gkJ7SpBJ3VskQ@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389130663;
	bh=3qzMGpJBJj6IAwtKEniPL2V/ZLrIuqfJtoepu19RJtU=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=OD14pMPlrxxGAAJgZpq/eN9Cu25bhVbxxV8F5vZb9igM5n0jiJowuwir+KyHYMo/Z
	 Ua70/9bFCBWLp/2jyCl37mhc+tJkVSw7H5m4LEUG4BT/0vSl/G8OgGgIm3XdPIhb8w
	 I787JBPjGP9GA76sCmD64cfmA7aJ8KJnrcUYTz6xCdKvq8tYAYDL9WbREFKwmJv3HC
	 y2m0Ujz7HongiaPOUu//KdWr37cgY7+ZdmrLRVixVjQKraDQctr3eqLr0J6XJYj6dK
	 AbfTA2q9lNKuPj/VAERjWYX+NYYZ6SnYj6a+D5+5h7o2MEsW9CuCom9Tzu1JGFVM0A
	 SIWrFy1XFVasA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240164>


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2014 at 09:09:19PM +0100, Francesco Pretto wrote:
> 2014/1/7 W. Trevor King <wking@tremily.us>:
> >> Trevor, maybe it was not clear. But I wanted to say:
> >>
> >> " I fully support *Trevor's* patch..." :)
> >
> > Which I appreciate ;).  I still though I should point out that my
> > patch *confuses* the role of submodule.<name>.branch :p.
>=20
> You are welcome. Also, at your wish, can you please reply also in
> public?

Here you go.

I'd be happy to hear ideas about superproject-branch-specific local
overrides to a hypothetical submodule.<name>.local-branch, in the
event that a developer doesn't like a default set in .gitmodules.  If
I could think of a way to do that, we could avoid this heuristic
approach, and make the local submodule.<name>.local-branch
vs. remote-tracking submodule.<name>.branch distinction more obvious.

It would also be nice if submodule.<name>.branch was just an initial
setup-time and detached-HEAD default.  If the submodule is on a branch
it would make more sense to use the checked-out branch's @{upstream}.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzHOhAAoJEKKfehoaNkbtZjoP/RSA9He/+xe1WIcw/Khn6rUs
cJjXBv47TrWbFmRmR10IZqVwmQkOC7AghE2/K0hWfKuyts2eHBbZsnCoO514HoWs
GTeoZflaThN+mbWO+gxTH/kesLXvgXSAq66fJ36UvGmjpKsc/hRkrvFiYM5liBP7
0pxk8+vIEseretEozxS769OUYqJ+1HPAk8yc5eHUf7SynJ6WYpLZxE9zFHA4jWU/
9gDOD4DzNV55n4RmzY/nLwjHaz4BiPzkhd9SgE9gePqj9FVRRoY3BpP1j67sCZ3v
4LKXnRAchsvVvHfX2ZnmVTS93B5GcbE5wMSsGVra5Pj9J5L+Vl7Mj5pOKi/Lad5o
cEDKtJ98mih6dFc4fhw9p24aUfIpbLTp8oiliwdVBnGLlcViw6ndLYVtITtNzFs/
YfgYfo6J6e3+Ns/5pAEzIwCccHYpMpmjDxzlvD3HlkroxRqNxRYVWZV0AElUthFW
1F6Nd8rjkojlOI3Wa2I3a2OJcxfVJDlJbSAYBGRNwPZuYfmSk3+7eF0IyZXRKP9N
2jOxs1OYu7wgfo9Oh0he2RoCzIA0hMokuYG+lRI3ZNwNE7OLoTSywC5HdWa4O6ia
K0IP1kRRkR3XghcThyy5pDEPa+7song0h9hazVE9BkGggsU1Xc+x97GgIoOtMnyy
9UsUvkPZ3MLxbf1ApVmn
=5cyK
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
