From: martin f krafft <madduck@madduck.net>
Subject: Re: .gitignore, .gitattributes, .gitmodules, .gitprecious?,
	.gitacls? etc.
Date: Mon, 27 Aug 2007 13:35:48 +0200
Message-ID: <20070827113548.GA21977@piper.oerlikon.madduck.net>
References: <2646CA4BEA644C9E9089C4A1AC395250@ntdev.corp.microsoft.com> <7v1wdqud0z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 13:36:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPctA-0000qO-Er
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 13:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756180AbXH0Lf5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 07:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756169AbXH0Lf4
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 07:35:56 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:36752 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756151AbXH0Lfz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 07:35:55 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id F1BF5895D77
	for <git@vger.kernel.org>; Mon, 27 Aug 2007 13:35:49 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 01466-09 for <git@vger.kernel.org>;
	Mon, 27 Aug 2007 13:35:49 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id AF750895D73
	for <git@vger.kernel.org>; Mon, 27 Aug 2007 13:35:49 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id C8ED39F161
	for <git@vger.kernel.org>; Mon, 27 Aug 2007 13:35:48 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 5ECB543F4; Mon, 27 Aug 2007 13:35:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v1wdqud0z.fsf@gitster.siamese.dyndns.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56819>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Junio C Hamano <gitster@pobox.com> [2007.08.26.0637 +0200]:
> > 1. It may be better to combine all these files into one
> > (.gitmeta) with different sections
>=20
> Merging what has traditionally been known as .gitignore's
> capability to attributes has been discussed, and I think it would
> make sense in longer term, as 'this path pattern is to be ignored'
> is just a special case of a more general attribute.

I tried to find related threads in the archives but failed. If
someone has a pointer handy, I'd appreciate it. Alternatively,
please feel free to just bounce related messages from your own
archives to me.

I am interested in this mainly because of a somewhat related idea of
honouring .gitignore/* in case it's a directory [0].

0. http://marc.info/?l=3Dgit&m=3D118725982332041&w=3D2

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"the question of whether computers can think
 is like the question of whether submarines can swim."
                                                 -- edsgar w. dijkstra
=20
spamtraps: madduck.bogus@madduck.net

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG0rcUIgvIgzMMSnURAjONAKCZjaAdkNZpAPAAliWe51G8gjOY0QCgrhOm
pDDVGzWdhgsXTbMd0GhZfRc=
=EFGv
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
