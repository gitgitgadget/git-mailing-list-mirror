From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Rebase and incrementing version numbers
Date: Wed, 25 Jan 2012 11:53:40 +0100
Message-ID: <1327488820.3052.15.camel@beez.lab.cmartin.tk>
References: <CADo4Y9jGYJasDL9m7_50aOTrOyoezdyg=vcsZhQ87Qk-1XfTUQ@mail.gmail.com>
	 <CADo4Y9iKvoXhKg5pEAB+cbA7Rkfa=nF4TLu0xgcS3dnkNi_n4g@mail.gmail.com>
	 <1327000803.5947.59.camel@centaur.lab.cmartin.tk>
	 <CAP8UFD0gd_-=Cc0vox-6Ts4-iBWcJG8LgmqXteXgp3qc-bX13w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-0kfqKQeTGQDDDrkkS4z3"
Cc: mike@nahas.com, git@vger.kernel.org
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 11:53:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rq0UC-0004VP-EN
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 11:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879Ab2AYKxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 05:53:48 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:37305 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151Ab2AYKxr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 05:53:47 -0500
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 4B5DA46092;
	Wed, 25 Jan 2012 11:53:42 +0100 (CET)
In-Reply-To: <CAP8UFD0gd_-=Cc0vox-6Ts4-iBWcJG8LgmqXteXgp3qc-bX13w@mail.gmail.com>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189107>


--=-0kfqKQeTGQDDDrkkS4z3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-01-25 at 11:32 +0100, Christian Couder wrote:
> On Thu, Jan 19, 2012 at 8:20 PM, Carlos Mart=C3=ADn Nieto <cmn@elego.de> =
wrote:
> > You could write a merge driver that detects this situation and writes i=
n
> > a higher number, but it's all working around the fact that it's a race
> > condition.
>=20
> By "merge" driver you mean a new merge startegy?

No. By "merge driver" I mean a "merge driver".

>=20
> Isn't it possible to write a script and use it with git mergetool to
> automatically detect and resolve the merge conflicts resulting from
> changes in these numbers?

No. A mergetool is what you call manually to help you resolve a merge
conflict. What you're describing is a merge driver. If you grep for
"driver" in the merge manpage, you'll see how to set it, and it'll tell
you to look in the gitattributes manpage for more information. If you
search the web for "git merge driver" you'll see lots of examples of how
these are done.

   cmn



--=-0kfqKQeTGQDDDrkkS4z3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJPH980AAoJEHKRP1jG7ZzTEZoH/ioNdK+hN58qmE3iZWLGy9A6
hIvPBMeNIMhAOOcz+HHYyVuPfOwLLYJQqjvHUYvZ427cwhu07STMSBTdrlSs/JmU
ijoDA9b3STewU0xuvjqsbknOVZySQD9N69ERS2cS86qu6dnmjwP05TrniwJOvcQc
cNip02WUzYO+BrMbHZ6AJRews2zXkajrSxz2pR1D2sQeOu61N0YoY1yrqzf3JIJo
IEGC23zQ22bzpNKSPjWyAoieQfLrn7S/JawooBdHZ9oj+8yiqvmgBVv13oXDS5AK
z6UcDsjHhJUu8j0HMP1SV6G8ykXmDNvfSOoWL1zX69Fs/npKSQvtXBohqwCZ7N8=
=lqa8
-----END PGP SIGNATURE-----

--=-0kfqKQeTGQDDDrkkS4z3--
