From: Penny Leach <penny@mjollnir.org>
Subject: git-svn starting with an empty svn repository
Date: Tue, 24 Feb 2009 14:43:25 +0100
Message-ID: <20090224134325.GA10719@mjollnir.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 15:04:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbxtm-0000wm-CI
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 15:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310AbZBXODM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 09:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754950AbZBXODK
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 09:03:10 -0500
Received: from mjollnir.org ([202.78.240.81]:45080 "EHLO mjollnir.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755221AbZBXODJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 09:03:09 -0500
X-Greylist: delayed 1172 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Feb 2009 09:03:09 EST
Received: from localhost (localhost [127.0.0.1])
	by mjollnir.org (Postfix) with ESMTP id 4077528A558
	for <git@vger.kernel.org>; Tue, 24 Feb 2009 14:43:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mjollnir.org
Received: from mjollnir.org ([127.0.0.1])
	by localhost (mjollnir.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b3zX4DYC9Hqg for <git@vger.kernel.org>;
	Tue, 24 Feb 2009 14:42:57 +0100 (CET)
Received: from hermia.mjollnir.org (114-123.104-92.cust.bluewin.ch [92.104.123.114])
	(Authenticated sender: penny)
	by mjollnir.org (Postfix) with ESMTP id 6E96728A557
	for <git@vger.kernel.org>; Tue, 24 Feb 2009 14:42:57 +0100 (CET)
Received: by hermia.mjollnir.org (Postfix, from userid 1000)
	id 19ABD22104; Tue, 24 Feb 2009 14:43:26 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111287>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear list,

This is maybe an abuse of what git-svn is designed to do, but nevertheless
I need to do it.

I'm working with a project (Moodle) that still uses CVS for its upstream
VCS.  The friendly folk at Catalyst in NZ run a git import of this, that a
lot of the community uses as their (read only) upstream instead of CVS.

So far so good.

However, now for various political reasons, I must (at least) publish
changes to SVN.  I'm going to be patch trading a lot between my work
branches, and Moodle's CVS directly and I don't want to lose the power that
git gives me while doing that.  So I want to keep git as the tool I use for
development, that acts as a go-between for me between CVS and SVN.

So what I'd really like to do is something like this:

- clone from Catalyst's git mirror
- push that to SVN using git-svn
- keep working, committing patches to Moodle CVS, and pulling from Catalyst
  regularly, while pushing both my local changes and new pulled upstream
  patches, to SVN, using git-svn

The problem seems to be that I'm starting out with an *empty* SVN
repository.  Almost all of the documentation I've found on this topic is
for going from an existing SVN repository to git.

Theoretically at least, the opposite direction should also be possible, but
I'm having a hard time figuring it out.  I followed the steps outlined in
the comments here:
http://quirkygba.blogspot.com/2007/10/using-git-with-google-code-hosting.ht=
ml

But I didn't have much luck, it seems as though the rebased trunk branch
doesn't share any ancestry with the original Catalyst sources, so regularly
updating is going to be hard (unless I create graft entries for each time I
do it I guess?).

Not to mention the fact that it's 8 years of history that takes a while to
import and after about 5 tries I didn't even manage to get git svn to
dcommit it and got impatient and cross and stopped trying.

So really I want to know is - is this even possible? Is using the above
steps along with the graft approach the best|only way to do it?  How
brittle is this to maintain, if I even manage to get it imported?

Any ideas or advice?

For reference, the CVS/Git import can be cloned here:
http://git.catalyst.net.nz/git/moodle-r2.git but will take a long time to
come down.

Cheers for any help.

Penny


--=20
/* ---------------------------------------------------
Penny Leach | http://mjollnir.org | http://she.geek.nz
GPG: 8347 00FC B5BF 6CC0 0FC9 AB90 1875 120A A30E C22B
--------------------------------------------------- */

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmj+X0ACgkQGHUSCqMOwita1gCgrqZy+X6dN9QWAkXL3YFFl9XY
AVcAoJZrPCsHhvlF7t9x8XswZOWRd/4/
=zZdt
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
