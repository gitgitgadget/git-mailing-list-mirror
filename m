From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Mon, 21 May 2007 13:41:57 +0200
Message-ID: <20070521114157.GZ5412@admingilde.org>
References: <11796842882917-git-send-email-skimo@liacs.nl> <20070520222621.GG25462@steel.home> <20070521095749.GI942MdfPADPa@greensroom.kotnet.org> <200705211244.16374.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+k4Drb7WGefOwc9B"
Cc: skimo@liacs.nl, Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 21 13:42:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq6H8-0002p0-4k
	for gcvg-git@gmane.org; Mon, 21 May 2007 13:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755964AbXEULl7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 07:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756114AbXEULl7
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 07:41:59 -0400
Received: from mail.admingilde.org ([213.95.32.147]:49584 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755964AbXEULl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 07:41:59 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Hq6H0-00046D-0J; Mon, 21 May 2007 13:41:58 +0200
Content-Disposition: inline
In-Reply-To: <200705211244.16374.Josef.Weidendorfer@gmx.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48011>


--+k4Drb7WGefOwc9B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, May 21, 2007 at 12:44:16PM +0200, Josef Weidendorfer wrote:
> There should be a way for a superproject to specify useful sets of
> subprojects for different developer roles, and these sets should be
> versioned. It is also useful for a superproject to be able to say
> "for this subproject to work, that other subprojects needs to be
> checked out".

What subprojects to use is the responsibility of the build system and
we should not step on its shoes too much.
We should provide a simple way to populate a submodule, but all the
dependency handling should really be done in the build system /
package handling system on top of git, IMHO.

Perhaps we can simply provide "cd $subproject && git clone" to
automatically fetch all needed stuff from a default location and
checkout that subproject.
Then we can integrate that command in bitbake and whatnot or start
a new configuration management system on top of git which uses
dependencies from Makefiles etc. to automatically check out the
right set of subprojects.  But that should really be on top of git.

--=20
Martin Waitz

--+k4Drb7WGefOwc9B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGUYWFj/Eaxd/oD7IRAhz/AJ9wBcOwCfL/tp74Jn3fnFwH1bD9AQCeL3yM
GAa5WObBWWEHxww5pVut+9c=
=A7Ln
-----END PGP SIGNATURE-----

--+k4Drb7WGefOwc9B--
