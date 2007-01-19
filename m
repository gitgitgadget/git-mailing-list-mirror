From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: git ls-files -o under .git/ prints all repository files
Date: Fri, 19 Jan 2007 13:19:47 +0100
Message-ID: <45B0B763.2020007@fs.ei.tum.de>
References: <87r6trsu7n.wl@mail2.atmark-techno.com>	 <7vwt3jjywc.fsf@assigned-by-dhcp.cox.net>	 <45B07875.9030506@fs.ei.tum.de>	 <81b0412b0701182357l3a6d44fel58da50c7895fb6b4@mail.gmail.com>	 <45B07C26.4000008@fs.ei.tum.de>	 <81b0412b0701190032w686c9403uacd9b3e1e44be307@mail.gmail.com>	 <45B0898B.5040804@fs.ei.tum.de>	 <81b0412b0701190133o70ab9da3ga0441e9ca16991a9@mail.gmail.com>	 <45B09926.5060306@fs.ei.tum.de> <81b0412b0701190238o79ce8473t2faf1a797565bc5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig57B251258FCC557B9327101D"
Cc: Junio C Hamano <junkio@cox.net>,
	Yasushi SHOJI <yashi@atmark-techno.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 13:20:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7sis-0004Wy-CT
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 13:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbXASMTz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 07:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbXASMTz
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 07:19:55 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:33554 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965086AbXASMTy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 07:19:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 385D028180;
	Fri, 19 Jan 2007 13:19:53 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zdUldDVT6+wH; Fri, 19 Jan 2007 13:19:51 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-212-125.dynamic.mnet-online.de [62.216.212.125])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 969F92816B;
	Fri, 19 Jan 2007 13:19:51 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701190238o79ce8473t2faf1a797565bc5d@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37175>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig57B251258FCC557B9327101D
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Alex Riesen wrote:
>> okay, what do I expect when doing cd .git && git-ls-files?
>>  Either listing *all files* in the repo (like git-ls-files from the
>> repo root) or no files at all, or failure (".git is private").
>=20
> List nothing. That's what it does. It could return non-0
> (which it does not), but aside from that,... looks very sensible.

yah, to fail or not to fail.  I'd still say listing in .git is invalid, h=
ence fail.

> Alright, it is not. I can even imagine someone having a script
> containing "git-ls-files -o| rm -f; git reset --hard" to get clean=20
> working dir,
> and starting the script in .git one day. Make "-o" list nothing as well=
?

yes, I actually wanted to talk about -o, but forgot to mention.  Followin=
g my reasoning above, it should fail as well.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig57B251258FCC557B9327101D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFsLdmr5S+dk6z85oRAm9GAJ0Si02rVWsGUi7RmRskrGbRfkdRYwCfXg9O
YO64BmZrD9v3MSo7L5WRX20=
=kfyh
-----END PGP SIGNATURE-----

--------------enig57B251258FCC557B9327101D--
