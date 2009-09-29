From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-diff/git-diff-files: Turn off copy-detection?
Date: Tue, 29 Sep 2009 15:42:41 +0200
Message-ID: <20090929134241.GL32702@genesis.frugalware.org>
References: <4AC20286.6020108@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CZI63rpYmK/igF6U"
Cc: Git Mailing List <git@vger.kernel.org>
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 15:42:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mscye-0001Kt-FQ
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 15:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbZI2Nmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 09:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbZI2Nmj
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 09:42:39 -0400
Received: from virgo.iok.hu ([212.40.97.103]:38774 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434AbZI2Nmj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 09:42:39 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id CFA5E5808B;
	Tue, 29 Sep 2009 15:42:41 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 92B684490F;
	Tue, 29 Sep 2009 15:42:41 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id B2DDF11F0028; Tue, 29 Sep 2009 15:42:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4AC20286.6020108@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129301>


--CZI63rpYmK/igF6U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2009 at 02:50:14PM +0200, Marius Storm-Olsen <mstormo@gmail=
=2Ecom> wrote:
> So, not even related. They should really had shown up as new files,=20
> IMO. (I guess git stores the creation of the file as a delta of the=20
> indicated 'copy', but in this case I don't care about that :)

No, it does not (as long as we are not talking about packfiles). AFAIK
copy detection is disabled by default, so probably you have a setting
that enables it for you and you forgot about it. Are you sure you don't
have any settings like diff.renames =3D copies?

--CZI63rpYmK/igF6U
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrCDtEACgkQe81tAgORUJa+pACdHQBU1P6eAlC/KDiOHDho9eLB
GfIAoIAZeWC1ZcFtrizOnpOHaFDgRgIa
=SCKc
-----END PGP SIGNATURE-----

--CZI63rpYmK/igF6U--
