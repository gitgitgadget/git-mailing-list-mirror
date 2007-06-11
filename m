From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Does anyone have any benchmarks against CVS?
Date: Mon, 11 Jun 2007 15:30:43 -0700
Message-ID: <20070611223043.GE13515@curie-int.orbis-terrarum.net>
References: <20070611090451.26209.qmail@science.horizon.com> <46a038f90706111454i5f4898b5kd77d18f4a893904e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="84ND8YJRMFlzkrP4"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 00:30:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxsPJ-0000Wj-Uq
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 00:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbXFKWai (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 18:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755405AbXFKWai
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 18:30:38 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:58407 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755319AbXFKWae (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 18:30:34 -0400
Received: (qmail 31259 invoked from network); 11 Jun 2007 22:30:32 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Mon, 11 Jun 2007 22:30:32 +0000
Received: (qmail 26085 invoked by uid 10000); 11 Jun 2007 15:30:43 -0700
Content-Disposition: inline
In-Reply-To: <46a038f90706111454i5f4898b5kd77d18f4a893904e@mail.gmail.com>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49893>


--84ND8YJRMFlzkrP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2007 at 09:54:50AM +1200, Martin Langhoff wrote:
>  On 11 Jun 2007 05:04:51 -0400, linux@horizon.com <linux@horizon.com> wro=
te:
> > It seems to be common knowledge that git is a heck of a lot faster than
> > CVS at most operations, but I'd like to do a little evangelizing and
> > I can't seem to find a benchmark to support that claim.
>=20
>  It _will_ be a bit of an apple-to-oranges comparison, but you could
>  use a few large-ish projects that have a published GIT gateway.
>  Measure time and bw use of
>=20
>    - cvs co vs git clone
On the Git side, give breakdowns of the time for cloning with --bare
(git-fetch) and the separate actual checkout time.
Also compare the effects of shallow clones.

>    - cvs update vs git pull
Again, do both the git-fetch and git-merge portions.

>    - cvs log (at top level) vs git log
cvs history vs. git log might be more appropriate in the top level
sense.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--84ND8YJRMFlzkrP4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGbc0TPpIsIjIzwiwRAnyzAKCQN0JOa3MJ3sVTJqXlhTxoGuzwcQCfeYSt
XAgBia1eRK/8J9psnomnsWw=
=jh9G
-----END PGP SIGNATURE-----

--84ND8YJRMFlzkrP4--
