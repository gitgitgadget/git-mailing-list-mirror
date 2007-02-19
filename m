From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Allow passing of an alternative CVSROOT via -d.
Date: Mon, 19 Feb 2007 12:54:12 +0100
Message-ID: <45D98FE4.3060906@fs.ei.tum.de>
References: <45D88A14.4040400@fs.ei.tum.de> <45D934CC.6080707@catalyst.net.nz> <Pine.LNX.4.63.0702191209200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig53C70FC2274E288ECF1EB3C3"
Cc: Martin Langhoff <martin@catalyst.net.nz>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 19 12:54:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ76A-0000Ne-Ib
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 12:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbXBSLyT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 06:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbXBSLyT
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 06:54:19 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:58758 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932156AbXBSLyS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 06:54:18 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 9159928214;
	Mon, 19 Feb 2007 12:54:16 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WT9O5GcE1zVc; Mon, 19 Feb 2007 12:54:16 +0100 (CET)
Received: from [62.216.203.216] (ppp-62-216-203-216.dynamic.mnet-online.de [62.216.203.216])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id E03A7281EC;
	Mon, 19 Feb 2007 12:54:15 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <Pine.LNX.4.63.0702191209200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40122>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig53C70FC2274E288ECF1EB3C3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
> On Mon, 19 Feb 2007, Martin Langhoff wrote:
>>> This is necessary if using CVS in an asymmetric fashion, i.e. when th=
e=20
>>> CVSROOT you are checking out from differs from the CVSROOT you have t=
o=20
>>> commit to.
>> I guess you have an anon checkout and then use CVSROOT at commit time =
to=20
>> switch to cvs-over-ssh perhaps even on a different server.=20
>> In-te-rest-ing.
> It was kind of common operation when SourceForge had immense problems w=
ith=20
> SSH checkout, but the anonymous services were up-and-running.

Large projects like *BSD are using cvsup to distribute the repos, and you=
 checkout from a local copy then.  To commmit, you obviously have to use =
the master cvs server, though.

> I am still worried why "CVSROOT=3Dbla git cvsexportcommit ..." does not=
 run=20
> as expected, though.

sweatshorts % cvs status Makefile.inc1                                   =
         /usr/src|12:48:57
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
File: Makefile.inc1     Status: Up-to-date

   Working revision:    1.101   2007-01-19 08:51:44 +0100
   Repository revision: 1.101   /home/dcvs/src/Makefile.inc1,v
   Commit Identifier:   9177lVhuKoFNs53s
   Sticky Tag:          (none)
   Sticky Date:         (none)
   Sticky Options:      (none)

sweatshorts % CVSROOT=3Dcrater:/cvs cvs status Makefile.inc1             =
           /usr/src|12:49:03
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
File: Makefile.inc1     Status: Up-to-date

   Working revision:    1.101   2007-01-19 08:51:44 +0100
   Repository revision: 1.101   /home/dcvs/src/Makefile.inc1,v
   Commit Identifier:   9177lVhuKoFNs53s
   Sticky Tag:          (none)
   Sticky Date:         (none)
   Sticky Options:      (none)

sweatshorts % cvs -d crater:/cvs status Makefile.inc1                    =
         /usr/src|12:49:09
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
File: Makefile.inc1     Status: Needs Patch

   Working revision:    1.101
   Repository revision: 1.102   /cvs/src/Makefile.inc1,v
   Commit Identifier:   zV7uPbXLmK5jW17s
   Sticky Tag:          (none)
   Sticky Date:         (none)
   Sticky Options:      (none)

sweatshorts % rm CVS/Root                                                =
         /usr/src|12:52:44
sweatshorts % CVSROOT=3Dcrater:/cvs cvs status Makefile.inc1             =
           /usr/src|12:52:48
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
File: Makefile.inc1     Status: Needs Patch

   Working revision:    1.101
   Repository revision: 1.102   /cvs/src/Makefile.inc1,v
   Commit Identifier:   zV7uPbXLmK5jW17s
   Sticky Tag:          (none)
   Sticky Date:         (none)
   Sticky Options:      (none)

so that only works when there is no CVS/Root file.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig53C70FC2274E288ECF1EB3C3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF2Y/nr5S+dk6z85oRAnV+AJoCx6vv9X2lFabp0xxXEcWqQ2iZ9QCgrFW0
12Bu/1Cr2pvk+AOF1p65IS0=
=vx69
-----END PGP SIGNATURE-----

--------------enig53C70FC2274E288ECF1EB3C3--
