From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [RFC] git-mergetool: show original branch names when possible
Date: Mon, 20 Aug 2007 20:17:25 +0200
Message-ID: <20070820181725.GB8542@efreet.light.src>
References: <20070820075318.GA12478@coredump.intra.peff.net> <7vabsmtxsg.fsf@gitster.siamese.dyndns.org> <20070820085246.GA23764@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 20 20:17:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INBol-0006rQ-Lr
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 20:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbXHTSRc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 14:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752274AbXHTSRc
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 14:17:32 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:39829 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183AbXHTSRc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 14:17:32 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 0BC9C5736A;
	Mon, 20 Aug 2007 20:17:31 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id O+XvFOE6F0J8; Mon, 20 Aug 2007 20:17:26 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 5E219572A2;
	Mon, 20 Aug 2007 20:17:26 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1INBob-0006af-Dy; Mon, 20 Aug 2007 20:17:25 +0200
Content-Disposition: inline
In-Reply-To: <20070820085246.GA23764@coredump.intra.peff.net>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56234>


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2007 at 04:52:47 -0400, Jeff King wrote:
> On Mon, Aug 20, 2007 at 01:28:31AM -0700, Junio C Hamano wrote:
> > > 2. It looks like doing an anonymous 'git-pull' leaves GITHEAD_* as the
> > > commit sha1, which means you will end up with that sha1 rather than
> > > 'REMOTE', which is less nice than the current behavior.
> >=20
> > Much less nice indeed.
>=20
> I think this is a failing of git-merge, though, for not including that
> nice human-readable information. We can fix it with something like this:

Maybe you could call git-name-rev on it if it does not come with
a human-readable name.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGydq1Rel1vVwhjGURAqaTAJ9AMUN2OSh2Dl9fvvDntHLQdNg7bQCgs9Nf
JPNCI5cEe8/gB6pl78T/0DU=
=oXQy
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
