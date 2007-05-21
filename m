From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Mon, 21 May 2007 13:34:15 +0200
Message-ID: <20070521113415.GY5412@admingilde.org>
References: <11796842882917-git-send-email-skimo@liacs.nl> <20070520225252.GO5412@admingilde.org> <20070521085419.GG942MdfPADPa@greensroom.kotnet.org> <20070521100716.GX5412@admingilde.org> <20070521101455.GK942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v15hXiddb3kq3Bam"
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon May 21 13:34:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq69i-0001RH-IK
	for gcvg-git@gmane.org; Mon, 21 May 2007 13:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689AbXEULeT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 07:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755107AbXEULeT
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 07:34:19 -0400
Received: from mail.admingilde.org ([213.95.32.147]:43153 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012AbXEULeT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 07:34:19 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Hq69X-00042i-Ox; Mon, 21 May 2007 13:34:15 +0200
Content-Disposition: inline
In-Reply-To: <20070521101455.GK942MdfPADPa@greensroom.kotnet.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48009>


--v15hXiddb3kq3Bam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, May 21, 2007 at 12:14:55PM +0200, Sven Verdoolaege wrote:
> How?  AFAICS, it's upload-pack of the *clonee* that determines
> where the actual git dir is.  The cloner has no clue.

we can just store the link to the workdir-or-gitdir and then try
it out every time we access it.  When clone stores the location
of the parent repository it doesn't know what it points to, but
fetch works, too.

--=20
Martin Waitz

--v15hXiddb3kq3Bam
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGUYO3j/Eaxd/oD7IRAjF/AJ4l8VL/NNPtOLTH7Zg6I5+zVZrYJACfctwW
ZQKqUC0KgtZJAIb//fb3BZQ=
=VPn6
-----END PGP SIGNATURE-----

--v15hXiddb3kq3Bam--
