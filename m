From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 0/2] Custom low-level merge driver support.
Date: Thu, 19 Apr 2007 09:52:30 +0200
Message-ID: <20070419075229.GA27208@admingilde.org>
References: <11768880622402-git-send-email-junkio@cox.net> <Pine.LNX.4.64.0704181247410.12094@racer.site> <20070418153445.GC12888@admingilde.org> <alpine.LFD.0.98.0704180910120.2828@woody.linux-foundation.org> <7vslaxhamd.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0704181136360.2828@woody.linux-foundation.org> <7vzm55fqyv.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0704181246160.2828@woody.linux-foundation.org> <7vk5w9fnjx.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0704181330050.2828@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 19 09:52:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeRRh-0003rs-B7
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 09:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993147AbXDSHwr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 03:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993156AbXDSHwr
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 03:52:47 -0400
Received: from mail.admingilde.org ([213.95.32.147]:57474 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993147AbXDSHwb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 03:52:31 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HeRRO-0007OX-0d; Thu, 19 Apr 2007 09:52:30 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0704181330050.2828@woody.linux-foundation.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44988>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2007 at 01:35:05PM -0700, Linus Torvalds wrote:
> So maybe each strategy could have "sub-strategies" for other file types.
>=20
> Ie something like
>=20
> 	[merge "ours"]
> 		name =3D pick our own version
> 		driver =3D /bin/true
> 		symlinks =3D /bin/true

or different attributes for other file types:

[attr] *@ merge=3Dours		# for symlinks
[attr] */ merge=3Dsubmodule	# for dirlinks

--=20
Martin Waitz

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGJx+9j/Eaxd/oD7IRAjJRAJ0XypINqO+e3gCf/aqQbzNx/CYSdQCfezyK
Vnt6MB9duaMKgWAU39P4Nsc=
=EHjq
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
