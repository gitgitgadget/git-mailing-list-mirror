From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: git ls-files -o under .git/ prints all repository files
Date: Fri, 19 Jan 2007 10:04:11 +0100
Message-ID: <45B0898B.5040804@fs.ei.tum.de>
References: <87r6trsu7n.wl@mail2.atmark-techno.com>	 <7vwt3jjywc.fsf@assigned-by-dhcp.cox.net>	 <45B07875.9030506@fs.ei.tum.de>	 <81b0412b0701182357l3a6d44fel58da50c7895fb6b4@mail.gmail.com>	 <45B07C26.4000008@fs.ei.tum.de> <81b0412b0701190032w686c9403uacd9b3e1e44be307@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2D8538C964BB55305BEEB6A1"
Cc: Junio C Hamano <junkio@cox.net>,
	Yasushi SHOJI <yashi@atmark-techno.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 10:04:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7pfd-0000m5-2q
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 10:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbXASJEV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 04:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbXASJEV
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 04:04:21 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:48743 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964982AbXASJET (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 04:04:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id A464828178;
	Fri, 19 Jan 2007 10:04:15 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id xnAPXnKWcoSa; Fri, 19 Jan 2007 10:04:15 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-208-62.dynamic.mnet-online.de [62.216.208.62])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 2C96E28156;
	Fri, 19 Jan 2007 10:04:15 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701190032w686c9403uacd9b3e1e44be307@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37164>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2D8538C964BB55305BEEB6A1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Alex Riesen wrote:
>> i would claim .git to be off limits and unrelated to the working dir
>> (file-wise).  if you want to list files there, do a find . or so.
>>  After all you wouldn't expect cd /usr && git-ls-files -o work there
>> unless you have a /.git or /usr/.git, right?
> Right, just see no practical point changing ls-file for that.

right.  .git should be forbidden in higher layers already.

> I can imagine keeping hooks under git control.
> In this case path(pwd) does contain .git component
> (as in .hg example).

doesn't work either:

% cd .git/hooks
% git add *
fatal: unable to add .git/hooks/applypatch-msg to index

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig2D8538C964BB55305BEEB6A1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFsImOr5S+dk6z85oRAq9xAJ419Datl/Og795uV7ej+ogByLW/sgCeN95R
0q8DyGrCLdnR4NQiLwxjHqk=
=6vHs
-----END PGP SIGNATURE-----

--------------enig2D8538C964BB55305BEEB6A1--
