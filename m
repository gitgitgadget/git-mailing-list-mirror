From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: How to ignore changes on remote
Date: Tue, 23 Mar 2010 15:07:15 +0100
Message-ID: <1269353235.14299.0.camel@kheops>
References: <26ae428a1003230654m50c35caci4a02e2df321f289c@mail.gmail.com>
Reply-To: sylvain@abstraction.fr
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-MEyoer80+iWxob+KME6o"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 23 15:07:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu4la-0002B5-CD
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 15:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670Ab0CWOH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 10:07:29 -0400
Received: from lo.gmane.org ([80.91.229.12]:41397 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753562Ab0CWOH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 10:07:29 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nu4lS-00026A-N0
	for git@vger.kernel.org; Tue, 23 Mar 2010 15:07:26 +0100
Received: from smj33-1-82-233-66-33.fbx.proxad.net ([82.233.66.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 15:07:26 +0100
Received: from sylvain by smj33-1-82-233-66-33.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 15:07:26 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: smj33-1-82-233-66-33.fbx.proxad.net
In-Reply-To: <26ae428a1003230654m50c35caci4a02e2df321f289c@mail.gmail.com>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143016>


--=-MEyoer80+iWxob+KME6o
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-03-23 at 13:54 +0000, Howard Miller wrote:
> My remote branch has changes that are not fast forward (I forgot to
> merge). I have now made incompatible changes on my local branch. I
> simply want to use the local version and push it to the remote. I
> don't care about the remote version. I don't want to merge as there'll
> be loads of conflicts and the answer will always be 'use the local
> one'. Is there an easy way to do this? I can't think of anything.
>=20
> Cheers!

git push origin +local_branch:remote_branch

--=20
Sylvain Rabot <sylvain@abstraction.fr>

--=-MEyoer80+iWxob+KME6o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkuoywwACgkQ+TklUoyVcyf7twCff1pFz2nytWB0iNcnEWggCUZq
FLsAnRMsNhdD+XR9DSwRLd9CfsS62I2l
=NqUY
-----END PGP SIGNATURE-----

--=-MEyoer80+iWxob+KME6o--
