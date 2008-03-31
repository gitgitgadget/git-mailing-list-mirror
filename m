From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] git gc --auto: defer on battery
Date: Mon, 31 Mar 2008 19:38:02 +0200
Message-ID: <20080331173801.GD10018@genesis.frugalware.org>
References: <20080330231408.GR11666@genesis> <47F11036.1000809@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Mar 31 19:38:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgNy9-0007CF-MH
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 19:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbYCaRiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 13:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753144AbYCaRiJ
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 13:38:09 -0400
Received: from virgo.iok.hu ([193.202.89.103]:13234 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753745AbYCaRiI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 13:38:08 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id C36311B2505;
	Mon, 31 Mar 2008 19:38:04 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 23BCC446A3;
	Mon, 31 Mar 2008 19:34:53 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 242521190A11; Mon, 31 Mar 2008 19:38:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <47F11036.1000809@nrlssc.navy.mil>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78594>


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2008 at 11:24:22AM -0500, Brandon Casey <casey@nrlssc.navy.=
mil> wrote:
> Miklos Vajna wrote:
> > This patch modifies git gc --auto so that it will not always repack when
> > a user is on battery.
> >=20
> > It introduces the new gc.deferonbattery configuration variable,
>=20
> Shouldn't the config option have 'auto' in the name? Or in some way convey
> that this is _only_ about deferring automatic gc'ing?

That makes sense. Though this patch isn't OK, see my other patch series
in this thread (the pre-auto-gc hook has no config name).

--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkfxIXkACgkQe81tAgORUJai+gCfXk+b8AKUXFNvawCrPRHwL9aZ
RsUAnRYggKmI7Slzxs22BbuD6rATEYsH
=hRpb
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--
