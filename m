From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Thu, 01 Feb 2007 11:15:47 +0100
Message-ID: <45C1BDD3.8050103@fs.ei.tum.de>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <200702010058.43431.jnareb@gmail.com> <20070201003429.GQ10108@waste.org> <200702010157.51452.jnareb@gmail.com> <45C19DD0.20504@fs.ei.tum.de> <Pine.LNX.4.63.0702011108430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF0F56CA043E42E6359E57DA3"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 01 11:17:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCZ0S-0000nv-Eq
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 11:17:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422789AbXBAKQK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 05:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422788AbXBAKQA
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 05:16:00 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:38072 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422777AbXBAKPv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 05:15:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id CAC0E28255;
	Thu,  1 Feb 2007 11:15:48 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gURMhzM5n7ai; Thu,  1 Feb 2007 11:15:48 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-202-10.dynamic.mnet-online.de [62.216.202.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 682C52824E;
	Thu,  1 Feb 2007 11:15:48 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
In-Reply-To: <Pine.LNX.4.63.0702011108430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38340>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF0F56CA043E42E6359E57DA3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
>> If you rename, you take the penalty of duplicating the content=20
>> (compressed) with a new name.  No big deal there. So there are *no*=20
>> file-ids.  Blobs go into the data/index file which corresponds to thei=
r=20
>> filename.
> So, can you explain to me how a filename is _not_ a file-id?

It is not a file-id like other SCM use it (I think monotone, not sure tho=
ugh).  If you copy/move the content to a new name, the ID will not stay t=
he same.  Just see it as a hash bucket which allows you easy access to th=
e history for a file currently with this name.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enigF0F56CA043E42E6359E57DA3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFwb3Tr5S+dk6z85oRAlufAJ4vXtDPht/ZAku+jlzyQ7nGXOen+gCffjaF
sqBNYcGdOE+8WLA7a0BZpkM=
=SYwi
-----END PGP SIGNATURE-----

--------------enigF0F56CA043E42E6359E57DA3--
