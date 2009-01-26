From: martin f krafft <madduck@madduck.net>
Subject: Re: [topgit] shared topic branch
Date: Mon, 26 Jan 2009 13:00:49 +0100
Message-ID: <20090126120049.GA9676@lapse.rw.madduck.net>
References: <EFB70468-7900-4B22-925D-3FC5F05F951B@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
To: Fabien Thomas <thomas.fabien@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 27 06:58:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRgxc-0004W2-WF
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 06:58:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbZA0F4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 00:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbZA0F4o
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 00:56:44 -0500
Received: from clegg.madduck.net ([193.242.105.96]:34088 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbZA0F4n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 00:56:43 -0500
Received: from lapse.rw.madduck.net (lapse.rw.madduck.net [IPv6:2001:41e0:ff3a::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id D83151D40B2;
	Tue, 27 Jan 2009 06:56:34 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 51C6780F4; Mon, 26 Jan 2009 13:00:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <EFB70468-7900-4B22-925D-3FC5F05F951B@gmail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux 5.0 kernel 2.6.27-1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8907/Tue Jan 27 03:40:54 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107313>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Fabien Thomas <thomas.fabien@gmail.com> [2008.12.18.2102 +0100]:
> I'm testing topgit 0.5 in a shared env. (multiple user working on same =
=20
> patch).

Sorry for the late reply!

> My problem is that when i want to push my local work i'm doing
> "git  push" that will force update the remote branch. The problem
> is that each time master is not up to date i will push my  entire
> master or topic branch to the remote.

I do not understand what you mean. Could yo please try to give us
more detail? git push is intended to push all local changes to the
remote, so I don't understand what your problem is.

> [remote "origin"]
[...]
> 	push =3D +refs/top-bases/*:refs/top-bases/*
> 	push =3D +refs/heads/*:refs/heads/*

Those two lines ensure that git pushes all local heads as well as
all top-bases.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
it may look like i'm just sitting here doing nothing.
but i'm really actively waiting
for all my problems to go away.
=20
spamtraps: madduck.bogus@madduck.net

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkl9pekACgkQIgvIgzMMSnXhWQCfb7bB9z/EHJMBlm0bEPl2fFyc
UOoAnjXl83kF1OV923xcbLDa1zoKrF8W
=/5AJ
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
