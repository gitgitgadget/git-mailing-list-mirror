From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 2/2] filter-branch: fail gracefully when a filter fails
Date: Thu, 05 Jul 2007 20:22:24 -0700
Message-ID: <468DB570.1090900@freedesktop.org>
References: <Pine.LNX.4.64.0707041535420.4071@racer.site> <20070705135824.GB5493@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD931FC15F6FC50410D94E9DD"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 06 05:22:47 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6eP8-0001M5-9P
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 05:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760929AbXGFDWe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 23:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760812AbXGFDWe
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 23:22:34 -0400
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:51148 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760645AbXGFDWd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 23:22:33 -0400
Received: (qmail 21244 invoked from network); 6 Jul 2007 03:22:32 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail2.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <peff@peff.net>; 6 Jul 2007 03:22:32 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.4 (X11/20070622)
In-Reply-To: <20070705135824.GB5493@sigill.intra.peff.net>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51716>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD931FC15F6FC50410D94E9DD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff King wrote:
> On Wed, Jul 04, 2007 at 03:36:01PM +0100, Johannes Schindelin wrote:
>=20
>> 	It is slightly ugly that the output of msg-filter is written
>> 	to a temporary file. But I do not know a better method to
>> 	catch a failing msg-filter. Help?
>=20
> If you mean, in general, to catch the exit code of the first part of a
> pipe, you have to do something like this:
>=20
> status=3D`((cmd1; echo $? >&3) | cmd2) 3>&1`
>=20
> which is pretty ugly in itself, and if you want the stdout of cmd2, the=
n
> you have to add even more redirection. I'm not sure it's worth it.

bash has "set -o pipefail", but that would require bash.  However, you co=
uld
try setting pipefail, and ignoring any failure to set it; that would give=
 the
more friendly behavior with bash, while still allowing any /bin/sh in gen=
eral.

- Josh Triplett



--------------enigD931FC15F6FC50410D94E9DD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGjbVxGJuZRtD+evsRAhzTAJ9cpMd81LafC1n/m4EELtZwEcB6WQCfY6Ch
L3UjB4CFEPa5gVl2tewNQ/M=
=9lgH
-----END PGP SIGNATURE-----

--------------enigD931FC15F6FC50410D94E9DD--
