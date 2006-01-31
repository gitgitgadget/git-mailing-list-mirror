From: Simon Richter <Simon.Richter@hogyros.de>
Subject: Idea: "repair" tool
Date: Tue, 31 Jan 2006 14:16:50 +0100
Message-ID: <43DF6342.2010703@hogyros.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig853DC847A8132AA045D68F52"
X-From: git-owner@vger.kernel.org Tue Jan 31 14:17:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3vNY-0006x2-78
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 14:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWAaNRA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 08:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWAaNRA
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 08:17:00 -0500
Received: from kleinhenz.com ([213.239.205.196]:49366 "EHLO kleinhenz.com")
	by vger.kernel.org with ESMTP id S1750803AbWAaNQ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 08:16:59 -0500
Received: from [192.168.115.35] (p54995B2F.dip.t-dialin.net [84.153.91.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Simon Richter", Issuer "Kleinhenz Elektronik CA" (verified OK))
	by kleinhenz.com (Postfix) with ESMTP id 174EC4A8045
	for <git@vger.kernel.org>; Tue, 31 Jan 2006 14:16:58 +0100 (CET)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
To: git <git@vger.kernel.org>
X-Enigmail-Version: 0.93.0.0
OpenPGP: url=http://www.hogyros.de/simon.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15313>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig853DC847A8132AA045D68F52
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

since one of my linux-2.6 repos got damaged by filesystem corruption (a 
bunch of objects vanished), I am wondering whether it would make sense 
to have a small tool that would get a list of missing objects and try to 
acquire them from all known remote repos (possibly with the approach of 
trying the one you got the last object from first, as usually only files 
from the same pull will have problems if there are filesystem issues).

What do you think?

    Simon

--------------enig853DC847A8132AA045D68F52
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ99jRFYr4CN7gCINAQI7hgQAnzgaV5aHj2XoWbP6F/oY59M3FtVG4sa5
BpKV83RNtkLTtUm207L6wsS6vUcvDIEHgYmiKWBLYAJDg6zXXiXHqHD5lFLXaTL9
phdV2t3ZwGrHhLJLOC5dVvcRAcwSPDiY4PzCoOEtviYs9KwgF2Znx7+j/TCqinRe
CWsWMU0wOHE=
=o82u
-----END PGP SIGNATURE-----

--------------enig853DC847A8132AA045D68F52--
