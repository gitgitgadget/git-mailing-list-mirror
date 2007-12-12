From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [(not so) random thoughts] using git as its own caching tool
Date: Wed, 12 Dec 2007 17:27:42 +0100
Message-ID: <20071212162742.GE14538@artemis.madism.org>
References: <20071212003813.GG29110@artemis.madism.org> <475FFFB7.4010102@op5.se>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="98e8jtXdkpgskNou";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git ML <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Dec 12 17:28:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2URK-0004OG-Lc
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 17:28:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220AbXLLQ1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 11:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754825AbXLLQ1p
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 11:27:45 -0500
Received: from pan.madism.org ([88.191.52.104]:33787 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752957AbXLLQ1o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 11:27:44 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 592FB2F99B;
	Wed, 12 Dec 2007 17:27:43 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 0E8C346923B; Wed, 12 Dec 2007 17:27:42 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Andreas Ericsson <ae@op5.se>, Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <475FFFB7.4010102@op5.se>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68071>


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2007 at 03:35:19PM +0000, Andreas Ericsson wrote:
> Pierre Habouzit wrote:
> >  So am I having crazy thoughts and should I throw my crack-pipe away ?
> >Or does parts of this mumbling makes any sense to someone ?
>=20
> A bit of both ;-)
>=20
> I like the idea to use the git object store, because that certainly
> has an API that can't be done away with by user config. The reflog
> and its expiration mechanism is subject to human control though, and
> everyone doesn't even have them enabled. I don't for some repos where
> I know I'll create a thousand-and-one loose objects by rebasing,
> --amend'ing and otherwise fiddling with history rewrites.
>=20
> Having a tool that works on some repos but not on others because it
> relies on me living with an auto-gc after pretty much every operation
> would be very tiresome indeed.

  Well if you disable the reflog on some repositories, those commands
will just be slow. But would still work.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHYAv+vGr7W6HudhwRAoYGAJ9W9eD9/p5pI25emLylwWPuFTUfYgCgqfPK
Qr5Scnb7bwR2Z/IT2qH4NFY=
=iM29
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
