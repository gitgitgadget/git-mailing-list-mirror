From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Add more tests for git-clean
Date: Mon, 05 Nov 2007 00:46:17 +0100
Message-ID: <20071104234617.GG4207@artemis.corp>
References: <1194202941253-git-send-email-shawn.bohrer@gmail.com> <11942029442710-git-send-email-shawn.bohrer@gmail.com> <7vve8hr3ch.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="1giRMj6yz/+FOIRq";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 00:46:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IopAo-0006AB-2Q
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 00:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817AbXKDXqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 18:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753836AbXKDXqU
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 18:46:20 -0500
Received: from pan.madism.org ([88.191.52.104]:50163 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753726AbXKDXqT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 18:46:19 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id E2F7B25E02;
	Mon,  5 Nov 2007 00:46:17 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 5AECF4359E6; Mon,  5 Nov 2007 00:46:17 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vve8hr3ch.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63459>


--1giRMj6yz/+FOIRq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 04, 2007 at 11:35:42PM +0000, Junio C Hamano wrote:
> Shawn Bohrer <shawn.bohrer@gmail.com> writes:
>=20
> > +test_expect_success 'git-clean with prefix' '
> > +
> > +	mkdir -p build docs &&
> > +	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
> > +	cd src/ &&
> > +	git-clean &&
> > +	cd - &&
>=20
> This is wrong for two reasons.
>=20
>  - Is "cd -" portable?

  this is POSIX:

8910 =E2=88=92 When a hyphen is used as the operand, this shall be equivale=
nt to the command:
8911   cd "$OLDPWD" && pwd
8912   which changes to the previous working directory and then writes its =
name.

  Meaning that cd $OLDPWD should work, and won't print $OLDPWD.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--1giRMj6yz/+FOIRq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHLlnJvGr7W6HudhwRArJ+AKCM3tFn0sxHZI9CtgGZoJQHGAgHywCgkseP
Np/1Ng4PCC/5StcmxszD+68=
=A9mp
-----END PGP SIGNATURE-----

--1giRMj6yz/+FOIRq--
