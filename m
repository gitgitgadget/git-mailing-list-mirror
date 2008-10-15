From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: StGIT 0.14.3: extra space is added before e-mail on export after "stg edit"
Date: Wed, 15 Oct 2008 20:25:14 +0400
Message-ID: <200810152025.19995.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1707442.lqMjNUNyOW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Wed Oct 15 19:19:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqA1C-0005Iu-1u
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 19:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbYJORR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 13:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752836AbYJORR1
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 13:17:27 -0400
Received: from fallback.mail.ru ([194.67.57.14]:14267 "EHLO mx4.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752819AbYJORR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 13:17:27 -0400
X-Greylist: delayed 3090 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Oct 2008 13:17:26 EDT
Received: from mx71.mail.ru (mx71.mail.ru [194.67.23.4])
	by mx4.mail.ru (mPOP.Fallback_MX) with ESMTP id 0DF62EDE7
	for <git@vger.kernel.org>; Wed, 15 Oct 2008 20:25:54 +0400 (MSD)
Received: from [91.77.250.205] (port=29786 helo=cooker.net)
	by mx71.mail.ru with asmtp 
	id 1Kq9BY-0005Kf-00; Wed, 15 Oct 2008 20:25:21 +0400
User-Agent: KMail/1.9.10
X-Spam: Not detected
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98287>

--nextPart1707442.lqMjNUNyOW
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Funny problem. I have following export template:

Subject: [PATCH] %(shortdescr)s
From: %(authname)s %(authemail)s

%(longdescr)s
Signed-off-by: %(authname)s %(authemail)s

---

%(diffstat)s

So after "stg new", edit, "stg refres" (and any number of "stg refresh"es)
it exports OK. But once I did "stg edit patch", all subsequent "stg export patch"
will give (assuming author is me@foo.net):

From: My Name < me@foo.net>
...
Signed-off-by: My Name < me@foo.net>

Notice extra space between "<" and e-mail.

TIA

-andrey

--nextPart1707442.lqMjNUNyOW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkj2GWsACgkQR6LMutpd94xNoQCdGRL5avkuMqu82lphC+uuKBaU
E6YAnRw5h6AimNZ9zEsPzxlR2El/EC3x
=v3+Q
-----END PGP SIGNATURE-----

--nextPart1707442.lqMjNUNyOW--
