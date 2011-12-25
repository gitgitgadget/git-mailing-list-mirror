From: Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH] add post-fetch hook
Date: Sun, 25 Dec 2011 14:06:29 -0400
Message-ID: <20111225180629.GB32626@gnu.kitenet.net>
References: <20111224234212.GA21533@gnu.kitenet.net>
 <7v4nwpbaxq.fsf@alter.siamese.dyndns.org>
 <20111225035059.GA29852@gnu.kitenet.net>
 <7vsjk99exw.fsf@alter.siamese.dyndns.org>
 <m3liq0fwkz.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 25 19:06:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ResT3-0006Kp-M1
	for gcvg-git-2@lo.gmane.org; Sun, 25 Dec 2011 19:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688Ab1LYSGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Dec 2011 13:06:37 -0500
Received: from wren.kitenet.net ([80.68.85.49]:54026 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753272Ab1LYSGg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Dec 2011 13:06:36 -0500
Received: from gnu.kitenet.net (dialup-4.153.2.217.Dial1.Atlanta1.Level3.net [4.153.2.217])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 285CD1180EC
	for <git@vger.kernel.org>; Sun, 25 Dec 2011 13:06:34 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 80B4444999; Sun, 25 Dec 2011 13:06:29 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <m3liq0fwkz.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187686>


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jakub Narebski wrote:
> This is a very nice idea, IMHO, both because it makes it simple to
> implement no-op (example) hook by just using "cat", and beause it
> makes possible to stack such hooks (e.g. one from git-annex with the
> one from pristine-tar etc.).

Indeed.

> One thing that needs to be specified is what should happen if the hook
> changes "the refname at the remote" part...

I'm not sure what the use case is for including the remote's refname is yet.
Changing it would allow changing what's written into FETCH_HEAD though.
For example:

-2ce0edcd786b790fed580e7df56291619834d276        not-for-merge   branch 'ma=
int' of git://git.kernel.org/pub/scm/git/git
+2ce0edcd786b790fed580e7df56291619834d276        not-for-merge   branch 'jc=
-maint' of git://git.kernel.org/pub/scm/git/git

And that would in turn be used by a few things that consume that
information. Whether that's useful, I don't know.

--=20
see shy jo

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTvdmJMkQ2SIlEuPHAQjQDxAArvBTqnwwGtvJUlZQmkzVs/g0Qn6QBXfd
MDBacIzyDA4nuOGGRM4rwG4/vsA2L5pUh7bN40kmvh7yVox6pkJ8dSbClh2YSWuF
gKNDhC00+4NPL+J8C6w/0aSUOR6I68+/I013e8/KsXa5uNJfBQwMwepHPy2JsB1T
2TlBFqOc0tdCbR5gvlCjzqWti+Taam3aWt7H0vXY0CziO59dN4OLyvfnkkf4/P2a
aED0ERqui9bLZJzA+pwClGHpPH2weoQUOdeRL3ZEhu5pI+5v1uaD+/7A7ZHqIOHZ
IYEcgUE97fLXDzRXVVlSUnLQQNNHEmvtxJx9oQXWt3w3JFEGm9pio+ivKXH4HO7E
TAXNIgRXJD7mIZuStDo4h26R7HYr3UWTULJwJrGjfbfE4oDFoUnm2jOdPYOHSAR+
enUGiWa/aA4Rl98X+lM6Cfr4nOxHDm4wxWx+LjInB7jqgt7hqv9usO62964IWXyD
7KmkHQSPGt9ryijHVeBLgP1t6yVrsyCnJY4jg1qO2/VrBIwhWKCfHRjPLKU61yjT
HQkrEF8iMbM6fEjZzDhEs8ojaYsMRVwd0QG6hoe685mc0y3AGavM6LlX0j7eRVe1
jiJEyU/c4FK1cB0bxH46oEcov2lZM1pWdUHFpAsh4L7wF4B5q2XZeqqtsMvUQjln
irKlW5GoSds=
=oZJ6
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
