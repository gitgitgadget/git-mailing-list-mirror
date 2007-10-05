From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [ALTERNATE PATCH] Add a simple option parser.
Date: Fri, 05 Oct 2007 18:49:23 +0200
Message-ID: <20071005164923.GF20305@artemis.corp>
References: <1191447902-27326-1-git-send-email-krh@redhat.com> <20071005142140.GK19879@artemis.corp> <20071005142507.GL19879@artemis.corp> <20071005143014.GA18176@glandium.org> <20071005144540.GM19879@artemis.corp> <598D5675D34BE349929AF5EDE9B03E2701624FD6@az33exm24.fsl.freescale.net> <20071005155647.GC20305@artemis.corp> <598D5675D34BE349929AF5EDE9B03E2701624FF2@az33exm24.fsl.freescale.net> <alpine.LFD.0.999.0710050924530.23684@woody.linux-foundation.org> <598D5675D34BE349929AF5EDE9B03E270162501A@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Il7n/DHsA0sMLmDu";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mike Hommey <mh@glandium.org>,
	Kristian H?gsberg <krh@redhat.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Medve Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 18:49:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdqN0-0007MB-0e
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 18:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756898AbXJEQt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 12:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755680AbXJEQt0
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 12:49:26 -0400
Received: from pan.madism.org ([88.191.52.104]:42729 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754157AbXJEQtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 12:49:25 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id F3F552391D;
	Fri,  5 Oct 2007 18:49:23 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 603F31E328; Fri,  5 Oct 2007 18:49:23 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Medve Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mike Hommey <mh@glandium.org>, Kristian H?gsberg <krh@redhat.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E270162501A@az33exm24.fsl.freescale.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60113>


--Il7n/DHsA0sMLmDu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 05, 2007 at 04:41:48PM +0000, Medve Emilian-EMMEDVE1 wrote:
> Hello Linus,
>=20
>=20
> > On Fri, 5 Oct 2007, Medve Emilian-EMMEDVE1 wrote:
> > > >=20
> > > >   Because it's GNU and that it's a heavy dependency to begin with.
> > >=20
> > > So it's more of a political decision then a technical one?
> >=20
> > I'd *strongly* argue against new dependencies unless they buy us
> > something major.
> >=20
> > We've been good at cutting them down, including any required
> > libraries internally. We shouldn't add new ones.
> >=20
> > So we'd have to include GNU getopt sources with the git tree, at
> > which point any advantage would be gone. Might as well include a
> > private and simpler version of our own.
>=20
>=20
> From what I understand argp is part of glibc.

  And of course requiring the glibc would be a big step forward for the
msys (or AIX, or HP-UX, or =E2=80=A6) port !

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Il7n/DHsA0sMLmDu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHBmsTvGr7W6HudhwRAqVcAJ4msgmVqeOrpO4HvzMUHNdm0FbDTACfdNRm
dhN1Gor3nuPQdwzdj8YzPBw=
=yPj6
-----END PGP SIGNATURE-----

--Il7n/DHsA0sMLmDu--
