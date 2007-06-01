From: "Jeffrey C. Ollie" <jeff@ocjtech.us>
Subject: Re: [PATCH] Use =20 when rfc2047 encoding spaces.
Date: Fri, 01 Jun 2007 16:12:03 -0500
Message-ID: <1180732323.3890.33.camel@lt21223.campus.dmacc.edu>
References: <11807320922292-git-send-email-hoegsberg@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fFEhGVhHfawLzBH+eVsC"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 01 23:11:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuEOq-0002bx-Db
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 23:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762327AbXFAVLE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 17:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762644AbXFAVLE
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 17:11:04 -0400
Received: from homer.isunet.net ([63.175.164.9]:57300 "EHLO homer.isunet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762327AbXFAVLD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 17:11:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by homer.isunet.net (Postfix) with ESMTP id 95A6D38815D
	for <git@vger.kernel.org>; Fri,  1 Jun 2007 15:17:46 -0500 (CDT)
Received: from homer.isunet.net ([63.175.164.9])
 by localhost (homer [63.175.164.9]) (amavisd-new, port 10024) with ESMTP
 id 07271-04 for <git@vger.kernel.org>; Fri,  1 Jun 2007 15:17:45 -0500 (CDT)
Received: from max1.ocjtech.us (dsl-ppp239.isunet.net [63.175.164.239])
	by homer.isunet.net (Postfix) with ESMTP id 157D1388053
	for <git@vger.kernel.org>; Fri,  1 Jun 2007 15:17:45 -0500 (CDT)
Received: from [161.210.6.122]
	by max1.ocjtech.us with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.62)
	(envelope-from <jeff@ocjtech.us>)
	id 1HuEOo-0002Cm-UM
	for git@vger.kernel.org; Fri, 01 Jun 2007 16:11:07 -0500
In-Reply-To: <11807320922292-git-send-email-hoegsberg@gmail.com>
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
X-Virus-Scanned: by amavisd-new at isunet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48888>


--=-fFEhGVhHfawLzBH+eVsC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-06-01 at 17:08 -0400, Kristian H=C3=B8gsberg wrote:
>
> -		if (is_rfc2047_special(ch)) {
> +		/* We encode ' ' using '=3D20' even though rfc2047
> +		 * allows using '_' for readability.  Unfortunately,
> +		 * doesn't understand this and just leaves the
> +		 * underscore in place. */
> +		if (is_rfc2047_special(ch) || ch =3D=3D ' ') {

Looks like "much software" got left out of the comment.

Jeff


--=-fFEhGVhHfawLzBH+eVsC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGYIufrtk7xyyIQRERAmIDAKCGGWo/tZXtGy5aw05ZCrRufsjTpgCdGrge
v4y2jDqTRA7d0AUec3Zf71Q=
=t/9H
-----END PGP SIGNATURE-----

--=-fFEhGVhHfawLzBH+eVsC--
