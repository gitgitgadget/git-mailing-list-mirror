From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: See commits on remote repository
Date: Thu, 29 Apr 2010 00:54:55 +0200
Message-ID: <1272495295.3021.84.camel@kheops>
References: <n2v3f81a4241004281535h30d35f5cw5f33e265d19d35b6@mail.gmail.com>
Reply-To: sylvain@abstraction.fr
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-gBKblU4aDGHFZaGtvRR9"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 29 01:00:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7GF3-0008KF-Af
	for gcvg-git-2@lo.gmane.org; Thu, 29 Apr 2010 01:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757163Ab0D1XAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 19:00:11 -0400
Received: from lo.gmane.org ([80.91.229.12]:47814 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900Ab0D1XAK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 19:00:10 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O7GEd-00089l-AR
	for git@vger.kernel.org; Thu, 29 Apr 2010 01:00:03 +0200
Received: from smj33-1-82-233-66-33.fbx.proxad.net ([82.233.66.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Apr 2010 01:00:03 +0200
Received: from sylvain by smj33-1-82-233-66-33.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Apr 2010 01:00:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: smj33-1-82-233-66-33.fbx.proxad.net
In-Reply-To: <n2v3f81a4241004281535h30d35f5cw5f33e265d19d35b6@mail.gmail.com>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146018>


--=-gBKblU4aDGHFZaGtvRR9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-04-28 at 16:35 -0600, Bryan Richardson wrote:
> Hello All,
>=20
> Sorry if this question has been asked already. This mailing list is
> crazy active, and even after searching I couldn't find anything.
>=20
> Is it possible to show commits to a remote repository that was created
> as a clone of a local repository, similar to how GitHub lets users
> view commits made to forked projects in a project's network?
>=20
> For example, say I have repository X, which I do a bare clone on to
> create repository Y for someone else to work on (effectively forking
> repo X). Is there a way for me to see, from repository X, what commits
> have been made to repository Y?
>=20
> --
> Thanks!
> Bryan

Hi,

$ git remote update
$ git log origin/<branch>
$ gitk origin/<branch>

Regards.


--=20
Sylvain Rabot <sylvain@abstraction.fr>

--=-gBKblU4aDGHFZaGtvRR9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkvYvLsACgkQ+TklUoyVcyd7ZwCgnP+FVr7XU5OSs3JqidLO1sVk
BGAAn2NPhG6cxn+RHRRkizZ8eV3QYFV2
=011r
-----END PGP SIGNATURE-----

--=-gBKblU4aDGHFZaGtvRR9--
