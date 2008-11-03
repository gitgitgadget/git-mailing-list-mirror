From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI  revamp
Date: Mon, 03 Nov 2008 14:47:22 +0100
Message-ID: <20081103134722.GF13930@artemis.corp>
References: <1225338485-11046-1-git-send-email-sam@vilain.net> <20081030132453.GB24098@artemis.corp> <7vy70123rr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ExXT7PjY8AI4Hyfa";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 14:48:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwznO-0006r3-0E
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 14:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755229AbYKCNr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 08:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755227AbYKCNr1
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 08:47:27 -0500
Received: from pan.madism.org ([88.191.52.104]:33590 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755097AbYKCNr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 08:47:26 -0500
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id E52053BBE8;
	Mon,  3 Nov 2008 14:47:23 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 8ABA055AC1C; Mon,  3 Nov 2008 14:47:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vy70123rr.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99944>


--ExXT7PjY8AI4Hyfa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 02, 2008 at 09:53:44PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
> >   * git-send-email should be either more interactive, or less: either
> >     just use the damn configuration, or propose a mode where it spawns
> >     an editor for each patch so that you can add further comments.
>=20
> In principle I'd agree, but I use send-email non-interactively myself (I
> type Meta/SE where Meta is an independent checkout of my 'todo' branch),
> so I am not sure if the "just use the configuration" is an added
> requirement.  I also have this in .git/config in the repo:
>=20
>         [sendemail]
>                 smtpserver =3D /usr/bin/msmtp
>                 to =3D git@vger.kernel.org
>                 suppressfrom
>                 signedoffcc =3D false

Well with my patches it goes _more_ interactive on request only, so that
wouldn't break your setup (you have to explicitely pass --annotated
and/or --compose). Okay arguably not the feature that auto enables
--compose on series of more than 1 patch, but you can redirect
send-email to | cat or pass --no-compose for that. Or we can drop that
bit of the patch if people find it too cumbersome, I can put that in an
alias I don't really care.

I really _care_ about not breaking send-email for its previous uses.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--ExXT7PjY8AI4Hyfa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkPAOkACgkQvGr7W6Hudhwo0ACfdSveE3V3pneWLA5EX+WE1dF9
/k0AnA5ClMKwOAMouz7lVq5xrDDq+MPU
=JC2v
-----END PGP SIGNATURE-----

--ExXT7PjY8AI4Hyfa--
