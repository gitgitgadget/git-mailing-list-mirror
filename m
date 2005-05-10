From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH Cogito] cg-init breaks if . contains sub-dir
Date: Tue, 10 May 2005 11:58:25 +0200
Message-ID: <20050510095825.GI11221@kiste.smurf.noris.de>
References: <20050509233904.GB878@osuosl.org> <pan.2005.05.10.03.41.15.683163@smurf.noris.de> <428043EB.7010004@didntduck.org> <20050510075227.GA8176@lug-owl.de> <20050510080445.GB8176@lug-owl.de> <7vis1rpi8a.fsf@assigned-by-dhcp.cox.net> <20050510093212.GD8176@lug-owl.de> <20050510093924.GH11221@kiste.smurf.noris.de> <20050510094538.GE8176@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HCdXmnRlPgeNBad2"
Cc: Junio C Hamano <junkio@cox.net>,
	Brian Gerst <bgerst@didntduck.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 11:54:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVRQN-0002kE-5v
	for gcvg-git@gmane.org; Tue, 10 May 2005 11:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVEJKAG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 06:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVEJKAG
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 06:00:06 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:33461 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261600AbVEJJ7c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 05:59:32 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DVRVR-0008PT-BD; Tue, 10 May 2005 11:58:40 +0200
Received: (nullmailer pid 6157 invoked by uid 501);
	Tue, 10 May 2005 09:58:25 -0000
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Content-Disposition: inline
In-Reply-To: <20050510094538.GE8176@lug-owl.de>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--HCdXmnRlPgeNBad2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Jan-Benedict Glaw:
> > Please don't change that without talking to Linus.
>=20
> I won't.  You haven't seen a patch from me "fixing" this, too.  *I*
> consider this as a defect, but that doesn't mean that I'll force others
> to take this view, too.  But maybe I'll talk Linus into this when he's
> back from his trip.

That would be a good idea; I do support dropping (or at least relaxing)
that rule. For excluding unwanted files, I'd suggest using a .git/ignore
file with nice shiny patterns (*.a *.o *.swp ...) inside -- git already
supports that anyway.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de

--HCdXmnRlPgeNBad2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCgIXB8+hUANcKr/kRAoCtAKCp0qZ3THoeSYd5BxrGWeHg6hpp5QCeKvH4
FJ+8ETZAgLAlAYirRFQyk3k=
=se5p
-----END PGP SIGNATURE-----

--HCdXmnRlPgeNBad2--
