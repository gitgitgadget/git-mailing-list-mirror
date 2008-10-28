From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 0/3] symref rename/delete fixes
Date: Wed, 29 Oct 2008 00:45:41 +0100
Message-ID: <20081028234541.GY24201@genesis.frugalware.org>
References: <20081027085055.GL2273@genesis.frugalware.org> <cover.1225136865.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wA9WyeW1yVBM2Q32"
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 00:47:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuyH4-0003JO-Ku
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 00:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbYJ1Xpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 19:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbYJ1Xpq
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 19:45:46 -0400
Received: from virgo.iok.hu ([193.202.89.103]:51800 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267AbYJ1Xpp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 19:45:45 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 70960580EE;
	Wed, 29 Oct 2008 00:45:44 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id C18DB4465E;
	Wed, 29 Oct 2008 00:45:41 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 80776119019E; Wed, 29 Oct 2008 00:45:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <cover.1225136865.git.vmiklos@frugalware.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99333>


--wA9WyeW1yVBM2Q32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2008 at 08:50:19PM +0100, Miklos Vajna <vmiklos@frugalware.=
org> wrote:
> Here they are. The first is updated: the delete_ref() part is unchanged,
> but the rename_ref() part is dropped and it just bails out with an error
> if it detects a symref. The testcase is updated according to this as
> well.
>=20
> The two others are just rebased on top of the new first one, no
> functional changes.

I forgot to fetch and did not notice the previous round is already in
'next'. Just forget about these patches then, I'll rebase the relevant
part against mv/maint-branch-m-symref and resend.

--wA9WyeW1yVBM2Q32
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkHpCUACgkQe81tAgORUJYrnACgh+PO3H1VaxkUNW8AVOwy/l43
sV0AniHW73HUMAgFkGfGMuJuSFpzCbpd
=BHbJ
-----END PGP SIGNATURE-----

--wA9WyeW1yVBM2Q32--
