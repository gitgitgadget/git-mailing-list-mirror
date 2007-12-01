From: Tilman Schmidt <tilman@imap.cc>
Subject: cannot see git-fetch result in gitk
Date: Sat, 01 Dec 2007 13:34:35 +0100
Organization: me - organized??
Message-ID: <475154DB.4040606@imap.cc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2E38596855EB07500ACCA7DF"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 01 13:33:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyRXb-0003DD-NA
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 13:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbXLAMdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 07:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753396AbXLAMdb
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 07:33:31 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33244 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753189AbXLAMda (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Dec 2007 07:33:30 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 582A856AB8
	for <git@vger.kernel.org>; Sat,  1 Dec 2007 07:33:29 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Sat, 01 Dec 2007 07:33:29 -0500
X-Sasl-enc: iRcX1M44R8gi3tKuqDwdfbGkdzQJpil5lJevczvIVUWs 1196512408
Received: from [192.168.59.127] (pD9E86E37.dip.t-dialin.net [217.232.110.55])
	by mail.messagingengine.com (Postfix) with ESMTP id 89B5823981
	for <git@vger.kernel.org>; Sat,  1 Dec 2007 07:33:28 -0500 (EST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.1.4) Gecko/20070509 SeaMonkey/1.1.2 Mnenhy/0.7.5.666
X-Enigmail-Version: 0.95.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66712>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2E38596855EB07500ACCA7DF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

I'm still learning my way around git and trying to understand how it
works. So after reading
http://www.kernel.org/pub/software/scm/git/docs/howto/rebase-from-interna=
l-branch.txt
I wanted to try and understand the command sequence

git fetch origin
git rebase FETCH_HEAD

by looking at what it does with gitk. But after the first command I do
not see any change at all in gitk. Only after the second one do the
newly fetched objects appear in the gitk display.

Simple question: why?

Thanks,
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Yes, I have searched Google!


--------------enig2E38596855EB07500ACCA7DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHUVTiMdB4Whm86/kRAvxZAJ4jrR8eOtblETsAQSPUcnmhhMp6KgCeP+as
RkFQhDi4+TrI7Dx6HV/5X88=
=Nwun
-----END PGP SIGNATURE-----

--------------enig2E38596855EB07500ACCA7DF--
