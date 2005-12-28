From: Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: git-inject-tarball
Date: Wed, 28 Dec 2005 16:51:16 +0100
Message-ID: <43B2B474.1000603@hogyros.de>
References: <pan.2005.12.28.02.40.14.577883@progsoc.org> <Pine.LNX.4.63.0512281230070.15184@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5C03EDE1EE006E3E8FFA83A2"
Cc: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 16:51:49 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErdaX-0008Fl-Gy
	for gcvg-git@gmane.org; Wed, 28 Dec 2005 16:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbVL1Pvi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Dec 2005 10:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVL1Pvi
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Dec 2005 10:51:38 -0500
Received: from kleinhenz.com ([213.239.205.196]:33481 "EHLO kleinhenz.com")
	by vger.kernel.org with ESMTP id S932528AbVL1Pvi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Dec 2005 10:51:38 -0500
Received: from [192.168.115.35] (p549965B9.dip.t-dialin.net [84.153.101.185])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Simon Richter", Issuer "Kleinhenz Elektronik CA" (verified OK))
	by kleinhenz.com (Postfix) with ESMTP id AA31E4A8003;
	Wed, 28 Dec 2005 16:51:21 +0100 (CET)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512281230070.15184@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.93.0.0
OpenPGP: url=http://www.hogyros.de/simon.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14099>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5C03EDE1EE006E3E8FFA83A2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Johannes Schindelin wrote:

> Something like this?

> -- snip --
> #!/bin/sh
> 
> TARFILE="$1"
> test -z "$TARFILE" && TARFILE=-
> 
> git-ls-files -z | xargs -0 rm
> tar xvf "$TARFILE" | xargs git add
> git-update-index --remove $(git-ls-files)
> -- snap --

Well, the most important thing for such a tool IMO would be that it 
wouldn't overwrite any uncommitted changes, so it's not as trivial as it 
seems.

    Simon

--------------enig5C03EDE1EE006E3E8FFA83A2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ7K0dFYr4CN7gCINAQKDiQP/dsKneiJpaiO/JOhTrV/5L7PMJ+eODEO+
deVrxVrNrZVp+9pgkcSCQpbUQeygmvw4E83IuocbvPzJr5On1C5heenNz4Jq/UeC
xW+cU/BCMm/WAW3lauopsSODiAydflhEPjxQEZSIEBsVFBLt67+ylEwCo+e6bycx
PAR/h23L7Ns=
=2pW+
-----END PGP SIGNATURE-----

--------------enig5C03EDE1EE006E3E8FFA83A2--
