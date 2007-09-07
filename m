From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String   Library.
Date: Fri, 07 Sep 2007 21:59:40 +0200
Message-ID: <20070907195940.GB23483@artemis.corp>
References: <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org> <alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org> <fbqmdu$udg$1@sea.gmane.org> <20070907094120.GA27754@artemis.corp> <fbs79k$tac$1@sea.gmane.org> <20070907194115.GA23483@artemis.corp> <85odge2r0w.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="b5gNqxB1S1yM7hjW";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Walter Bright <boost@digitalmars.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 21:59:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITjzb-0000xn-Au
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 21:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758265AbXIGT7q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 15:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758219AbXIGT7q
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 15:59:46 -0400
Received: from pan.madism.org ([88.191.52.104]:51583 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752538AbXIGT7p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 15:59:45 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 8102D1E858;
	Fri,  7 Sep 2007 21:59:41 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 085DEE6E6; Fri,  7 Sep 2007 21:59:41 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	David Kastrup <dak@gnu.org>, Walter Bright <boost@digitalmars.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <85odge2r0w.fsf@lola.goethe.zz>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58064>


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2007 at 07:51:11PM +0000, David Kastrup wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> [bit fields]
>=20
> >   Really, I feel this is a big lack, for a language that aims at
> > simplicity, conciseness _and_ correctness.
> >
> >   OK, maybe I'm biased, I work with networks protocols all day long, so
> > I often need bitfields, but still, a lot of people deal with network
> > protocols, it's not a niche.
>=20
> And strictly speaking, C bitfields are completely useless for that
> purpose since the compiler is free to use whatever method he wants for
> allocating bit fields.  So if you want to write a portable program,
> you are back to making the masks yourself.

  The point is (1) D is not C, (2) we all know that linux e.g. does that
in many places using the fact that it knows how the supported compilers
(gcc icc tcc maybe some other) do their packing.

  The discussion is about D. D solves the infamous problem with longs
not having the same size everywhere, I don't see why it couldn't solve
the bitfield issue either.

> Where bit fields work reliably is when you are not interchanging data
> with other applications, but just laying out your internals.

  Thank you for the _C_ lesson.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4a2svGr7W6HudhwRAsgoAJ4nnG/LeH+LjY28o0H9bPeamaoaZACfRzd8
echCZFxofV4hBtNXXUwVhv8=
=If6g
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
