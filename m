From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] fix git-revert command-line options
Date: Thu, 3 Aug 2006 20:41:42 +0200
Message-ID: <20060803184141.GA5476@admingilde.org>
References: <20060803153742.109978@dial-up-mi-12.lombardiacom.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 03 20:41:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8i8k-00083T-Uq
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 20:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWHCSlr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 14:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbWHCSlr
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 14:41:47 -0400
Received: from admingilde.org ([213.95.32.146]:15236 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1030199AbWHCSlr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 14:41:47 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1G8i8c-0001a2-2j; Thu, 03 Aug 2006 20:41:42 +0200
To: Michael <barra_cuda@katamail.com>
Content-Disposition: inline
In-Reply-To: <20060803153742.109978@dial-up-mi-12.lombardiacom.it>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24745>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Thu, Aug 03, 2006 at 05:42:23PM +0200, Michael wrote:
> -	-n|--n|--no|--no-|--no-c|--no-co|--no-com|--no-comm|\
> +	-n|--no-c|--no-co|--no-com|--no-comm|\

> -	--n|--no|--no-|--no-e|--no-ed|--no-edi|--no-edit)
> +	--n|--no-e|--no-ed|--no-edi|--no-edit)

well spottet, but now we still have "-n" versus "--n".
Perhaps we should drop the single-letter options or at least only
keep one of them and then explicitly document that in the manpage.

--=20
Martin Waitz

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFE0kNlj/Eaxd/oD7IRAlVkAJ48BGuODRWD+aTG+dWSRjUjlNYuTwCeLHhV
3YzPMy9QO823w3wIXWTZ5Qk=
=3MK+
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
