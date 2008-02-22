From: Aidan Van Dyk <aidan@highrise.ca>
Subject: Re: [Fwd: [ANNOUNCE] bzr-fastimport plugin, yet another Bazaar import option]
Date: Fri, 22 Feb 2008 09:44:15 -0500
Message-ID: <20080222144415.GA19974@yugib.highrise.ca>
References: <47BE167A.4060005@internode.on.net> <20080222073228.GF8410@spearce.org> <20080222113737.GA18581@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
To: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ian Clatworthy <ian.clatworthy@internode.on.net>,
	Bazaar <bazaar@lists.canonical.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 22 15:44:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSZ8w-0001HP-E6
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 15:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbYBVOoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 09:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752634AbYBVOoS
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 09:44:18 -0500
Received: from yugib.highrise.ca ([205.150.199.213]:43914 "EHLO
	yugib.highrise.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804AbYBVOoR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 09:44:17 -0500
Received: from localhost (yugib.highrise.ca [205.150.199.213])
	by yugib.highrise.ca (Postfix) with ESMTP id EEF70111E3A;
	Fri, 22 Feb 2008 09:44:15 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080222113737.GA18581@artemis.madism.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74725>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Pierre Habouzit <madcoder@debian.org> [080201 08:20]:
=20
>   /me opens bigs ears and eyes: does this mean that we have an
> incremental importer of CVS based on git-fast-import ? I mean I'm really
> interested into that, as git-cvsimport is really broken with the glibc
> CVS tree, and as the glibc CVSROOT is rsync-able, an incremental
> importer that has access to the CVSROOT RCS files is probably the most
> efficient way.

In the repository I convert (PostgreSQL), I'm using the ruby
=66romcvs/togit converter, which has worked well, because git-cvsimport
doesn't work.

I actually found the problem with the PostgreSQL CVS repository - it is
a TAG, which seems to have some cyclic dependencies which throws cvsps
into a loop.  Unfortuntely, I have neither time nor energy to be able to
look into fixing cvsps, especially since fromcvs "just works" on it.

	http://mid.gmane.org/20080220220014.GB16099@yugib.highrise.ca

I don't know what the problem with the glibc CVSROOT, but if it's the
same, that might be something to look at.

Note that fromcvs doesn't import tags (that's probably why it didn't
have any trouble with the PostgreSQL CVS) but that doesn't bother me,
since CVS tags carry none of the authority git tags do, and the git
commit ids provide a stable way to refer to particular commits anyways.

a.

--=20
Aidan Van Dyk                                             Create like a god,
aidan@highrise.ca                                       command like a king,
http://www.highrise.ca/                                   work like a slave.

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFHvt+/uVxNPsxNPScRAgE4AJwLAmIp23O83YqAFJoQNkQHNxCCMQCgmhG/
MD4+veiyB9Y+kCgrE+1+CII=
=0Ox4
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
