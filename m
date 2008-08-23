From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [bug] git `next' does not do trivial merges
Date: Sat, 23 Aug 2008 08:08:39 +0200
Message-ID: <20080823060839.GB23800@genesis.frugalware.org>
References: <g8lmpn$jvk$1@ger.gmane.org> <20080822193117.GA6361@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E50aLcSU4JxQSj/B"
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 23 08:20:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWmUa-0005e6-Uo
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 08:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbYHWGIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 02:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751989AbYHWGIq
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 02:08:46 -0400
Received: from virgo.iok.hu ([193.202.89.103]:48281 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665AbYHWGIq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 02:08:46 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 93C611B2533;
	Sat, 23 Aug 2008 08:08:42 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A31524465E;
	Sat, 23 Aug 2008 07:10:42 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id E7C401770015; Sat, 23 Aug 2008 08:08:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080822193117.GA6361@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93426>


--E50aLcSU4JxQSj/B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2008 at 03:31:17PM -0400, Jeff King <peff@peff.net> wrote:
> On Fri, Aug 22, 2008 at 08:36:39AM +0200, Paolo Bonzini wrote:
>=20
> > I had already posted this bug report yesterday but it was hidden in a =
=20
> > cover letter at =20
> > http://permalink.gmane.org/gmane.comp.version-control.git/93143 -- so =
=20
> > I'll copy the relevant info here:
>=20
> Sadly, this bisects to 1c7b76b (Build in merge).

I guessed the bug is in builtin-merge.c::read_tree_trivial(), but I
don't see how it is different to builtin-read-tree.c::cmd_read_tree(),
at least the unpack_trees_options struct is the same.

I'm on it..

--E50aLcSU4JxQSj/B
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkivqWcACgkQe81tAgORUJavZACgocmeLWHq6GYeFt1fS2PX3+Q4
B9gAnRHqOPDpb5MIt07yQUbQJK4lrtjz
=TyNz
-----END PGP SIGNATURE-----

--E50aLcSU4JxQSj/B--
