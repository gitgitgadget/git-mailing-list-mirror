From: Martin Waitz <tali@admingilde.org>
Subject: Re: git reset --hard not removing some files
Date: Sun, 4 Jun 2006 11:16:02 +0200
Message-ID: <20060604091601.GN14325@admingilde.org>
References: <20060601160052.GK14325@admingilde.org> <Pine.LNX.4.64.0606010918060.5498@g5.osdl.org> <7vhd33d2q2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2WS97oupGEGbYNpW"
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 11:16:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmoiW-0007gi-AA
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 11:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWFDJQF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 05:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWFDJQF
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 05:16:05 -0400
Received: from admingilde.org ([213.95.32.146]:27841 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S932210AbWFDJQE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 05:16:04 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1FmoiI-0002BI-3t; Sun, 04 Jun 2006 11:16:02 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhd33d2q2.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21251>


--2WS97oupGEGbYNpW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Jun 02, 2006 at 07:57:57AM -0700, Junio C Hamano wrote:
> I would agree in the reproduction recipe Martin gave there is no
> problem but feature, but at the same time I suspect the recent
> "reset --hard simplification" has introduced a true regression.

This may have been the bug that bit me.
Thanks for finding it although I was not able to reproduce it myself!

--=20
Martin Waitz

--2WS97oupGEGbYNpW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEgqTRj/Eaxd/oD7IRArtfAJ9IJu6tTYTsop5h9hR02wlbjxn+fQCfcFsx
gQ+hbxB+72bH2AT1WpmizEA=
=djC3
-----END PGP SIGNATURE-----

--2WS97oupGEGbYNpW--
