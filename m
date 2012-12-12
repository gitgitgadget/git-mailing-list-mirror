From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v7 0/3] submodule update: add --remote for submodule's
 upstream changes
Date: Wed, 12 Dec 2012 10:24:37 -0500
Message-ID: <20121212152437.GB5157@odin.tremily.us>
References: <20121204001717.GA17375@odin.tremily.us>
 <cover.1355251862.git.wking@tremily.us>
 <7vtxrr6d2f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=H+4ONPRPur6+Ovig
Cc: Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 16:25:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TioBi-00059h-1W
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 16:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963Ab2LLPZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 10:25:13 -0500
Received: from vms173013pub.verizon.net ([206.46.173.13]:21694 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276Ab2LLPZM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 10:25:12 -0500
Received: from odin.tremily.us ([unknown] [72.68.110.234])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MEX004F7C51BV60@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 12 Dec 2012 09:24:40 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id B649F71BA99; Wed,
 12 Dec 2012 10:24:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1355325877; bh=YAnHaN29l2c87iucc1ghOw7q2HxAHI/mdN6qRZmJFs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gMOn559S+kQVfq+oiNlRJo77sJn3eL/XumovKiFKp/EFCTXlbc8UKb5VzWt9JdCoK
 nxAks7nIC+KzD5SC6YMRNvAnv3CnEWKbcRFIAEH/gcl6FPJdEdDn0Q46HpnN7B8AUQ
 auU/6iZKshZ+AB36hngGLYEzQtZUFFFVDWbyU9tk=
Content-disposition: inline
In-reply-to: <7vtxrr6d2f.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211358>


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2012 at 09:42:48PM -0800, Junio C Hamano wrote:
> What branch did you base this series on?

Every version of this series has been based on v1.8.0.

> The preimage of git-submodule.sh in [2/3] does not seem to match
> anything I have (I could wiggle the patch, but in general I would
> rather prefer not having to).

=46rom patch 1/3:

  diff --git a/git-submodule.sh b/git-submodule.sh
  index ab6b110..f969f28 100755

And from patch 2/3:

  diff --git a/git-submodule.sh b/git-submodule.sh
  index f969f28..1395079 100755

ab6b110 is in v1.8.0:

  $ git ls-tree v1.8.0 git-submodule.sh
  100755 blob ab6b1107b6090494f192f361471ed5748ffa7dc1    git-submodule.sh

I can reroll if necessary, but I'm not sure what I've done wrong=E2=80=A6

Cheers,
Trevor

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQyKG0AAoJEEUbTsx0l5OMqgwQALfum7LUKxcxDS7v0Wl2SSzq
mpUj8dcnYk+ITPCxHjPPlozcFabwwj4yv1ah/LTBvRnRnP7trVBATaooTAtc+5az
OUzEijbKBm/R36xlv8qDwy4LwBp3uqLqJPJcmLce4FFRLahzUJ+IiEcSgGfTvWgI
OAPOCdWxJ3P2bDr0Cgyrhv3D2taduUOXVnC1XG5o6dH4i7rzYCpiU7MIgPkkcA92
CTz/HYNH7pJA155r2G0K2isFAukXJWl6/jxngUbvad6LOVgERf5Xk+XzlCxQXlBp
x16tmZhU+tHT9C1ehTqOpSrkaKzaV8sdj0mgQKuLAP9XYA4S2diz5h3vEPd86lFr
rlL/x/d4HU8i+QWrFBsxMckfKCwR3eVIgS99wVYGwkGsauWuoZuU4tR2mTDvrLnW
dJwm0h6Nal5xR3e8QqzF+HzeX3/uPNgTDngqP4i4VSRdOopDx/lOlIH+PMd7+ly6
TYf8wqkmcdirFnX2+NyknYlUT+kKxcr6Q6tde0BvhJj6mSiBklU9uAUaQDsNcNER
BDorZHH1dbDCmSTr4omMmkp0bR6YB45EmG2VRGcAOeLgSny+MJMq+ZKIolHs/mKj
HEvoTSX5uoqFgMq+TdcPoJagEKSsbALFav8FkYsF46Zyk2g2r1wQEQStIxlQlccp
h4TalRxesyFIHpQZfxuH
=w+2J
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
