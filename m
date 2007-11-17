From: Jan Hudec <bulb@ucw.cz>
Subject: Re: wishlist: git info
Date: Sat, 17 Nov 2007 17:21:01 +0100
Message-ID: <20071117162101.GA5198@efreet.light.src>
References: <fhad5q$iia$1@ger.gmane.org> <20071112222106.GE2918@steel.home> <4738D8AA.1030604@users.sourceforge.net> <fhaol0$p5r$1@ger.gmane.org> <fhbn50$uqu$1@ger.gmane.org> <Pine.LNX.4.64.0711131111220.4362@racer.site> <47398B43.30408@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Thomas Neumann <tneumann@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Nov 17 17:21:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItQQD-0005Wn-8N
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 17:21:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbXKQQVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 11:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752629AbXKQQVM
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 11:21:12 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:35053 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbXKQQVL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 11:21:11 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id E41EF5727C;
	Sat, 17 Nov 2007 17:21:08 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id waLuf91bjfT3; Sat, 17 Nov 2007 17:21:06 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 95B5B57288;
	Sat, 17 Nov 2007 17:21:05 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1ItQPm-0006cL-0W; Sat, 17 Nov 2007 17:21:02 +0100
Content-Disposition: inline
In-Reply-To: <47398B43.30408@users.sourceforge.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65286>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2007 at 12:32:19 +0100, Thomas Neumann wrote:
> > Is slightly troubles me that you put so much emphasis on what I would c=
all=20
> > "remote information".  I understand that in svn, your working directory=
=20
> > without the server is not very useful.  But we do not have that problem.
> that is true. My usage pattern probably stems from the fact that I am a
> long term svn user :) And I use git for work now, where there is indeed
> some kind of central repository just as in a Subversion setting.
> In a fully decentralized setting the remote information is probably not
> as important, although you might still want to know what happens if you
> issue "git pull".

The remote URL isn't /the/ useful bit, most of the time. Either you have ju=
st
one remote, which is the project central repository and you probably know
which it is just by knowing which project it is, or you have many of them a=
nd
their names tell you enough.

Note, that unlike in Subversion, the branch name is /not/ part of the URL.
And that is the useful bit of the information. So what 'git info' probably
should show is:
 - Which branch is currently checked out
 - Which branch it is tracking (inspect the config)
 - List of n (where n is small integer) "closest" branches, where the
   distance to a branch is number of commits in HEAD since common ancestor
   with that branch.
 - Latest included tag. Basically something like git describe.
 - Short log of last few commits.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHPxTtRel1vVwhjGURAsxPAJ9emq+4GzQ2xfUXfdpl5JjvSzoiVACgtKlr
hFD4/aK/EoLWX6YaQ7fHyGc=
=AC41
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
