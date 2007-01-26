From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: cvsimport/cvsps: wrong revisions in branch
Date: Fri, 26 Jan 2007 07:20:12 +0100
Message-ID: <45B99D9C.40908@fs.ei.tum.de>
References: <20070125142242.1402.qmail@b4b5deb4d44aa3.315fe32.mid.smarden.org>	 <45B8C032.7020004@fs.ei.tum.de> <46a038f90701251806k719dd35p7b13fe049b9cf25c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig351BF541A0487AC4E915E7F1"
Cc: git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 07:20:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAKRn-0006gW-19
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 07:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030784AbXAZGUX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 01:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030785AbXAZGUX
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 01:20:23 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:40960 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030784AbXAZGUW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 01:20:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 58DCA281EB;
	Fri, 26 Jan 2007 07:20:20 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id YRcXKmRKHpW1; Fri, 26 Jan 2007 07:20:19 +0100 (CET)
Received: from [62.216.203.38] (ppp-62-216-203-38.dynamic.mnet-online.de [62.216.203.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 4D35E281E6;
	Fri, 26 Jan 2007 07:20:19 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <46a038f90701251806k719dd35p7b13fe049b9cf25c@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37805>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig351BF541A0487AC4E915E7F1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Martin Langhoff wrote:
> On 1/26/07, Simon 'corecode' Schubert <corecode@fs.ei.tum.de> wrote:
>> how do you expect this to ever work?  your tag is not a time stable on=
e.
> I agree on that, but you _can_ try a range of importers. I think you
> should give Keith Packard's parsecvs a try. It is memory-bound and
> won't do incremental imports but it manages to import some repos
> cvsimport can't do directly.

whichever importer you try, it *will* fail to create pure tags equivalent=
 to the CVS tag.  it is not possible.  of course you can do trickery and =
create branches to simulate crooked tags.

> The other option is to use cvs2svn, which is the most conservative and
> careful importer around, and most likely to be able to deal with your
> insane tags. And then git-svnimport right after ;-)

yes, cvs2svn is quite top notch regarding the brokenness in repos it tole=
rates.  however, going from svn to git is equally complicated again, as y=
ou can't nicely convert svn's copy-to-branch if it again copies files fro=
m different revisions.  you just converted the problem to svn, but you di=
dn't make it go away.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig351BF541A0487AC4E915E7F1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFuZ2fr5S+dk6z85oRAiA0AKCIfvOBaJO016IYPmT2wQ1YjqPM6wCgkLak
pn9WiriQBQmG0VxAtiILa3g=
=p2Gv
-----END PGP SIGNATURE-----

--------------enig351BF541A0487AC4E915E7F1--
