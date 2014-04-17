From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC/PATCH 2/4] Submodules: Add the
 lib-submodule-update.sh test library
Date: Thu, 17 Apr 2014 14:55:31 -0700
Message-ID: <20140417215531.GY21805@odin.tremily.us>
References: <5331B6F6.60501@web.de>
 <5331B741.6000606@web.de>
 <20140417164138.GP21805@odin.tremily.us>
 <535042B6.7040800@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MxYQAzdbOWKZB282"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder p <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 17 23:55:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WauHX-0005xm-ID
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 23:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbaDQVzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 17:55:37 -0400
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:42731
	"EHLO qmta04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751041AbaDQVze (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Apr 2014 17:55:34 -0400
Received: from omta07.westchester.pa.mail.comcast.net ([76.96.62.59])
	by qmta04.westchester.pa.mail.comcast.net with comcast
	id r9dy1n0031GhbT8549vZQd; Thu, 17 Apr 2014 21:55:33 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta07.westchester.pa.mail.comcast.net with comcast
	id r9vX1n00Q152l3L3T9vYH3; Thu, 17 Apr 2014 21:55:33 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 41C161151604; Thu, 17 Apr 2014 14:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1397771731; bh=9BN3jbbE+UZHnFjFTvh9OEd+SR/0dSsqtKrEVyJhgKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MZC68VQqV4BDW3uB8yvqeW/Ck5OEYNefI0TdlNjByqbjyfE1QoF4/xbdVuKhDxL8u
	 rAS6W4/iypC7C6we5ZLAPlD3eAoDsawkTrKmvKX6GEs9ntf8zL5kwk92NOlPFc+qWn
	 tU0DqrPn+Ce2DotgvWSXRWMLKVi1ABvL6J5nfJZQ=
Content-Disposition: inline
In-Reply-To: <535042B6.7040800@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1397771733;
	bh=zpQ/FCtxb9OPyZqq7u/b2N1TilvMUA66x0Jkvh6qpBk=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=DSDeo5broQglvX5FJcrVhNBiMAaxvSUTC9k+vSkF/EjX7nM6GpcxYqrXClxcnXR+H
	 QmLqj95h8G4SkMi0XVpfcYusJQe79jaZuRsOTb4ePJjJZlRZ8GuV0Jxs6KkHEz5HiI
	 HLkRF0fD6UKF0ivYO/WzfVu5jYwIuobzsmTE0X4IINm+WoCaetWJf8ZldYpHQjaDZj
	 0QFa50RM1xK43iGV2ryq1yxjRIabMQBfNEy52j336KdsgZ7lA7zRth2Dokxkz6Z6lt
	 NX0K9SLgnYuXKmVlxCVSRnljIQbkZtjzdZT9dXlPIkA2elYB4BZzycnXZZBKOlJjGs
	 ao24KKSO9PULQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246456>


--MxYQAzdbOWKZB282
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2014 at 11:08:06PM +0200, Jens Lehmann wrote:
> Am 17.04.2014 18:41, schrieb W. Trevor King:
> > On Tue, Mar 25, 2014 at 06:05:05PM +0100, Jens Lehmann wrote:
> >> *) When a submodule is replaced with a tracked file of the same name
> >>    the submodule work tree including any local modifications (and
> >>    even the whole history if it uses a .git directory instead of a
> >>    gitfile!) is simply removed.
> >> =E2=80=A6
> >> I think the first bug really needs to be fixed, as that behavior is
> >> extremely nasty. We should always protect work tree modifications
> >> (unless forced) and *never* remove a .git directory (even when
> >> forced).
> >=20
> > I think this should be covered by the usual =E2=80=9Cdon't allow checko=
uts
> > from dirty workdirs unless the dirty-ing changes are easily applied to
> > the target tree=E2=80=9D.
>=20
> Nope, the target tree will be removed completely and everything in
> it is silently nuked. It should be allowed with '-f', but only if
> the submodule contains a gitfile, and never if it contains a .git
> directory (which is just what we do for rm too).

I think it's not covered *now* because of a flaw in our =E2=80=9Care dirty-=
ing
changes easily applied to the target tree=E2=80=9D detection logic, and the
solution should involve updating that logic to hit on this case.

> b) recursive checkout is the place to consistently care about
> submodule modifications (the submodule script doesn't do that and it
> is impossible to change that without causing trouble to a lot of
> users.

I agree that the submodule script is not the place for this, and the
core checkout code is.  I'd like checkouts to always be recursive, and
see --[no-]recurse-submodules as a finger-breaking stop-gap until we
can complete that transition for checkout, bisect, merge, reset, and
other work-tree altering commands.  I think this is one reason why
some folks prefer the stiffer joints you get from a subtree approach.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--MxYQAzdbOWKZB282
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTUE3QAAoJEKKfehoaNkbt4YAP/RTak7zo3layRTc0KavPVueW
4NRuA2Gx/Hd0N3A17jLSgy+ozjzZIkrp4VAMXqLNYinQ7hq4MHZ8zgkyIpxUmfzI
s/AV2ccmatvR/ZEN3uSsTgIx1ABJK/rKdu9uP0k1gM9oxg4WWPs4x6mfDg6X9Umr
WAqJSXCCHw92pIj2my16vcKjXzTxNEFwBVexSWUOW643/CT91byzY036wqy7iVUX
XD3GxB0/5qkMBc5v++iKPeZ2DMCLmnsOJReOgDkr4+2na8Wc4QFfdMUDg3invPef
YS39IvhkVSRZCIpXea9VRVNdmGVIeWGTwi8BdgkFvdIWHXOmvpv9JFi8CsXlDU19
4bQ6D8YQFxIPMzSxRteoknT7BnFygmhM1EpRf9F9fa8L4rryle8yuWv9gkSz5+tD
PnGBQ6xqIyL+aEMLyNuTTBKy6YSaHEfiRZXAo9Hu+zDxdiMvaNm4oJUhBXve8tng
dLt+s4H1qYTYbAAzf8g+dZmzq41hS2fejJFi+WzvUtzB4W3IZojfdDrfrI0YpSlG
cPeodY2jzh17hwcBHMvdqNainxeKneM35+j74oNUq82Q12k4WVZW9JF7RLM7k8BH
Jxh8UM9IzEF2QLaeoqAzNfbtvqHfXeaNH/tIFfhGukHtmLE1LW5bSU3Jr+LbiyDz
GPDejxhmqA3PaX9uDfFz
=qfwQ
-----END PGP SIGNATURE-----

--MxYQAzdbOWKZB282--
