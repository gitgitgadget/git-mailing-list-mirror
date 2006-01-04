From: Simon Richter <Simon.Richter@kleinhenz.de>
Subject: [PATCH] Ignore tags that contain colons in their names
Date: Wed, 04 Jan 2006 14:13:46 +0100
Message-ID: <43BBCA0A.6020906@kleinhenz.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4E0912AF765A09BE75B66D9F"
X-From: git-owner@vger.kernel.org Wed Jan 04 14:14:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eu8TK-0003AR-TT
	for gcvg-git@gmane.org; Wed, 04 Jan 2006 14:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWADNOO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jan 2006 08:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWADNOO
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jan 2006 08:14:14 -0500
Received: from kleinhenz.com ([213.239.205.196]:14795 "EHLO kleinhenz.com")
	by vger.kernel.org with ESMTP id S1751256AbWADNON (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jan 2006 08:14:13 -0500
Received: from [192.168.115.35] (p54994D62.dip.t-dialin.net [84.153.77.98])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Simon Richter", Issuer "Kleinhenz Elektronik CA" (verified OK))
	by kleinhenz.com (Postfix) with ESMTP id DCD6A4A8045
	for <git@vger.kernel.org>; Wed,  4 Jan 2006 14:13:55 +0100 (CET)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
To: git <git@vger.kernel.org>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14176>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4E0912AF765A09BE75B66D9F
Content-Type: multipart/mixed;
 boundary="------------030608090202070902000405"

This is a multi-part message in MIME format.
--------------030608090202070902000405
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

a repo I was trying to clone contained a tag that somehow had a colon in 
its name, which is illegal. The attached patch makes git-fetch ignore 
these tags rather than barf.

    Simon

--------------030608090202070902000405
Content-Type: text/plain;
 name="ignore-colon-tags.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="ignore-colon-tags.diff"

ZGlmZiAtLWdpdCBhL2dpdC1mZXRjaC5zaCBiL2dpdC1mZXRjaC5zaAppbmRleCAxMjViY2Vh
Li42ZDkzMGIyIDEwMDc1NQotLS0gYS9naXQtZmV0Y2guc2gKKysrIGIvZ2l0LWZldGNoLnNo
CkBAIC0xOTEsNiArMTkxLDcgQEAgdGhlbgogCXRhZ2xpc3Q9JChnaXQtbHMtcmVtb3RlIC0t
dGFncyAiJHJlbW90ZSIgfAogCQlzZWQgLWUgJwogCQkJL1xeL2QKKwkJCS86L2QKIAkJCXMv
XlteCV0qCS8vCiAJCQlzLy4qLy4mOiYvJykKIAlpZiB0ZXN0ICIkIyIgLWd0IDEK
--------------030608090202070902000405--

--------------enig4E0912AF765A09BE75B66D9F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ7vKClYr4CN7gCINAQIbNAP/SjT+wQc0qwgO3yR8pbaJIXjYeflyydsU
JHx7UPifoFi3XT1kIaW2Zx0MUTSTeQsb4zUirnv72WCIoF09uj0a4dVBV4jOBK6o
bciTeKpI6nJ14aFRtFDYD30YyyX2FOOkzuh7bjrNO/ZjeLvE6hoxzB0WRUhZxjhO
+qmqi/p6bCM=
=fpmx
-----END PGP SIGNATURE-----

--------------enig4E0912AF765A09BE75B66D9F--
