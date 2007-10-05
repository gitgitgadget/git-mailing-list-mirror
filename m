From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [ALTERNATE PATCH] Add a simple option parser.
Date: Fri, 05 Oct 2007 18:38:46 +0200
Message-ID: <20071005163846.GE20305@artemis.corp>
References: <1191447902-27326-1-git-send-email-krh@redhat.com> <20071005142140.GK19879@artemis.corp> <20071005142507.GL19879@artemis.corp> <20071005143014.GA18176@glandium.org> <20071005144540.GM19879@artemis.corp> <598D5675D34BE349929AF5EDE9B03E2701624FD6@az33exm24.fsl.freescale.net> <20071005155647.GC20305@artemis.corp> <598D5675D34BE349929AF5EDE9B03E2701624FF2@az33exm24.fsl.freescale.net> <86wsu1v8ha.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="FN+gV9K+162wdwwF";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 18:38:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdqCX-0002el-Vo
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 18:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754873AbXJEQis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 12:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755284AbXJEQis
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 12:38:48 -0400
Received: from pan.madism.org ([88.191.52.104]:41927 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753675AbXJEQir (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 12:38:47 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 62B3823902;
	Fri,  5 Oct 2007 18:38:46 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 091131E16F; Fri,  5 Oct 2007 18:38:46 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	David Kastrup <dak@gnu.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <86wsu1v8ha.fsf@lola.quinscape.zz>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60109>


--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 05, 2007 at 04:20:33PM +0000, David Kastrup wrote:
> "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com> writes:
>=20
> > Hi Pierre,
> >
> >> -----Original Message-----
> >> From: Pierre Habouzit [mailto:madcoder@debian.org]=20
> >> Sent: Friday, October 05, 2007 10:57 AM
> >> To: Medve Emilian-EMMEDVE1
> >> Cc: Mike Hommey; Kristian H=C3=B8gsberg; git@vger.kernel.org;=20
> >> Junio C Hamano
> >> Subject: Re: [ALTERNATE PATCH] Add a simple option parser.
> >>=20
> >> On ven, oct 05, 2007 at 03:45:36 +0000, Medve Emilian-EMMEDVE1 wrote:
> >> > You probably already considered and rejected the GNU argp parser. I
> >> > used it before and I'd like to know reasons I should stay away from
> >> > it.
> >>=20
> >>   Because it's GNU and that it's a heavy dependency to begin with.
> >
> > So it's more of a political decision then a technical one?
>=20
> Well, if it is GNU then it is likely to mean GPLv3 (or GPLv3+) at some
> point of time, though it should certainly be possible for now to still
> secure a v2-licensed version (either GPL or LGPL).

  That is an issue indeed.

> And the typical git developer AFAICT prefers to consider themselves as
> unaligned with GNU and the FSF as much as possible.

  And is nothing near reality in my case.

  The real issue is dependency and bloat. getopt_long would need the GNU
implementation, That I believe depends upon gettext, and argp is just
bloated, and I'm not even sure it's distributed outside from the glibc
anyways.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--FN+gV9K+162wdwwF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHBmiWvGr7W6HudhwRAoHlAJ9ckyL70UvzCxS6FkVUtq96S1DsHQCePgNc
X4FA2hVmLajJsG6Wc7Nt0r8=
=96K3
-----END PGP SIGNATURE-----

--FN+gV9K+162wdwwF--
