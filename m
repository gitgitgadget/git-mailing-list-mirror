From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [RFC][PATCH 00/10] Sparse: Git's "make check" target
Date: Sat, 09 Jun 2007 16:50:32 -0700
Message-ID: <466B3CC8.4010508@freedesktop.org>
References: <4669D2F2.90801@ramsay1.demon.co.uk> <466A5204.6060200@freedesktop.org> <20070609225630.GC3008@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig16AF9614489734AED60CE3B1"
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <junkio@cox.net>,
	GIT Mailing-list <git@vger.kernel.org>,
	linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
X-From: linux-sparse-owner@vger.kernel.org Sun Jun 10 01:50:41 2007
Return-path: <linux-sparse-owner@vger.kernel.org>
Envelope-to: gcps-linux-sparse@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxAhc-0000xJ-AH
	for gcps-linux-sparse@gmane.org; Sun, 10 Jun 2007 01:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705AbXFIXug (ORCPT <rfc822;gcps-linux-sparse@m.gmane.org>);
	Sat, 9 Jun 2007 19:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753573AbXFIXug
	(ORCPT <rfc822;linux-sparse-outgoing>);
	Sat, 9 Jun 2007 19:50:36 -0400
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:48639 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbXFIXuf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Jun 2007 19:50:35 -0400
Received: (qmail 8872 invoked from network); 9 Jun 2007 23:50:34 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail7.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <sam@ravnborg.org>; 9 Jun 2007 23:50:34 -0000
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <20070609225630.GC3008@uranus.ravnborg.org>
X-Enigmail-Version: 0.94.2.0
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49640>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig16AF9614489734AED60CE3B1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sam Ravnborg wrote:
>> Also, you might consider just using cgcc to run both GCC and Sparse.  =
That
>> would handle the issue of target-specific CFLAGS, by ensuring that Spa=
rse and
>> GCC always see the same CFLAGS.
>=20
> Is this the recommended way?
> I that case I suggest that someone looks into the linux kernel part
> and change it to use this method.

The approach taken by Linux allows running sparse on files without recomp=
iling
them.  Using CC=3Dcgcc just makes for less work, but the kernel has that =
work
done now.

- Josh Triplett


--------------enig16AF9614489734AED60CE3B1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGazzIGJuZRtD+evsRAqDbAJsGIDnaEQwAi2BSAL+aemsirT7G/QCeLAcb
7rHpo43EvMJtbNZkHhx51lc=
=LbOg
-----END PGP SIGNATURE-----

--------------enig16AF9614489734AED60CE3B1--
