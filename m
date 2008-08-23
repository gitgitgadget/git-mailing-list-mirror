From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: strange temporary pull-errors
Date: Sat, 23 Aug 2008 19:35:48 +0200
Message-ID: <20080823173548.GD23800@genesis.frugalware.org>
References: <20080822191324.GO10819@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K5roPakIqCb4O6y8"
Cc: git@vger.kernel.org
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Sat Aug 23 19:38:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWx4S-0001ZN-G6
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 19:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbYHWRfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 13:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752760AbYHWRfu
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 13:35:50 -0400
Received: from virgo.iok.hu ([193.202.89.103]:49398 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752692AbYHWRfu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 13:35:50 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 988E31B2528;
	Sat, 23 Aug 2008 19:35:48 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id C92AC4465E;
	Sat, 23 Aug 2008 18:37:35 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3B7D8119003C; Sat, 23 Aug 2008 19:35:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080822191324.GO10819@cs-wsok.swansea.ac.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93467>


--K5roPakIqCb4O6y8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2008 at 08:13:24PM +0100, Oliver Kullmann <O.Kullmann@swans=
ea.ac.uk> wrote:
> > git pull
> Updating 688e3cb..d9b9324
> error: Entry 'Buildsystem/Configuration/Html/local_html.mak' not uptodate=
=2E Cannot mer
> ge.
> > git status
> # On branch master
> # Your branch is behind 'origin/master' by 3 commits, and can be fast-for=
warded.
> #
> nothing to commit (working directory clean)
> > git pull
> Updating 688e3cb..d9b9324
> Fast forward
>  Buildsystem/Configuration/Html/local_html.mak      |    3 +
>  .../Configuration/ReleaseProcess/ReleaseHistory    |    1 +
>  Buildsystem/Html/Local/History.html                |   11 +++-
>  Buildsystem/Html/Local/PackageHistory.html         |   52 ++++++++++++++=
++++++
>  Buildsystem/Html/Local/plans/History.hpp           |    2 +-
>  Buildsystem/Html/Local/plans/milestones.hpp        |    4 +-
>  Buildsystem/OKlibBuilding/Targets/html/Makefile    |    1 +
>  Buildsystem/ReleaseProcess/README                  |    9 +++-
>  Buildsystem/ReleaseProcess/plans/general.hpp       |    5 +-
>  Buildsystem/ReleaseProcess/plans/milestones.hpp    |    4 +-
>  plans/general.hpp                                  |    7 ++-
>  11 files changed, 87 insertions(+), 12 deletions(-)
>  create mode 100644 Buildsystem/Html/Local/PackageHistory.html
>=20
>=20
> There is nothing special going out, the simple pull should succeed, but
> I have to try several times; don't know whether the "git status" is
> instrumental here or not --- will try the next time.

Yes, it is. It runs git update-index --refresh.

I think Junio fixed this two days ago in 9ca8f60 ("git-merge": allow
fast-forwarding in a stat-dirty tree). Could you please confirm?

Thanks.

--K5roPakIqCb4O6y8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiwSnQACgkQe81tAgORUJY4SwCcDG6+cx9Pf7iFEz+OCfxo99nR
X80AmwYn65LbNdz3WA9kLGUJOWP14m7c
=Q46y
-----END PGP SIGNATURE-----

--K5roPakIqCb4O6y8--
