From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Thu, 12 Apr 2007 02:56:54 +0200
Message-ID: <20070412005654.GQ21701@admingilde.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org> <200704101828.37453.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0704101122510.6730@woody.linux-foundation.org> <e7bda7770704111742i2ac12cbas50fd7a3ba5c21cd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sWvRP97dwRHm9fX+"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Torgil Svensson <torgil.svensson@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 02:56:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbncR-0001ff-8k
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 02:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbXDLA44 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 20:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753764AbXDLA44
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 20:56:56 -0400
Received: from mail.admingilde.org ([213.95.32.147]:36203 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbXDLA44 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 20:56:56 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HbncM-0002Co-Fg; Thu, 12 Apr 2007 02:56:54 +0200
Content-Disposition: inline
In-Reply-To: <e7bda7770704111742i2ac12cbas50fd7a3ba5c21cd8@mail.gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44300>


--sWvRP97dwRHm9fX+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Thu, Apr 12, 2007 at 02:42:43AM +0200, Torgil Svensson wrote:
> I guess this file could also cover the case where the superproject is
> only interested in a small subset of the subproject. For example if I
> only uses some header-files in a library and want
> "/lib1/src/interface" in the subproject end up as "/includes/lib1" in
> the superproject. Could single files be handled in a similar way?

Conceptionally this information would have to be part of the
supermodule tree (after all it changes how your tree is set up).

I think it makes more sense to make users think about which part
of their tree can be reused and make them choose submodule boundaries
wisely so that the above partial-checkout is not needed.

> Although this is just an example, external links shouldn't be
> specified in the same configuration file as project internal things
> (which should be version-controlled). If the url configuration gets
> overwritten with checkouts there will be problems bisecting if the url
> changes over time.

Most of the time we may not need to add any per-submodule URL
information anyway.  If you fetch a new supermodule version, you
can get the new submodule from the same source (or from a per-submodule
source which can be determined by looking at and munching the supermodule U=
RL).

--=20
Martin Waitz

--sWvRP97dwRHm9fX+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGHYPWj/Eaxd/oD7IRAh8oAJ9XYJrWagJGoTYWRv/NZ8YSzGkTnwCfat7R
m5veyzDqt113FgtNbmXd2k0=
=X8TJ
-----END PGP SIGNATURE-----

--sWvRP97dwRHm9fX+--
