From: Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: [RFC] shallow clone
Date: Tue, 31 Jan 2006 15:23:34 +0100
Message-ID: <43DF72E6.4050802@hogyros.de>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de> <43DDFF5C.30803@hogyros.de> <Pine.LNX.4.63.0601301305100.20228@wbgn013.biozentrum.uni-wuerzburg.de> <7vzmld7c2g.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0601311127490.25248@wbgn013.biozentrum.uni-wuerzburg.de> <43DF608C.1060201@hogyros.de> <Pine.LNX.4.63.0601311422400.7918@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEDD969EA53EEE38FA45E97CC"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 15:24:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3wQC-0000a2-6K
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 15:23:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWAaOXo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 09:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWAaOXo
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 09:23:44 -0500
Received: from kleinhenz.com ([213.239.205.196]:54486 "EHLO kleinhenz.com")
	by vger.kernel.org with ESMTP id S1750905AbWAaOXn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 09:23:43 -0500
Received: from [192.168.115.35] (p54995B2F.dip.t-dialin.net [84.153.91.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Simon Richter", Issuer "Kleinhenz Elektronik CA" (verified OK))
	by kleinhenz.com (Postfix) with ESMTP id E3C0B4A8045;
	Tue, 31 Jan 2006 15:23:41 +0100 (CET)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0601311422400.7918@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.93.0.0
OpenPGP: url=http://www.hogyros.de/simon.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15317>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEDD969EA53EEE38FA45E97CC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Johannes Schindelin wrote:

> If you pull, upload-pack will think you have *every* object depending on 
> every ref you have stored.

Ah, okay. That was the missing information, thanks.

> You only have two choices: you proposed code duplication, and yours truly 
> proposed data duplication.

Erm, if there are multiple places for parsing a grafts file, that needs 
to be addressed as well.

> As is known from good database design: a few redundancies here and there 
> are typically needed for good performance.

Sure, but only if you can "rebuild" all the redundant information reliably.

    Simon

--------------enigEDD969EA53EEE38FA45E97CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ99y6FYr4CN7gCINAQK8CQP+KsjhoNgXlcAerHnCv4s/97UsFw+EFOtI
HSuAGySieFb5FjiFiHnGq8spbnibS1/ewdbiJcRAqezioqW2+Kcs8jlEBS84yI78
zUNYlJqPRcAIisq33G5wu+y7YhUqoezvzEWtUUyMZqKQ520mzD6vO6HyezFkzkk7
C78JkQ+/5cU=
=QteN
-----END PGP SIGNATURE-----

--------------enigEDD969EA53EEE38FA45E97CC--
