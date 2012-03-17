From: Joey Hess <joey@kitenet.net>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Sat, 17 Mar 2012 10:00:30 -0400
Message-ID: <20120317140030.GA27369@gnu.kitenet.net>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 15:07:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8uHz-0007mj-2i
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 15:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611Ab2CQOHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 10:07:19 -0400
Received: from wren.kitenet.net ([80.68.85.49]:48515 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751714Ab2CQOHR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 10:07:17 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Mar 2012 10:07:17 EDT
Received: from gnu.kitenet.net (dialup-4.152.246.209.Dial1.Atlanta1.Level3.net [4.152.246.209])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id EFB5B1180CD
	for <git@vger.kernel.org>; Sat, 17 Mar 2012 10:00:36 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id A8A0C43C59; Sat, 17 Mar 2012 10:00:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193326>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'd like to point out a use case for the current push behavior
that has probably not been considered. I've written several tools
that store data on subsidiary git branches.=20

One is pristine-tar, in which information necessarily to reconstruct
bit-identical tarballs containing the source in (say) master is stored
efficiently in the pristine-tar branch. Another is git-annex, in which
bookeeping information about the actual location of large files is
stored in the git-annex branch. These are not unlike git notes, other
than not being built into git. I'm not the only one doing this, other
examples I know of include several bug trackers (git-case, git-issues,
ticgit).

The current push behavior works well for these subsidiary branches.
But if users have to remember to manually push these branches, which they
do not otherwise manually interact with, they'll forget. I know this
will be confusing, because with current git, users have to be instructed
to push these branches *once*, to get the tracking set up.

I feel that this use of subsidiary branches expands the reach of git;
there are reasons that Fossil is pulling other ancillary data
(bugs, wiki, blog etc) into DVCS. But it makes the mistake, IMHO, of
bundling all that together into one peice of software. Git allows doing
the same things, but loosely coupled, so the best implementation of each
can win.

There might be some way to handle such subsidiary branches while
still changing the push default. If git prints a good enough warning
about other, unpushed matching branches, the user only has to do a
little more work to push them. If a hook was available that could
add branches to the set to be pushed, it could automate pushing
such branches. Or git could get a way to mark one branch as a subsidiary
branch of another, and automatically include subsidiaries in pushes.

--=20
see shy jo

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUBT2SY+8kQ2SIlEuPHAQjQ8w/8DGCbQuoYZv9WR4ZEquoKg+FxXE76+LDH
1n4PfUCi4hkLg43mN2GQLj8jsWGp3HmOR525hsoJAMFY0cCj6YySe9EAd+zldOtI
iGflGDS+BomPLc5CmY1dqFTXFOKW6++DDe7mXoKi6luDP3WWf57aOSZcjWGeLa0h
N7rjlMPqpCF30oQoBkRpy3gLI2OD7FaCalpRKW1S7VJwkMyRZeIYMfEmEs3d5GDb
7ToO/JIubmdegCjxM7Lb9slCYZG7hYV1E4ItQ61ze1ta9nWxpF4lYJijsQnb8Yqm
pAluEJ3i6Y+Kp0waLJiY2ZMSRKjVb0VQlj8BAfW8SNeUG0lsPOBa2wBqdQJ83kVc
+6/fhr8vIY8uL4eGsQLBheoyVmJCEtAXMDo6fbFloYMB1kU2C/FAGMf7WDoykRnG
EjCyesO1Wm37s5/MbvfJdLpIzeZNsJURQ2VRg6qJDtxguRaHoaPTqhUgFMiVJVum
ljdQGUzi+oBXTMdPpbD/J2QCh8vvxkDulBWIDn7cxPnpN13Was0J3ylHOxyBtNwL
BPeleXbtO8yWpBsavoUe065DWa0WOvGXAAwSzr1dKyStiqL9QjNsZVksdTyArOZL
GLr/HGaihI33GMoyuzEdRvo+VS4QILAjy3LloxmAz36WPqK8l/8Ux89b323obBir
skhbK8S+Sqk=
=LrcG
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
