From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [IRC/patches] Failed octopus merge does not clean up
Date: Wed, 17 Sep 2008 17:59:33 +0200
Message-ID: <20080917155933.GI4829@genesis.frugalware.org>
References: <200809160048.31443.trast@student.ethz.ch> <200809170053.15341.jnareb@gmail.com> <48D0A776.1000009@op5.se> <200809171011.06714.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2yB5+CA2g0IhBuTl"
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 18:00:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfzSN-0006r9-3q
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 18:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611AbYIQP7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 11:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753565AbYIQP7f
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 11:59:35 -0400
Received: from virgo.iok.hu ([193.202.89.103]:51824 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753380AbYIQP7f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 11:59:35 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 0F6421B2507;
	Wed, 17 Sep 2008 17:59:34 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id C5C144465E;
	Wed, 17 Sep 2008 17:59:33 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id B4AE411901A1; Wed, 17 Sep 2008 17:59:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809171011.06714.jnareb@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96123>


--2yB5+CA2g0IhBuTl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2008 at 10:11:02AM +0200, Jakub Narebski <jnareb@gmail.com>=
 wrote:
> >> BTW. does it mean that "git merge a b" might be not the same as
> >> "git merge b a"?
> >>=20
> >=20
> > No. Git merges all the sub-things together and then merges the result
> > of that jumble into the branch you're on.
> >=20
> > Someone might have to correct me on that, but that's as far as I've
> > understood it.
>=20
> From what I understand from above explanation, and from thread on git
> mailing list about better implementation of and documenting finding
> merge bases for multiple heads, I think octopus merge is done by merging
> [reduced] heads one by one into given branch.
>=20
> This means that "git merge a b" does internally "git merge a; git merge b"
> as I understand it.

Sure, but given that both 'a' and 'b' merged (so none of them is subset
of the other, for example so that reduce_heads() would drop one of them)
the order of the parents will be different so the resulting commit will
differ. The resulting tree will no, I think.

--2yB5+CA2g0IhBuTl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjRKWUACgkQe81tAgORUJZFIgCfe96Kqtv8rtW1T6UbFV0E0KWF
1BoAoJzD4y+6gor/eaQYZ809yUt2UIPu
=jbAx
-----END PGP SIGNATURE-----

--2yB5+CA2g0IhBuTl--
