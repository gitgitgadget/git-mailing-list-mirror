From: Timo Sirainen <tss@iki.fi>
Subject: Re: [PATCH 3/3] Use stringbuf to clean up some string handling
	code.
Date: Sun, 20 May 2007 14:19:17 +0300
Message-ID: <1179659957.32181.1312.camel@hurina>
References: <1179627942.32181.1288.camel@hurina>
	 <20070520095623.GA3106@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BcPFv1nGRvAnDSze3cyF"
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 13:19:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpjRd-0004Sk-7V
	for gcvg-git@gmane.org; Sun, 20 May 2007 13:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898AbXETLTT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 07:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754916AbXETLTT
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 07:19:19 -0400
Received: from dovecot.org ([213.157.71.38]:51507 "EHLO dovecot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754357AbXETLTS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 07:19:18 -0400
Received: from [192.168.10.2] (82-203-162-146.dsl.gohome.fi [82.203.162.146])
	by dovecot.org (Postfix) with ESMTP id 26971F0B8F;
	Sun, 20 May 2007 14:19:17 +0300 (EEST)
In-Reply-To: <20070520095623.GA3106@steel.home>
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47825>


--=-BcPFv1nGRvAnDSze3cyF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2007-05-20 at 11:56 +0200, Alex Riesen wrote:
> Timo Sirainen, Sun, May 20, 2007 04:25:42 +0200:
> > ---
> >  commit.c      |   30 +++++++++++++-----------------
> >  local-fetch.c |   34 ++++++++++++++++------------------
> >  2 files changed, 29 insertions(+), 35 deletions(-)
>=20
> I find it hard to believe that it actually was a cleanup.
>=20
> It is a nicer code, but... it is bigger, heavier on stack, and it does
> not actually fix anything.
>=20
> In my experience, such changes are seldom worth the effort. It may be
> a nice code (and I actually like str.[hc]), but its use _must_ be
> justified. I.e. it must simplify a complex formatting routine, or fix
> a bug, which otherwise would be too hard or ugly to fix. It is
> definitely not the case in this patch.

In my own projects security is the highest priority and it justifies
pretty much all changes. I've done several large changes that change
thousands of lines of code just because it makes it a bit easier to
verify the code's safety/correctness.

I realize that other projects may not want to use all of the tricks that
I'm using in my C code (type safe dynamic arrays, type safe context
pointer in callback functions, etc.), but I was hoping that at least the
libc string handling functions would never be used in a large project
anymore. Using them makes it extremely time consuming to verify the
code's safety, and at least I try to avoid software if I can't do that.


--=-BcPFv1nGRvAnDSze3cyF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGUC61yUhSUUBViskRAqwGAJ941ZE8+vq4pbxvDrXIhKDf1ge2QwCfSbSU
ps5N5FWCbp8qZjGXJs2h2jg=
=9m85
-----END PGP SIGNATURE-----

--=-BcPFv1nGRvAnDSze3cyF--
