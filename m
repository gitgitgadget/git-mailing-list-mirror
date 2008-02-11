From: Sebastian Harl <sh@tokkee.org>
Subject: Re: [Feature Request] Better Subversion integration
Date: Mon, 11 Feb 2008 09:47:04 +0100
Message-ID: <20080211084704.GB20741@albany.tokkee.org>
References: <FC5B6F22-27A9-4F0F-85EE-0B72B94C69E2@gmail.com> <20080210035611.GA2454@atjola.homenet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkhOn4hPPRcnTymj"
Cc: Sam Granieri Jr <sjgdev@gmail.com>,
	Git Users List <git@vger.kernel.org>
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 11 10:09:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOUf5-0002GQ-7n
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 10:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbYBKJIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 04:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbYBKJIV
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 04:08:21 -0500
Received: from mail.tokkee.org ([212.114.247.92]:39552 "EHLO albany.tokkee.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751051AbYBKJIT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 04:08:19 -0500
X-Greylist: delayed 1273 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Feb 2008 04:08:19 EST
Received: by albany.tokkee.org (Postfix, from userid 1000)
	id C440A364001; Mon, 11 Feb 2008 09:47:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080210035611.GA2454@atjola.homenet>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73487>


--FkhOn4hPPRcnTymj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Feb 10, 2008 at 04:56:11AM +0100, Bj=F6rn Steinbrink wrote:
> On 2008.02.09 20:44:59 -0600, Sam Granieri Jr wrote:
> > Right now, git-svn import (or clone) will convert tags and branches as =
=20
> > remote branches.
> > I would like it if git could pick up subversion tags and translate them=
=20
> > as git tags upon importing
>=20
> SVN tags aren't like git tags. A "tag" in SVN is just another directory,
> which you can modify at will.

Well, a SVN tag could be represented as a Git branch _and_ a Git tag
pointing to the head of that branch. Whenever any such "tag branch"
advances, the user should be notified, the user responsible for the
further commits to the SVN "tag" should be seriously hurt and the Git
tag should be overwritten (git tag -f).

Sam, is that basically what you want?

Cheers,
Sebastian

--=20
Sebastian "tokkee" Harl +++ GnuPG-ID: 0x8501C7FC +++ http://tokkee.org/

Those who would give up Essential Liberty to purchase a little Temporary
Safety, deserve neither Liberty nor Safety.         -- Benjamin Franklin


--FkhOn4hPPRcnTymj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHsAuIEFEKc4UBx/wRAmpZAKCYIq6CDNpGTed4KozR/Ht+vJKmRgCfZWAq
2Z8f93fTsbodf984ELv/qNM=
=mz2n
-----END PGP SIGNATURE-----

--FkhOn4hPPRcnTymj--
