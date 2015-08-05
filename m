From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [bug report] Signing your work: GnuPG signing failed (gpg
 version 2.1)
Date: Wed, 5 Aug 2015 22:55:38 +0000
Message-ID: <20150805225538.GE581651@vauxhall.crustytoothpaste.net>
References: <20150805203545.GD4325@xps>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0hHDr/TIsw4o3iPK"
Cc: git@vger.kernel.org
To: Hugo Roy <hugo@fsfe.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 00:55:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN7bB-0002Y6-2G
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 00:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776AbbHEWzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 18:55:44 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:39612 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751482AbbHEWzn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2015 18:55:43 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6DAF02808D;
	Wed,  5 Aug 2015 22:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1438815342;
	bh=X7yEG2RrzfUE0GW4wLXTgzSZkgZKxgL2G/SSe44gRpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vQVcTmX1niUViNTp7069PtMDFrhNOvAERI4TaHHXR/2wvf0lkpcINiew/ND9kEIen
	 gAxF3aP2DFGX+A7c6X8GdCmcbCIPNqCzMOF8jK/Vt5nKwdwb+OMBbqtnUQTw1sNP95
	 QUVe13h5oN3XqbJjvJyzty7D3IY9sdpEmJnSzCf/D8sA0UAgVqkVX44vusZmawt16E
	 pEjpZsCOKFZp5oDxObCMm1o0DNSG0BbPDDFyHXv6o//KQvFv40gfj0UBnK2JwYxvNs
	 NV0UHYbCjsQ3ydf9EMyLRzBZegyQjzuaEmxBQGO6SnTyS4ZdGFUeefdSCFpuadHNNB
	 8ye1QiH80j5zZqCa6HzvX3tJtGjK+J+DxhdSrItN4hAO+6pvY/mjkmkPXJ9kSfZxxv
	 K4nmjsEpYvaTldOAl5rEyFtj3Hljjgzf9X9VBxjA9vlydVIePhf6AilOA/K1oAOfFm
	 KE7qxuzbB1NnYCHK9c/zYfISpGz7AwBi4aN3WW0YqnNso7CyAPm
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Hugo Roy <hugo@fsfe.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20150805203545.GD4325@xps>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.0.0-2-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275407>


--0hHDr/TIsw4o3iPK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2015 at 10:35:45PM +0200, Hugo Roy wrote:
>=20
> Hello,
>=20
> I've tried to sign a commit following
> https://git-scm.com/book/tr/v2/Git-Tools-Signing-Your-Work however,
> this is what happened:
>=20
>     % git commit -a -S -m "signed commit testing"
>     gpg: =C3=A9chec de la signature : Op=C3=A9ration annul=C3=A9e
>     gpg: signing failed: Op=C3=A9ration annul=C3=A9e
>     error: gpg n'a pas pu signer les donn=C3=A9es
>     fatal: =C3=A9chec de l'=C3=A9criture de l'objet commit
>=20
> sorry for the locale, "annul=C3=A9e" means cancelled and the last two
> lines mean:
>=20
>     error: gpg could not sign data
>     fatal: failure to write the commit object
>=20
> However, when I tried later, nothing specific happened and the commit
> was done just as if I did not add the -S option:
>=20
>     % git commit -a -S -m "signed commit test"
>     [master 739cdd3] signed commit test
>     1 file changed, 5 deletions(-)
>=20
> Commit:
> https://github.com/hugoroy/.emacs.d/commit/b8e5b72def0c5fcc760c84d6ecd2b9=
5b9727ae62
>=20
>=20
>=20
> I notice in the git-scm.com manual that they use GnuPG version 1. I
> use GnuPG 2.1.6 with libgcrypt 1.6.3.

I believe this is a bug in GnuPG 2.1 or the relevant pinentry.  Debian
bug #793016[0] describes my experience with it.  Killing the gpg-agent
when this occurs and letting it respawn works for me.  I'm very certain
that this is not a bug in Git, though.

GnuPG 2.1 provides the same command line interface as GnuPG 1, so it
will work the same way with git.  Failing to sign is a GnuPG problem,
not a Git problem.

[0] https://bugs.debian.org/790316
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--0hHDr/TIsw4o3iPK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.6 (GNU/Linux)

iQIcBAEBCgAGBQJVwpRqAAoJEL9TXYEfUvaLiYEP/R3RYqouGRXHq7XjELj7nxMu
xqQGFDiGLhfBgzX+FX3ueHj9AJ9k0V/Xi6odSnfmRPe7T6hMLsVip1LaJbppcssA
FAqlz5dHNVzOmCWzCZd0wkQ+rHf+EZknSq5BdGLyMooRUR09K02XH9m7uRcHyTTD
Lrhe5iM23Y5iabBUGIeMePRETR3UEVU4Upb4RVMVkTIODG6RRaV+vAJQjVONAMtR
1vDpH8pIY3z1/vdswTJzm8YlzPKeVEdwRYE/8buoObciG3bIhgX5r6UccdXIqHTU
271OuCOze1YdnURG7N0hsRzMrNV+v/18/McFwOIA4YXqEmlC04vau8E7cBiA43Bm
JyluOfhK3B32aeUe6hYebL8kC+Y4yFuE6VTfzRsKzme9+1EQzD+dR/yF88CGX/fK
DMQzmJX6KkudtgcYxSpCtB2JPHHzinUMCkX37qwwJKRMBCUS9ThnF40B9x6ldr5Y
KnVB81N426J6Gp4XvUWMZ+nI36U62AlJk1A62+CRKH/Ls4v1IZ8jLP8aJCaj5vjh
PDYmTwJGWbvX8k7vaUg5iiPNkP4t2dC+uVqEXGO0ue71xPYyIf61wZbcB4Ng44Z1
8sEIajkdr0V2XTjrUHYJlMmLv4cmmOkZoi1TyB1YOSAs4aOdIR6PNk6S5gtOQ2Tk
nCC77BPMrJz2NZNmrYsK
=GN/E
-----END PGP SIGNATURE-----

--0hHDr/TIsw4o3iPK--
