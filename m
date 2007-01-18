From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH 2/2] Use fixed-size integers for .idx file I/O
Date: Thu, 18 Jan 2007 15:56:06 +0100
Message-ID: <45AF8A86.7070101@fs.ei.tum.de>
References: <7vd55col04.fsf@assigned-by-dhcp.cox.net> <118833cc0701180651w3b5ac164m4e396399f1d58cb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB50F2212BF79AAC4D8727F40"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 15:56:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Ygb-0002Um-9D
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 15:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbXARO4P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 09:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057AbXARO4P
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 09:56:15 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:39242 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbXARO4O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 09:56:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 395BA28162;
	Thu, 18 Jan 2007 15:56:13 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 9qMTeaVLbyXq; Thu, 18 Jan 2007 15:56:12 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-203-232.dynamic.mnet-online.de [62.216.203.232])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 8AD1928120;
	Thu, 18 Jan 2007 15:56:12 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc0701180651w3b5ac164m4e396399f1d58cb7@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37100>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB50F2212BF79AAC4D8727F40
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Morten Welinder wrote:
>> -                       return ntohl(*((unsigned int *) ((char *)=20
>> index + (24 * mi))));
>> +                       return ntohl(*((uint32_t *)((char *)index +=20
>> (24 * mi))));
>=20
> Is that pointer gymnastics guaranteed to work?  I.e., how do we know
> that we can access an uint32_t (or unsigned) at such an address?

if index is always aligned to a 4-byte boundary, this is safe.  apart fro=
m that, the problem already existed.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enigB50F2212BF79AAC4D8727F40
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFr4qLr5S+dk6z85oRAqL0AJsG6W/yOWqkvz3kBfqLyB1oaQfQewCfYvXZ
k2zmLgwCBcqbpz8gA1PDNFE=
=kA9m
-----END PGP SIGNATURE-----

--------------enigB50F2212BF79AAC4D8727F40--
