From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] Support for large files on 32bit systems.
Date: Sat, 17 Feb 2007 10:39:53 +0100
Message-ID: <20070217093953.GE21842@admingilde.org>
References: <20070217091310.GD21842@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 17 10:40:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIM35-00015k-E7
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 10:40:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbXBQJjz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 04:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbXBQJjz
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 04:39:55 -0500
Received: from mail.admingilde.org ([213.95.32.147]:40176 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965106AbXBQJjy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 04:39:54 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HIM2r-0007S8-To
	for git@vger.kernel.org; Sat, 17 Feb 2007 10:39:53 +0100
Content-Disposition: inline
In-Reply-To: <20070217091310.GD21842@admingilde.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39981>


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

arg, this patch is completely broken.
I tested it by setting the macro via the command line and the
=3D is still left in there.  And __GLIBC__ is not yet defined at this
point.

However, we need to set _FILE_OFFSET_BITS for glibc somehow.
What is the best way to do so?

--=20
Martin Waitz

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFF1s1pj/Eaxd/oD7IRAtzmAKCC/kf2y79QmgC2+nzf/rM2UArcgACeO5fM
owZFFWBNNoelBK7fftLAe4M=
=FhVc
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--
