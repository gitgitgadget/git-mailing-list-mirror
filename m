From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/4] Allow building Git with Asciidoctor
Date: Tue, 14 Oct 2014 11:26:42 +0000
Message-ID: <20141014112642.GB7041@vauxhall.crustytoothpaste.net>
References: <1413070656-241955-1-git-send-email-sandals@crustytoothpaste.net>
 <xmqqtx371z44.fsf@gitster.dls.corp.google.com>
 <20141014003451.GA7041@vauxhall.crustytoothpaste.net>
 <543CF5F7.5060704@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 13:26:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xe0Fj-0006WO-Lz
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 13:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755042AbaJNL0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 07:26:52 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49264 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754823AbaJNL0v (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Oct 2014 07:26:51 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2B9472808F;
	Tue, 14 Oct 2014 11:26:47 +0000 (UTC)
Mail-Followup-To: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <543CF5F7.5060704@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2014 at 12:07:51PM +0200, Jakub Nar=C4=99bski wrote:
> brian m. carlson wrote:
> >On Mon, Oct 13, 2014 at 01:41:31PM -0700, Junio C Hamano wrote:
> >>
> >>What I do not understand is that 3/4 lets you drop inclusion of
> >>asciidoc.conf which contains a lot more than just linkgit:
> >>definition.
> >
> >Asciidoctor just doesn't understand the -f argument, so trying to pass
> >it is going to fail.  For Asciidoctor, you're going to want to do
> >something like "-I. -rasciidoctor/extensions -rextensions" there
> >instead.
> >
> >As for the rest of the asciidoc.conf file, the DocBook manpage header
> >declarations are implemented automatically by Asciidoctor after my
> >recent patches.  The paragraph hacks do not appear to be necessary with
> >Asciidoctor, so they've been omitted.
> >
> >That leaves the attributes.  All but litdd are built-in to Asciidoctor,
> >and I can reroll with a modification to extensions.rb that implements
> >that one.
>=20
> Would it be possible to automatically convert asciidoc.conf file to
> Asciidoctor extension?

It is in theory possible, but it's going to result in a lot of messy
code.  I'm also not sure that Junio wants more than the minimal amount
of Ruby possible, since the goal has been to move away from scripting
languages and to C.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUPQhyAAoJEL9TXYEfUvaLrlQP/jI2eXsZnd9lPF3JFD0iEBj3
JcoGo9dHYgoux4lQpS/jpuDAvl3FPGUBWdZTtBIObq7Z1z5yxisO+egw15C3brmA
3BpFYHVYiNc958iDilZuOPMukJEpDF8JkcTch23JAeNoEq3+d5zeA6EN5qUqALca
C8W4Q16mBWAxbsnZSG0kt/RUHTfIif34W7zjfiJ2qL+lT4U67QJ7stHAuqPQYV+b
ViSzj78bDNNgOddWVm2cjKlzYtxAu/WT+UgB3rbx+ou5t0FPneHiDhKobb8Y8F/d
J6NBf9odz0Q+GZlsB3U498Q2NWzhhk1i3qGAbogr2p2yogxYidR/T2QaaAU6iAQl
+U+/BoYXDMBuNrx4sk9HZCFAcpZ4aiD7mTh02sn4pzlV29iuPpjXrlMwA7bF7HjS
hytmsZ+JG0HqhZbfFKoIC64VNLuahubcstCoDS450IiRfiuQBzrPbCcSjdQV7u0y
85O4odby6g5NS6oOCZG4sNdP7iARR9UZsw/vfL5bJT/oLpWk5eAla176H638W7BS
1stiPhe0bLw62qYVYgg2RJZ7gnx17t/aOZUiXz/gEEPA7F8QwJ0FFhM7TJLVRWag
bJ6rkx23JX3HgEss6TChIQVVivgdFk3Dd7OehHijB6VnsCxL+LaMEDFYbjSwjPQ9
EcPdKajNzsQDf8bjcAzP
=PFn+
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
