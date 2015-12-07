From: Patrick Steinhardt <ps@pks.im>
Subject: Re: What's cooking in git.git (Dec 2015, #01; Tue, 1)
Date: Mon, 7 Dec 2015 14:40:14 +0100
Message-ID: <20151207134014.GA1105@pks-xps.fritz.box>
References: <20151202002450.GA27994@sigill.intra.peff.net>
 <xmqq4mg05wmj.fsf@gitster.mtv.corp.google.com>
 <20151202223114.GA20542@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 07 14:40:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5w1g-0001O8-83
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 14:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbbLGNkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 08:40:18 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:47491 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753180AbbLGNkR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2015 08:40:17 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 12062209AA
	for <git@vger.kernel.org>; Mon,  7 Dec 2015 08:40:17 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 07 Dec 2015 08:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=sQFjuIfYl2v7PcJGsM8xgRC/ehQ=; b=tXDEd
	CRBWYz2UiBxrzNSbNM9hqF8TgZMSbjLS4BTemm6zQMJ9bMyq0j+FiYsLVquv4ieC
	XYAVUxZVUKvVGFp3xd6Yv7uFqLXLk55Ak7ErlpVe4MXuCjOquNjTC/8Xkrs/Uz5w
	4PnPlGhNH/aEorzzUtNyWNEEs2YpWvipAEoM2M=
X-Sasl-enc: PJwoLt957V07manWW2W+T3J/5Nt+xeWUXJTDFNo252+w 1449495616
Received: from localhost (p57a9b1d9.dip0.t-ipconnect.de [87.169.177.217])
	by mail.messagingengine.com (Postfix) with ESMTPA id 765D2C01776;
	Mon,  7 Dec 2015 08:40:16 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20151202223114.GA20542@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282092>


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 02, 2015 at 05:31:14PM -0500, Jeff King wrote:
> On Wed, Dec 02, 2015 at 02:11:32PM -0800, Junio C Hamano wrote:
[snip]
> > "--keep-empty" has always been about keeping an originally empty
> > commit, not a commit that becomes empty because of rebasing
> > (i.e. what has already been applied to the updated base).  The
> > documentation, if it leads to any other interpretation, needs to be
> > fixed.
> >=20
> > Besides, if "--keep-empty" were to mean "keep redundant ones that
> > are already in the updated base", the patch must do a lot more,
> > e.g. stop filtering with git-cherry patch equivalence.
> >=20
> > I'm inclined to eject this topic.
>=20
> That was my thinking too (and I notice it didn't get any review from
> anybody else).
[snip]

Well, I kind of agree. The cherry-pick command has both
--allow-empty and --keep-redundant flags, where the second one is
the kind of behavior I want to achieve in my case. As an
alternative to the proposed change to `--keep-empty` I could
instead introduce a new flag `--keep-redundant-commits` to `git
rebase` which would then pass the flag through to the
cherry-pick.

Any opinions on this?

Patrick

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWZYw+AAoJEBF8Z7aeq/EsJywP/06B/MN6jnw/aMDD8Im6VM4r
rSaSKtcDf/dSBoQg92KdExVRtv7vTj2tbsIq07i2EHTTmaOdS3vpSgvvDnLcH1aC
YGSv4p9o9k0vnK5BUMRLKzSS4lN3y4HIW1fCkT66vKUi7R0y4lQFYuzykgN6qjuv
LXdcADNmvIdTzOe8Z/4npUPcQFPe1B5kI7TycXBd87OZs6eLRBwhdSqvbSt8owGw
GaJaLgG5iosy+CmrxKQY8EyJ4ZXSk8IaxiIB4Cndh3kcvk1StHEIwKsQQoD11Mtg
/ONeO61sowu0GJ3LD3L7NQgEfbVN8DG2E06VIX24x17S79FMwi/jcxPQmwqrY5nH
U7xBiRIAX6zi7B96uKuWCpNJjyDF7MakYKWtPOEJ4oN3/rdJW3HUXghtELHupzEn
Nx1StuwvTAbm4D806q8vJj9VNs78WOMC4Ix2A6mNLNHf/vJ/a8QheDQPfgpcHR9F
cZmMZsBNUGWGpEX2gGedRCK3nMKz/vVaLO7iUKtLDKEQiq129QUubmEeBHKBt6iE
85Vo9OD9guvGF6JTa2tCwZxskiU9ozX65pD/CZyq1arKyOglNQt14Le8a+VCFJO4
HyaZt3imyRk+yCTDjxEcOQWm+/ZZ7mjW2r1Vwe3DlewEtnj8il3qnoEOP/x1J9ux
1SeMr1qWdl43JbYwjCCQ
=qnpY
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
