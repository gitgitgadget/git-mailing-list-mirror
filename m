From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 12/13] Build in merge
Date: Fri, 27 Jun 2008 15:01:48 +0200
Message-ID: <20080627130148.GL29404@genesis.frugalware.org>
References: <cover.1214066798.git.vmiklos@frugalware.org> <0b7ea424b3d5ea18a5a8660c6aead51adcc6a40f.1214066799.git.vmiklos@frugalware.org> <57d8a308fae0012174ed4388baccf1bde8515f2f.1214066799.git.vmiklos@frugalware.org> <5cae08d3bf2852a8bbd8dc8cdf741cb4bdfa237e.1214066799.git.vmiklos@frugalware.org> <d5d80c5a068c76810edfa9c0c68de500f02780a0.1214066799.git.vmiklos@frugalware.org> <486270D5.5050204@free.fr> <20080627010609.GJ29404@genesis.frugalware.org> <alpine.DEB.1.00.0806271255240.9925@racer>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gOA5A3xDLQTKni8K"
Cc: Olivier Marin <dkr+ml.git@free.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 27 15:03:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCDbR-0005Dv-KL
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 15:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000AbYF0NBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 09:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753682AbYF0NBv
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 09:01:51 -0400
Received: from virgo.iok.hu ([193.202.89.103]:36042 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753609AbYF0NBu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 09:01:50 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 26E4C1B250E;
	Fri, 27 Jun 2008 15:01:49 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id BB13244668;
	Fri, 27 Jun 2008 14:35:14 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 00A861778012; Fri, 27 Jun 2008 15:01:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806271255240.9925@racer>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86552>


--gOA5A3xDLQTKni8K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2008 at 12:56:02PM +0100, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> > +		char hex[41];
> > +
> > +		memcpy(hex, find_unique_abbrev(head, DEFAULT_ABBREV), 41);
>=20
> Maybe strcpy(hex, find_unique_abbrev(head, DEFAULT_ABBREV)) would be more=
=20
> intuitive?

Ah yes. Changed.

Thanks.

--gOA5A3xDLQTKni8K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhk5LwACgkQe81tAgORUJZpWgCcCqjVqqBVKp6TmAt09Rkd44oL
SicAnicDsqzw8G3bpuai7IbTe+NjcM8a
=QWf6
-----END PGP SIGNATURE-----

--gOA5A3xDLQTKni8K--
