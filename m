From: Sebastian Harl <tokkee@debian.org>
Subject: Re: git push <branch-name>
Date: Wed, 6 Oct 2010 15:41:35 +0200
Message-ID: <20101006134135.GS26193@chough.tokkee.org>
References: <201010051811.49211.ComputerDruid@gmail.com> <AANLkTi=sDDXRKuHf93cZ4fSVpZFvgyB+k934qg7gDL9T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c8bPn4FL4u+7TADa"
Cc: Daniel Johnson <computerdruid@gmail.com>, git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 15:48:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3UMV-0001M4-FY
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 15:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758868Ab0JFNsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 09:48:42 -0400
Received: from mail.tokkee.net ([91.190.183.230]:47067 "EHLO mail.tokkee.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754917Ab0JFNsl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 09:48:41 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Oct 2010 09:48:41 EDT
Received: by mail.tokkee.net (Postfix, from userid 1000)
	id D761D7001C0; Wed,  6 Oct 2010 15:41:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=sDDXRKuHf93cZ4fSVpZFvgyB+k934qg7gDL9T@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158286>


--c8bPn4FL4u+7TADa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 05, 2010 at 03:28:56PM -0700, Eric Raible wrote:
> On Tue, Oct 5, 2010 at 3:11 PM, Daniel Johnson <computerdruid@gmail.com> =
wrote:
> > Isn't that syntax reserved for remotes?
> > for example:
> >
> > git push origin
> >
> > I feel like it would be a bad idea to have these 2 types of invocations
> > overlap in syntax like that.
>=20
> The idea is that given "git push <branch>" if <branch> is NOT a remote but
> IS a branch name then git could unambiguously provide the correct remote.
>=20
> Naturally if there's a branch and a remote of the same name then for back=
wards
> compatibility the remote would be chosen.

Please don't do that. Imho, this introduces too much magic in the
behavior of git-pull, making it less intuitive to understand and, thus
error-prone.

Cheers,
Sebastian

--=20
Sebastian "tokkee" Harl +++ GnuPG-ID: 0x8501C7FC +++ http://tokkee.org/

Those who would give up Essential Liberty to purchase a little Temporary
Safety, deserve neither Liberty nor Safety.         -- Benjamin Franklin


--c8bPn4FL4u+7TADa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkysfI8ACgkQEFEKc4UBx/wKuACfVGLG6sNXQLw9WovAhHxWfWWM
j4gAnAhAsRsWsAg2dxWAuBp8lchXi0JS
=x222
-----END PGP SIGNATURE-----

--c8bPn4FL4u+7TADa--
