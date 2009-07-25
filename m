From: Pierre Habouzit <madcoder@madism.org>
Subject: Re: [PATCH] git-add -p: be able to undo a given hunk
Date: Sat, 25 Jul 2009 16:48:03 +0200
Message-ID: <20090725144803.GA18545@artemis.corp>
References: <20090723074104.GI4750@laphroaig.corp>
 <7veis7yxwx.fsf@alter.siamese.dyndns.org>
 <20090724193207.6117@nanako3.lavabit.com>
 <7v8wienk07.fsf@alter.siamese.dyndns.org>
 <20090724170622.GA20247@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 25 16:48:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUiXt-0004vL-9e
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 16:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbZGYOsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 10:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751725AbZGYOsN
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 10:48:13 -0400
Received: from pan.madism.org ([88.191.52.104]:40553 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722AbZGYOsM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 10:48:12 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 0245A40804;
	Sat, 25 Jul 2009 16:48:10 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 350732AEA0; Sat, 25 Jul 2009 16:48:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090724170622.GA20247@sigill.intra.peff.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124016>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2009 at 01:06:22PM -0400, Jeff King wrote:
> On Fri, Jul 24, 2009 at 09:06:16AM -0700, Junio C Hamano wrote:
>=20
> > In your arsenal, you have "git add -p" to help you sift good pieces from
> > other parts in finer grained manner, instead of having to make an all or
> > nothing decision per file basis (i.e. "git add file").  But "git add -p"
> > (and "git add -i") is still about the "git add" step in the above high
> > level view.  You have a mixture of good and not so good changes in your
> > work tree, and you pick only good pieces to add to the index, _knowing_
> > that you can go back and redo this step safely exactly because your work
> > tree will stay the same even if you did make mistakes.
> >=20
> > The proposed change breaks this expectation you would have naturally
> > gained during the course of becoming more and more proficient in using
> > git.
> >=20
> > In other words, I do not think you can say that the change will not harm
> > the experts due to both the points 2 (experts can easily make typo) and=
 3
> > above (the change breaks the mental model of the world experts would ha=
ve
> > formed).
> >=20
> > Having said all that, it indeed would be useful to selectively revert
> > changes from the work tree files.
>=20
> Perhaps it makes sense to have an interactive stash rather than an
> interactive revert?

Very cool idea, it's even better than creating a revert patch.

Note that to undermine the "dirty stash list" effect we could have
quite easily different stash queues if it's badly needed, so it sounds
like a moot point to me.
--=20
Intersec <http://www.intersec.com>
Pierre Habouzit <pierre.habouzit@intersec.com>
T=C3=A9l : +33 (0)1 5570 3346
Mob : +33 (0)6 1636 8131
Fax : +33 (0)1 5570 3332
37 Rue Pierre Lhomme
92400 Courbevoie

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkprGyIACgkQvGr7W6HudhzAkgCcD2cBbJxJwIDbJi8G8ZYge84x
KbgAnj/3Km+Xs1oUzoTFMgjJzWf5JDV7
=LZFA
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
