From: Martin Waitz <tali@admingilde.org>
Subject: Re: Unresolved issues
Date: Wed, 21 Feb 2007 11:42:09 +0100
Message-ID: <20070221104209.GM21842@admingilde.org>
References: <7virdx1e58.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702200934270.20368@woody.linux-foundation.org> <7vfy90v729.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702201621050.4043@woody.linux-foundation.org> <Pine.LNX.4.63.0702210136050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HTLCc13+3hfAZ6SL"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 21 11:42:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJovY-0008Hw-6n
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 11:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbXBUKmN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 05:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbXBUKmM
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 05:42:12 -0500
Received: from mail.admingilde.org ([213.95.32.147]:37332 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932392AbXBUKmM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 05:42:12 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HJovJ-0001hs-6F; Wed, 21 Feb 2007 11:42:09 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702210136050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40293>


--HTLCc13+3hfAZ6SL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Feb 21, 2007 at 01:39:48AM +0100, Johannes Schindelin wrote:
> In that case, .gitattributes (I mean a tracked one) would be wrong, wrong=
,=20
> wrong.

I don't think so.

> It's a local setup if you want auto-CRLF or not. So, why not just make it=
=20
> a local setting (if in config or $GIT_DIR/info/gitattributes, I don't=20
> care) which shell patterns are to be transformed on input and/or output?

The file-type/whatever information about paths is per repository.
Whether you want to do crlf conversion for "text" files is a local
setting.  So I do think that a tracked .gitattributes makes sense.

Of course you also need some local settings (e.g. in .git/config) to
use that information.  Perhaps something like:

[filetype "text*"]
	AutoCRLF =3D yes

[filetype "text/xml"]
	Merge =3D xml-merge -whatever

--=20
Martin Waitz

--HTLCc13+3hfAZ6SL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD4DBQFF3CIBj/Eaxd/oD7IRAhJSAJdSJY8d4n43cC/doy1dJTKBAevkAJ9zOHbv
5tipJTZr0nsQjrpKqgWHuQ==
=g3yX
-----END PGP SIGNATURE-----

--HTLCc13+3hfAZ6SL--
