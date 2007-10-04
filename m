From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] git-init: don't base core.filemode on the ability to chmod.
Date: Thu, 4 Oct 2007 09:17:51 +0200
Message-ID: <20071004071751.GD20800@admingilde.org>
References: <20071003105501.GD7085@admingilde.org> <470388DC.4040504@viscovery.net> <20071003231941.GA20800@admingilde.org> <Pine.LNX.4.64.0710040053380.28395@racer.site> <470482A2.3080907@op5.se> <7vr6kbbdph.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 09:18:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdKyC-0006v9-G5
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 09:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbXJDHR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 03:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbXJDHR4
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 03:17:56 -0400
Received: from mail.admingilde.org ([213.95.32.147]:50437 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbXJDHR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 03:17:56 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.63 #1)
	id 1IdKxz-0000gr-S2; Thu, 04 Oct 2007 09:17:51 +0200
Content-Disposition: inline
In-Reply-To: <7vr6kbbdph.fsf@gitster.siamese.dyndns.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59926>


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Oct 03, 2007 at 11:23:22PM -0700, Junio C Hamano wrote:
> filemode =3D !( (st1.st_mode & S_IXUSR)
>         	/* we did not ask for x-bit -- bogus FS */
> 	    || chmod(path, st1.st_mode & S_IXUSR)
>         	/* it does not let us flip x-bit -- bogus FS */
> 	    || lstat(path, &st2)
>         	/* it does not let us read back -- bogus FS */
> 	    || (st1.st_mode =3D=3D st2.st_mode)
> 	        /* it forgets we flipped -- bogus FS */
> 	    );

that looks good.

--=20
Martin Waitz

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHBJOfj/Eaxd/oD7IRAuPUAJ9b6pedKvZtPSZRJWcXxKdjArTFtACggbEQ
LpzovCD2RFiL0RNOqlfA3DQ=
=6GoY
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
