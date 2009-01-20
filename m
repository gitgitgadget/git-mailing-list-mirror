From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: Newbie Query
Date: Tue, 20 Jan 2009 16:24:25 -0600
Message-ID: <200901201624.30131.bss@iguanasuicide.net>
References: <20090120191952.GA25322@uts.thewillards.local> <200901201534.16571.bss@iguanasuicide.net> <49764647.1080606@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1440427.D1zpmr7PT3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: devel@morey-chaisemartin.com
X-From: git-owner@vger.kernel.org Tue Jan 20 23:25:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPP28-0007a1-9L
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 23:25:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756105AbZATWXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 17:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756072AbZATWXq
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 17:23:46 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:43800 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518AbZATWXp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 17:23:45 -0500
Received: from [63.167.79.115]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LPP0b-0002MD-1B; Tue, 20 Jan 2009 22:23:45 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <49764647.1080606@morey-chaisemartin.com>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106533>

--nextPart1440427.D1zpmr7PT3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 2009 January 20 15:46:47 Nicolas Morey-Chaisemartin wrote:
>Boyd Stephen Smith Jr. a =E9crit :
>> On Tuesday 2009 January 20 15:07:55 Nicolas Morey-Chaisemartin wrote:
>>> I did the rookie mistkae on the central server to create the main
>>> reposity in non-bare mode.
>>> Is there a cleaner way to convert a non-bare git repo into a bare repo
>>> than cloning it?

No.

>>> My repo have a lot of remote branch registered, and cloning them to a
>>> new bare repo mean I'll have to add all those remote branches again
>>> (except if there is another trick here I don't know about).
>>
>> Well, if you can make sure no one is pushing into the repo for a bit:
>> clone it and replace the original with a symlink to new, bare one.  Your
>> clients will be able to use the same URL, so they should be happy.  (I
>> haven't tried this, but it should work.)
>
>Well I know there are solutions to convert it to a bare repo.
>I was just wondering if there was a "clean" one which really converts
>the repo to a bare one and not create a copy which is bare.

The clone *is* a way to convert, with the added advantage of not trashing t=
he=20
original during the conversion, by putting the results in a different=20
location.  In fact, it's probably *cleaner* than any convert-in-place.

>I don't know how bare/non-bare is managed but I guess both types of repo
>are not differing by much, so it'd be great to have a function to
>convert from one to another.

I couldn't tell you all the differences, but I don't think there are many=20
either.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1440427.D1zpmr7PT3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl2Tx4ACgkQdNbfk+86fC1CeACeJlVcEHpLOx8oemXgVbfERmBc
HXUAnjCMj1yt2v5ErK4urYZdc9e6FChz
=h7mX
-----END PGP SIGNATURE-----

--nextPart1440427.D1zpmr7PT3--
