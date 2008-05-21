From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: Git-new-workdir
Date: Wed, 21 May 2008 19:44:46 +0100
Message-ID: <20080521184446.GA23924@bit.office.eurotux.com>
References: <63BEA5E623E09F4D92233FB12A9F794301FC8B1D@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Cc: git@vger.kernel.org
To: "Craig L. Ching" <cching@mqsoftware.com>
X-From: git-owner@vger.kernel.org Wed May 21 20:46:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JytJo-0007rf-Pu
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 20:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137AbYEUSoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 14:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756657AbYEUSoy
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 14:44:54 -0400
Received: from os.eurotux.com ([216.75.63.6]:47256 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755059AbYEUSox (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 14:44:53 -0400
Received: (qmail 17722 invoked from network); 21 May 2008 18:44:51 -0000
Received: from unknown (HELO bit.office.eurotux.com) (luciano@82.102.23.9)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 21 May 2008 18:44:51 -0000
Content-Disposition: inline
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F794301FC8B1D@emailmn.mqsoftware.com>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82564>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2008 at 01:21:22PM -0500, Craig L. Ching wrote:
> Hi all,
>=20
> I'm a bit of a newbie to Git, but I have started using it in earnest for
> the past couple of months.  I had asked on IRC about a potential problem
> I saw with git and how it fit into our workflow.  We currently use CVS
> and have used it for the past ten years.  A lot of us have grown
> accustomed to keeping multiple builds around for different things, e.g.
> defects we're working on, new features, etc., we do a lot of task
> switching and very rarely can we work on something start to finish
> without being interrupted with something else.  The normal workflow of
> git seems to cut across that need to keep many builds around.
> Generally, building our software is not trivial and takes a fair amount
> of time, so just "git checkout" out a new branch and rebuilding is not
> really an option for us.  I jumped on IRC while back and the contrib
> git-new-workdir was sugggested, but with the caveat that I should try
> and think outside the box before I adopted git-new-workdir.  So, I come
> here, after using Git for a couple of months and not seeing a way around
> this, asking if I'm missing something?  Should I be using
> git-new-workdir?  Or is there a better way that I have yet to see?  I'm
> sure the kernel developers must have this need as well, so it's quite
> possible I'm missing something.  I appreciate all feedback!

Personally, I'd clone a local rep for each build, with the -s option to
clone.

Something like:

git clone server:/rep ~/master
git clone -s ~/master build/abc
git clone -s ~/master build/foo
=2E..

The -s option should reduce disk-usage considerably.

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkg0bZ4ACgkQinSul6a7oB+ZlACdFk4E3cmmzerOclo5lnl/Ovlv
UlAAniVZNMsLvdaWPyXqdBjkGYVJkbUc
=bZjj
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
