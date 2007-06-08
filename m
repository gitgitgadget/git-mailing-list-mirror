From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Git Vs. Svn for a project which *must* distribute binaries too.
Date: Fri, 8 Jun 2007 22:41:01 +0200
Message-ID: <20070608204101.GA4084@efreet.light.src>
References: <5971b1ba0706070057l2d4b170emd8af733d888d6a56@mail.gmail.com> <20070607165150.27434.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Cc: godeater@gmail.com, git@vger.kernel.org
To: linux@horizon.com
X-From: git-owner@vger.kernel.org Fri Jun 08 22:41:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwlGg-0002UN-8k
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 22:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761049AbXFHUlH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 16:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758326AbXFHUlG
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 16:41:06 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:40191 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725AbXFHUlF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 16:41:05 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 11E9657741;
	Fri,  8 Jun 2007 22:41:03 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HwlGX-0001lx-4k; Fri, 08 Jun 2007 22:41:01 +0200
Content-Disposition: inline
In-Reply-To: <20070607165150.27434.qmail@science.horizon.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49497>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 07, 2007 at 12:51:50 -0400, linux@horizon.com wrote:
> 3) Branches are your friend.  CVS users think branches are a big
>    deal and require careful thought and planning.  Git users branch
>    almost as often as CVS users commit.  A typical "big change"
>    that might be a single commit in CVS would be a branch of
>    several commits in git.
>=20
>    In fact, a good piece of advice is to NEVER commit directly
>    to your trunk ("master").  Do ALL development on branches, and
>    merge them into the trunk.
>=20
>    I cheat on that a lot, but I also know how to fix things if I get
>    caught becauee a quick hack is proving not so quick: add a branch
>    reference to the tip I'm developing on and then back up the master
>    branch to where I should have left it when I started this project.

There is a big difference between the cvs and subversion notion of branches
and the git one, which make branches so much more friendly in git.

In cvs and subversion, branch name is part of the commit identity, so you
have to create it before you commit and it will stay with you forever. That
means you have to plan the branch, because there's no going back.

On the other hand git branch (head) names are just pointers to revisions you
base your work on. You can add branch name after you commit, you can rename
the branch anytime and you can delete branches that are no longer
interesting, either because they are already merged, or because they didn't
work out. That means you don't have to think twice whether you need a branch
before you commit, since you can always change your mind later.

This makes it possible to use heaps of short-lived branches for
experimenting and to give them silly names, because noone cares if you don't
publish them, which you don't need to do and ususally won't do until you are
confident that you are working in the right direction (at which point you
have much better idea about what name to publish them under).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGab7dRel1vVwhjGURAnp1AKCP50RM24ghffDCsfjJRaKJkMAmEQCeL+4s
IlqLXnnENqV/RLLalIb9P7o=
=0xtL
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
