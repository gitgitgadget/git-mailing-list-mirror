From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFT] Format our Documentation/ with both AsciiDoc 7 & 8
Date: Fri, 15 Jun 2007 10:09:35 +0200
Message-ID: <20070615080935.GB28554@artemis.intersec.eu>
References: <11810823561507-git-send-email-madcoder@debian.org> <7vfy4t915f.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="RIYY1s2vRbPFwWeW";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 10:09:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz6sI-0002QR-N1
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 10:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbXFOIJk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 04:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbXFOIJi
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 04:09:38 -0400
Received: from pan.madism.org ([88.191.52.104]:50783 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799AbXFOIJh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 04:09:37 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 5CAF1DE54;
	Fri, 15 Jun 2007 10:09:36 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D4DD0710D; Fri, 15 Jun 2007 10:09:35 +0200 (CEST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stefan Richter <stefanr@s5r6.in-berlin.de>
Content-Disposition: inline
In-Reply-To: <7vfy4t915f.fsf@assigned-by-dhcp.pobox.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50252>


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2007 at 11:34:20PM -0700, Junio C Hamano wrote:
> It turns out that the attribute definition we have had for a
> long time to hide "^" character from AsciiDoc 7 was not honored
> by AsciiDoc 8 even under "-a asciidoc7compatible" mode.
>=20
> Also the double colon at the end of definition list term needs
> to be attached to the term, without a whitespace.  After this
> minimum fixups, AsciiDoc 8 (I used 8.2.1 on Debian) with
> compatibility mode seems to produce reasonably good results.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>=20
>  * This is "Request for Test" to people who reported problems
>    formatting our documentation with asciidoc 8.  To format with
>    Asciidoc 8, you would need to say something like:
>=20
> 	$ make ASCIIDOC8=3DYesPlease doc

  sadly, it does not fixes the issue I reported with git-pull.1 (e.g.)
that reads:

   <refspec>
       The canonical format of a <refspec> parameter is ?<src>:<dst>; that

whereas it should be:

   <refspec>
       The canonical format of a <refspec> parameter is +?<src>:<dst>; that


But I've not seen any serious or even noticeable regression here.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGckk/vGr7W6HudhwRAjYdAKCILylrXC9+PRAvdfzTwxuJ6MqFpACdExkw
BARKIaq+5VLEUQJemFTTkKo=
=FEIP
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
