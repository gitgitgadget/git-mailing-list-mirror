From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Segfault on merge with 1.6.2.1
Date: Wed, 1 Apr 2009 11:50:14 +0200
Message-ID: <20090401095014.GT22446@genesis.frugalware.org>
References: <op.urifmtkkso3nzr@sulidor.mdjohnson.us> <20090329121700.GN22446@genesis.frugalware.org> <op.urk20nanso3nzr@sulidor.mdjohnson.us> <20090330110335.GF22446@genesis.frugalware.org> <op.urnad7jbso3nzr@sulidor.mdjohnson.us> <op.uro0u0xuso3nzr@sulidor.mdjohnson.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cxfMsoqvp1jUizWj"
Cc: git@vger.kernel.org
To: Michael Johnson <redbeard@mdjohnson.us>
X-From: git-owner@vger.kernel.org Wed Apr 01 11:51:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lox6t-0007HS-Gi
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 11:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbZDAJuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 05:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbZDAJuT
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 05:50:19 -0400
Received: from virgo.iok.hu ([212.40.97.103]:40147 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752180AbZDAJuR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 05:50:17 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 0A5D2580BD;
	Wed,  1 Apr 2009 11:50:15 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B964A44783;
	Wed,  1 Apr 2009 11:50:14 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 4932E11F0824; Wed,  1 Apr 2009 11:50:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <op.uro0u0xuso3nzr@sulidor.mdjohnson.us>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115362>


--cxfMsoqvp1jUizWj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2009 at 12:43:38AM -0500, Michael Johnson <redbeard@mdjohns=
on.us> wrote:
> Anyway, I decided to try an experiment, as I had mentioned to someone tha=
t =20
> if I couldn't get this bug tracked down, I'd have to do the merge =20
> manually. So... I figured out the common ancestor (I used git show-branch=
, =20
> but I'm betting there's an easier way), and merged the ancestor + 1 of th=
e =20
> other branch into my HEAD. It segfaulted. So, I tried the resolve strateg=
y =20
> at the same point. Amazingly, it worked. And a default recursive merge =
=20
> handled the rest.

I initially replied to this thread as I wasn't sure if it's a bug in
merge-recursive or builtin-merge itself. I'm not that familiar with
merge-recursive, that's why I didn't reply so far. ;-)

> In short, I don't personally need a fix right now, but I can help figure =
=20
> out what is broken with it.

If you don't need rename detection, you can merge with '-s resolve', I
think that would do what you need and it avoids the problematic
codepath.

--cxfMsoqvp1jUizWj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknTONYACgkQe81tAgORUJYPNACgkJ4e7E+21LHcD6a4Pn457aqt
Ok8An2F3HXMC5KTGJWQiWuYaEgrs5UO9
=GkI4
-----END PGP SIGNATURE-----

--cxfMsoqvp1jUizWj--
