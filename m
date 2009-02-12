From: martin f krafft <madduck@debian.org>
Subject: Re: [topgit] tg update error
Date: Thu, 12 Feb 2009 22:01:35 +0100
Organization: The Debian project
Message-ID: <20090212210135.GA24687@piper.oerlikon.madduck.net>
References: <cc723f590902120009w432f5f61xd6550409835cdbb7@mail.gmail.com> <20090212084811.GA14261@piper.oerlikon.madduck.net> <20090212092558.GB21074@skywalker> <20090212125621.GB5397@sigill.intra.peff.net> <20090212125946.GC5397@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
To: Jeff King <peff@peff.net>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Aneesh Kumar <aneesh.kumar@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	pasky@suse.cz
X-From: git-owner@vger.kernel.org Thu Feb 12 22:03:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXiiZ-0007vz-KS
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 22:03:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758815AbZBLVCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 16:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758802AbZBLVCA
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 16:02:00 -0500
Received: from clegg.madduck.net ([193.242.105.96]:37572 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758227AbZBLVCA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 16:02:00 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 6DC4B1D409B;
	Thu, 12 Feb 2009 22:01:37 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTPS id C16239F13D;
	Thu, 12 Feb 2009 22:01:35 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 656F94463; Thu, 12 Feb 2009 22:01:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090212125946.GC5397@sigill.intra.peff.net>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux 5.0 kernel 2.6.26-1-amd64 x86_64
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8984/Thu Feb 12 15:24:21 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109651>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Jeff King <peff@peff.net> [2009.02.12.1359 +0100]:
> > So what I suspect is happening is that topgit is trying to set HEAD to
> > "refs/top-bases/whatever". Aneesh, can you confirm by running your test
> > with GIT_TRACE=3D1?  I suspect you will see a call like "git symbolic-r=
ef
> > HEAD refs/top-bases/foo".
>=20
> Actually, I was able to reproduce with the recipe from Martin and Bert
> elsewhere in the thread. And that is indeed what is happening:
>=20
>   trace: built-in: git 'symbolic-ref' 'HEAD'
>   'refs/top-bases/test'\

Thanks, Jeff, for the accurate analysis. Since I do not see a way
for topgit to do things differently -- top-bases are *not* heads and
thus warrant a different namespace -- can I assume that this is to
be fixed in Git and not in TopGit?

--=20
 .''`.   martin f. krafft <madduck@d.o>      Related projects:
: :'  :  proud Debian developer               http://debiansystem.info
`. `'`   http://people.debian.org/~madduck    http://vcs-pkg.org
  `-  Debian - when you have better things to do than fixing systems
=20
"it is only the modern that ever becomes old-fashioned."
                                                        -- oscar wilde

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmUjioACgkQIgvIgzMMSnXUtQCgjwYFCLBmcSSt9vK9qG4V2tQR
4skAnRDL9kt9Srb42Xrn185L5/ny4Y0/
=DE5V
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
