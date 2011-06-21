From: Joey Hess <joey@kitenet.net>
Subject: Re: git-union-merge proposal
Date: Tue, 21 Jun 2011 12:10:44 -0400
Message-ID: <20110621161044.GA8079@gnu.kitenet.net>
References: <20110621022049.GA1632@gnu.kitenet.net>
 <20110621052211.GA16919@elie>
 <201106210934.34025.johan@herland.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Jun 21 18:10:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ3XV-00068w-6w
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 18:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756768Ab1FUQKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 12:10:51 -0400
Received: from wren.kitenet.net ([80.68.85.49]:48399 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559Ab1FUQKv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 12:10:51 -0400
Received: from gnu.kitenet.net (dialup-4.153.14.177.Dial1.Atlanta1.Level3.net [4.153.14.177])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 0CCF5118282;
	Tue, 21 Jun 2011 12:10:48 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 463C44DE39; Tue, 21 Jun 2011 12:10:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <201106210934.34025.johan@herland.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176167>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jonathan Nieder wrote:
> Does the GitRepo module that it uses come from git-annex?
>=20
> If the prototype were self-contained, I would encourage you to submit
> it for inclusion under contrib/ so it can evolve and eventually
> graduate out of there.  Cc-ing Johan (who has no doubt thought through
> these things in the context of "git notes") in case he has thoughts on
> it.

Yes, this was written in the context of git-annex. I would probably not want
to submit the haskell implementation to contrib/, but a shell implementation
could be done that would be perhaps less robust, but also less unusual in
the context of git's code base.

Johan Herland wrote:
> I must confess that my Haskell skills are exactly nil, but AFAICS the scr=
ipt=20
> depends on the filename as the only criteria to identify files that need =
a=20
> line-level merge. How does the script deal with renamed and copied files?
>=20
> If you depend on the filename only, this script simply will not work for=
=20
> notes.

It simply depends on filenames. I saw there was additional complexity
in notes and I don't see how a general purpose merger can handle that.
(I wish I could just use notes for my application, but I have data that
is not tied to any one object in git.)

Although, this is an obvious extension that would add some flexability
to handle for files that cannot be merged with a naive union:

git union-merge foo origin/foo refs/heads/foo -c "sort * | uniq"

Where the files would be passed in as temp files.

Hmm, that makes it look not unlike git-filter-branch, except
it's generating a new commit at the tip. I *think* that filter-branch
can't do this.

--=20
see shy jo

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTgDCg8kQ2SIlEuPHAQj64g//Ts7aQRJ6LSiAXqwwMi6Ib2z3b5iC1FJ6
suz8eKk5uB821nSeIiA1P23cgRzZ4zTlkXhBnv4BdQvRHbPxv7Z4ghiJ7CedHADD
dbNpcZ9TQrZmLbfOOQFuUi42Q1L1Ea2pa3hAB08iKARPLom8LhUM0ctO0tTPNV7h
LpWuxZ80tcFKxGWhUNBSz4xW1oq9y4JaRwusy1S+QC7tdVrN4nWYY7fNe1Xo0S0U
hvgl9vyO7cFeUiv+8LK5o/uuJ6Aj0LVaWwr3oMSWtDv+S92hA3uGF2cPQBxZTvCm
XYjr6/S4b5Xa11cg2kTOnvihLFWuvppckS1IVFjQRJpOPtqlx/J3lrukoF+kg9X5
83ISuC3B767uJjt/tZI0Hk/JiGms4gZeg4eanEBjrOn3vnAH5TW2C7qk9ZH5YwWA
I9oFUTecDh8NevpGw9q4W8bUKND970dbEQ/PrMtayPKxkVIK7kXC9aVeaJpoi6+p
YIVG3UuNsyxnwxP4xSfIIJo6iL0I4g/ybeQWuplWidQ3vkSISJXPOlECeLgpcJqf
gfQFOG+m993zsgXSnzu4++0CS6/wacK6Ia7KYrwNgEfjFx7WqUOSt5a22EcFlvvM
TtyLRJdjachRAeVQVt60hJyH9o6Fd9Q/n2UJZzlwk97rU/9v6pGevrFVXewaUn9E
SzjKdQ32DxQ=
=9/kn
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
