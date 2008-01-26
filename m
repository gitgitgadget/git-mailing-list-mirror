From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Check for -amend as a common wrong usage of --amend.
Date: Sat, 26 Jan 2008 11:42:16 +0100
Message-ID: <20080126104216.GA13922@artemis.madism.org>
References: <1201198439-3516-1-git-send-email-pascal@obry.net> <alpine.LSU.1.00.0801241818441.5731@racer.site> <4798DE6A.1050201@obry.net> <20080124204711.GC17765@kodama.kitenet.net> <7vd4rp3y6e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="AqsLC8rIMeq19msA";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 11:42:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIiUw-0008Cm-1L
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 11:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589AbYAZKmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 05:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754542AbYAZKmV
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 05:42:21 -0500
Received: from pan.madism.org ([88.191.52.104]:35053 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753960AbYAZKmU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 05:42:20 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 71BB92BAF7;
	Sat, 26 Jan 2008 11:42:17 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id D96134D66FF; Sat, 26 Jan 2008 11:42:16 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Joey Hess <joey@kitenet.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vd4rp3y6e.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71773>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 26, 2008 at 06:20:41AM +0000, Junio C Hamano wrote:
> Joey Hess <joey@kitenet.net> writes:
>=20
> > Some option parsers avoid this sort of ambiguity by not allowing short
> > options that take a string to be bundled in the same word with other
> > short options.
> >
> > So, for example, git-commit -am<msg> would not be allowed, while
> > git-commit -a -m<msg> and perhaps git-commit -am <msg> would be allowed.
> >
> > There could still be problems if there were a --mend option that could
> > be typoed as -mend.
> >
> > I don't know enough about compatability to say if this would work for g=
it.
>=20
> Yeah, I think that is quite a sensible workaround.

  I agree, I think that we should refuse things where the string after a
/one/ dash starts with 3 or more consecutive characters that are also
the beginning of a long option. I think that 2 is usually a bit "short"
to assume that it's a typo. I'll provide a patch soon

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHmw6IvGr7W6HudhwRAsK4AJ9BHlIK9MGtk2po/XxhB6eoEn3RpgCdE1T7
zd40/ibV9qaye6So2v0bTIU=
=WMNS
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
