From: Johan Herland <johan@herland.net>
Subject: "git reset --hard" not cleaning up working copy?
Date: Mon, 07 May 2007 09:51:31 +0200
Message-ID: <200705070951.39677.johan@herland.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=nextPart98220920.9KbE9jAJZe;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 09:52:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hky1C-0006CR-Ae
	for gcvg-git@gmane.org; Mon, 07 May 2007 09:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144AbXEGHwX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 03:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753289AbXEGHwX
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 03:52:23 -0400
Received: from smtp.getmail.no ([84.208.20.33]:55093 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753144AbXEGHwW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 03:52:22 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JHN00A0NV752G00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 07 May 2007 09:52:17 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JHN00IM0V640260@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 07 May 2007 09:51:40 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JHN003J3V63O240@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 07 May 2007 09:51:40 +0200 (CEST)
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46426>

--nextPart98220920.9KbE9jAJZe
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

When I "git reset --hard HEAD" to purge all my non-committed changes, it=20
seems that files I created after the last commit (but not part of the=20
index) are left lying around my working copy. Is this intended?


Have fun!

=2E..Johan

=2D-=20
Johan Herland, <johan@herland.net>
www.herland.net

--nextPart98220920.9KbE9jAJZe
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6-ecc01.6 (GNU/Linux)

iD8DBQBGPtqLBHj4kl4fT1wRAh7uAJsEaDLx9AN1ZVBSK/Ut+X/fJ0YlugCfdyK8
AFLg8R6fD9nppty9X0dLJR8=
=rCFm
-----END PGP SIGNATURE-----

--nextPart98220920.9KbE9jAJZe--
