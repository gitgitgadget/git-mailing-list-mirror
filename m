From: Martin Waitz <tali@admingilde.org>
Subject: Re: .gitlink for Summer of Code
Date: Tue, 27 Mar 2007 19:35:12 +0200
Message-ID: <20070327173512.GS22773@admingilde.org>
References: <1174825838.12540.5.camel@localhost> <20070326220302.GH22773@admingilde.org> <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net> <200703270117.59205.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0703270952020.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X35wERi4JU/f1kly"
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>, Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 19:35:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWFZq-00038u-6k
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 19:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934052AbXC0RfS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 13:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934054AbXC0RfS
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 13:35:18 -0400
Received: from mail.admingilde.org ([213.95.32.147]:47107 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934052AbXC0RfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 13:35:16 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HWFZg-0003Od-EA; Tue, 27 Mar 2007 19:35:12 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703270952020.6730@woody.linux-foundation.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43290>


--X35wERi4JU/f1kly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Mar 27, 2007 at 10:04:53AM -0700, Linus Torvalds wrote:
>  - walking the *global* object list is simply not possible. You need to=
=20
>    fsck every single subtree individually, and fsck the superproject on=
=20
>    its own, *without* recursing into the subprojects. And you need to be=
=20
>    able to clone the superproject and only one or two subprojects, and=20
>    never see it as one "atomic" big repository.

and just skip the unreachability check of fsck?
With this limitation a shared object store would be possible.

> I really think people should think about the *BSD kind of "world" setup.=
=20
> You absolutely do _not_ want supermodules to be indivisible "everything o=
r=20
> nothign" kind of things. You want submodules to be very much separate=20
> repostories, although you *can* of course share the object store if you=
=20
> want to (the same way git can do it between any number of totally=20
> unrelated repositories!)

You already convinced me that the "world" use-case is worthwhile.
As to *can* be shared: I'd really like to have some default location for
all objects so that it can be found automatically when you later decide
to checkout a new submodule which has not yet been fetched.

--=20
Martin Waitz

--X35wERi4JU/f1kly
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGCVXQj/Eaxd/oD7IRAnDKAKCFFOfSEYYY3afgL7U2llo4pA1dEQCggplT
k9uKJLXBtiR6HFUZgt88SRA=
=57d5
-----END PGP SIGNATURE-----

--X35wERi4JU/f1kly--
