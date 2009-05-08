From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: GPG signing for git commit?
Date: Fri, 8 May 2009 12:03:58 -0700
Message-ID: <robbat2.20090508T190254.538956494Z@orbis-terrarum.net>
References: <1238793954.19982.14.camel@hyperair-laptop> <alpine.LFD.2.00.0904031535140.3915@localhost.localdomain> <49D99BB2.2090906@vilain.net> <20090415185554.GG23644@curie-int> <fcaeb9bf0905062230h7ba9526fg6b79ddade72c072a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 21:05:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2VNN-0004UP-VZ
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 21:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758671AbZEHTEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 15:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754285AbZEHTEG
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 15:04:06 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:60599 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753881AbZEHTEF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 15:04:05 -0400
Received: (qmail 2180 invoked from network); 8 May 2009 19:04:02 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Fri, 08 May 2009 19:04:02 +0000
Received: (qmail 14993 invoked by uid 10000); 8 May 2009 12:03:58 -0700
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0905062230h7ba9526fg6b79ddade72c072a@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118625>


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2009 at 03:30:51PM +1000, Nguyen Thai Ngoc Duy wrote:
> On Thu, Apr 16, 2009 at 4:55 AM, Robin H. Johnson <robbat2@gentoo.org> wr=
ote:
> > One of the spots that we're looking for in this, is a model something
> > like what follows. Firstly, a "proxy maintainer" (PM) is a developer
> > with commit rights to the central repo, that's willing to proxy commits
> > by an outside source for some specific package. Think of them as the
> > kernel subsystem maintainer, but many more of them. The PM is still
> > expected to verify the work before passing it on the central repo.
> >
> > So we have a commit with author+committer being the outside source, and
> > now we want to record (in an easily reviewable fashion) that a specific
> > changeset was introduced to the central tree by the PM.
> >
> > Not sure of the best route to trace this data. Signing the SHA1 makes
> > the most sense, but need to be able to do that without polluting the tag
> > namespace.
> >
> > If the changeset does not have an associated signature, we'd like to
> > reject it at the central repo.
> How about signing the tree SHA-1 and putting the signature in commit
> message? It's like gpg way of saying Signed-off-by. If the committer
> wants to sign again before pushing out, he could amend the commit,
> append his signature there; or make a no-change commit to contain his
> signature (probably from git-commit-tree because iirc git-commit won't
> let you make no-change commit)
Hmm, I like the sound of that, but I'm concerned it might be difficult
to enforce. If rewrite-history ever happens, it's also invalidated.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAkoEgh0ACgkQPpIsIjIzwizDogCdHb2t0EzWRFEs1TAce4WrblJ6
KB0An0iD/Fv58fLWEmiSAb67vl/ygqP6
=gPh+
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
