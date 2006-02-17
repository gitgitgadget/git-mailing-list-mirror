From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: [PATCH 5/5] Optionally work without python
Date: Fri, 17 Feb 2006 22:07:17 +0100
Message-ID: <43F63B05.4030405@gorzow.mm.pl>
References: <Pine.LNX.4.63.0602171523510.24274@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig97EB7F2661EE9C927309FDAB"
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Feb 17 22:07:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FACpP-0005w1-On
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 22:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbWBQVHo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 16:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbWBQVHo
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 16:07:44 -0500
Received: from goliat1.kalisz.mm.pl ([81.15.136.226]:26530 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S1751800AbWBQVHn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Feb 2006 16:07:43 -0500
Received: (qmail 21189 invoked from network); 17 Feb 2006 21:07:36 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.201.167])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <junkio@cox.net>; 17 Feb 2006 21:07:36 -0000
Received: from [192.168.0.1] (zen.uplink [192.168.0.1])
	by zen.uplink (Postfix) with ESMTP id 3E40C178A85;
	Fri, 17 Feb 2006 22:07:22 +0100 (CET)
User-Agent: Thunderbird 1.4.1 (X11/20051010)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602171523510.24274@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16365>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig97EB7F2661EE9C927309FDAB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
> In some setups (notably server setups) you do not need that dependency.=

> Gracefully handle the absence of python when NO_PYTHON is defined.
>

> +# Define NO_PYTHON if you want to loose all benefits of the recursive =
merge.

lose

> --- a/git-merge.sh
> +++ b/git-merge.sh
> @@ -11,7 +11,11 @@ LF=3D'
>  '
>
>  all_strategies=3D'recursive octopus resolve stupid ours'

Maybe use this:

default_strategies=3D'recursive'
if test -n "@@NO_PYTHON@@"; then
	default_strategies=3D'resolve'
fi

--=20
GPG Key id:  0xD1F10BA2
Fingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm


--------------enig97EB7F2661EE9C927309FDAB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD9jsKlUMEU9HxC6IRAg9PAJ0X9kuNAorCnxR3Tcrl72WOP7u2aQCgmvU/
bVLibxS0GsuPhzgTObB2Le4=
=sY4e
-----END PGP SIGNATURE-----

--------------enig97EB7F2661EE9C927309FDAB--
