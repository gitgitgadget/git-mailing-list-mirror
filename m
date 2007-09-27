From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Mergetool generating blank files (1.5.3)
Date: Thu, 27 Sep 2007 21:11:25 +0200
Message-ID: <20070927191125.GD12427@artemis.corp>
References: <94ccbe710709271131o620bf1far8893328ce98f0ba4@mail.gmail.com> <20070927185707.GC12427@artemis.corp> <46FBFDD7.1080300@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="fXStkuK2IQBfcDe+";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Kelvie Wong <kelvie@ieee.org>, git@vger.kernel.org
To: Russ Brown <pickscrape@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 21:11:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iaylt-0002GZ-I9
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 21:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756414AbXI0TL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 15:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755970AbXI0TL1
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 15:11:27 -0400
Received: from pan.madism.org ([88.191.52.104]:35203 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754701AbXI0TL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 15:11:26 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 8E94B2214D;
	Thu, 27 Sep 2007 21:11:25 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 3ADA8941A; Thu, 27 Sep 2007 21:11:25 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Russ Brown <pickscrape@gmail.com>, Kelvie Wong <kelvie@ieee.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46FBFDD7.1080300@gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59314>


--fXStkuK2IQBfcDe+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 27, 2007 at 07:00:39PM +0000, Russ Brown wrote:
> Pierre Habouzit wrote:
> > On Thu, Sep 27, 2007 at 06:31:19PM +0000, Kelvie Wong wrote:
> >> At work, I've been using a git-svn import for my daily workflow (still
> >> somewhat of a git newbie, but now has come to the point where it's
> >> tough to work without it), and while rebasing from svn (on a rather
> >> old branch), I found that the mergetool option does not work too well
> >> for me.
> >=20
> >   Which tool are you using ? kdiff3 ? I've noticed that it often fails
> > miserably, or worse, create bad merges silentely with it.
> >=20
> >   And as none of the other merge tool that are supported are able to
> > either do 3way merges, or have a decent UI (that definitely seems to be
> > exclusive features) I've given up on git-mergetool (and to be fair, it
> > sucks, because it could be _sooo_ useful sometimes).
> >=20
>=20
> What about meld? That does 3-way merge, and the UI is fine.

  Indeed, it seems that since the last time I tested it, it now does
diff3 merging. I should reevaluate it :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--fXStkuK2IQBfcDe+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG/ABdvGr7W6HudhwRAqrSAJ9xChSrt0qJJ8DVumfhLXrEsRhCWQCghmM/
1TMsK5M0Q+sDRR159PXWas4=
=No8t
-----END PGP SIGNATURE-----

--fXStkuK2IQBfcDe+--
