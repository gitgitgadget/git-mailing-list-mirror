From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH Cogito] cg-init breaks if . contains sub-dir
Date: Tue, 10 May 2005 10:56:04 +0200
Message-ID: <20050510085604.GV3562@admingilde.org>
References: <20050509233904.GB878@osuosl.org> <pan.2005.05.10.03.41.15.683163@smurf.noris.de> <428043EB.7010004@didntduck.org> <20050510075227.GA8176@lug-owl.de> <20050510080445.GB8176@lug-owl.de> <20050510083609.GF11221@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7jXYzuaWN+k1iCx7"
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
	Brian Gerst <bgerst@didntduck.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 10:49:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVQQb-0002BO-AC
	for gcvg-git@gmane.org; Tue, 10 May 2005 10:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVEJI4k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 04:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVEJI4k
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 04:56:40 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:437 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261588AbVEJI4d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 04:56:33 -0400
Received: from faui31y.informatik.uni-erlangen.de (mnwaitz@faui31y [131.188.33.40])
	by faui3es.informatik.uni-erlangen.de (8.13.4/8.13.4/Debian-1) with ESMTP id j4A8u9MM003301;
	Tue, 10 May 2005 10:56:09 +0200
Received: (from mnwaitz@localhost)
	by faui31y.informatik.uni-erlangen.de (8.13.4/8.13.4/Submit) id j4A8u4Mv003291;
	Tue, 10 May 2005 10:56:04 +0200
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <20050510083609.GF11221@kiste.smurf.noris.de>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--7jXYzuaWN+k1iCx7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, May 10, 2005 at 10:36:09AM +0200, Matthias Urlichs wrote:
> Jan-Benedict Glaw:
> > > 	find * \( -type f -o tyle l \) -print0 | ...
> >=20
> > Btw, this won't find dot files, so using "." as the path list (instead
> > of "*") might be wise...
> >=20
> git doesn't want to handle dot files anyway.

but find will output dotfiles in subdirectories.
So you have to prune the list anyway.

--=20
Martin Waitz

--7jXYzuaWN+k1iCx7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFCgHckj/Eaxd/oD7IRApkkAKCDvg5kr9DcfNavIxUgQZPfyBilGACfdZiZ
D5xGcAtoz0h8bs3ANtC+WuM=
=uaQz
-----END PGP SIGNATURE-----

--7jXYzuaWN+k1iCx7--
