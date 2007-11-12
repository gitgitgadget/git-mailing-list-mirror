From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-clean: Fix error message if clean.requireForce is  not  set.
Date: Mon, 12 Nov 2007 13:24:23 +0100
Message-ID: <20071112122423.GB20482@artemis.corp>
References: <47380E77.9040205@viscovery.net> <20071112083352.GA20482@artemis.corp> <4738119F.2030901@viscovery.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="1LKvkjL3sHcu1TtY";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Bohrer <shawn.bohrer@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 13:25:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrYLL-0003Ki-Q8
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 13:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758257AbXKLMY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 07:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758256AbXKLMY2
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 07:24:28 -0500
Received: from pan.madism.org ([88.191.52.104]:45903 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758202AbXKLMYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 07:24:25 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 9E45729BB4;
	Mon, 12 Nov 2007 13:24:24 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 8E8991E2E7; Mon, 12 Nov 2007 13:24:23 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Bohrer <shawn.bohrer@gmail.com>
Content-Disposition: inline
In-Reply-To: <4738119F.2030901@viscovery.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64610>


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 12, 2007 at 08:41:03AM +0000, Johannes Sixt wrote:
> Pierre Habouzit schrieb:
> >On Mon, Nov 12, 2007 at 08:27:35AM +0000, Johannes Sixt wrote:
> >>It was distracting to see this error message:
> >>
> >>    clean.requireForce set and -n or -f not given; refusing to clean
> >>
> >>even though clean.requireForce was not set at all. This patch=20
> >>distinguishes
> >>the cases and gives a different message depending on whether the
> >>configuration variable is not set or set to true.
> >  Note that your patch won't apply to next as is :)
>=20
> You mean because of the builtinification of git-clean? I was hoping that=
=20
> Shawn (Bohrer) is listening and will update his patch. ;) It has the same=
=20
> problem.

  No, afaict the builtin git-clean isn't in next yet. Though the
git-rev-parse --parseopt-ification is :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHOEX3vGr7W6HudhwRAiqXAKCItk0m3vizgQAtsShNOub6ODdtrQCfdhsf
iOPoT08+CiSyWBR5dPyAI5k=
=GgeR
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
