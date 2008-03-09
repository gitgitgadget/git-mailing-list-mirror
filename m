From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-quiltimport: better parser to  grok "enhanced"  series files.
Date: Sun, 09 Mar 2008 10:59:19 +0100
Message-ID: <20080309095918.GA23924@artemis.madism.org>
References: <20080308182709.GA3109@artemis.madism.org> <7vk5kcsh06.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="zhXaljGHf11kAtnf";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 11:00:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYIKQ-00029F-8f
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 11:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbYCIJ7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 05:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbYCIJ7W
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 05:59:22 -0400
Received: from pan.madism.org ([88.191.52.104]:54426 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751269AbYCIJ7V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 05:59:21 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 0404B323B7;
	Sun,  9 Mar 2008 10:59:19 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 140E2364; Sun,  9 Mar 2008 10:59:19 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vk5kcsh06.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76643>


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 09, 2008 at 03:39:21AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >   I'd even argue that it's maint material btw :)
>=20
> I don't know.

Well not groking the -pNNN makes it useless for me in its current form, 80%=
 of
the quilt series I use have them (and right now it says: I cannot apply pat=
ch
'foo-bar.patch -p1').

> You made the loop a subshell but I think you can redirect into the while
> loop without an extra "cat" process.

Well probably yeah, I could use an exec -- < series or an alike trick
for sure.

> Can a patch name contain $IFS whitespace characters?

  I tested and quilt says that:

$ quilt new a\ b.patch
Patch a is now on top

And when I quilt refresh it, it creates a patch named 'a'.  (and yes, I tho=
ught
of this and tested it prior to sending the patch).

> If so, this patch would regress them.  Otherwise it looks fine.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQBH07T2vGr7W6HudhwRAmhVAJig1tkIqvoiMSgUcs4XWLInOGfOAJ9/ENcv
zj7mhYWSfGbefzdcPndlng==
=DhHQ
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
