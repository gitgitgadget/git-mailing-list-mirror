From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [RFC] git-mergetool: show original branch names when possible
Date: Tue, 21 Aug 2007 16:59:43 +0200
Message-ID: <20070821145943.GI8542@efreet.light.src>
References: <20070820075318.GA12478@coredump.intra.peff.net> <7vabsmtxsg.fsf@gitster.siamese.dyndns.org> <20070820085246.GA23764@coredump.intra.peff.net> <20070820181725.GB8542@efreet.light.src> <20070821061014.GB7323@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u/L2/WlOHZg+YGU4"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 21 16:59:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INVD1-0007xy-Qv
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 16:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758257AbXHUO7w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 10:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758496AbXHUO7w
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 10:59:52 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:50793 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757334AbXHUO7v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 10:59:51 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 6C0985735B;
	Tue, 21 Aug 2007 16:59:50 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id HUglMyuafiqw; Tue, 21 Aug 2007 16:59:49 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 2F2EE57506;
	Tue, 21 Aug 2007 16:59:46 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1INVCp-0002Sd-D7; Tue, 21 Aug 2007 16:59:43 +0200
Content-Disposition: inline
In-Reply-To: <20070821061014.GB7323@coredump.intra.peff.net>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56298>


--u/L2/WlOHZg+YGU4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2007 at 02:10:14 -0400, Jeff King wrote:
> On Mon, Aug 20, 2007 at 08:17:25PM +0200, Jan Hudec wrote:
>=20
> > > I think this is a failing of git-merge, though, for not including that
> > > nice human-readable information. We can fix it with something like th=
is:
> >=20
> > Maybe you could call git-name-rev on it if it does not come with
> > a human-readable name.
>=20
> I considered that, but it has two drawbacks:
>=20
>   1. It does not handle pulls which have no tracking branch (the only
>      ref we have is FETCH_HEAD, which is not a useful name :) ).

If there's no useful name, than it's probably hard to do anything at all
about it. Though FETCH_HEAD is not all that useless -- it at least says it =
is
that that you pull.

>   2. In some circumstances, it can come up with counter-intuitive
>      names. If more than one ref points to a given commit, then you can
>      end up with something like "git-merge foo" telling you all about
>      the merge conflicts with "bar". But perhaps that is too obscure a
>      corner case to worry about.

I meant it as a fallback, for cases where it for some reason can't be
recorded or is not recorded. Recording it is obviously better.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--u/L2/WlOHZg+YGU4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGyv3fRel1vVwhjGURAt7oAKDo6YHMbQTM96Tk7oRoUdPtc+uLXQCfabwD
GIaTwZGUHFKuTnErWH16NLU=
=lpIn
-----END PGP SIGNATURE-----

--u/L2/WlOHZg+YGU4--
