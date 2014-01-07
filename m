From: "W. Trevor King" <wking@tremily.us>
Subject: Preferred local submodule branches (was: Introduce git submodule
 attached update)
Date: Tue, 7 Jan 2014 14:36:25 -0800
Message-ID: <20140107223625.GB29954@odin.tremily.us>
References: <20140107041004.GA11060@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 23:36:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0fGJ-0003G1-Tv
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 23:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbaAGWgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 17:36:31 -0500
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:34423
	"EHLO qmta07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752707AbaAGWg3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jan 2014 17:36:29 -0500
Received: from omta22.westchester.pa.mail.comcast.net ([76.96.62.73])
	by qmta07.westchester.pa.mail.comcast.net with comcast
	id B4Py1n01E1ap0As57AcV7U; Tue, 07 Jan 2014 22:36:29 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta22.westchester.pa.mail.comcast.net with comcast
	id BAcT1n00F152l3L3iAcULU; Tue, 07 Jan 2014 22:36:29 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id BA710EAAB2C; Tue,  7 Jan 2014 14:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389134185; bh=U95AeRt+Y/nixzAQlpwT2TQi0RjgazjJdAdTDPnfKBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=EyVUJ64To4z4ylWCtkRoHAcMMKK1IdfCoZnEQAiJSTadk5JeAkrUik6TmkGQoRuC9
	 np3GwdcK7ohYQXCkZ/+bDxpugwAWIjA1gv0J/IQ6XQxHH2OPexRKORmzFFL0ZVi8Pt
	 cxZgrAdsDRmu2wFcPanplDoQ0XQztDqt8vuJU0cc=
Content-Disposition: inline
In-Reply-To: <20140107041004.GA11060@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389134189;
	bh=4n5yuseppOVbxA+hFRoH6kINHNaB5oQ+kJpba2J/dEI=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=Ihj+L1kHoDUjPP4Bhm9crA4DB5MT24YfqQVOkXAqD8g1WF0JyasIsQJi1kBLDsFK9
	 J3sx0ngtGhWdB9Ps+dVZooIjiYBEDQ2JobCjYYgQjlPgdpvcHY/y5APKo2lZyW9Oul
	 fs0R8JZO6lUmf5rUN45OF77zAV3Bjd1EcztNOPzGoa7RfSqllS3C5qlxNyKK0QbUjk
	 bALMJMSZNGqdRYdQ2WIB0wA1dyaXz5hpTR/UARLfpdS9YdvW8W2wbXiyjFeZ5V0sA3
	 XOj5nRqU5tcNJoxXz8jPH5LJw0wh7FuJMnSlFG/zTqcVPrEMkXddA5KSkLgD3C1BD6
	 IfmBmZTwPuuDA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240177>


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2014 at 10:51:34PM +0100, Francesco Pretto wrote:
> 2014/1/7 W. Trevor King <wking@tremily.us>:
> >
> > I'd be happy to hear ideas about superproject-branch-specific local
> > overrides to a hypothetical submodule.<name>.local-branch, in the
> > event that a developer doesn't like a default set in .gitmodules.  If
> > I could think of a way to do that, we could avoid this heuristic
> > approach, and make the local submodule.<name>.local-branch
> > vs. remote-tracking submodule.<name>.branch distinction more obvious.
>=20
> Uh, I think you got it wrong in the other thread:

I'm grafting this discussion back on to the thread where I proposed
submodule.<name>.local-branch.

> I didn't proposed such feature.

Right.  I proposed this feature after reading your proposed workflow.

> I just wanted the attached submodule use case to be supported and of
> course "--branch means attached" is even easier to get this.

As I understood it, the '--branch means attached' stuff was tied up
with automatic --remote updates.

There are three branches that submodule folks usually care about:

1. The linked $sha1 in the superproject (set explicitly for every
   superproject commit, and thus for every superproject branch).
2. The remote-tracking submodule.<name>.branch that lives in the
   upstream submodule.<name>.url repository.
3. The submodule's locally checked out branch, which we currently let
   the developer setup by hand, which is used integrated with one of
   the other two branches during non-checkout updates.

Git is currently a bit weak on conveniently handling type-3 branches.
=E2=80=9CJust use what the developer has setup=E2=80=9D works well for many=
 basic
workflows, but falls short for:

* Cloning-updates, where we currently always setup a detached HEAD.
* Workflows where the preferred type-3 branch depends on the
  superproject branch.

The former is easy to fix [1] if you accept submodule.<name>.branch as
a guess, but this conflates the type-2 and type-3 branches.

For the latter, you'd want something like:

On Mon, Jan 06, 2014 at 08:10:04PM -0800, W. Trevor King wrote:
> * Auto checkout of the preferred branch
>   * Can do this at clone-update time with my patch.
>   * For later submodule branch switches, maybe we want:
>=20
>       git submodule checkout [-b <branch>] [<paths>=E2=80=A6]
>=20
>     Then if a user blows off their detached HEAD, at least they'll
>     feel a bit sheepish afterwards.

which would likely need some of Jens' new core checkout handling [2].

Cheers,
Trevor

[1]: Using something along the lines of my
     http://article.gmane.org/gmane.comp.version-control.git/239967
[2]: http://article.gmane.org/gmane.comp.version-control.git/240117

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzIFnAAoJEKKfehoaNkbtUQEQAICefNBQJpuW3Z7zdX2ngYcL
Lqi+faKXJKPwSk3JNfj4t9kedQEj8ziDvQcqGTWfpSqGJi2KuKHY2j2sVk3BN1QX
XbHW/JghOtaWL+JerCu78XZH8Fkv+rAJZiCPYP4moBfLGqeq3LxUlxSkeoDLMHgB
nniUYjrGrxoTr4GQNw9jOkA6dssnTwNXIIYNdfg3sULqmp3wGuqv+QKNYDccKxpn
4R4wZtz7POP8H7rLaADbA3ft3FC+kHHWnUhydZMj3s7X7uyy52+1NwKufcLnIIHe
cxaTU1uZfheR5OKpmcbXmlFzkYNZeyzi0hlHwogvlz7IdbAnrVFJw75cWuf37McL
W7QjnA95CEd+9Zbh+Nnxd1hojpW5SkXvsOqRFstqQEtLNKeT2ZrwV7PJ6NnS6kD5
uvlyPtOtfLrQAnjhUXsQOE+Rp3+qbLnjE0eNRBPxQCeyQG6swB8z1cb9VvaRNjZ7
lM6Et4eRnmd/l2s7qnTODka8QnaoC9aCKEAN+QbLOT//Rj/4YH21OsvZ5hDuMxDa
8+sWcHvktE0k8jxGD8FhJIP3QzfixsgW79L687yI3AU2k2XyaU7jqgL9jC+hCrHT
zb7pCT83eonFKMDIzpOyt118oGWNtEVy33h1gr6U7ZbVOLAlaydxp/mzJjSWn6s1
L8cBSX/4Nz4UV88ZN47s
=N/Hq
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
