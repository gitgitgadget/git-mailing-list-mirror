From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 0/14] fork/exec removal series
Date: Sun, 14 Oct 2007 09:28:49 +0200
Message-ID: <20071014072849.GD1198@artemis.corp>
References: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at> <20071014021149.GO27899@spearce.org> <Pine.LNX.4.64.0710140348550.25221@racer.site> <20071014025857.GQ27899@spearce.org> <20071014071239.GB1198@artemis.corp> <20071014071751.GC1198@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="iVCmgExH7+hIHJ1A";
	protocol="application/pgp-signature"; micalg=SHA1
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>, gitster@pobox.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 09:29:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Igxue-0004gC-Ja
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 09:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755040AbXJNH2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 03:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756268AbXJNH2v
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 03:28:51 -0400
Received: from pan.madism.org ([88.191.52.104]:48699 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446AbXJNH2u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 03:28:50 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id AC346244A4;
	Sun, 14 Oct 2007 09:28:49 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 46B8F3A736D; Sun, 14 Oct 2007 09:28:49 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>, gitster@pobox.com,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071014071751.GC1198@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60802>


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On dim, oct 14, 2007 at 07:17:51 +0000, Pierre Habouzit wrote:
> On dim, oct 14, 2007 at 07:12:39 +0000, Pierre Habouzit wrote:
> >   The trivial way is to add a __thread keyword to make them TLS
> > variables, though, it's not really a step in the direction of
> > portability, and last time I looked at it, mingw didn't had TLS support,
> > not sure if msys has. Though, if Msys has, it's worth using, and we
>=20
>   Okay forget it, mingw and msys are one and the same *g*.
>   So well, maybe threading isn't such a so great idea :/

  And again last time I checked it was still a mingw 3.x in debian, now
that it's 4.2.1 it seems to support __thread (but not
__declspec(thread)) and their changelog seems to confirm that fact [0].

  So the question holds again, do we require pthread-using targets to
support TLS ? It feels sane and right to me, but =E2=80=A6


  [0] http://sourceforge.net/project/shownotes.php?release_id=3D532062
      [...]
      * The  __thread keyword is honoured.
      [...]

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHEcUxvGr7W6HudhwRAoC7AJwK+DiKDfJLfO9gwJztgLRo76qgxQCffy+n
rybqMOjkz8IlBIJxGr3FJJk=
=fZ00
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--
