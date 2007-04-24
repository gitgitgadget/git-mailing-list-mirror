From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Add clean.requireForce option, and add -f option to git-clean
 to override it
Date: Mon, 23 Apr 2007 19:05:41 -0700
Message-ID: <462D65F5.4060405@freedesktop.org>
References: <462D4CC8.70006@freedesktop.org> <462D5C4D.3050004@uwaterloo.ca> <462D6589.7060206@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig05E8FA12BCDFA3E89FF841B1"
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Michael Spang <mspang@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Tue Apr 24 04:06:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgAQ7-0002ip-Rk
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 04:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031026AbXDXCGR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 22:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031028AbXDXCGR
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 22:06:17 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:52645 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031026AbXDXCGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 22:06:16 -0400
Received: (qmail 31887 invoked from network); 24 Apr 2007 02:06:16 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail4.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <mspang@uwaterloo.ca>; 24 Apr 2007 02:06:15 -0000
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <462D6589.7060206@freedesktop.org>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45404>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig05E8FA12BCDFA3E89FF841B1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Josh Triplett wrote:
> Michael Spang wrote:
>> Josh Triplett wrote:
>>> +if [ "$disabled" =3D true ]; then
>>> +	echo "clean.requireForce set and -n or -f not given; refusing to cl=
ean"
>>> +	exit 1
>>> +fi
>> How is it useful to abort completely? Wouldn't it be better to behave
>> like -n unless -f is given?
>=20
> I don't think so, for a couple of reasons.
[...]

That said, a *separate* config option to make git-clean assume -n by defa=
ult
seems potentially useful as well.

- Josh Triplett


--------------enig05E8FA12BCDFA3E89FF841B1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGLWX1GJuZRtD+evsRAtLNAKCJSiRtM+oLQPBPeE/hp3IMftoyKQCgozM8
1LV1wOI8MWwsq0OvkWPtuOM=
=sW8h
-----END PGP SIGNATURE-----

--------------enig05E8FA12BCDFA3E89FF841B1--
