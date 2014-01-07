From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Preferred local submodule branches (was: Introduce git submodule
 attached update)
Date: Tue, 7 Jan 2014 15:52:08 -0800
Message-ID: <20140107235208.GC29954@odin.tremily.us>
References: <20140107041004.GA11060@odin.tremily.us>
 <20140107223625.GB29954@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 00:52:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0gRV-0000JK-IU
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 00:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305AbaAGXwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 18:52:14 -0500
Received: from qmta11.westchester.pa.mail.comcast.net ([76.96.59.211]:55328
	"EHLO QMTA11.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754105AbaAGXwM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jan 2014 18:52:12 -0500
Received: from omta18.westchester.pa.mail.comcast.net ([76.96.62.90])
	by QMTA11.westchester.pa.mail.comcast.net with comcast
	id B1WR1n0051wpRvQ5BBsBgG; Tue, 07 Jan 2014 23:52:11 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta18.westchester.pa.mail.comcast.net with comcast
	id BBsA1n001152l3L3eBsAqS; Tue, 07 Jan 2014 23:52:11 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id C0C3DEAB35D; Tue,  7 Jan 2014 15:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389138728; bh=3gf41kQV8paHUGJ2aecNMRkEolOdyMaN5rCJuI20NFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GmtqkNYW8su3MEhEvtGaSqHCXpN5LsJl5E55XeJzogKdzGI54kYHeqoEOdOSnTBNp
	 l18Du+WiuoqIwuNFrtI7t5aOr3YuLHVjLoEEfj0Z4HRDQ9cnb5I44hm1K53KdpNi3m
	 vdgyPt8AcsxC8zQ0SyQkjTglMtxpHuuMDFZGABPk=
Content-Disposition: inline
In-Reply-To: <20140107223625.GB29954@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389138731;
	bh=vrK13iS76yX7PE51P4e8DZE/p8LE+JcJxkV19UdVzPY=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=NOJ467AukASzD9QD9tmvyf+RduZ0ROBGlxKuxnjLWDRpmWA1bMHzinrjCDKAlF1x7
	 3reDtJ8cAVCz9ZZShtUZRvIlZvTWC6nER8luSflT7YXTupoAPwTGkjvM3OTg9OLo+/
	 QIyuqYwDNIf2j31RXuoosp936CTEALPAbECcgt82A80SJCYGgTnh9Y7kA8DQsk9cT1
	 ixgFlZt0/CVqtIKBHMJ3bOw9xeodkPuJFVeoLQQfpgp7NhIvxDnQ/sT9bPjozKysmc
	 qmxi/qAueH3RYVMAJvu0K7A9IlkdIKB/aA9cdJOr9RZPLxTpqScrYVBkVOryV67lkh
	 ZVps6fEzWlFlA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240181>


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2014 at 02:36:25PM -0800, W. Trevor King wrote:
> There are three branches that submodule folks usually care about:
>=20
> 1. The linked $sha1 in the superproject (set explicitly for every
>    superproject commit, and thus for every superproject branch).
> 2. The remote-tracking submodule.<name>.branch that lives in the
>    upstream submodule.<name>.url repository.
> 3. The submodule's locally checked out branch, which we currently let
>    the developer setup by hand, which is used integrated with one of
>    the other two branches during non-checkout updates.
>=20
> Git is currently a bit weak on conveniently handling type-3 branches.
> =E2=80=9CJust use what the developer has setup=E2=80=9D works well for ma=
ny basic
> workflows, but falls short for:
>=20
> * Cloning-updates, where we currently always setup a detached HEAD.
> * Workflows where the preferred type-3 branch depends on the
>   superproject branch.
>=20
> The former is easy to fix [1] if you accept submodule.<name>.branch as
> a guess, but this conflates the type-2 and type-3 branches.
>=20
> For the latter, you'd want something like:
>=20
> On Mon, Jan 06, 2014 at 08:10:04PM -0800, W. Trevor King wrote:
> > * Auto checkout of the preferred branch
> >   * Can do this at clone-update time with my patch.
> >   * For later submodule branch switches, maybe we want:
> >=20
> >       git submodule checkout [-b <branch>] [<paths>=E2=80=A6]
> >=20
> >     Then if a user blows off their detached HEAD, at least they'll
> >     feel a bit sheepish afterwards.
>=20
> which would likely need some of Jens' new core checkout handling [2].
>=20
> [1]: Using something along the lines of my
>      http://article.gmane.org/gmane.comp.version-control.git/239967
> [2]: http://article.gmane.org/gmane.comp.version-control.git/240117

For example, in Jonathan's recent version of Jens' series, the
initial-setup and update functionality are moving into C.  See:

* populate_submodule() [1] for the initial-clone setup (calling
  'read-tree'), and
* update_submodule() [2] for subsequent updates (calling 'checkout -q'
  with an optional '-f')

this is where any submodule.<name>.local-branch would come into play,
if we decide to go down that route.  It doesn't look like the C
updates have the auto-clone functionality that the Bash updates have.
I'm not sure if that's in the pipe or not.  I'm not as familiar with
the C implementation though, so maybe I'm missing the mark here.

Cheers,
Trevor

[1]: http://article.gmane.org/gmane.comp.version-control.git/239698
[2]: http://article.gmane.org/gmane.comp.version-control.git/239699

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzJMmAAoJEKKfehoaNkbtlcgP/1mdIkWBNLMbspyzr/tgohz+
9WazyoLLrFDb+qDdVeJdhESh9ra4zXNS15QosrUuLeqIssjYjOVaq8PCxlFazjV7
8QRkNtqOKxPBP8Y6cNcGdXjyMCM3aXuWGZSp68jSgcPU6iDj7o9xKK+RYDpuod1g
9FPtlidflhaJq8nfTxiXycsURe2Jq11V0Ixek6zlgiSg5waU55xOjtcvH5gSxtSk
ypT+okscdiLjSWZhlS7RmlG1CUEfmaWoZE0J3/5iuxSmXB9KWP+cGIykR0b1Y0jo
9H4zjGa+QxLc6suGnd145barrHI9vt2El34QQ8Yisl72mkRvv9E1Z3ZS9msjJBce
x5eriiTDnSuB6DhlqbIJl4JWpr9U2iJ/QkVPQyPSWOizRu9XvcVk9Q8HvVAiJsYs
POA9JPr5U+Jas+frpPR20OJwAzLiypAEg+0R/fCmuGXrEAQU5puOERelxuWW/VHn
Ggo/CAIIt9o1l5mRXPsC6xu4vbPXcAklBYAZFrQHmEwgyjP0kUYrDJjddp7/xiqN
CbvB08Lc42q0bgNy82LeoqnEdtUzbzjQdYjc3/DMNw7Zh2e/aSbnHOdm5y4E410b
dVrtDBiSBOCQbbmbKLclWWpAj8vFJekklJvg0FcYamcHe8pYJe+tLm5m2MvHO+kN
TCSmcKPF4OF8xlk2HzhG
=J7Jq
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--
