From: Christian Weiske <cweiske@cweiske.de>
Subject: Re: git svn clone clone php/pear/Net_LDAP2 misses tags and branches
Date: Sun, 25 Oct 2015 19:48:51 +0100
Message-ID: <20151025194851.793f8c64@bogo>
References: <20151025154325.36eddb4c@bogo>
	<CAOc6etYvzv+MFyTXk0zU673b1GypyUbTOuiVyS35PS4ROFHztg@mail.gmail.com>
	<20151025173033.28346d49@bogo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/TSSKIN8aelLu=0eMjfRhOYs"; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 19:49:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqQMU-0006m4-OA
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 19:49:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbbJYSs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 14:48:57 -0400
Received: from cweiske.de ([5.35.241.22]:58201 "EHLO mail.cweiske.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751579AbbJYSs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 14:48:57 -0400
Received: by mail.cweiske.de (Postfix, from userid 65534)
	id 32D152E571C; Sun, 25 Oct 2015 19:48:52 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on ahso2
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from bogo (p5B09EA9E.dip0.t-ipconnect.de [91.9.234.158])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by mail.cweiske.de (Postfix) with ESMTPSA id A07DA2E5434;
	Sun, 25 Oct 2015 19:48:51 +0100 (CET)
In-Reply-To: <20151025173033.28346d49@bogo>
X-Mailer: Claws Mail 3.10.1 (GTK+ 2.24.27; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280163>

--Sig_/TSSKIN8aelLu=0eMjfRhOYs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Christian,


> > Did you try with -r revision-number:HEAD?
>=20
> Good idea. I tried it, and now I have the tags and branches:

Unfortunately, the tag branches only have a single commit and have no
relation to the trunk branch:

$ git log --oneline origin/tags/Net_LDAP2-2.0.12
0bc9db1 Tagging the 2.0.12 release
$

What can I do against that?

--=20
Regards/Mit freundlichen Gr=C3=BC=C3=9Fen
Christian Weiske

-=3D=E2=89=A1 Geeking around in the name of science since 1982 =E2=89=A1=3D-

--Sig_/TSSKIN8aelLu=0eMjfRhOYs
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlYtJBMACgkQFMhaCCTq+CO0nwCdEGePSr/GG+9H5fZ0tXUw6Zzf
t58Anix9l0HRRzOiJSVhzhXJT/m622Sy
=RExw
-----END PGP SIGNATURE-----

--Sig_/TSSKIN8aelLu=0eMjfRhOYs--
