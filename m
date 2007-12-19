From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Git-to-svn convert
Date: Thu, 20 Dec 2007 00:16:43 +0100
Message-ID: <20071219231643.GB7378@genesis.frugalware.org>
References: <476997C1.2080506@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Harning <harningt@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 00:17:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J58AA-0000Ca-4I
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 00:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758120AbXLSXQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 18:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757656AbXLSXQr
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 18:16:47 -0500
Received: from virgo.iok.hu ([193.202.89.103]:16142 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757647AbXLSXQq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 18:16:46 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E38F21B24FB;
	Thu, 20 Dec 2007 00:16:44 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 55F8A4465C;
	Thu, 20 Dec 2007 00:15:26 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 106F3119019C; Thu, 20 Dec 2007 00:16:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <476997C1.2080506@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68952>


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 19, 2007 at 05:14:25PM -0500, Thomas Harning <harningt@gmail.co=
m> wrote:
> Example of what I mean...:
>=20
> a - b -
> `c'
>=20
>=20
> As to how to pull the repository into subversion.. how would I do that?
> git-svn init ?

i think you have two options:

- use some 3rd-party tool like tailor

- first you should rewrite your history by creating a linear history
  then git-svn can dcommit your changes to svn

- VMiklos

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHaaZbe81tAgORUJYRAthhAJ4zrpNP+xC5x4hGkjMPevPjbc2zMQCeMs+l
O+PzQz6LLPmvOZB5yWVhLHQ=
=ZOwQ
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
