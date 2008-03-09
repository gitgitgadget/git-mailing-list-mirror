From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-quiltimport: better parser to  grok "enhanced"   series files.
Date: Sun, 09 Mar 2008 12:27:00 +0100
Message-ID: <20080309112700.GB23924@artemis.madism.org>
References: <20080308182709.GA3109@artemis.madism.org> <7vk5kcsh06.fsf@gitster.siamese.dyndns.org> <20080309095918.GA23924@artemis.madism.org> <7vpru4p5g1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="IiVenqGWf+H9Y6IX";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 12:27:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYJgt-0005nI-69
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 12:27:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbYCIL1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 07:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752765AbYCIL1E
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 07:27:04 -0400
Received: from pan.madism.org ([88.191.52.104]:39125 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665AbYCIL1C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 07:27:02 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 2367E329D8;
	Sun,  9 Mar 2008 12:27:00 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 3332F2FD91B; Sun,  9 Mar 2008 12:27:00 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vpru4p5g1.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76653>


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 09, 2008 at 10:17:18AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >> You made the loop a subshell but I think you can redirect into the whi=
le
> >> loop without an extra "cat" process.
> >
> > Well probably yeah, I could use an exec -- < series or an alike trick
> > for sure.
>=20
> It seems many people forget that it is perfectly fine to redirect into
> while loop itself, like
>=20
> 	while read foo bar
>         do
>         	do a lot of stuff
> 	done <input-file

Oh right, well, I assume you already squashed that on top of my patch :)

> Ok, somehow in an earlier patch to quiltimport I picked up an incorrect
> notion that they could contain a blank, but then that's fine.

  Well, maybe they could, but quilt doesn't get it right.

> Will queue, but I am very well into my merge binge for tonight (and it
> hasn't finished even though it is past 3 AM, sheesh), so it will be in the
> next round.

  That's obviously fine by me, thanks :)
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH08mEvGr7W6HudhwRAtfVAJwM0x4/Q+SQUtm2madfl6Svk3CuWwCePaSG
CUNPsasHT+arFlJVnyXAWNE=
=2/LU
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
