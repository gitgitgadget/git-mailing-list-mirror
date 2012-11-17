From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Sat, 17 Nov 2012 17:00:07 -0500
Message-ID: <20121117220007.GJ22234@odin.tremily.us>
References: <20121117153007.GB7695@book.hvoigt.net>
 <20121117150441.GA7695@book.hvoigt.net>
 <20121117192026.GI22234@odin.tremily.us>
 <20121117213130.GC7695@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=5me2qT3T17SWzdxI
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat Nov 17 23:00:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZqRA-0005nu-Ak
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 23:00:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339Ab2KQWAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2012 17:00:12 -0500
Received: from vms173021pub.verizon.net ([206.46.173.21]:57815 "EHLO
	vms173021pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275Ab2KQWAL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 17:00:11 -0500
Received: from odin.tremily.us ([unknown] [72.68.87.214])
 by vms173021.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MDN006LZJS7KT30@vms173021.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 17 Nov 2012 16:00:08 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 4AD40695A09; Sat,
 17 Nov 2012 17:00:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1353189607; bh=GsbKxR/AKNaHM6IfoBQX98v2Y5B4GmZCK+BAOEBGIRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dh5Dt0me6qShbbik94/BGBeJc9d4iymq8KZ+oY+++TrPtA3I7DjSYvkGQ/kO80K0M
 E7PAbRptcyCTypBFs7FxChTL1vtZtYjH7X94z8JPWoyPpSJNgN6TTIimTXGbgkkHUz
 31jWNT6Tl5F6lF/krCQ3dIevgwnhC/3/vnTVOGgQ=
Content-disposition: inline
In-reply-to: <20121117213130.GC7695@book.hvoigt.net>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209982>


--5me2qT3T17SWzdxI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 17, 2012 at 10:31:30PM +0100, Heiko Voigt wrote:
> On Sat, Nov 17, 2012 at 02:20:27PM -0500, W. Trevor King wrote:
> > On Sat, Nov 17, 2012 at 04:30:07PM +0100, Heiko Voigt wrote:
> > > > >  (2) "git diff [$path]" and friends in the superproject compares =
the
> > > > >      HEAD of thecheckout of the submodule at $path with the tip of
> > > > >      the branch named by submodule.$name.branch in .gitmodules of
> > > > >      the superproject, instead of the commit that is recorded in =
the
> > > > >      index of the superproject.
> > > > >=20
> > > >=20
> > > > Hmm.  ???git diff??? compares the working tree with the local HEAD =
(just a
> > > > SHA for submodules), so I don't think it should care about the stat=
us
> > > > of a remote branch.  This sounds like you want something like:
> > > >=20
> > > >   $ git submodule foreach 'git diff origin/$submodule_branch'
> > > >=20
> > > > Perhaps this is enough motivation for keeping $submodule_* exports?
> > > >=20
> > > > > and the option were called something like "--follow-branch=3D$bra=
nch",
> > > > > ???
> > >=20
> > > I am not sure if hiding changes to the recorded SHA1 from the user is
> > > such a useful thing. In the first step I would like it if it was kept
> > > simple and only the submodule update machinery learned to follow a
> > > branch. If that results in local changes that should be shown. The us=
er
> > > is still in charge of recording the updated SHA1 in his commit.
> >=20
> > I understand what you're warning against here, or what it has to do
> > with "git diff".
>=20
> Is there a not missing here?

Thanks.  I'd meant to say "I don't understand=E2=80=A6".

> What I am talking about is the suggestion of Junio.  Instead of
> showing a diff if the SHA1 is different we show a diff if the
> checkout in the worktree is different from the tip of the configured
> branch. That would hide the fact that a submodule has changed during
> a submodule update operation.

Ahh, now I understand.  I agree that comparing to the remote tip is a
bad idea.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--5me2qT3T17SWzdxI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQqAjkAAoJEEUbTsx0l5OMeroP/itIgcpQuowsJ+TGfOt08mYa
+dW0RWZm2SeXTrd28rn8OKnEUBMFtEIz1dGGdpHVHKp88pn9Uh8q1uof+Ug3kjOx
KvW+QGSBR7IagnZg8d1ufDNHJLiGxpBlEi3rBEq1qNwzPf9vGA/OV/L7ir+tIlcd
pmT6qZ9n5K1mq+oJVRnvdl94fhO8KbI8dBD0MFX8Hzsr9qkZHDNP/UBbSYcDunKz
clpc9zWmB9P2bQQHwJ7Np0Fq6Mda4+es9uY//QwJSnt8jKC1XM+gZ8OKa3KF45fA
EeiaiYs4aCrsoc7zKFuEbb1Vg4RKxNODuabhGnHwC6LxW3hDRmD+XdfEw0O6amlj
RVpfree67W9DLanwZWvnHH7OgW8/uoKGkAbSKsTmbj43541eZVVEeyAsuDayw9U8
VVdbpxZQ4hOvx1Lut9YpT5tiQz5KyDrt9jSwiECTuPmMZV1BBfpejmfe6s/yJpMj
4vn/HSgJQ4hSeXyB2uMHKZz0UK6qa+wTbG/91GhqhuzmYEs3AdqNWnC5swwWt7bI
vCvO0WrlCH/krr7Oio1MKDAd2qMajQuwmb+v/QGXPo9gSHivbsSIu2X5a1WPE3tb
/o3+nS8LoWAeV905LNdFeoO+BC4nNJlOnYG7AP4BOJPj5aH/idC/lJw8Y+RNwOyI
XfwFjMKAoyvgtYWrdodJ
=Z1TR
-----END PGP SIGNATURE-----

--5me2qT3T17SWzdxI--
