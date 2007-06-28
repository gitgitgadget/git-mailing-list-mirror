From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] git-log: detect dup and fdopen failure
Date: Wed, 27 Jun 2007 19:46:54 -0700
Message-ID: <4683211E.2010704@freedesktop.org>
References: <87wsxpobf0.fsf@rho.meyering.net> <81b0412b0706270548p6f694fd6x5f47cbefa16c08ac@mail.gmail.com> <87r6nxo8iq.fsf_-_@rho.meyering.net> <EF53B249-8430-4700-81AE-B97FD49FB955@adacore.com> <87odj1mpy2.fsf@rho.meyering.net> <alpine.LFD.0.98.0706270935340.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5D5A4AF99A7114CF56307DED"
Cc: Jim Meyering <jim@meyering.net>, Geert Bosch <bosch@adacore.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 28 04:48:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3k3J-0005Jr-2n
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 04:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762205AbXF1CsL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 22:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760508AbXF1CsL
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 22:48:11 -0400
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:42354 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759544AbXF1CsK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 22:48:10 -0400
Received: (qmail 7184 invoked from network); 28 Jun 2007 02:48:09 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail7.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <torvalds@linux-foundation.org>; 28 Jun 2007 02:48:09 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.4 (X11/20070622)
In-Reply-To: <alpine.LFD.0.98.0706270935340.8675@woody.linux-foundation.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51076>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5D5A4AF99A7114CF56307DED
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
> On Wed, 27 Jun 2007, Jim Meyering wrote:
>> Subject: [PATCH] git-log: detect dup and fdopen failure
>>  git-compat-util.h (xdup, xfdopen): Define functions.
>>
>> Signed-off-by: Jim Meyering <jim@meyering.net>
>=20
> Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
>=20
> That said, the whole "prepend 'x' to the function name" thing is obviou=
sly=20
> how git does things, but maybe it would be more readable in the long te=
rm=20
> to make the prefix be 'safe_' instead of 'x', or something like that?

If you want a more verbose name than xfoo, I personally like the foo_or_d=
ie
convention, which reminds you explicitly that the function might kill the=

program.  safe_ might convey exactly the opposite impression.

- Josh Triplett


--------------enig5D5A4AF99A7114CF56307DED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGgyEeGJuZRtD+evsRArFwAJ9TZgyoSnJswhjA4Q3cYpQL84LvzQCghPzh
rStP5TWW4mNrCktsxTR16aA=
=5Tc5
-----END PGP SIGNATURE-----

--------------enig5D5A4AF99A7114CF56307DED--
