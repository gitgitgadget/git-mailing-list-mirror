From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Mon, 21 May 2007 00:55:22 +0200
Message-ID: <20070520225521.GP5412@admingilde.org>
References: <11796842882917-git-send-email-skimo@liacs.nl> <7vhcq7l3ar.fsf@assigned-by-dhcp.cox.net> <20070520195930.GX942MdfPADPa@greensroom.kotnet.org> <20070520205444.GC25462@steel.home> <20070520214026.GL5412@admingilde.org> <20070520222410.GF25462@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ArrI7P/b+va1vZ8"
Cc: skimo@liacs.nl, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 21 00:55:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpuJF-0002Nw-7F
	for gcvg-git@gmane.org; Mon, 21 May 2007 00:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757835AbXETWzY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 18:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757814AbXETWzY
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 18:55:24 -0400
Received: from mail.admingilde.org ([213.95.32.147]:46517 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757537AbXETWzX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 18:55:23 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HpuJ8-00071k-BR; Mon, 21 May 2007 00:55:22 +0200
Content-Disposition: inline
In-Reply-To: <20070520222410.GF25462@steel.home>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47943>


--7ArrI7P/b+va1vZ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, May 21, 2007 at 12:24:10AM +0200, Alex Riesen wrote:
> But it is not a merge. It is a checkout. Being another operation it
> may even be disallow merges of subprojects. Just plainly tell user
> that this checkout is not possible because there are changes in
> subprojects and in the pointer to this subproject in the upper level
> superproject, and that the user should think about committing in
> subproject first.

If the user did commit and then you do a supermodule checkout -m you
will get a merge.

--=20
Martin Waitz

--7ArrI7P/b+va1vZ8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGUNHZj/Eaxd/oD7IRAtecAJoC8u5vh+l5C5a37zdDwdak/2lx7ACggSzZ
byUtoCOfQZv+zKiCJCdwFMA=
=p505
-----END PGP SIGNATURE-----

--7ArrI7P/b+va1vZ8--
