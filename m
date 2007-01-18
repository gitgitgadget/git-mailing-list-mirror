From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Lose perl dependency. (fwd)
Date: Thu, 18 Jan 2007 12:52:35 +0100
Message-ID: <45AF5F83.6090207@fs.ei.tum.de>
References: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2E65E21C8DC395F9D7CF5F45"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 12:52:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Vov-0003Op-Aa
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 12:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbXARLwj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 06:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbXARLwj
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 06:52:39 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:55889 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932179AbXARLwi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 06:52:38 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 0C0C12815D;
	Thu, 18 Jan 2007 12:52:37 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id GGPdWvpbs0se; Thu, 18 Jan 2007 12:52:36 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-203-232.dynamic.mnet-online.de [62.216.203.232])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id A6FED28133;
	Thu, 18 Jan 2007 12:52:36 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37082>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2E65E21C8DC395F9D7CF5F45
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
> On Thu, 18 Jan 2007, Simon 'corecode' Schubert wrote:
>=20
>>  for cmt in `git-rev-list --no-merges "$upstream"..ORIG_HEAD \
>> -			| @@PERL@@ -e 'print reverse <>'`
>> +			| sed -ne '1!G;$p;h'`
>=20
> Why not teach the revision machinery to output in reverse with=20
> "--reverse"?

I'm more in favour of "small is beautiful".  Also from looking at the cod=
e, this seems to be a bit complicated.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig2E65E21C8DC395F9D7CF5F45
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFr1+Dr5S+dk6z85oRAvdNAKCsT/qMLYmfjWlYzASAdheVPSRasQCg5S08
Qg9QlpRYXJ7ntavzFAyAz0g=
=GzNh
-----END PGP SIGNATURE-----

--------------enig2E65E21C8DC395F9D7CF5F45--
