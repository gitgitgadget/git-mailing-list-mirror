From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Bring parse_options to the shell
Date: Fri, 02 Nov 2007 19:48:23 +0100
Message-ID: <20071102184823.GE27505@artemis.corp>
References: <1194016162-23599-1-git-send-email-madcoder@debian.org> <20071102151453.GB27505@artemis.corp> <alpine.LFD.0.999.0711020844310.3342@woody.linux-foundation.org> <20071102160925.GC27505@artemis.corp> <Pine.LNX.4.64.0711021818480.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Yb+qhiCg54lqZFXW";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 02 19:48:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io1Zb-00008F-Bx
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 19:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757195AbXKBSs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 14:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757122AbXKBSs0
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 14:48:26 -0400
Received: from pan.madism.org ([88.191.52.104]:60065 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755797AbXKBSsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 14:48:25 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 074F328139;
	Fri,  2 Nov 2007 19:48:23 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 4191B9BD; Fri,  2 Nov 2007 19:48:23 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>, gitster@pobox.com,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711021818480.4362@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63153>


--Yb+qhiCg54lqZFXW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 02, 2007 at 06:21:17PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Fri, 2 Nov 2007, Pierre Habouzit wrote:
>=20
> > On Fri, Nov 02, 2007 at 03:51:13PM +0000, Linus Torvalds wrote:
> >=20
> > > That command [rev-parse] was written exactly to parse a command line.=
=20
> > > This is really cheesy, and doesn't really work right (it splits up=20
> > > numbers too), but you get the idea..
> >=20
> >   I get the idea, though parse-options is not incremental at all, this=
=20
> > could probably be done, but would complicate the API (we would need to=
=20
> > allocate a state object e.g.). And parseoptions checks that options=20
> > getting an argument have one, checks that options exists and so on. It=
=20
> > looks like to me that it's not easy to plumb into rev-parse without=20
> > being a brand new independant mode.
> >=20
> >   We can do that, if we don't want yet-another-git-builtin/command, but=
=20
> > in the spirit it'll remain a brand new "thing".
> >=20
> >   Though I'd be glad to hear about what others think about it.
>=20
> Yeah, rev-parse's only purpose in life is to help scripts.  (Even if it i=
s=20
> used sometimes -- even by myself -- to turn symbolic names into SHA-1s.)
>=20
> IMHO it makes tons of sense to put the functionality into that command,=
=20
> even if it is not incremental.

  Okay so what do I do ? I create a new mode for git-rev-parse that does
what I do in git-parseopt ? I can do that, I don't like it a lot, but if
people it's better to work this way... It's also kind of counter
intuitive to have git *rev-parse* doing that but oh well, after all it's
plumbing

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Yb+qhiCg54lqZFXW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHK3D3vGr7W6HudhwRAib+AJwOgMoQxAz6f3XXGOL0lG1si8MnRwCfVHbf
g2aXTY3uf7DR/oMhuNPGeL4=
=YyJL
-----END PGP SIGNATURE-----

--Yb+qhiCg54lqZFXW--
