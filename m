From: David Clymer <david@zettazebra.com>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 07:56:04 -0400
Message-ID: <1161604564.22276.173.camel@zepto.home.zettazebra.com>
References: <45357CC3.4040507@utoronto.ca>
	 <200610212141.51829.jnareb@gmail.com>
	 <1161544685.22276.127.camel@zepto.home.zettazebra.com>
	 <200610222206.13973.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RVunq8VfsXcggOJCeWRN"
Cc: "Matthew D. Fuller" <fullermd@over-yonder.net>,
	Andreas Ericsson <ae@op5.se>,
	Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 13:55:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbyOo-0004Dl-3T
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 13:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWJWLzT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 07:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWJWLzS
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 07:55:18 -0400
Received: from zettazebra.com ([72.36.162.130]:9681 "EHLO zettazebra.com")
	by vger.kernel.org with ESMTP id S932144AbWJWLzR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 07:55:17 -0400
Received: from 67-23-48-101.chvlva.adelphia.net ([67.23.48.101] helo=[192.168.11.100])
	by zettazebra.com with esmtpa (Exim 4.50)
	id 1GbyOT-0002wq-KE; Mon, 23 Oct 2006 07:55:01 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610222206.13973.jnareb@gmail.com>
X-Mailer: Evolution 2.6.3 
X-SA-Exim-Connect-IP: 67.23.48.101
X-SA-Exim-Mail-From: david@zettazebra.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29828>


--=-RVunq8VfsXcggOJCeWRN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-10-22 at 22:06 +0200, Jakub Narebski wrote:
> David Clymer wrote:
> > 1. revnos don't work because they don't serve the same purpose as revid=
s
> > or git's SHA1 commit ids.
> Revnos works only locally, or in star-topology configuration. They have
> some consequences: treating first parent specially, need for merges
> instead of fast-forward even if fast-forward would be applicable,
> two different "fetch" operators: "pull" (which uses revids on the
> pulled side) and "merge" (which preserves revids on pullee side).

s/revids/revnos/g  but yes, I think I said this later in my previous
email.

>=20
> > 2. bzr does not support fully distributed development because revnos
> > "don't work" as stated in #1.
> Bazaar is biased towards centralized/star-topology development if we
> want to use revids. In fully distributed configuration there is no
> "simple namespace".

So revnos aren't globally meaningful in fully distributed settings. So
what? I don't see how this translates into bias. There is a lot of
functionality provided by bazaar that doesn't really apply to my use
case, but it doesn't mean that it is indicative of some bias in bazaar.

>=20
> > 3. Ok, bzr does support distributed development, I just say it doesn't
> > because I think revids are ugly.
> I think that bzr revids are uglier that git commit-ids.
>=20
> If on the pros side of bzr is "simple namespace", you must remember that
> it is simple namespace only for not fully distributed development. The
> pros of "simple namespace" with cons of "merge" vs "pull" and centralizat=
ion
> required for uniqueness of revids.

I think you've switched revids and revnos, but I get what you are
saying. In fact, I think I said pretty much the same thing in the email
you are replying to. I don't think that anyone is disagreeing about
anything other than the assertion that bzr is biased because revnos are
used to simplify cases where it is possible to do so.

In any case, Matthew Fuller & Carl Worth cover this in greater detail in
emails further down in this thread (or one of its siblings), so I think
I'll stop here.

-davidc

--=20
gpg-key: http://www.zettazebra.com/files/key.gpg

--=-RVunq8VfsXcggOJCeWRN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFPK3U2XpGgG+SNaERAriKAJ9UsYAamjt09bT8NRXbbPHJDAlNTACfURpZ
1MG7HVCZGen8xf3LbEgy7tU=
=vOO0
-----END PGP SIGNATURE-----

--=-RVunq8VfsXcggOJCeWRN--
