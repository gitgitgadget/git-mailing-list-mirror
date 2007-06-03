From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] git integrated bugtracking
Date: Mon, 4 Jun 2007 01:07:03 +0200
Message-ID: <20070603230702.GC16637@admingilde.org>
References: <20070603114843.GA14336@artemis> <alpine.LFD.0.98.0706031216560.23741@woody.linux-foundation.org> <20070603201632.GF30347@artemis>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
To: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 01:07:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuzAJ-0005id-Pv
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 01:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbXFCXHJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 19:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbXFCXHI
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 19:07:08 -0400
Received: from mail.admingilde.org ([213.95.32.147]:49945 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbXFCXHH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 19:07:07 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HuzA7-0005dJ-NH; Mon, 04 Jun 2007 01:07:03 +0200
Content-Disposition: inline
In-Reply-To: <20070603201632.GF30347@artemis>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49048>


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, Jun 03, 2007 at 10:16:32PM +0200, Pierre Habouzit wrote:
>   Well I went that way, but we loose the quite cool "if I branch my
> repository I branch the bugs coming with them too"-feature. And I'd be
> sad to give that up. But maybe it's an error to want to use git to
> encode that relation.

Just store the commit which introduced the bug (or where the bug
was first found) and you will get that, too.  You only have to check
if this commit is reachable by a given branch to see if it is affected.
When you fix the bug you store the commit id that fixed it and then
you can check every branch if it points into bad..good.

You can also do this for released versions.
If you have the bug database inside the repository you can't report
any bugs for a released version, because it is, well already released.

--=20
Martin Waitz

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGY0mWj/Eaxd/oD7IRArRvAJ9KKdiwfdVg1J5T20dWq2OO5/7afQCePyTc
q1GUnrBmQD2pqBNUEYvUAao=
=1Qee
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
