From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH v2] maint: check return of split_cmdline to avoid bad
	config strings
Date: Thu, 25 Sep 2008 00:32:52 +0200
Message-ID: <20080924223252.GL23137@genesis.frugalware.org>
References: <20080924061028.GA2792@riemann.deskinm.fdns.net> <20080924092847.GD23137@genesis.frugalware.org> <20080924145029.GA3052@riemann.deskinm.fdns.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7lMq7vMTJT4tNk0a"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Thu Sep 25 00:34:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kicvx-0005BX-CB
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 00:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbYIXWc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 18:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbYIXWc5
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 18:32:57 -0400
Received: from virgo.iok.hu ([193.202.89.103]:55462 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbYIXWc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 18:32:56 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 4E5F21B2510;
	Thu, 25 Sep 2008 00:32:55 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id EE2F24465E;
	Thu, 25 Sep 2008 00:32:52 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id AB0FA11901A1; Thu, 25 Sep 2008 00:32:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080924145029.GA3052@riemann.deskinm.fdns.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96705>


--7lMq7vMTJT4tNk0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2008 at 10:50:29AM -0400, Deskin Miller <deskinm@umich.edu>=
 wrote:
> As the testcase demonstrates, it's possible for split_cmdline to return -=
1 and
> deallocate any memory it's allocated, if the config string is missing an =
end
> quote.  In both the cases below, which are the only calling sites, the re=
turn
> isn't checked, and using the pointer causes a pretty immediate segfault.
>=20
> Signed-off-by: Deskin Miller <deskinm@umich.edu>

Acked-by: Miklos Vajna <vmiklos@frugalware.org>

Thanks.

--7lMq7vMTJT4tNk0a
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjawBQACgkQe81tAgORUJZYoACdEXAfVGGseRXMJD5X0+g9lWh9
b3MAniyPADmGamFLEXGtkT9BDvdhVWdS
=xYN3
-----END PGP SIGNATURE-----

--7lMq7vMTJT4tNk0a--
