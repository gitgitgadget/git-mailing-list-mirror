From: Christian Weiske <cweiske@cweiske.de>
Subject: Re: git svn clone clone php/pear/Net_LDAP2 misses tags and branches
Date: Sun, 25 Oct 2015 17:30:33 +0100
Message-ID: <20151025173033.28346d49@bogo>
References: <20151025154325.36eddb4c@bogo>
	<CAOc6etYvzv+MFyTXk0zU673b1GypyUbTOuiVyS35PS4ROFHztg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/08Ehfft=V=0ZL82yNn/9ZOX"; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 17:30:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqOC0-000720-Fm
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 17:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbbJYQaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 12:30:39 -0400
Received: from cweiske.de ([5.35.241.22]:37902 "EHLO mail.cweiske.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751794AbbJYQaj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 12:30:39 -0400
Received: by mail.cweiske.de (Postfix, from userid 65534)
	id 561622E570D; Sun, 25 Oct 2015 17:30:37 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on ahso2
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	URIBL_BLOCKED autolearn=unavailable version=3.3.2
Received: from bogo (p5B09EA9E.dip0.t-ipconnect.de [91.9.234.158])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by mail.cweiske.de (Postfix) with ESMTPSA id CCF6D2E567F;
	Sun, 25 Oct 2015 17:30:35 +0100 (CET)
In-Reply-To: <CAOc6etYvzv+MFyTXk0zU673b1GypyUbTOuiVyS35PS4ROFHztg@mail.gmail.com>
X-Mailer: Claws Mail 3.10.1 (GTK+ 2.24.27; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280158>

--Sig_/08Ehfft=V=0ZL82yNn/9ZOX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Edmundo,


> Using -r single-revision-number (against tha same repo), I was not
> able to pull much (on that revision only the standard layout was set
> up so nothing would come out for git)

It's actually the standard layout here; I only used the single
parameters to rule out problems with --stdlayout.


> Did you try with -r revision-number:HEAD?

Good idea. I tried it, and now I have the tags and branches:

$ git svn clone --stdlayout
  https://svn.php.net/repository/pear/packages/Net_LDAP2
  -r 255346:HEAD
...

$ cd Net_LDAP2
$ git br -a
* master
  remotes/origin/implementingPagedSearches_PHP5.4
  remotes/origin/tags/Net_LDAP2-2.0.10
  remotes/origin/tags/Net_LDAP2-2.0.12
...
  remotes/origin/trunk

Thanks!


Is there a way to convert the tags branches into real tags
automatically?


--=20
Regards/Mit freundlichen Gr=C3=BC=C3=9Fen
Christian Weiske

-=3D=E2=89=A1 Geeking around in the name of science since 1982 =E2=89=A1=3D-

--Sig_/08Ehfft=V=0ZL82yNn/9ZOX
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlYtA6kACgkQFMhaCCTq+CNYNQCgmgPv2t3AAf7XSO16u0nHdie3
JysAnRDgSvBWIQOEGTt6qRWNciqK33Sf
=Rj/k
-----END PGP SIGNATURE-----

--Sig_/08Ehfft=V=0ZL82yNn/9ZOX--
