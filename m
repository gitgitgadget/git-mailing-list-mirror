From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in git, help users out.
Date: Mon, 05 Nov 2007 20:50:11 +0100
Message-ID: <20071105195011.GB8939@artemis.corp>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org> <CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="CdrF4e02JqNVZeln";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 20:50:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip7xs-0004On-Hm
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 20:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbXKETuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 14:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbXKETuO
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 14:50:14 -0500
Received: from pan.madism.org ([88.191.52.104]:39405 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbXKETuM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 14:50:12 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id E6B2A2899C;
	Mon,  5 Nov 2007 20:50:11 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 81AD020E829; Mon,  5 Nov 2007 20:50:11 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Steven Grimm <koreth@midwinter.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63543>


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2007 at 07:28:03PM +0000, Steven Grimm wrote:
> On Nov 5, 2007, at 11:01 AM, Pierre Habouzit wrote:
> >When git-revert has a file argument then redirect the user to what he
> >probably meant.
>=20
> That's a big improvement. Basically everyone I show git to gets "revert"=
=20
> wrong at first.
>=20
> >+			die("Cannot find commit '%s', did you meant: "
> >+				"git checkout HEAD -- '%s'", arg, arg);
>=20
> But that suggested command is not going to convince anyone they were=20
> wrong about git being hard to learn. I wonder if instead of saying, "I=20
> know what you meant, but I'm going to make you type a different command,"=
=20
> we should make git revert just do what the user meant.

  That's an option, but it wouldn't be maint material then :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHL3PzvGr7W6HudhwRAhMZAJ9W8By0z6IwDuq/99rb1bAwDzCBsACeINUv
iOxL+rpq3IBKL/ex6pu93ig=
=jJ57
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
