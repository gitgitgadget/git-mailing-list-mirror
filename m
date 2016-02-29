From: =?UTF-8?B?TWljaGFsIMSMaWhhxZk=?= <michal@cihar.com>
Subject: git cat-file -e behavior
Date: Mon, 29 Feb 2016 10:58:29 +0100
Message-ID: <56D41645.4050800@cihar.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GuVmPsrnKr6IVBLQMjDOLbDm7uBSVucQh"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 29 11:16:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaKsK-0007Hb-NB
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 11:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482AbcB2KQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 05:16:11 -0500
Received: from mort.cihar.com ([77.78.107.252]:53222 "EHLO mail.cihar.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119AbcB2KQI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 05:16:08 -0500
X-Greylist: delayed 1053 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Feb 2016 05:16:08 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cihar.com; s=20150416;
	h=Content-Type:MIME-Version:Date:Message-ID:Subject:From:To; bh=EOwQtWfY+PxKDT6bbbm/oSRJ8dZsQpA1QI7132iELF0=;
	b=kS8GO6w+HaUOiPLYppPLtt8U5cof/rG7YO0zUfTCP9pd5xmTdayCEqQk+8TJqI7hXbtrkhHHhlEboEIK73LyWaH70brsqhTYxKaA8GVwADy21F0WmjY5s4zSf4/6xJ+NG+F8LHZZYKVl0GRIDwGGhFfScGu/xxR7u9u4L/eDOLQ=;
Received: from 127.0.0.1 (helo=authenticated.u-s-e-r)
	by mail.cihar.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.84)
	(envelope-from <michal@cihar.com>)
	id 1aaKb0-00062j-Io
	for git@vger.kernel.org; Mon, 29 Feb 2016 10:58:30 +0100
Received: from [::1]
	by nutt with esmtp (Exim 4.86)
	(envelope-from <michal@cihar.com>)
	id 1aaKaz-0001w9-Tv
	for git@vger.kernel.org; Mon, 29 Feb 2016 10:58:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287819>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GuVmPsrnKr6IVBLQMjDOLbDm7uBSVucQh
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

the documentation for "git cat-file -e" says:

> Suppress all output; instead exit with zero status if <object> exists
and is a valid object.

However running it on non existing object will complain "fatal: Not a
valid object name".

$ git cat-file -e master:README.rst
$ echo $?
0
$ git cat-file -e master:foo
fatal: Not a valid object name master:foo
$ echo $?
128

Is the output in this case expected?

I'm currently running 2.7.0.

--=20
	Michal =C4=8Ciha=C5=99 | http://cihar.com | http://blog.cihar.com


--GuVmPsrnKr6IVBLQMjDOLbDm7uBSVucQh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW1BZFAAoJEPSqIp1NWMJFTooP+weIyS2ROZpbGzllaEG1cepR
xUheAi6w83j9v76bazbo1Bi3PZa2WNEvJRxGekWrQzZivwijsg4ldDbA7Wuu6aTK
NU0hT8l5ZdFgH6Hf5NHGEpOfRP15pJNr0LxPT9BedJQSEWdVl6QYtGWauwkr8UYr
I+9p/A3SFp+C8B87RI5ctFwHy4fQ9edcMWKGYJ534GwcN5Y2ujTDfXDCZE7quAER
HnpXdGoBxlDrO66Bgflvc5xz+kbvfPV5WympSXq82hIxOneZLTerr1inNlJm2JwI
MyZcF17U450W1k47Iy14kxMSb/dw2z/9NYcc49n+EO139X/1HX1bsVDyUAKaY1SI
gKrJHqRQihEaINyVaE+NdZETJQ+sypG37qE3RhLHLuHtd1WTUL9pX78Rl8RGDA12
YteGUrEG0GURYg9UhnxIabA6+8JK1IR9qt6M9k9VHNcweHIFGLqU3vpCJm/3rAh1
4XEPsZSA4jX+l5yT3AjcAh4pxqUe1wiZX05HEjrpTVfzQYs17Mwpz7+9kJBwdHZh
NyAUY0MEWMZYU0sLla75az7OpQskAqlAK8fIMkbvg9n1wMh5EiCbIwkAU2t2SIZc
tUfJlJQsGMK1jmg4V3pwWd5jI7Sp4fKUZrGmmsp8lSEspGTb4HAIbWUYrjD6CyES
kygVRrzZHdTMmUVv8QcH
=W7w1
-----END PGP SIGNATURE-----

--GuVmPsrnKr6IVBLQMjDOLbDm7uBSVucQh--
