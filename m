From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Improve documentation for git-sh-setup.
Date: Fri, 22 Feb 2008 19:19:28 +0100
Message-ID: <20080222181927.GA4555@artemis.madism.org>
References: <20080221230101.27644.49229.stgit@gandelf.nowhere.earth> <20080222093558.GC29114@artemis.madism.org> <7vbq68ap1c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="qDbXVdCdHGoSgWSk";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 19:20:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JScVH-0002AC-Mi
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 19:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864AbYBVSTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 13:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755147AbYBVSTf
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 13:19:35 -0500
Received: from pan.madism.org ([88.191.52.104]:36720 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754361AbYBVSTc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 13:19:32 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A9D541835F;
	Fri, 22 Feb 2008 19:19:29 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 4302E385D; Fri, 22 Feb 2008 19:19:28 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vbq68ap1c.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74744>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2008 at 05:17:51PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >   Actually, new scripts should be written using git rev-parse if
> > possible, the USAGE/LONG_USAGE were there _before_ and I'd like to call
> > them the deprecated interface if other git hackers don't mind.
> >
> >   git rev-parse --parseopt gives consistency in how git parses options,
> > and it's A Good Thing=E2=84=A2
>=20
> I certainly think encouraging use of parse-options in new
> scripts is a good idea, even though I suspect "deprecated" above
> might be a bit too strong.

  Okay.

> I did not find accessible from the command line variant was the
> parse-opt-hidden feature, which was frustrating.

  Well, it's probably doable using some more magic flags, I can hack
something if you need to, I'll try to work something out during FOSDEM's
talks :)

> >   That makes me think that git-sh-setup(1) use should be documented in
> > gitcli(5), maybe even included, and git-sh-setup(1) should *definitely*
> > link to gitcli(5). We wondered where to link gitcli from, this is
> > definitely the place !
>=20
> Sounds good.  Please make it so.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHvxIvvGr7W6HudhwRAoBpAJ94F1Fg94fKQo2N8RzPaB+udDsLdQCeK5gP
kjvNhBwka/4JjNTqGhw2A8Q=
=zlEc
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
