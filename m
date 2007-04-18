From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 18:06:37 -0700
Message-ID: <20070418010637.GF31488@curie-int.orbis-terrarum.net>
References: <200704171041.46176.andyparkins@gmail.com> <Pine.LNX.4.64.0704170829500.5473@woody.linux-foundation.org> <46250175.4020300@dawes.za.net> <Pine.LNX.4.64.0704171121090.5473@woody.linux-foundation.org> <20070417235649.GE31488@curie-int.orbis-terrarum.net> <7vps62lfbw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Rogan Dawes <lists@dawes.za.net>,
	Andy Parkins <andyparkins@gmail.com>
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 03:07:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdydP-0001c8-9v
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 03:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030603AbXDRBGr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 21:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030650AbXDRBGr
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 21:06:47 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:54876 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030603AbXDRBGj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 21:06:39 -0400
Received: (qmail 30537 invoked from network); 18 Apr 2007 01:06:38 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Wed, 18 Apr 2007 01:06:38 +0000
Received: (qmail 21696 invoked by uid 10000); 17 Apr 2007 18:06:37 -0700
Content-Disposition: inline
In-Reply-To: <7vps62lfbw.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44847>


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2007 at 05:02:43PM -0700, Junio C Hamano wrote:
> > As for a usage case:
> > - J.PEBKAC.User gets a a tree (from a tarball or GIT, we should gain the
> >   same output)
> > - Copies some file outside of the tree (the user is NOT smart enough,
> >   and resists all reasonable attempts at edumacation)
> > - Modifies said file outside of tree.
> > - Contacts maintainer with entire changed file.
> > - User vanishes off the internet.
> >
> > The entire file he sent if it's CVS, contains a $Header$ that uniquely
> > identifies the file (path and revision), and the maintainer can simply
> > drop the file in, and 'cvs diff -r$OLDREV $FILE'.
> > If it's git, the maintainer drops the file in, and does 'git diff
> > $OLDSHA1 $FILE'.
> I personally hope that the maintainer drops such a non-patch
> that originates from a PEBKAC.  At least I hope the tools that I
> personally use are not maintained by such a maintainer ;-)
I certainly wasn't stating blindly commit the file. Any Gentoo developer
doing that should not have made it through the recruitment process.

Do the diff, separate the wheat from the chaff, and then put the useful
(and reviewed) changes back into the tree.

Glancing at the Gentoo bugs I've dealt with over the last 2 months as a
quick survey, there are a few levels:=20
A - Able to submit a good diff
B - Able to do a good implementation
C - Able to come up with a good idea for improvement

B are in short supply, and even of those, the number that can do A are
smaller :-(. Category C is vastly bigger than B, and those that don't
make B throw up a lot of chaff of bad implementations.

Being able to extract the good ideas is what's important.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGJW8dPpIsIjIzwiwRAkgxAKCKg+Plbvrpaps/8Jni0wPY/9LocACgrqaX
A1xMh1kYcfZuZ8q7u8hfx4M=
=Rygn
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
