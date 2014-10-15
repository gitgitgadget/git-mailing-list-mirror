From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/4] Allow building Git with Asciidoctor
Date: Wed, 15 Oct 2014 01:17:54 +0000
Message-ID: <20141015011754.GA131351@vauxhall.crustytoothpaste.net>
References: <1413070656-241955-1-git-send-email-sandals@crustytoothpaste.net>
 <20141014095119.GC16686@peff.net>
 <xmqqsiiqziik.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 03:18:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeDEN-0001FH-EP
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 03:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755594AbaJOBSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 21:18:06 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49284 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755517AbaJOBSF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Oct 2014 21:18:05 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id F0BC72808F;
	Wed, 15 Oct 2014 01:17:59 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqsiiqziik.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2014 at 10:08:19AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > On Sat, Oct 11, 2014 at 11:37:32PM +0000, brian m. carlson wrote:
> >
> > Specifically I'm not excited about getting into a state where we have to
> > maintain both an asciidoc.conf file _and_ ruby extensions for
> > asciidoctor. I don't mind if somebody wants to step up and keep the
> > asciidoctor bits in sync with the asciidoc.conf, but I feel like one of
> > them needs to be considered the "master".
>=20
> My so-far-unstated inclination, since seeing the patch to fix the
> unbalanced example block separators from Brian (which was outside
> and before this four-patch series), has been to keep our Makefile in
> Documentation/ aware only of AsciiDoc while maintaining *.txt files
> in a state so that AsciiDoctor could also be used to process them,
> if people want to futz with their copies of Documentation/Makefile.
>=20
> I do not mind to have the machinery to run AsciiDoctor too much in
> my tree.  It may make it easier for those who use it to spot places
> in *.txt that need (in)compatibility workarounds between the two
> formatters than keeping it outside.

I'd be happy if you simply picked up patch 3 and left out patch 4.  It
gets us most of the way there, which is good enough for most things.
It's even possible to handle the litdd attribute on the command line, so
the only thing we'd really lose is the linkgit links.

Alternately, I'm happy to be responsible for maintaining the
extensions.rb file.  The asciidoc.conf file has not had a substantive
(non-comment) change since 2012, and it has not had a change that would
require an update to the extensions since 2010.  I don't anticipate that
keeping it up-to-date will require a significant amount of work.  We can
even drop it into contrib if you think that's a better place.

It's really up to you which you'd prefer.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUPctCAAoJEL9TXYEfUvaL3GAP/2LIiH/XE1/BuuhQU69IA+BZ
4gu27kOK8X+G0lBAcpoSNipUiCqUfiuu1ECSZa4uTYb1wtCOVB5IBJ96kWcBGxnA
BOTW5oWvXlBXWBB3Hk1OQxWBHtB0ESxGluVELXBvOetLvs/WRTHgUMyXX3vmXhvU
aN5oU7dia/WBmnvutOCXQiEtSxt/prN2p1oD+YfTK/XhRwOOfaIq+WT82nN4TXDy
dJP/6rXgFH/mKU36JuuwKW/gq18b4mzyhJeaxHmiVAZrwjBKyUam4VjWkgc+R1D8
wmNSqsAOImnpx4Rrju3XuKyM+Z2kKQIileUEqjiOLvulpW7DFtCsaQ4SqXSc2W8b
009mIt9cCRGEj9UkqFuzvX0/qk/jW2MHxzCXB99mEaSOzbQCdzQG9IPoWR67bkip
fH/8+mp6IXr6gdY+vdM4HH+JKm26Si5dipKHUJJAoXl0PVCSUJleO83PNxsUBoGD
CYPcZ2LDgo78KpMBl6KifnLxX8Mx9r4mSMJVHiBT5hnyJLAeQGdwbB3vMJkLIKAw
6N5sybK/gPWaros248m3ERnrF/9Hz3m4zFH41FJfU+IaQ5WZMOkuZpYcLt8aH5LD
155n+nv+40FdC3vj113VjVbl6R8rWi4FNwQUiAazLvwrKUwqEtpjrO6s+TfEfvE7
anpgas+6+XNs+fy7z1TY
=qNuv
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
