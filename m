From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v4 2/4] git-submodule init: Record submodule.<name>.branch
 in repository config.
Date: Tue, 27 Nov 2012 19:40:25 -0500
Message-ID: <20121128004025.GF15213@odin.tremily.us>
References: <20121123175402.GH2806@odin.tremily.us>
 <cover.1353962698.git.wking@tremily.us>
 <6734714e90064b3932126565e3027d7edcf45d51.1353962698.git.wking@tremily.us>
 <50B54A68.60309@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=AH+kv8CCoFf6qPuz
Cc: Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Nov 28 01:41:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdVi0-0001gg-Qu
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 01:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002Ab2K1Akp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 19:40:45 -0500
Received: from vms173009pub.verizon.net ([206.46.173.9]:9789 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625Ab2K1Akp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 19:40:45 -0500
Received: from odin.tremily.us ([unknown] [72.76.144.216])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ME600N349VD5120@vms173009.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 27 Nov 2012 18:40:26 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 71AE86E0F81; Tue,
 27 Nov 2012 19:40:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354063225; bh=d9byPmwt8vvAROEtEeJBl42EIaI3XRo5r6+evKyDDVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=arvxKrwuaRk56vuJSQa6ieAuTbxUHgex2Ub1zAaHISEGMMp670PgkmBfEalLpXfyd
 utfHjNLs4mQk2V96OeqcKLI6qMaCJ9r1vam8Ceo1a4LiuV+DXDsU47acZtdxanOFqM
 nJiaxnI8zS0eeYwLHNCAFP6OlvDrg8Jeu5eQ8d90=
Content-disposition: inline
In-reply-to: <50B54A68.60309@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210644>


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2012 at 12:19:04AM +0100, Jens Lehmann wrote:
> Am 26.11.2012 22:00, schrieb W. Trevor King:
> > From: "W. Trevor King" <wking@tremily.us>
> >=20
> > This allows users to override the .gitmodules value with a
> > per-repository value.
>=20
> [snip problems].  You should use the branch setting from .git/config
> if present and fall back to the branch setting from .gitmodules if
> not, which would enable the user to have her own setting if she
> doesn't like what upstream provides but would still enable others to
> follow different submodule branches in different superproject
> branches.

Sounds good.  Will fix in v5.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--AH+kv8CCoFf6qPuz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQtV12AAoJEEUbTsx0l5OMbGQP/2jsf4LHtQ8xUUZ1I5nAvv2S
XsgXeJzZW0Wr3T1NHlOdKGhCVPCafvjnWDWDZlF5Vb+zxfTsc37TFvOikJ4D56ui
8H2x8G1Vb9J3c6GNPD7sAH8gVBQ6ozqYdtUfLbA5O5Pz1s9BbfSFxrUVIdSabME6
cg4/uYbU5DHmGurBBF95W7kjkoBwjK0IJhxcou0CSsxIPXMYgtj6U+W9SXFyP/wo
jqFdqD/O0fGq+4C45e2fe/cQszOQy/9GB48nKuANTvEDMj+UhiMkvli5/CwdjtFW
CngTYMBydsirmtcMPzbJFKTBBFWeYaG9bws5mNsnutdtePyqSlGhzLDSBdR+7F35
gyKowEbDYYOQwvToogtmf5cEwOO9N07OAG3x6PFiknE8hXfCrv8+XyHzDgs5o3Me
zyREVQcclh6c9DPlggoKBoayUbFZUNwLIvk4WtZaqRmhvrKDDuO17WFKFioo4cpv
rhEwpfYTDsbTAabl+5etA7gBpOeBBp+RM42ChQmHJkhcanq7Gbt136gTe4VMsLzB
F33h5xLf9ydqYiyNDNDRMTNomwRgNoFDT9IJ6lIg19kNFvhlIjL4XmrDvFG6pfd1
2V6G7oYvJ/PG7YjIY2roXIcdUEgrbYVWIE0ASAgmkK66LPtsuo+5yCHOPPDdJ3bR
OmQ9ummKgy0iyTkrwgbs
=ryUr
-----END PGP SIGNATURE-----

--AH+kv8CCoFf6qPuz--
