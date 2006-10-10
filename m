From: Martin Waitz <tali@admingilde.org>
Subject: Re: GIT 1.4.3-rc2
Date: Tue, 10 Oct 2006 19:55:01 +0200
Message-ID: <20061010175501.GD8612@admingilde.org>
References: <7viris63xz.fsf@assigned-by-dhcp.cox.net> <20061010093914.GC8612@admingilde.org> <7vpsd02hkm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 19:55:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXLot-0005tP-0u
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 19:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWJJRzG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 13:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbWJJRzG
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 13:55:06 -0400
Received: from agent.admingilde.org ([213.95.21.5]:53475 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S964911AbWJJRzC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 13:55:02 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GXLoj-0002fD-He; Tue, 10 Oct 2006 19:55:01 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsd02hkm.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28645>


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Oct 10, 2006 at 10:42:33AM -0700, Junio C Hamano wrote:
> > have you looked into the git-fetch --update-head-ok thing I sent last
> > week?
>=20
> I remember seeing it and wondering what workflow would need it.
> Also at the same time I wondered if it was indeed needed for a
> workflow why that workflow can get away with adding only that
> option to git-fetch without either adding more things to it or
> have a custom porcelain that drives the underlying
> git-fetch-pack directly.

I was wondering about it, too.
That's why I haven't added a [PATCH] tag to the message
and just added the diff to show the broken part ;-).

It is clear that the code as it is now does not work but perhaps
the right fix is to simply kill that option.
As nobody replied to the message I guess that nobody cares and
we can remove it after the release.

--=20
Martin Waitz

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFK951j/Eaxd/oD7IRAkj/AJsFvkR/LnMW+tflNtRgSTqNwb6K3QCfXvx7
yRojwp8s7SHts4ujplcXZSA=
=uJkF
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--
