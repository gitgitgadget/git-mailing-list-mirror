From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Comment on weak refs
Date: Sun, 10 Jun 2007 16:09:00 +0200
Message-ID: <20070610140859.GB6730@artemis.madism.org>
References: <200706040251.05286.johan@herland.net> <200706100325.32846.johan@herland.net> <Pine.LNX.4.64.0706100716480.4059@racer.site> <200706101541.44362.johan@herland.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="IiVenqGWf+H9Y6IX";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 16:09:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxO6L-00071d-Sf
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 16:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184AbXFJOJE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 10:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754320AbXFJOJE
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 10:09:04 -0400
Received: from pan.madism.org ([88.191.52.104]:50762 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753876AbXFJOJD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 10:09:03 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id AF38E7FE;
	Sun, 10 Jun 2007 16:09:00 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 43C7EE5; Sun, 10 Jun 2007 16:09:00 +0200 (CEST)
Mail-Followup-To: Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200706101541.44362.johan@herland.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49738>


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  Sorry for the noise, but I'm really pissed with git@vger recently.
That mail I'm answering to, never made it to the list. Neither did my
quite long answer to Martin, who kindly forwared it back to me so that I
can send it again, sadly git@vger just does not wants mail, whereas its
SMTP seems to accept mail:

  Jun 10 16:02:09 pan postfix/smtp[20560]: DE84FCAD9: to=3D<git@vger.kernel=
=2Eorg>, relay=3Dvger.kernel.org[209.132.176.167]:25, delay=3D4, delays=3D0=
=2E31/0.02/0.5/3.1, dsn=3D2.7.0, status=3Dsent (250 2.7.0 nothing apparentl=
y wrong in the message. BF:<H 0.0800319>; S1754569AbXFJOCJ)

  I've sent a mail to postmaster@vger.kernel.org a week ago, but it
seems it remained a dead letter. Is anyone able to tell what's going
wrong ? it's _really_ irritating, and let me want to give up
discussions, as I _hate_ losing mail (I usually don't keep a copy of
mails I send to a mail list as I expect it to send it back to me, and
well, what would be a copy worth if nobody can read the mail anyway ?).

  So if anyone knows what can be done ....


On Sun, Jun 10, 2007 at 03:41:44PM +0200, Johan Herland wrote:
> On Sunday 10 June 2007, Johannes Schindelin wrote:
> > On Sun, 10 Jun 2007, Johan Herland wrote:
> > > On Sunday 10 June 2007, Junio C Hamano wrote:
> > Has my lightweight annotation patch reached you?
> >=20
> > I like my approach better than yours, because it is
> >=20
> > 1) a way, way smaller patch, and
> > 2) it automatically includes the versionability.
>=20
> I see your point, but your lightweight annotations are solving a differen=
t=20
> problem, aren't they? They do provide the after-the-fact annotations that=
=20
> sort of sparked of these discussions, but I can't see how your patch is a=
=20
> replacement of the general "relationships between arbitrary objects"=20
> concept that softrefs try to solve.
>=20
> Of course, it might be that the lightweight annotations are "good enough"=
=20
> for the use cases we currently see, and that softrefs are a bit overkill.=
=20
> We'll just have to see what features people (like Pierre) really need.
>=20
> > After thinking about it a little more (my plane was slow, and as a resu=
lt=20
> > I am allowed to spend 8 more hours in Paris), I think that a small but=
=20
> > crucial change would make this thing even more useful:
> >=20
> > Instead of having "core.showAnnotations" be a boolean config, it might =
be=20
> > better to have "core.annotationsRef" instead, overrideable by the=20
> > environment variable GIT_ANNOTATION_REF.
> >=20
> > With this, you can have different refs for different kinds of annotatio=
ns.
> >=20
> > For example, some people might add bugtracker comments (even comments l=
ike=20
> > "this commit was bad: introduced bug #798, solved by commit 9899fdadc..=
").=20
> > Those comments could live in refs/annotations/bugs. To see them, just s=
ay=20
> >=20
> > 	GIT_ANNOTATION_REF=3Drefs/annotations/bugs gitk
> >=20
> > Voila.
>=20
> Nice. Something similar should be possible to do with softrefs as well.
>=20
> > I am quite certain that treating annotations as branches, containing=20
> > fan-out directories for the reverse lookup. I am even quite certain tha=
t=20
> > in most cases, a working-directory-less merging is possible for such=20
> > annotations.
>=20
> I'm not convinced about the working-directory-less merging. AFAICS the=20
> lightweight annotations will behave pretty much like the "regular" versio=
n=20
> controlled filesystem, and you'll have the same kind of conflicts when yo=
u=20
> merge stuff between repos. I'd be glad to be proven wrong, of course.
>=20
>=20
> Have fun!
>=20
> ....Johan
>=20
> --=20
> Johan Herland, <johan@herland.net>
> www.herland.net

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGbAX7vGr7W6HudhwRAhBaAJ94zQcGxONMga/V9raTTgnyHLvM8gCfcYGa
9QJkEyM5ZUynsBjYeEu6HsA=
=TWvv
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
