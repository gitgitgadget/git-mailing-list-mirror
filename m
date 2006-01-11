From: Simon Richter <Simon.Richter@hogyros.de>
Subject: RFC: Subprojects
Date: Wed, 11 Jan 2006 16:58:23 +0100
Message-ID: <43C52B1F.8020706@hogyros.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig05092532A64B2FAF07FAC83A"
X-From: git-owner@vger.kernel.org Wed Jan 11 16:59:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwiN7-0000wT-L1
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 16:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWAKP6r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 10:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWAKP6r
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 10:58:47 -0500
Received: from kleinhenz.com ([213.239.205.196]:35532 "EHLO kleinhenz.com")
	by vger.kernel.org with ESMTP id S1750864AbWAKP6q (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2006 10:58:46 -0500
Received: from [192.168.115.35] (p5499772B.dip.t-dialin.net [84.153.119.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Simon Richter", Issuer "Kleinhenz Elektronik CA" (verified OK))
	by kleinhenz.com (Postfix) with ESMTP id 59EED4A8045
	for <git@vger.kernel.org>; Wed, 11 Jan 2006 16:58:31 +0100 (CET)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Enigmail-Version: 0.93.0.0
OpenPGP: url=http://www.hogyros.de/simon.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14486>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig05092532A64B2FAF07FAC83A
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

one thing that I have been missing so far in all SCM systems apart from 
CVS (and there it's just coincidence) is the ability to include a 
project as part of a bigger project. Developing software for embedded 
systems, I need that feature fairly often, for example the source tree 
for a particular device almost always contains one or more Linux trees, 
some binutils, gcc and gdb stuff and so on.

The changes necessary here would be fairly simple: "tree" objects would 
point to a "commit" or a "tag" object when a subproject is used.

In the working directory, this would be represented by a .git directory 
that contains a symref to the embedding project instead of the objects 
directory. Head pointers are only required if you intend to push changes 
upstream to the maintainer of the embedded project. Each subproject has 
its own index.

Would such a feature make sense, and what behaviour would make the most 
sense for the various operations (e.g. shall commits in the inner 
project propagate to the outer?)?

    Simon

--------------enig05092532A64B2FAF07FAC83A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ8UrIVYr4CN7gCINAQLF0AP/QG4l/dR3rNJMBQI8tEgRrlxWu9dUbs8Y
zTo2UjF0TAgxRx2lHV9p5wa/jbec4LlG6kMYaPqIz3FUUpsFtzVNBvc8WrqyV2s2
JqQthPJ0hMPU1t6NRYGIwmrZKdIZGX+8CkixqR844OVSKBrkdMulH+KcPRlB88Zv
5iX57DsDPJI=
=v8C/
-----END PGP SIGNATURE-----

--------------enig05092532A64B2FAF07FAC83A--
