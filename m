From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] add -p: get rid of Git.pm warnings about unitialized values
Date: Sun, 8 Feb 2009 19:01:25 +0100
Message-ID: <200902081901.44974.trast@student.ethz.ch>
References: <1234114839-11958-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1442250.tmRGhjsPt7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Feb 08 19:03:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWE08-000720-7m
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 19:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbZBHSBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 13:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752772AbZBHSBy
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 13:01:54 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:5510 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725AbZBHSBx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 13:01:53 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 8 Feb 2009 19:01:51 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 8 Feb 2009 19:01:51 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <1234114839-11958-1-git-send-email-s-beyer@gmx.net>
X-OriginalArrivalTime: 08 Feb 2009 18:01:51.0548 (UTC) FILETIME=[51A5EFC0:01C98A17]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108996>

--nextPart1442250.tmRGhjsPt7
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Stephan Beyer wrote:
> After invoking git add -p I always got the warnings:
>=20
>  Use of uninitialized value $_[3] in exec at Git.pm line 1282.
>  Use of uninitialized value $args[2] in join or string at Git.pm line 126=
4.
[...]
> -	my $help_color_spec =3D $repo->config('color.interactive.help');
> +	my $help_color_spec =3D ($repo->config('color.interactive.help') or
> +				'red bold');

Acked-By: Thomas Rast <trast@student.ethz.ch>

Thanks for spotting this.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1442250.tmRGhjsPt7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmPHggACgkQqUud07tmzP0SAACeNI3aBVosTH+rZ0QKVtsuTEJ9
3p0AnROLhDlDaYAKs0bAuAtaLC+fZKFx
=rFZ4
-----END PGP SIGNATURE-----

--nextPart1442250.tmRGhjsPt7--
