From: Tilman Sauerbeck <tilman@code-monkey.de>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Wed, 6 Feb 2008 17:43:04 +0100
Message-ID: <20080206164303.GA1255@code-monkey.de>
References: <20080203030054.GA18654@coredump.intra.peff.net> <20080203043310.GA5984@coredump.intra.peff.net> <alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org> <7vr6fsk08w.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802041146060.3034@hp.linux-foundation.org> <alpine.LFD.1.00.0802041223080.3034@hp.linux-foundation.org> <7vir13g9hx.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802051300050.3110@woody.linux-foundation.org> <alpine.LSU.1.00.0802052228280.8543@racer.site> <alpine.LFD.1.00.0802051539570.2967@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 17:43:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMnNG-0003mh-AM
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 17:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755448AbYBFQnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 11:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbYBFQnN
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 11:43:13 -0500
Received: from code-monkey.de ([88.198.45.137]:42805 "EHLO code-monkey.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752602AbYBFQnL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 11:43:11 -0500
Received: from brimstone (dialin-145-254-162-092.pools.arcor-ip.net [145.254.162.92])
	by code-monkey.de (Postfix) with ESMTP id 822E13F24D;
	Wed,  6 Feb 2008 17:43:09 +0100 (CET)
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802051539570.2967@woody.linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72812>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus Torvalds [2008-02-05 15:59]:

Hi guys,
thanks for looking into this.

> On Tue, 5 Feb 2008, Johannes Schindelin wrote:
> > >=20
> > >  - make commit warn if any parent commit date is in the future from t=
he=20
> > >    current commit date (allow a *small* fudge factor here, say 5 minu=
tes).
> >=20
> > 5 minutes seems a little narrow to me.  I think we can even go with 864=
00=20
> > seconds.
>=20
> Well, notice how I said *warn*. Not abort the commit. Not stop. Just make=
=20
> people very aware of the fact that clocks are skewed.
>=20
> In the case that actually triggered this whole discussion, the problem=20
> seems to sadly have been in the original CVS tree (or whatever it was=20
> imported from): the project started in 2006, had lots of regular commits=
=20
> up to October 2007, and then suddenly it had a commit that had a date in=
=20
> 2002!
>=20
> [ For those interested in looking at this, the broken commit in that=20
>   Tilman's repo was commit 3a7340af2bd57488f832d7070b0ce96c4baa6b54, whic=
h=20
>   is from October 2002, and which is surrounded by commits from October=
=20
>   2007, so somebody was literally off by five years ]

I'm not sure whether this repository was import from another SCM, but I
doubt it. I'm fairly sure that 3a7340af2bd57488f832d7070b0ce96c4baa6b54
was created using git commit though. I guess the committer's clock just
was a little late at that point.

Regards,
Tilman

--=20
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing on usenet and in e-mail?

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.8 (GNU/Linux)

iEYEARECAAYFAkep45cACgkQ6tx5H15YdGIX7gCglhr6nSAJ7E0fQfSdZLEGqgo0
FxMAoJhKUZBeKxJ4f7wxFdLADTbZPWFo
=vH6D
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
