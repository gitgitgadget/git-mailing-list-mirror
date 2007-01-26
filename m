From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH 1/2] UNIX reference time of 1970-01-01 00:00 is UTC timezone,
 not local time zone
Date: Fri, 26 Jan 2007 18:49:07 +0100
Message-ID: <45BA3F13.2090003@fs.ei.tum.de>
References: <200701260858.48212.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig59FC23706ED59268E415C873"
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 18:49:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAVCe-0000Np-C2
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 18:49:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161097AbXAZRtT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 12:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161099AbXAZRtS
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 12:49:18 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:41854 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161098AbXAZRtR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 12:49:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 49B7328213;
	Fri, 26 Jan 2007 18:49:15 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id qYwrMyF3XJ9B; Fri, 26 Jan 2007 18:49:15 +0100 (CET)
Received: from [62.216.203.38] (ppp-62-216-203-38.dynamic.mnet-online.de [62.216.203.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id DFAE12820E;
	Fri, 26 Jan 2007 18:49:14 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <200701260858.48212.andyparkins@gmail.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37879>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig59FC23706ED59268E415C873
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Andy Parkins wrote:
> $ date --date=3D"1970-01-01 00:00" +"%F %T %z (%Z)"
> 1970-01-01 00:00:00 +0100 (BST)

nice observation.  yet, my system doesn't even have date --date=3D.  rega=
rding the idea to provide a generic nice hook, it should be considered to=
 convert this usage to a standards-conforming way.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig59FC23706ED59268E415C873
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFuj8Wr5S+dk6z85oRAhRBAKDWPikoUmZ9vjtNoPIZ1WuqGLnotgCgqRfS
Sce174eB0gl7Ghi2DiMCgMU=
=x7AB
-----END PGP SIGNATURE-----

--------------enig59FC23706ED59268E415C873--
