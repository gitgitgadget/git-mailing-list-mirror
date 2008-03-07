From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] unquote_c_style: fix off-by-one.
Date: Fri, 07 Mar 2008 01:44:01 +0100
Message-ID: <20080307004401.GA13642@artemis.madism.org>
References: <20080306212819.GA10873@artemis.madism.org> <7vbq5ra4gu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="tThc/1wpZn/ma/RB";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git ML <git@vger.kernel.org>, dato@net.com.org.es
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 01:44:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXQhj-0008O2-3F
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 01:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764867AbYCGAoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 19:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765119AbYCGAoG
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 19:44:06 -0500
Received: from pan.madism.org ([88.191.52.104]:33332 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764867AbYCGAoE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 19:44:04 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 267CE31CE9;
	Fri,  7 Mar 2008 01:44:02 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 6A0424CDF; Fri,  7 Mar 2008 01:44:01 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>,
	dato@net.com.org.es
Content-Disposition: inline
In-Reply-To: <7vbq5ra4gu.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76438>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2008 at 10:10:41PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > Thanks to Adeodato Sim=C3=B2 for having caught this.
> >
> > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
>=20
> Thanks.  I would have appreciated a comment that said something about what
> external breakages this one caused, so that we can have an entry in "bugs
> fixed" list.
>=20
> A quick audit of the existing callers suggests that it is fast-import.

  I actually don't really know, Adeodato asked me to look into it
because I was the last that touched it, you have to ask him why he found
this :)

  I Cc'd him.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH0I/RvGr7W6HudhwRAkCfAJ9wprraUXOwmU/WPCJdkz/0WV/dqwCfd9ZZ
VGkbXBpUMwiPYwWZLOVQx/Q=
=6gSz
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
