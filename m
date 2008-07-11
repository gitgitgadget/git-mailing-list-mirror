From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: THREADED_DELTA_SEARCH
Date: Fri, 11 Jul 2008 09:41:08 +0200
Message-ID: <20080711074107.GA7783@artemis.madism.org>
References: <7vy749pxbe.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0807101212000.12484@xanadu.home> <20080710201352.GA3717@blimp.local> <alpine.LFD.1.10.0807101625330.12484@xanadu.home> <20080710202919.GB3717@blimp.local> <alpine.LFD.1.10.0807101633480.12484@xanadu.home> <20080710221922.GA3665@steel.home> <alpine.DEB.1.00.0807110032030.3279@eeepc-johanness> <alpine.LFD.1.10.0807101851520.12484@xanadu.home> <81b0412b0807102259q1046051bwc513eadb50847675@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ZPt4rx8FFjLCG7dd";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git ML <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 09:42:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHDGc-0007Dg-Li
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 09:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249AbYGKHlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 03:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753028AbYGKHlM
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 03:41:12 -0400
Received: from pan.madism.org ([88.191.52.104]:52706 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753106AbYGKHlM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 03:41:12 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 25DB7324B9;
	Fri, 11 Jul 2008 09:41:09 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 5AF23D04; Fri, 11 Jul 2008 09:41:08 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Alex Riesen <raa.lkml@gmail.com>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <81b0412b0807102259q1046051bwc513eadb50847675@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88094>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2008 at 05:59:56AM +0000, Alex Riesen wrote:
> 2008/7/11 Nicolas Pitre <nico@cam.org>:
> > Furthermore, the number of threads is, by default, equivalent to the
> > number of detected CPUs.  So if you have a 8-CPU machine, I sure hope
> > you have the RAM configuration that goes along with such a system.
>=20
> ....and while the threads limit is implemented, the global memory limit i=
s not
> (well, frankly, I just don't know. Maybe it is there, and I can't find it=
).

  You mean --window-memory=3D ?

  I agree this feature should be opt-in. Linux, FreeBSD and Solaris
should probably do fine I assume ? I'm quite sure the two first will do,
I really know the latter less though.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkh3DpIACgkQvGr7W6HudhxV2wCgjp9qA7O/wVjH/YvV57uvG5l4
loAAn2fiSiBqUIPGtZOypcxXLcH5YzfM
=DdVe
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
