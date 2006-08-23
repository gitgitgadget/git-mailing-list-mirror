From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Fix a comparison bug in diff-delta.c
Date: Wed, 23 Aug 2006 16:31:10 +0200
Organization: Polytechnique.org
Message-ID: <200608231631.12958.madcoder@debian.org>
References: <1156324675415-git-send-email-madcoder@debian.org> <Pine.LNX.4.63.0608231542380.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1712046.DuasTuU8r6";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 16:31:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFtlG-00081a-Ug
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 16:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWHWObQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 10:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWHWObQ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 10:31:16 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:42399 "EHLO
	mx1.polytechnique.org") by vger.kernel.org with ESMTP
	id S964896AbWHWObP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Aug 2006 10:31:15 -0400
Received: from mad.intersec.eu (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ssl.polytechnique.org (Postfix) with ESMTP id 49D783338E;
	Wed, 23 Aug 2006 16:31:14 +0200 (CEST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0608231542380.28360@wbgn013.biozentrum.uni-wuerzburg.de>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
X-AV-Checked: ClamAV using ClamSMTP at djali.polytechnique.org (Wed Aug 23 16:31:14 2006 +0200 (CEST))
X-Spam-Flag: No, tests=bogofilter, spamicity=0.000003, queueID=67BF9333BC
X-Org-Mail: pierre.habouzit.2000@polytechnique.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25918>

--nextPart1712046.DuasTuU8r6
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le mer 23 ao=C3=BBt 2006 15:45, Johannes Schindelin a =C3=A9crit :
> Hi,
>
> On Wed, 23 Aug 2006, Pierre Habouzit wrote:
> > -	for (i =3D 4; (1 << i) < hsize && i < 31; i++);
> > +	for (i =3D 4; (1u << i) < hsize && i < 31; i++);
>
> The variable i never takes on the value 31 (or any higher value), so
> there is no bug here. Unless you port git to a system where an int
> has less than 32 bit.

that remains quite tasteless though, and maybe that patch can be=20
integrated to the "cleanup" series I sent later today.
=2D-=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--nextPart1712046.DuasTuU8r6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE7GawvGr7W6HudhwRAuw2AJ9PGysgrEI4OFD5Z+QvWl/C3ApCyACgk9WM
4eoHt1EF7XbS2ImVpp/WP9k=
=ff49
-----END PGP SIGNATURE-----

--nextPart1712046.DuasTuU8r6--
