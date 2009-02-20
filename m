From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 1/8] builtin-apply: use warning() instead of
	fprintf(stderr, "warning: ")
Date: Fri, 20 Feb 2009 10:41:03 +0100
Message-ID: <20090220094103.GY4371@genesis.frugalware.org>
References: <200902190736.49161.johnflux@gmail.com> <20090219081725.GB7774@coredump.intra.peff.net> <20090219120708.GM4371@genesis.frugalware.org> <20090219122104.GA4602@sigill.intra.peff.net> <4f61642d10063adbff86094e91b1b6e90efabe8e.1235047192.git.vmiklos@frugalware.org> <20090220030245.GC22419@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6JKsAUbrJhuSllgx"
Cc: Junio C Hamano <gitster@pobox.com>,
	John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 20 10:42:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaRu0-0001As-Cj
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 10:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947AbZBTJlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 04:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbZBTJlH
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 04:41:07 -0500
Received: from virgo.iok.hu ([212.40.97.103]:51514 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752500AbZBTJlG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 04:41:06 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 0C3F95808C;
	Fri, 20 Feb 2009 10:41:05 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 9A50D446A6;
	Fri, 20 Feb 2009 10:41:03 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id B6EE511B877C; Fri, 20 Feb 2009 10:41:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090220030245.GC22419@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110830>


--6JKsAUbrJhuSllgx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2009 at 10:02:45PM -0500, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 19, 2009 at 01:53:10PM +0100, Miklos Vajna wrote:
>=20
> > @@ -2932,8 +2932,7 @@ static int write_out_one_reject(struct patch *pat=
ch)
> >  	cnt =3D strlen(patch->new_name);
> >  	if (ARRAY_SIZE(namebuf) <=3D cnt + 5) {
> >  		cnt =3D ARRAY_SIZE(namebuf) - 5;
> > -		fprintf(stderr,
> > -			"warning: truncating .rej filename to %.*s.rej",
> > +		warning("truncating .rej filename to %.*s.rej",
> >  			cnt - 1, patch->new_name);
> >  	}
>=20
> Hmm. This hunk is actually changing behavior, as the original didn't
> have a newline. It looks like a bug in the original, though.

I think so. The change in 5/8 (git-rm) is a similar one.

--6JKsAUbrJhuSllgx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmeeq8ACgkQe81tAgORUJbR+gCdEYOkrIB5jlv8hEWNcsCtYwOV
41cAn2+nMIfkTJGcv0+3FSSS1yK3jKXM
=LjEd
-----END PGP SIGNATURE-----

--6JKsAUbrJhuSllgx--
