From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] doc/git-send-email: mention sendemail.cc config variable
Date: Mon, 29 Dec 2008 14:00:06 +0100
Message-ID: <200812291400.08924.trast@student.ethz.ch>
References: <200812290037.25890.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8318266.76G4duW1d0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Mon Dec 29 14:01:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHHkG-0003oJ-8A
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 14:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438AbYL2M76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 07:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752259AbYL2M76
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 07:59:58 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:33951 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620AbYL2M75 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 07:59:57 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 29 Dec 2008 13:59:55 +0100
Received: from [192.168.0.3] ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 29 Dec 2008 13:59:54 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <200812290037.25890.markus.heidelberg@web.de>
X-OriginalArrivalTime: 29 Dec 2008 12:59:54.0831 (UTC) FILETIME=[584E8DF0:01C969B5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104099>

--nextPart8318266.76G4duW1d0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Markus Heidelberg wrote:
>  	Specify a starting "Cc:" value for each email.
> +	Default is the value of 'sendemail.cc'.
>  +
>  The --cc option must be repeated for each user you want on the cc list.

Judging from the source, this is not a default value that you can
override: any recipients listed in sendemail.cc configuration(s) are
always added to the Cc list.  The same goes for --bcc and
sendemail.bcc however, which uses the exact same formulation.

Maybe something like

  You can also add Cc recipients via 'sendemail.cc' configuration
  settings.

would clarify?

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch



--nextPart8318266.76G4duW1d0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklYydgACgkQqUud07tmzP0oQQCeOfJIloLvyLaeeSNgWnQA4JWg
YwQAniorl/hvVgggvydIbYvvvPSxhknE
=nwJJ
-----END PGP SIGNATURE-----

--nextPart8318266.76G4duW1d0--
