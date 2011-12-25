From: Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH] add post-fetch hook
Date: Sat, 24 Dec 2011 23:50:59 -0400
Message-ID: <20111225035059.GA29852@gnu.kitenet.net>
References: <20111224234212.GA21533@gnu.kitenet.net>
 <7v4nwpbaxq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 25 04:51:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ref7S-000557-KM
	for gcvg-git-2@lo.gmane.org; Sun, 25 Dec 2011 04:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755056Ab1LYDvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Dec 2011 22:51:07 -0500
Received: from wren.kitenet.net ([80.68.85.49]:39286 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753039Ab1LYDvG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2011 22:51:06 -0500
Received: from gnu.kitenet.net (dialup-4.154.2.64.Dial1.Atlanta1.Level3.net [4.154.2.64])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 45E301180F7
	for <git@vger.kernel.org>; Sat, 24 Dec 2011 22:51:04 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 3D6DA4497B; Sat, 24 Dec 2011 22:50:59 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v4nwpbaxq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187677>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> If we _were_ to sanction the use of the hook to tweak the result, I do not
> want to see it implemented as an ad-hoc hack that tells the hook writers
> that it is _entirely_ their responsiblity to update the remote tracking
> branches from what it fetched, and also update $GIT_DIR/FETCH_HEAD to
> maintain consistency between these two places.
>=20
> A very cursory look at the patch tells me that there are a few problems
> with it.  It does not seem to affect what will go to $GIT_DIR/FETCH_HEAD
> at all, and hence it does not have any way to affect the result of the
> fetch that does not store it to any of our remote tracking branches.

True, it does not update FETCH_HEAD. I had not considered using the hook
that way.

I suppose that after running the hook, fetch could check each remote
tracking branch for a new value, and only then write to FETCH_HEAD.

> > The #1 point of confusion for git-annex users is the need to run
> > "git annex merge" after fetching. That does a union merge of newly
> > fetched remote git-annex branches into the local git-annex branch.
>=20
> That use case sounds like that "git fetch" is called as a first class UI,
> which is covered by "git myfetch" (you can call it "git annex fetch")
> wrapper approach, the canonical example of a hook that we explicitly do
> not want to add. It also does not seem to call for mucking with the result
> of the fetch at all.

Most users are fetching by calling git pull as part of their normal
workflow. I would like to avoid git-annex needing its own special pull
command. For one thing, there can be many programs that use git branches
in similar ways (another one is pristine-tar), and a user shouldn't have
to run multiple wrapped versions of git fetch or pull when using
multiple such programs.

--=20
see shy jo

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTvadoskQ2SIlEuPHAQjWmBAAqOyUdiQot73F85x4045IdIf8MNaJpZan
7OBQI6HNEmlSd0hBECSXsmfD3EjUDF7qOJ54Xzt6XvVGGLX2zzkUV1n/NnPAl16d
9/LLSG7fjmAFozDiJ5nzHPm3YwC1wunk1riOQIf3X9Hn2t7PFWa0Jj1Z41u15y2l
oyfQA5CIRz6u2E97kKVF4brM8humksI9eBEwXH+/9aHW+9Fhz5MxYdOp75YR5Otw
n0s6ezlM/IVsGBcMAQX2vHTh2vJOYf8pbKY4LroCRJPoxZTfJDthu30wIloYtZKe
kCNJmlnZ101mK2Z4JuZkpPrQjU0edVTx68ZK3pSg0uP55zpT1vXPBOVi9oQ3+3bc
FSWNVinHZ9bIsDYnN5CeO0w/6PceyKpuEobR1o7bmrGGrUdmvx//lXoXfmI3TtyS
sQho2W7y3LyUApueK+t+jNM4BWEM7u4JFZdLT2/6s1ag/ltrn3Fon/2erp1JbwG9
NYwJWEeZNFY++xPXQTxgXraAWWq+IZOJW/08TX/2yIs0evEnsSoZClrkzuMfbeDK
yRDN8OkN7iINRl33dla3Juh4HtVjCbetBD2m/4ZbtxR5i48svY27gKcFjtpGWFI0
D5wjsylAYWVzqI6vFGz8QnZgDhnrLsQIarb1tp0EoaS9ec+DwpILwhO6ud6TCGBt
3CQO0//n1e4=
=/K8K
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
