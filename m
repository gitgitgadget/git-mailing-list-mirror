From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: clean/smudge filters for pdf files
Date: Thu, 23 Oct 2008 23:32:03 +0200
Message-ID: <20081023213203.GB26104@artemis.corp>
References: <ee2a733e0810231244u1510cdc8y7b27af9b8fdda1e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="p4qYPpj5QlsIQJ0K";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Leo Razoumov <slonik.az@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 23:33:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt7oY-00032H-2a
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 23:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284AbYJWVcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 17:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755855AbYJWVcI
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 17:32:08 -0400
Received: from pan.madism.org ([88.191.52.104]:38543 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753931AbYJWVcG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 17:32:06 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 271523FD50;
	Thu, 23 Oct 2008 23:32:05 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D11D055AC17; Thu, 23 Oct 2008 23:32:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ee2a733e0810231244u1510cdc8y7b27af9b8fdda1e0@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98988>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2008 at 07:44:39PM +0000, Leo Razoumov wrote:
> I am trying to improve storage efficiency for PDF files in a git repo.
> Following earlier discussions in this list I am trying to set up
> proper clean/smudge filters. What follows is my current setup
>=20
> # in ~/.gitconfig
> [filter "pdf"]
> 	clean  =3D "pdftk - output - uncompress"
> 	smudge =3D "pdftk - output - compress"
>=20
> # in .gitattributes
> *.pdf filter=3Dpdf
>=20
> Unfortunately, it seems as though that pdftk uncompress followed by
> pdftk compress do not leave the file invariant. I tried several
> uncompress+compress iterations and the file still keep changing (the
> size though stays the same).
> Is there any other alternative way to store PDF files in git repo more
> efficiently?
> Any alternative to pdftk on Linux?

actually it uses some kind of zlib algorithm so that's pretty normal you
don't have the same result with a packer. Maybe one could write a tool
like pristine-tar for that purpose.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkA7VMACgkQvGr7W6HudhwbXwCfdBnZur5qUXPqctdO0/VR0hjP
eHcAoI+LiQdfyihCDr/HkYV6xumzVqAP
=/yfO
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
