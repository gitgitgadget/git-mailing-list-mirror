From: Daniel Hulme <st@istic.org>
Subject: Re: git-daemon on NSLU2
Date: Sun, 26 Aug 2007 22:24:48 +0000
Message-ID: <20070826222448.GA24142@istic.org>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com> <20070824062106.GV27913@spearce.org> <9e4733910708241238n1899f332j4fafbd6d7ccc48b9@mail.gmail.com> <alpine.LFD.0.999.0708241618070.16727@xanadu.home> <9e4733910708241417l44c55306xaa322afda69c6beb@mail.gmail.com> <alpine.LFD.0.999.0708241616390.25853@woody.linux-foundation.org> <9e4733910708250844n7074cb8coa5844fa6c46b40f0@mail.gmail.com> <20070826093331.GC30474@coredump.intra.peff.net> <9e4733910708260934i1381e73ftb31c7de0d23f6cae@mail.gmail.com> <alpine.LFD.0.999.0708260959050.25853@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Cc: Jon Smirl <jonsmirl@gmail.com>, Jeff King <peff@peff.net>,
	jnareb@gmail.com, Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 26 23:26:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPPcg-00058w-Ly
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 23:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbXHZV0P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 17:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbXHZV0P
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 17:26:15 -0400
Received: from mail3.uklinux.net ([80.84.72.33]:36244 "EHLO mail3.uklinux.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800AbXHZV0O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 17:26:14 -0400
Received: from presteign (cpc2-cmbg3-0-0-cust106.cmbg.cable.ntl.com [86.7.28.107])
	by mail3.uklinux.net (Postfix) with ESMTP
	id DFAF240A491; Sun, 26 Aug 2007 21:26:10 +0000 (UTC)
Received: from foyle.aut.istic.org ([192.168.0.2] helo=localhost)
	by presteign with esmtp (Exim 4.67)
	(envelope-from <st@istic.org>)
	id 1IPPcS-000760-S1; Sun, 26 Aug 2007 22:26:04 +0100
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	Jon Smirl <jonsmirl@gmail.com>, Jeff King <peff@peff.net>,
	jnareb@gmail.com, Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0708260959050.25853@woody.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56735>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 26, 2007 at 10:15:24AM -0700, Linus Torvalds wrote:
> It's easier to optimize on the *client* side: just do the initial clone=
=20
> with rsync/http (and "git gc" it on the client afterwards), and then=20
> change it to the git native protocol after the clone.

When I was working on Xen two years ago, they did the same thing with
their Mercurial repository. They had a proper repo that handled all the
push and fetch traffic, and a cron job would periodically pull from that
into a second repo. This second one was served by http. People were
encouraged to download the seed repo and then do a fetch (from the main
one) immediately.

I don't know whether they still do that, but in any case it shows your
idea is not unprecedented.

--=20
Kanga  said to Roo,  "Drink up  your milk  first, dear, and  talk after-
wards." So Roo, who was drinking his milk, tried to say that he could do
both at once... and had to be  patted on the back  and dried for quite a
long time afterwards.                     A. A. Milne, 'Winnie-the-Pooh'

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG0f2wgoQ42ohbFw0RAj/bAKClLbLNk+PLwrt3jNinBh3GDiUuIgCgr5le
jubCYmjFgmuM4uaktHih2QI=
=DDgk
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
