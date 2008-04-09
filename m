From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Add --only-merges flag to display only merge commits.
Date: Wed, 9 Apr 2008 22:38:46 +0200
Message-ID: <20080409203846.GH11574@genesis.frugalware.org>
References: <20080408203648.GS11574@genesis.frugalware.org> <7v3apu6bes.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yFtM4vvgVM46ytb2"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 22:39:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjh4v-00039S-2g
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 22:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959AbYDIUit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 16:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753919AbYDIUit
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 16:38:49 -0400
Received: from virgo.iok.hu ([193.202.89.103]:51955 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753830AbYDIUit (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 16:38:49 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 783591B2511;
	Wed,  9 Apr 2008 22:38:47 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 7CB1744659;
	Wed,  9 Apr 2008 22:35:28 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id F0B0D1190A4E; Wed,  9 Apr 2008 22:38:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v3apu6bes.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79134>


--yFtM4vvgVM46ytb2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09, 2008 at 01:06:19PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> Miklos Vajna <vmiklos@frugalware.org> writes:
>=20
> > This is the opposite of git-rev-list --no-merges: It will hide commits
> > with single or no parent.
> >
> > It is useful if a maintainer has a lot of commits between tags and
> > usually each feature is developed in its own topic branch.
>=20
> For that particular use case, I'd suggest --first-parent.  It is not just
> about filtering the output but more importantly also affects the way the
> traversal is done (it does not descend into side branches).  It simply is
> more suited for the job you described.

Hm I was not exactly correct. Trivial fixes are pushed to master
directly, so just --first-parent won't solve my problem.

> It is very much unclear if the --only-merges is a very common thing for
> people to want to do, and it is very clear what --only-merges does is a
> very narrow single purpose filtering.

OK, that's something others should decide. :-) I find it useful but maybe
it's not commonly useful.

> Contrast that to existing --no-merges or --grep.  The former is a very
> narrow single purpose filtering but it is clearly something everybody
> would want to have.  The latter also satisfies a common desire, and it is
> an easy way to query with a customized filtering, e.g. you can use it like
> so: 'log --grep=3D"Merge " v1.5.4..v1.5.5'.

Oh, I forgot about --grep. Though I still think --only-merges would be a
solution and --grep=3D"Merge " is just a workaround, in practice it works
fine, so thanks for the hint. :-)

--yFtM4vvgVM46ytb2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkf9KVYACgkQe81tAgORUJaRmwCgk0e6H2stqYKsWBoUudcKBMpF
ttwAn0g7Sl+A0L70vIvaFQYaUKlr+Iqv
=c6PQ
-----END PGP SIGNATURE-----

--yFtM4vvgVM46ytb2--
