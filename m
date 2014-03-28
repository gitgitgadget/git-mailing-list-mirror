From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC] submodule: change submodule.<name>.branch default from
 master to HEAD
Date: Thu, 27 Mar 2014 20:52:55 -0700
Message-ID: <20140328035255.GF25485@odin.tremily.us>
References: <20140328030556.GD25485@odin.tremily.us>
 <c66d89d854407469b6fd223213a09e5d60eeec0a.1395977055.git.wking@tremily.us>
 <CAPig+cT7tmxvYz+sLQY68SgF6osM+pAj-gFb7xvyuH+Gnw5xrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5Mfx4RzfBqgnTE/w"
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johan Herland <johan@herland.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 04:53:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTNqs-0005fF-N9
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 04:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757469AbaC1Dw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 23:52:59 -0400
Received: from qmta08.westchester.pa.mail.comcast.net ([76.96.62.80]:42687
	"EHLO qmta08.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751883AbaC1Dw6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 23:52:58 -0400
Received: from omta24.westchester.pa.mail.comcast.net ([76.96.62.76])
	by qmta08.westchester.pa.mail.comcast.net with comcast
	id irmV1n0041ei1Bg58rsxBk; Fri, 28 Mar 2014 03:52:57 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta24.westchester.pa.mail.comcast.net with comcast
	id irsv1n00j152l3L3krswtX; Fri, 28 Mar 2014 03:52:57 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 9176A10DE2DF; Thu, 27 Mar 2014 20:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1395978775; bh=aBlV0L/NVWewG7Spov/4iO25gCgU9KKszH05HPs5Vhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M2vEw8UIQmfX/p71H+3ztTmGxB9h204Vr7qQNrV5eCl958sjTPpeSs1IaQDhFBoGM
	 rNhgGAQFRpgxA3Xq2J3l2iidn5uENQmvn4ArIYDSiPxOaDb+23wUwXXGTzoQ57wILN
	 pOcMLyvCaEzlhURFaMbBKhCkuMzSTJSOrlb5L8GE=
Content-Disposition: inline
In-Reply-To: <CAPig+cT7tmxvYz+sLQY68SgF6osM+pAj-gFb7xvyuH+Gnw5xrg@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1395978777;
	bh=TOMDfZbcflUGS15qB6Tiyav/5shIEoYsxtyuNcdvbmc=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=Tphf+RL1CdBfuYEyfTRvIFDo47QFWI3Ka/G5J/K295CfGNn9EcONzzn+2fIqByITn
	 bVBV8JUGhjfutUim2oz6bQIEvV36KXOtCfp0WSbcD8B795qQKmF9vh/i0ksqJnrZXo
	 KVx2PAKusul4LfohrsJ+xTOLgeQtQaV+vrvq4DRLA9K+ZbOaIwEdJUTmT7jfBTMO9/
	 dMoDMsmYFIkUlbeDibJsevCEd3qgtBD4Ym3BlFbk7UXhMXSfx4nyuniI446V0hVYqL
	 Ar3FtKxlSIFjfot3KG/JgcSJ2M0iN6OZxQj+iYLjBBBHkzvmzji6yJgCEms7eLe90p
	 eFJyZTjHfkCxw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245360>


--5Mfx4RzfBqgnTE/w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2014 at 11:43:47PM -0400, Eric Sunshine wrote:
> On Thu, Mar 27, 2014 at 11:36 PM, W. Trevor King <wking@tremily.us> wrote:
> >  submodule.<name>.branch::
> >         A remote branch name for tracking updates in the upstream submo=
dule.
> > -       If the option is not specified, it defaults to 'master'.  See t=
he
> > -       `--remote` documentation in linkgit:git-submodule[1] for detail=
s.
> > +       If the option is not specified, it defaults to the subproject's
>=20
> Did you mean s/subproject/submodule/ ?
>=20
> > +       HEAD.  See the `--remote` documentation in linkgit:git-submodul=
e[1]
> > +       for details.

No the remote branch is in the upstream subproject.  I suppose I meant
=E2=80=9Cthe submodule's remote-tracking branch following the upstream
subproject's HEAD which we just fetched so it's fairly current=E2=80=9D ;).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--5Mfx4RzfBqgnTE/w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNPIWAAoJEKKfehoaNkbtvjEP+gPByOr/4KEQA1t3VoWSYY57
/5Zlo6CaS/7s/592cSnUFrnnM3drd56nR7bAOEEAdyZT8HMK9cQTdODAx+H9SVHU
utj0Cf0+W2E+E+/QA7/MDG8RHVH6xVRyQT/C0zsiLIR0A4gm+85kwK18iChfH7OJ
wiM930woOlFADBK/JQ26uqf33d8+9Co7Mfv09rYSfwE/OjKtRRsFX6C/58TEbKzf
bVAZ32voupzQIeCOx35gFJfjBzpvEnlY9yWTDTYdFBr5C2Jtw958H/ewpgCacoOQ
JQ+O6pcJ7MlnjtbuQbW5H+O9JJfRNnlPKd3UH4ooKGDU5WAAJ5P4W7SOk8ncKLeH
F32iMMGt5fSM+8X03sC3fHSY7XIGBW7PifBxDjDKOnUx+0ZRa1+ec/QbUGrVqqHY
abuvEkL109Nl336m6FhE6394/mofBhcqnCPc0SHeZwg+aTDGjL+K0GCloMdWDoI8
H+VoEU8vN5xSF36sPwrchSM5iBglM+6PlfivNbCcSUSUlLyT7Vfgg3Tstxy0569a
hxwY9vyjRuV737fx1Kdkk5Hc4SDfbCCRSn1bxIiE70xLP1KYTnonv/SoWCuZSAof
u2DOJfiCnl5l82oR4pbCzK59HoZkptGQumXv2hE/nbTdETzrFi4+nanQq+ZRW9iI
UMCXSxfY9p+5Gttvm8cC
=FqVD
-----END PGP SIGNATURE-----

--5Mfx4RzfBqgnTE/w--
