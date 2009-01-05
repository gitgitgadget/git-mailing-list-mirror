From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH v2] parse-opt: migrate builtin-apply.
Date: Mon, 05 Jan 2009 20:12:22 +0100
Message-ID: <20090105191222.GA14793@artemis.corp>
References: <1230387764-11230-1-git-send-email-vmiklos@frugalware.org> <7vvdt5cmu6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="u3/rZRmxL6MmkK24";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 05 20:14:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJutt-0006lM-0C
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 20:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbZAETM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 14:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752638AbZAETM2
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 14:12:28 -0500
Received: from pan.madism.org ([88.191.52.104]:59501 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752685AbZAETM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 14:12:27 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 52BC93BA67;
	Mon,  5 Jan 2009 20:12:23 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 936969B8F42; Mon,  5 Jan 2009 20:12:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vvdt5cmu6.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104594>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2008 at 09:47:13PM +0000, Junio C Hamano wrote:
> Miklos Vajna <vmiklos@frugalware.org> writes:
>=20
> > +static int option_parse_inaccurate(const struct option *opt,
> > +				   const char *arg, int unset)
> > +{
> > +	options |=3D INACCURATE_EOF;
> > +	return 0;
> > +}
> > +
> > +static int option_parse_recount(const struct option *opt,
> > +				const char *arg, int unset)
> > +{
> > +	options |=3D RECOUNT;
> > +	return 0;
> > +}
>=20
> I still haven't applied and ran the testsuite myself, but these makes me
> wonder if there isn't a built-in "bit" type support in parse_options().

There is.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkliW5UACgkQvGr7W6HudhyvzACfSt0a8zp0ZF1nUdblYH62syuT
96EAoIw/kYxdiTZZUFUdwcP1bSBpcqTg
=bAvN
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
