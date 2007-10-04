From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Add a simple option parser.
Date: Thu, 04 Oct 2007 18:31:56 +0200
Message-ID: <20071004163156.GD5083@artemis.corp>
References: <1191447902-27326-1-git-send-email-krh@redhat.com> <20071003231145.GF28188@artemis.corp> <1191509878.29379.2.camel@hinata.boston.redhat.com> <20071004151532.GB5083@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="veXX9dWIonWZEC6h";
	protocol="application/pgp-signature"; micalg=SHA1
To: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 04 18:32:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdTcp-0000j9-EH
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 18:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757571AbXJDQcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 12:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757934AbXJDQcA
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 12:32:00 -0400
Received: from pan.madism.org ([88.191.52.104]:54306 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756851AbXJDQb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 12:31:59 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id AB2E523687;
	Thu,  4 Oct 2007 18:31:57 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id DC6B61023D1; Thu,  4 Oct 2007 18:31:56 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <20071004151532.GB5083@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59981>


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On jeu, oct 04, 2007 at 03:15:32 +0000, Pierre Habouzit wrote:
> On Thu, Oct 04, 2007 at 02:57:58PM +0000, Kristian H=C3=B8gsberg wrote:
> > I'm not sure - we can go with the current proposal and add new options
> > types and probably the callback option type I suggested as we go.  I
> > don't want to block builtin-commit on figuring out what the perfect
> > option parser should look like and what I sent out earlier work for
> > commit.  I think the way you handled the strbuf rewrites worked pretty
> > well; extending and rewriting the API as you put it to use in more and
> > more places.  We can do the same thing with parse_options().
>=20
>   Of course we can do that, or junio said that some people talked about
> popt some time ago. I understand that you don't want to block the
> git-commit work, but doing things right from the beginning is often a
> big win on the long term.
>=20
>   I don't know popt, and I don't know if it has sufficient expressivity.
> For sure I don't like getopt_long APIs at all, so if popt is as
> cumbersome, rolling our own based on the current parse_options you
> propose is probably a good choice.

  Okay, popt seems to be quite complicated, and depends upon gettext
(which we may require as per survey results, but right now it seems a
useless dependency). Don't get me wrong, I'm sure it's very powerful,
but again, I believe we can have a 200 line ad-hoc module that fits what
git really needs, the less cumbersome way.

  So well, I'd be (I'm not in position to decide anything btw ;p) in
favor of pursuing the work into git-commit like you did, and ASAP it
gets merged into next, I'm definitely willing to pursue a refactoring to
use it (now that strbufs seems to have been used where needed).

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHBRV8vGr7W6HudhwRAqvvAJ9K3x4Jigu+rb42HQe/pOfRo0EgRwCfcYP9
nQjKl0vszkhasVTG85yTn1Q=
=fRUD
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--
