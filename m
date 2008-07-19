From: Keith Packard <keithp@keithp.com>
Subject: Re: [PATCH] Ensure that SSH runs in non-interactive mode
Date: Sat, 19 Jul 2008 10:57:32 -0700
Message-ID: <1216490252.10694.58.camel@koto.keithp.com>
References: <1216487215-6927-1-git-send-email-fredrik@dolda2000.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5aIZ2X56RMk/8jXOJ0Mz"
Cc: keithp@keithp.com, git@vger.kernel.org
To: Fredrik Tolf <fredrik@dolda2000.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 20:08:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKGr8-0005lm-Ns
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 20:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819AbYGSSGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 14:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754797AbYGSSGm
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 14:06:42 -0400
Received: from home.keithp.com ([63.227.221.253]:3328 "EHLO keithp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754707AbYGSSGl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 14:06:41 -0400
X-Greylist: delayed 537 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Jul 2008 14:06:41 EDT
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 8959311406A;
	Sat, 19 Jul 2008 10:57:43 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 5y6XyA7mrcWR; Sat, 19 Jul 2008 10:57:33 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 7AF1A1141FB; Sat, 19 Jul 2008 10:57:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 663BA11406A;
	Sat, 19 Jul 2008 10:57:33 -0700 (PDT)
In-Reply-To: <1216487215-6927-1-git-send-email-fredrik@dolda2000.com>
X-Mailer: Evolution 2.22.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89120>


--=-5aIZ2X56RMk/8jXOJ0Mz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2008-07-19 at 19:06 +0200, Fredrik Tolf wrote:
>  By removing the DISPLAY env variable before forking, SSH
> can thus be forced into non-interactive mode, without any obvious
> ill effects.

This will keep ssh-askpass from using any X-based password input
program.

--=20
keith.packard@intel.com

--=-5aIZ2X56RMk/8jXOJ0Mz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQBIgisLQp8BWwlsTdMRAvh2AKDTlY/gcL/ErO++Qk4zhdeA3rYN/gCfcqrK
mC0mWOKfUSDLRY1ec6aPN/I=
=+T95
-----END PGP SIGNATURE-----

--=-5aIZ2X56RMk/8jXOJ0Mz--
