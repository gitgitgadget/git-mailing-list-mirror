From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] git-cvsexportcommit: don't cleanup .msg if not yet committed
 to cvs.
Date: Thu, 01 Mar 2007 02:17:37 +0100
Message-ID: <45E629B1.2050805@fs.ei.tum.de>
References: <20070227181721.GA4244@bogon.ms20.nix> <20070228123539.23809.qmail@d6daeb0e3466c1.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA0D624A238D31ADA5F2701A1"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 02:17:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMZvc-0007Vs-9b
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 02:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932889AbXCABRt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 20:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932894AbXCABRt
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 20:17:49 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:42122 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932889AbXCABRs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 20:17:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 049F4284CA
	for <git@vger.kernel.org>; Thu,  1 Mar 2007 02:17:47 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id GhWT-9DL-JFK for <git@vger.kernel.org>;
	Thu,  1 Mar 2007 02:17:46 +0100 (CET)
Received: from [62.216.208.146] (ppp-62-216-208-146.dynamic.mnet-online.de [62.216.208.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 56B27284C7
	for <git@vger.kernel.org>; Thu,  1 Mar 2007 02:17:46 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <20070228123539.23809.qmail@d6daeb0e3466c1.315fe32.mid.smarden.org>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41027>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA0D624A238D31ADA5F2701A1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Gerrit Pape wrote:
> Unless the -c option is given, and the commit to cvs was successful,
> .msg shouldn't be deleted to be able to run the command suggested by
> git-cvsexportcommit.

thanks, i've been meaning to search for the cause of this.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enigA0D624A238D31ADA5F2701A1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5im5r5S+dk6z85oRAqF4AKCMjSAytA4TpHo4jLT032W7JTW8iACgnRR/
cVe1/+wPybhLw1pHQq6YjcQ=
=gHdW
-----END PGP SIGNATURE-----

--------------enigA0D624A238D31ADA5F2701A1--
