From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Potentially dangerous behavior of git gc
Date: Mon, 19 Oct 2009 13:21:53 +0200
Message-ID: <20091019112153.GX6115@genesis.frugalware.org>
References: <loom.20091019T095725-840@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GOaLjq+VdFesH+wR"
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 13:22:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzqJL-0000jj-Fd
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 13:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756019AbZJSLVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 07:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755998AbZJSLVt
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 07:21:49 -0400
Received: from virgo.iok.hu ([212.40.97.103]:56909 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755141AbZJSLVt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 07:21:49 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E936F5809B;
	Mon, 19 Oct 2009 13:21:52 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id D8F9F44928;
	Mon, 19 Oct 2009 13:21:52 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 2FC7D11F002B; Mon, 19 Oct 2009 13:21:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <loom.20091019T095725-840@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130690>


--GOaLjq+VdFesH+wR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2009 at 08:04:58AM +0000, Sergio Callegari <sergio.callegar=
i@gmail.com> wrote:
> With this when the alternate info of A is finally updated, A is broken, m=
issing
> many references and not having a head anymore.
>=20
> Would it be better to have git gc not to take dangerous actions on potent=
ially
> problematic repos?

Such repos are usually created using git clone -s. See the NOTE of the
manpage under the -s option, probably you want to use git repack -a
after git clone.

--GOaLjq+VdFesH+wR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrcS9EACgkQe81tAgORUJblNwCgolpLa2PgF1b48Qq3AxuabY7v
MeoAnAz3OxBVeMdzt1pgv6FkkHjsVAIO
=Fbrv
-----END PGP SIGNATURE-----

--GOaLjq+VdFesH+wR--
