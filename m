From: Tilman Schmidt <tilman@imap.cc>
Subject: git bisect start silently quits on bad revision arg
Date: Sun, 17 Feb 2008 21:06:30 +0100
Organization: me - organized??
Message-ID: <47B893C6.1020802@imap.cc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4F47C6863F13CF63FA2FD48A"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 21:07:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQpn1-0006Vp-Vn
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 21:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbYBQUGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 15:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbYBQUGe
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 15:06:34 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:51318 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751940AbYBQUGd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Feb 2008 15:06:33 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id B085490E67
	for <git@vger.kernel.org>; Sun, 17 Feb 2008 15:06:32 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Sun, 17 Feb 2008 15:06:32 -0500
X-Sasl-enc: w1ILXrDvn7lMIIorAzdLp6L/Twhf3gMekq61xoJGIPBx 1203278792
Received: from [192.168.59.127] (pD9E85DD3.dip.t-dialin.net [217.232.93.211])
	by mail.messagingengine.com (Postfix) with ESMTP id 3290A114A0
	for <git@vger.kernel.org>; Sun, 17 Feb 2008 15:06:32 -0500 (EST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.1.12) Gecko/20080201 SeaMonkey/1.1.8 Mnenhy/0.7.5.666
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74177>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4F47C6863F13CF63FA2FD48A
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable

Just ran

% git bisect start v2.6.25-rc1 v2.6.24.2 e5dd1278

on a clone of Linus' tree in order to localize a regression I am
hitting, and wondered why it did nothing at all, until I realized
that there is no label v2.6.24.2 in that tree. It sure would be
nice if git would emit an error message in that case.

ts@xenon:~/kernel/linux-2.6> git --version
git version 1.5.4.7.gd8534-dirty

HTH
T.

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig4F47C6863F13CF63FA2FD48A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHuJPGMdB4Whm86/kRAhSUAJ9GHL6s0Ya3guQWvdr8lnjdMFLjywCfcA/U
+ul0j41/uBhxPrvUkbuuW5E=
=MM/z
-----END PGP SIGNATURE-----

--------------enig4F47C6863F13CF63FA2FD48A--
