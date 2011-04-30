From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: [PATCH] git-send-email: fix missing space in error message
Date: Sat, 30 Apr 2011 09:52:39 +0200
Message-ID: <1304149959.1850.4.camel@kheops>
References: <1304101404-4571-1-git-send-email-sylvain@abstraction.fr>
	 <7vmxj8x5yj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-D7uMId4VZLH4lm9jpJND"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 09:53:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QG4zG-0007lo-A0
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 09:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743Ab1D3Hwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Apr 2011 03:52:51 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39859 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740Ab1D3Hwu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2011 03:52:50 -0400
Received: by wwa36 with SMTP id 36so4898080wwa.1
        for <git@vger.kernel.org>; Sat, 30 Apr 2011 00:52:49 -0700 (PDT)
Received: by 10.227.54.6 with SMTP id o6mr847001wbg.61.1304149969034;
        Sat, 30 Apr 2011 00:52:49 -0700 (PDT)
Received: from [192.168.0.7] ([85.69.155.32])
        by mx.google.com with ESMTPS id x1sm2125545wbh.53.2011.04.30.00.52.47
        (version=SSLv3 cipher=OTHER);
        Sat, 30 Apr 2011 00:52:47 -0700 (PDT)
In-Reply-To: <7vmxj8x5yj.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.32.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172518>


--=-D7uMId4VZLH4lm9jpJND
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry about that. Was thinking this was not worth an entry in
the release note.

On Fri, 2011-04-29 at 11:33 -0700, Junio C Hamano wrote:
> Sylvain Rabot <sylvain@abstraction.fr> writes:
>=20
> > Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
>=20
> Please keep in mind that these individual commits will eventually need an
> entry added to Documentation/Relnotes/1.7.5.1.txt where I describe what
> bug was fixed in a single paragraph, and it almost always talks about how
> a bug would have been triggered so that the readers can tell if the fix
> would benefit them.
>=20
> It would have been perfect if you wrote under what condition the user
> would see this error message in the body of the commit.
>=20
> > ---
> >  git-send-email.perl |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index 76565de..98ab33a 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -1091,7 +1091,7 @@ X-Mailer: git-send-email $gitversion
> >  			    "VALUES: server=3D$smtp_server ",
> >  			    "encryption=3D$smtp_encryption ",
> >  			    "hello=3D$smtp_domain",
> > -			    defined $smtp_server_port ? "port=3D$smtp_server_port" : "";
> > +			    defined $smtp_server_port ? " port=3D$smtp_server_port" : "";
>=20
> If I were writing this from scratch, I probably would have written it
> by having leading SP for all options, perhaps like this:
>=20
> 	"VALUES:",
>         " option=3Dvalue",
>         " option=3Dvalue",
>         (showoption) ? " option=3Dvalue" : "",
>         (showoption) ? " option=3Dvalue" : "",
>         ...
>=20
> Thanks.


--=-D7uMId4VZLH4lm9jpJND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJNu7/AAAoJECLlHVUnhaoWlMYH/iABhvNwfjIkXpXv/2mY/IVw
63g87YcePQECitAlu6KMS7x//gifpQSVfrRopCi3KBu7GkKGHbGxGKRdkNADiLS+
6fZVca4FEX+6mEetqpy9K9p3WuPLt4jtTwZ4XBqpK/UzE+RODT1VB3IUhI6gwvAN
0heSezvW22AKWSNfaGmW40c0PkiAnctQNVKheeSOBnQ2/+o49TKzgeDFNlcGSxeU
ii5EIF4lkRksP4o7WuUoZEnSegKxb/C6xvR0G8eoCluGJamfE3DsE48cbDS7yXei
wy1vWbAR7cI2AbdBvgcdtnO07iLijjync9hP7fkNStQH+00zNFTQcgj/WYgll4Y=
=iVFI
-----END PGP SIGNATURE-----

--=-D7uMId4VZLH4lm9jpJND--
