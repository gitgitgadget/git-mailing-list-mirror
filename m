From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH 0/2] Fix handling of merges in git-annotate
Date: Mon, 03 Jul 2006 18:34:35 -0700
Message-ID: <44A9C5AB.1020604@michonline.com>
References: <11519766021208-git-send-email-ryan@michonline.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF159AA25366BB1312562256F"
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 03:36:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxZpm-0000hg-Lf
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 03:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWGDBgM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 21:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWGDBgL
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 21:36:11 -0400
Received: from h4x0r5.com ([70.85.31.202]:61956 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1751201AbWGDBgL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 21:36:11 -0400
Received: from c-71-202-182-135.hsd1.ca.comcast.net ([71.202.182.135] helo=mythryan.michonline.com)
	by h4x0r5.com with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FxZoh-0004KF-9W; Mon, 03 Jul 2006 18:35:07 -0700
Received: from localhost ([127.0.0.1])
	by mythryan.michonline.com with esmtp (Exim 4.62)
	(envelope-from <ryan@michonline.com>)
	id 1FxZoC-000361-3J; Mon, 03 Jul 2006 18:34:36 -0700
User-Agent: Thunderbird 1.5.0.4 (X11/20060619)
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <11519766021208-git-send-email-ryan@michonline.com>
X-Enigmail-Version: 0.94.0.0
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23234>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF159AA25366BB1312562256F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ryan Anderson wrote:
> This 2-patch series is a major overhaul to the way git-annotate calcula=
tes the blame for each line.
>
> Instead of parsing each diff in reverse, this uses the output from "git=

> diff-tree --combined", so that merges can be handled sanely.
>  =20
I forgot:

Please pull from http://h4x0r5.com/~ryan/git/ryan.git annotate-upstream

--=20

Ryan Anderson
  sometimes Pug Majere



--------------enigF159AA25366BB1312562256F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEqcWrfhVDhkBuUKURAoPSAKDa3EGH/tk1CKpwfTW0JfTsmv0EeACgwk7R
HF1ztfBzfDii4lV3JXAjldg=
=2RRF
-----END PGP SIGNATURE-----

--------------enigF159AA25366BB1312562256F--
