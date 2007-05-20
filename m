From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] allow commands to be executed in submodules
Date: Sun, 20 May 2007 22:48:02 +0200
Message-ID: <20070520204801.GH5412@admingilde.org>
References: <20070520153908.GF5412@admingilde.org> <20070520181433.GA19668@steel.home> <7vhcq7mjxn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 22:48:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpsKE-0007pl-G9
	for gcvg-git@gmane.org; Sun, 20 May 2007 22:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756090AbXETUsG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 16:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756279AbXETUsF
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 16:48:05 -0400
Received: from mail.admingilde.org ([213.95.32.147]:34625 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756090AbXETUsF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 16:48:05 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HpsJu-0005ed-1E; Sun, 20 May 2007 22:48:02 +0200
Content-Disposition: inline
In-Reply-To: <7vhcq7mjxn.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47913>


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, May 20, 2007 at 11:25:24AM -0700, Junio C Hamano wrote:
> Sounds useful and more generic.

I explicitly wanted to have a method to execute one command in
the environment of a submodule.  That way we can update it in
one place if we later add more environment variables which
influence the repository.

Do we really have so many places where we want to execute commands
in a different directory or with different environment?  Is it worth
keeping run-command generic and having to introduce knowledge about
how to run submodule commands in multiple places?

That said I don't have any strong feeling about it, as long as one
or the other patch is applied.

--=20
Martin Waitz

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGULQBj/Eaxd/oD7IRAijAAJ0bLnRpdBGzE1fGHBBlnP+CXJ4JhgCfU80A
PmkaSEwGsfzVGtUxRR036o4=
=SyI0
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
