From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git pull opinion
Date: Tue, 06 Nov 2007 09:51:34 +0100
Message-ID: <20071106085134.GD4435@artemis.corp>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com> <20071105234049.GA31277@genesis.frugalware.org> <3abd05a90711052016s615cd66cy5a5f932900d89143@mail.gmail.com> <176851C5-D735-4DDC-B799-A5106CD03989@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="tNQTSEo8WG/FKZ8E";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Aghiles <aghilesk@gmail.com>, git list <git@vger.kernel.org>
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Tue Nov 06 09:52:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpKAQ-0000zh-Cl
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 09:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887AbXKFIvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 03:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754666AbXKFIvh
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 03:51:37 -0500
Received: from pan.madism.org ([88.191.52.104]:58341 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754885AbXKFIvg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 03:51:36 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 4855A28A58;
	Tue,  6 Nov 2007 09:51:35 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id E5E6B20E8B5; Tue,  6 Nov 2007 09:51:34 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Benoit Sigoure <tsuna@lrde.epita.fr>, Aghiles <aghilesk@gmail.com>,
	git list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <176851C5-D735-4DDC-B799-A5106CD03989@lrde.epita.fr>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63645>


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 06, 2007 at 05:29:58AM +0000, Benoit Sigoure wrote:
> On Nov 6, 2007, at 5:16 AM, Aghiles wrote:
>=20
> >Hello,
> >
> >>who will run git stash clear? :)
> >
> >Yes you are right. By the way, in the context of merging into a
> >dirty tree, "git stash clear" seems to be a dangerous command:
> >there is a risk of loosing all your changes without a question
> >asked!
> >
> >I know unix is a harsh world but ...
>=20
> Be *very* careful, because it's worse than that.  If you run, say, `git=
=20
> stash clean', instead of `clear' (that's the sort of typo that quickly=20
> slips through), then it will stash all your changes in a new stash named=
=20
> "clean".  Once you realize you made a typo, you will most probably=20
> correct it and run `git stash clear' but...   Oops, you just wiped your=
=20
> changes that were in the "clean" stash.
> That happened to me and other people I know, so now I'm utterly cautious=
=20
> when I start a command with "git stash".
>=20
> As far as I remember, a patch was proposed to change this mis-behavior of=
=20
> "git stash" (one could argue that it's a PEBCAK issue, but I really think=
=20
> this command is *way* too dangerous) but I don't think it's been accepted=
=20
> at this time.

  no it's a command issue. git stash <random non command name> should
_NOT_ be an alias to git stash save <random name>. Either the command
should be mandatory _or_ it should be a long option to avoid such kind
of conflicts.

  It's just a bad ui design.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHMCsWvGr7W6HudhwRAq9TAKCHh2lbpgdKzrOgxDYaZx36hrzP1wCaA9p8
+HaDSAeHxHbZ0mfcADf5fJ8=
=erlA
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--
