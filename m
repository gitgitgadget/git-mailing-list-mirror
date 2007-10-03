From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Linking with -R (rpath) not supported on Darwin
Date: Wed, 3 Oct 2007 23:34:41 +0200
Message-ID: <4D954ADB-E66E-43CA-87EE-7522FFA87370@lrde.epita.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-76-539200052"
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 23:35:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdBsF-0003PS-TY
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 23:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567AbXJCVfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 17:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752927AbXJCVfL
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 17:35:11 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:47378 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbXJCVfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 17:35:09 -0400
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IdBs4-0000Qn-Gm
	for git@vger.kernel.org; Wed, 03 Oct 2007 23:35:08 +0200
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59888>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-76-539200052
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

Hello,
I've just compiled HEAD (1.5.3.4.209.g9e417) and saw a:
     LINK git-http-fetch
i686-apple-darwin8-gcc-4.0.1: unrecognized option '-R/opt/local/lib'

It didn't harm but the build process should be more careful to not  
use options that are not supported by the compiler.  And it's not a  
matter of using -Wl,-rpath instead.

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-76-539200052
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHBArxwwE67wC8PUkRAlaZAJ9KtANgHBhkQ1wqjkSsHcSu1Xov5wCcDgyJ
7vogJXKAme/AjcdGw9EhswU=
=Rypd
-----END PGP SIGNATURE-----

--Apple-Mail-76-539200052--
