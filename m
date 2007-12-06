From: Tilman Schmidt <tilman@imap.cc>
Subject: Re: how to create v2 patch
Date: Thu, 06 Dec 2007 21:04:38 +0100
Organization: me - organized??
Message-ID: <475855D6.201@imap.cc>
References: <47515693.9070405@imap.cc> <47515EF3.8010507@obry.net> <20071201134321.GA10997@glandium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig179FE9D856E74472C61D4F85"
Cc: Pascal Obry <pascal@obry.net>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Dec 06 21:31:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0NNb-0005ZV-Uh
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 21:31:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbXLFUbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 15:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752267AbXLFUbI
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 15:31:08 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:56170 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751592AbXLFUbH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Dec 2007 15:31:07 -0500
X-Greylist: delayed 1670 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Dec 2007 15:31:07 EST
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id BA1F568D56;
	Thu,  6 Dec 2007 15:03:16 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 06 Dec 2007 15:03:16 -0500
X-Sasl-enc: SyWnSv7isShbUEcIBA87rTL5RBPJljlZRGKoI4eLtTqv 1196971396
Received: from [192.168.59.127] (pD9E873FE.dip.t-dialin.net [217.232.115.254])
	by mail.messagingengine.com (Postfix) with ESMTP id CD7A61147D;
	Thu,  6 Dec 2007 15:03:15 -0500 (EST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.1.4) Gecko/20070509 SeaMonkey/1.1.2 Mnenhy/0.7.5.666
In-Reply-To: <20071201134321.GA10997@glandium.org>
X-Enigmail-Version: 0.95.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67335>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig179FE9D856E74472C61D4F85
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 01.12.2007 14:43 schrieb Mike Hommey:
> On Sat, Dec 01, 2007 at 02:17:39PM +0100, Pascal Obry wrote:
>> Tilman Schmidt a =E9crit :
>>> I have produced a patch, submitted it to LKML, received a few
>>> comments, committed appropriate changes to my local git tree,
>>> and now want to submit a revised patch. How do I do that?
>>> If I just run git-format-patch again, it produces my original
>>> patch plus a second one containing my updates, but what I need
>>> is a single new patch replacing the first one.
>> Can't you merge both of your changes in your local repository? I would=

>> do that with an interactive rebase.
>=20
> Or just git commit --amend when committing.

Hmm. But wouldn't each of these approaches lead to my original
commit being removed from my git repository? And isn't removing
commits that have already been published strongly discouraged?

Thx
T.

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Yes, I have searched Google!


--------------enig179FE9D856E74472C61D4F85
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHWFXWMdB4Whm86/kRAmq7AJ9U90DoombNQNgGsTlNofGInbIj2QCfQVyu
4HNfeTEkxa0+IZOXaMM4fzQ=
=b2X4
-----END PGP SIGNATURE-----

--------------enig179FE9D856E74472C61D4F85--
