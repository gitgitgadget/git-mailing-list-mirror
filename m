From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: How to ignore changes on remote
Date: Tue, 23 Mar 2010 15:25:27 +0100
Message-ID: <1269354326.14299.7.camel@kheops>
References: <26ae428a1003230654m50c35caci4a02e2df321f289c@mail.gmail.com>
	 <1269353235.14299.0.camel@kheops>
	 <26ae428a1003230713y12f0c74dh3b22c0d97565159b@mail.gmail.com>
Reply-To: sylvain@abstraction.fr
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-1MopLmjdx080NM67M5Dc"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 23 15:27:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu553-0006Pe-3G
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 15:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846Ab0CWOZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 10:25:40 -0400
Received: from lo.gmane.org ([80.91.229.12]:36066 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752192Ab0CWOZj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 10:25:39 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nu533-00050H-Bm
	for git@vger.kernel.org; Tue, 23 Mar 2010 15:25:37 +0100
Received: from smj33-1-82-233-66-33.fbx.proxad.net ([82.233.66.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 15:25:37 +0100
Received: from sylvain by smj33-1-82-233-66-33.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 15:25:37 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: smj33-1-82-233-66-33.fbx.proxad.net
In-Reply-To: <26ae428a1003230713y12f0c74dh3b22c0d97565159b@mail.gmail.com>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143020>


--=-1MopLmjdx080NM67M5Dc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-03-23 at 14:13 +0000, Howard Miller wrote:
> >
> > git push origin +local_branch:remote_branch
> >
>=20
> Thanks!
>=20
> Tell me more about that '+'. I've never heard of it before. Can't see
> anything in the docs (although I'm probably not looking in the right
> place)

http://kernel.org/pub/software/scm/git/docs/git-push.html

the '+' means that you want to bypass the security which does not allow
non fast-forward pushes.

Note that you shouldn't do non fast-forward pushes to a repository which
can be cloned by other people than you. Once published (accessible to
anybody) you should do a merge and then push to origin even if you only
take your local history in the merge to avoid user pulling from origin
conflicts due to the non fast forward history.

Regards.

--=20
Sylvain Rabot <sylvain@abstraction.fr>

--=-1MopLmjdx080NM67M5Dc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkuoz1YACgkQ+TklUoyVcycPRwCfYH3RzkD27Smdpvle27q4Q5WT
XMYAnioS74LYbrqDZ1d6ZmhcuaSmT1mJ
=OLxw
-----END PGP SIGNATURE-----

--=-1MopLmjdx080NM67M5Dc--
