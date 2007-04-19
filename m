From: Martin Waitz <tali@admingilde.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 19 Apr 2007 12:07:57 +0200
Message-ID: <20070419100757.GB27208@admingilde.org>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net> <7vr6qlxexe.fsf@assigned-by-dhcp.cox.net> <7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 19 12:08:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeTYb-0003Zg-8t
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 12:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161483AbXDSKH7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 06:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161487AbXDSKH7
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 06:07:59 -0400
Received: from mail.admingilde.org ([213.95.32.147]:53739 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161483AbXDSKH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 06:07:58 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HeTYT-00004x-EE; Thu, 19 Apr 2007 12:07:57 +0200
Content-Disposition: inline
In-Reply-To: <7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45001>


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Apr 18, 2007 at 05:04:13PM -0700, Junio C Hamano wrote:
> * lt/gitlink (Sun Apr 15 11:14:28 2007 -0700) 17 commits
>=20
> Stalled; Alex has a set of tests that should go on top of this
> series but I haven't taken a look at it yet.  I think we should
> have enough for interested people to start futzing with, and I
> am wondering why nobody has sent a note saying "Hey, I did this
> using tree objects with commits in it, it works nicely for these
> operations but these things are still cumbersome to do and I
> need to polish it more".

You know that I am interested, but sadly I don't have as much time to
really have a look / work on it as I'd liked.  But Linus' series
looks very good from what I've seen now.
Conceptually Linus approach is very much identical my prototyping work
and I am convinced that it is the right way to go.  Only his code is
much better (hey, it's Linus after all ;-) and about our branch-vs-HEAD
discussion, well we'll see how it works out.

Now, how to go on?
The next thing we need is a real checkout & merge support -- but that
is not that hard.
Then we need to think about how to handle the submodule object database,
e.g. when fetching.

I'd also like to be able to support bare supermodule repositories which
include all neccessary submodule objects.  But I guess we need some
more experience with submodules before we can solve that in a scalable
way.

--=20
Martin Waitz

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGJz99j/Eaxd/oD7IRApv1AJ0URqwLYJw0B6r+iFyyACz4Dqh7EACeIjUe
dCmevw2R+oirXk+LJnKg9LU=
=6ryn
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
