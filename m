From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] revisions: refactor init_revisions and setup_revisions.
Date: Mon, 10 Mar 2008 21:44:07 +0100
Message-ID: <20080310204407.GA30569@artemis.madism.org>
References: <20080304231945.GC24131@artemis.madism.org> <7v63vvkplm.fsf@gitster.siamese.dyndns.org> <20080310084920.GA2798@artemis.madism.org> <7vwsoaid6z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="a8Wt8u1KmwUX3Y2C";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 21:44:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYora-0004U5-9v
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 21:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbYCJUoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 16:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbYCJUoL
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 16:44:11 -0400
Received: from pan.madism.org ([88.191.52.104]:49967 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445AbYCJUoK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 16:44:10 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 99FD932365;
	Mon, 10 Mar 2008 21:44:08 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 9C7A03D26; Mon, 10 Mar 2008 21:44:07 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vwsoaid6z.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76755>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2008 at 07:36:20PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >   We could of course have a .def member in the struct rev_info, and use
> > the one passed to setup_revisions then if it's still NULL, but it
> > doesn't really makes sense to me, and I don't really see a problem with
> > saying at init time that you'll default to "HEAD". Though if you really
> > dislike it that much, I squash a patch that does that on top of it.
>=20
> Well, it was not liking or disliking.  Although I thought "default" that
> sets a value to the default after the parser finds that the user did not
> give anything (the approach you described in the above quoted paragraph)
> is a natural implementation, probably more so than what you did, I do not
> have strong preference either way.

  Well Okay, I'll let others comment, and will implement this way if
more are in favor of it than against then :)

> >> Applying this to 'master' and then merging 'pu' shows that there are a=
 few
> >> topics that are cooking that would conflict with this change.  Merging
> >> 'next' seems to go cleanly (I haven't checked the result), so it is not
> >> too bad for me to carrry this at this moment, if we were not this clos=
e to
> >> the rc freeze.  I dunno.
> >
> >   Well I can wait longer, I'd just like to see it merged in a not too
> > far future, because I have to check for new places that would need
> > conversions at each reabase :)
>=20
> Yeah, that burden can be shifted to me, in other words ;-)

  Heh, fair enough. Well, I can wait a bit longer :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH1Z2XvGr7W6HudhwRAuwcAJwOiWF+ro7/vMgwutIUiYxw8dpPUgCgiaHa
sl/+xmey3MeePniZ2dvScmg=
=K044
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
