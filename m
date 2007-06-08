From: Jan Hudec <bulb@ucw.cz>
Subject: Re: gitk highlighting commits
Date: Fri, 8 Jun 2007 23:11:33 +0200
Message-ID: <20070608211133.GB4084@efreet.light.src>
References: <20070608084501.1b66f16a@localhost.localdomain> <20070608065739.GC18521@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Cc: picca <picca@synchrotron-soleil.Fr>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 08 23:11:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwlk9-00084m-Mk
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 23:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756241AbXFHVLg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 17:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753357AbXFHVLg
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 17:11:36 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:40539 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752050AbXFHVLf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 17:11:35 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 61AA157273;
	Fri,  8 Jun 2007 23:11:34 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1Hwlk5-0001pV-I1; Fri, 08 Jun 2007 23:11:33 +0200
Content-Disposition: inline
In-Reply-To: <20070608065739.GC18521@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49501>


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2007 at 02:57:39 -0400, Shawn O. Pearce wrote:
> picca <picca@synchrotron-soleil.Fr> wrote:
> > I am using git to follow the wine development. And I wondering if it
> > is possible to highlight all the commit since my last git pull ?
>=20
> If you do it *right after* the pull, you can see those commits that
> are new to you with:
>=20
> 	gitk ORIG_HEAD..
>=20
> ORIG_HEAD is a special name for the commit that you had just before
> you pulled.  So you are asking gitk to show you all commits that
> are now in your current branch (implied by nothing to the right of
> the ..) that were not in your branch before the pull (ORIG_HEAD).
> That is the stuff you just pullled.
>=20
> If its many days later that you want to look at this and you have
> done some things that overwrite ORIG_HEAD (git reset; git rebase;
> etc.)  then this becomes more difficult.  But you can also do by
> time:
>=20
>   gitk HEAD@{2.days.ago}..

There is actually one ref which only changes in pulls (and fetches) -- the
tracking brach. Therefore:

gitk origin/master@{1}..

(or whatever you pull) is what you want.

> This shows you everything that is new *to you* in the past two days.
> Even if the changes were created months ago and just recently were
> pulled by you yesterday, they will appear in gitk, because you asked
> for *your* history over the past two days, not the project history.
>=20
> These same tricks also work with git-log of course:
>=20
>   git log ORIG_HEAD...
>   git log HEAD@{2.days.ago}..
>=20
> You could also take a look at the manual page for git-rev-parse,
> there are some more details covered there I think.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGacYFRel1vVwhjGURAgCiAJoCretSxqYc+P7OBtBAVsxadBtLMQCdHdyT
UNowNk/BwuFYLJDfTIFwwKc=
=9pm4
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
