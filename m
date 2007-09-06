From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 6/7] Eradicate yet-another-buffer implementation in  buitin-rerere.c
Date: Thu, 06 Sep 2007 22:54:08 +0200
Message-ID: <20070906205408.GA26924@artemis.corp>
References: <11890776114037-git-send-email-madcoder@debian.org> <118907761140-git-send-email-madcoder@debian.org> <11890776111843-git-send-email-madcoder@debian.org> <11890776112292-git-send-email-madcoder@debian.org> <11890776111670-git-send-email-madcoder@debian.org> <11890776112309-git-send-email-madcoder@debian.org> <11890776112641-git-send-email-madcoder@debian.org> <Pine.LNX.4.64.0709061504521.28586@racer.site> <20070906171734.GG8451@artemis.corp> <85hcm7a6t4.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="OgqxwSJOaUobr8KG";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 22:54:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITOMj-0001uQ-4o
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 22:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757629AbXIFUyM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 16:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757885AbXIFUyM
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 16:54:12 -0400
Received: from pan.madism.org ([88.191.52.104]:36976 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757426AbXIFUyL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 16:54:11 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id F238C1E585;
	Thu,  6 Sep 2007 22:54:09 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id EA5AF1A3C1; Thu,  6 Sep 2007 22:54:08 +0200 (CEST)
Mail-Followup-To: David Kastrup <dak@gnu.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <85hcm7a6t4.fsf@lola.goethe.zz>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57930>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2007 at 08:16:07PM +0000, David Kastrup wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > On Thu, Sep 06, 2007 at 02:05:36PM +0000, Johannes Schindelin wrote:
>=20
> >> You used spaces instead of tabs here.
> >
> >   crap, and I did that in the 5th patch as well. well, I'll maybe send
> > privately a "fixed" version of the patch to junio then, to avoid
> > flooding the list with spacing issues.
> >
> >   And I'll also set my vim to use tabs when I'm hacking on git.
>=20
> Just use Emacs and
> M-x c-set-style RET linux RET

  I'll give you a hunch:

apt-cache showsrc vim|grep Uplo
=E2=80=A6, Pierre Habouzit <madcoder@debian.org>, =E2=80=A6

  And it's not like vim doesn't has this either :)

  Anyways, we're going a bit OT aren't we ?
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4GjwvGr7W6HudhwRAnH0AJ0XRxvXl7EP5a65iWAwXUicVWINwgCdHGjj
ukNma733s7BRSG2vqfAWvlA=
=RmAW
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
