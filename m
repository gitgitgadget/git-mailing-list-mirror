From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-fast-export and tags without a tagger
Date: Thu, 18 Dec 2008 22:36:09 +0100
Message-ID: <20081218213609.GY5691@genesis.frugalware.org>
References: <20081218164614.GS5691@genesis.frugalware.org> <7vbpv9guqd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fqI+47YoL7hbVrTK"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, scott@canonical.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 22:37:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDQYt-0000eh-8L
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 22:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbYLRVgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 16:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753214AbYLRVgO
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 16:36:14 -0500
Received: from virgo.iok.hu ([212.40.97.103]:46116 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753151AbYLRVgN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 16:36:13 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E7346580A6;
	Thu, 18 Dec 2008 22:36:11 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id D7CFC4465E;
	Thu, 18 Dec 2008 22:36:11 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id BD89D11B862F; Thu, 18 Dec 2008 22:36:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vbpv9guqd.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103496>


--fqI+47YoL7hbVrTK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2008 at 11:15:54AM -0800, Junio C Hamano <gitster@pobox.com=
> wrote:
> Is "fast-export" the only thing that chokes on these tags?
>=20
> What I am worried about is if we have accidentally/stupidly/by mistake
> made other codepaths that check the validity of a tag object too strict,
> which would result things like "git show $such_a_tag" to barf.

git show works fine on the tag. git fsck --full passes without any
warning/error as well, so I don't think we have to worry about that.

--fqI+47YoL7hbVrTK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklKwkkACgkQe81tAgORUJYNdwCfQIGN+KCSCdMk0y1mz0W5kBrZ
5SEAnjoaXpccp4Tp/Z7mKt3Vfj4ukr+d
=dOV7
-----END PGP SIGNATURE-----

--fqI+47YoL7hbVrTK--
