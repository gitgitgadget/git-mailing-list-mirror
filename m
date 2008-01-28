From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Authenticate push via PGP signature, not SSH
Date: Mon, 28 Jan 2008 09:48:30 +0100
Message-ID: <20080128084830.GB15935@artemis.madism.org>
References: <479D5611.4010205@vilain.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="LpQ9ahxlCli8rRTG";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Jan 28 09:49:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJPgH-0004ca-H9
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 09:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759664AbYA1Ise (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 03:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759657AbYA1Isd
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 03:48:33 -0500
Received: from pan.madism.org ([88.191.52.104]:50482 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759634AbYA1Isc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 03:48:32 -0500
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id E2A012D82B;
	Mon, 28 Jan 2008 09:48:30 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 5142161A0; Mon, 28 Jan 2008 09:48:30 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Sam Vilain <sam@vilain.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <479D5611.4010205@vilain.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71864>


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2008 at 06:12:34AM +0000, Sam Vilain wrote:
> This does force potential contributors to get PGP keys, and get them
> signed - but that seems to me to be a reasonable barrier of entry and
> may even help drive some PGP adoption.
>=20
> Remember this is a proof of concept, so let's discuss the design first
> and not worry too much about the glaring bugs yet.

  FWIW I'm really interested into such a "thing", and that I'd like to
avoid giving unix (even with git-shell, not only because of security,
but because it pollutes the machine setup a lot) accounts to my git
servers, though would like to let people help in my Debian packaging.
Fors us GPG isn't an issue, as every single DD or wannabe has a GPG key
:)

  Note though that the fact that you need to push a dummy tag is somehow
disgusting IMHO, it should at least be integrated into git-push so that
the user doesn't have to generate the dummy tag himself.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHnZbevGr7W6HudhwRAnN/AKCQsCQYQgYxYund0ZreLorFV3jHbACffQ4Y
OKgn0oV1KYrv6j3i236bSxQ=
=MYbd
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
