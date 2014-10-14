From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/4] Allow building Git with Asciidoctor
Date: Tue, 14 Oct 2014 00:34:51 +0000
Message-ID: <20141014003451.GA7041@vauxhall.crustytoothpaste.net>
References: <1413070656-241955-1-git-send-email-sandals@crustytoothpaste.net>
 <xmqqtx371z44.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 02:35:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xdq5I-00039G-S1
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 02:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907AbaJNAfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 20:35:08 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49257 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753837AbaJNAfH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Oct 2014 20:35:07 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 24B082808F;
	Tue, 14 Oct 2014 00:34:57 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqtx371z44.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2014 at 01:41:31PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > The second two patches implement some basic support for building with
> > Asciidoctor.  The first of these moves some items into variables due to
> > some differences between the AsciiDoc and Asciidoctor command lines.
> > The user can then override these values when invoking make.
> >
> > The final patch adds support for the linkgit macro.  Asciidoctor uses
> > Ruby extensions to implement macro support, unlike AsciiDoc, which uses
> > a configuration file.
>=20
> What I do not understand is that 3/4 lets you drop inclusion of
> asciidoc.conf which contains a lot more than just linkgit:
> definition.

Asciidoctor just doesn't understand the -f argument, so trying to pass
it is going to fail.  For Asciidoctor, you're going to want to do
something like "-I. -rasciidoctor/extensions -rextensions" there
instead.

As for the rest of the asciidoc.conf file, the DocBook manpage header
declarations are implemented automatically by Asciidoctor after my
recent patches.  The paragraph hacks do not appear to be necessary with
Asciidoctor, so they've been omitted.

That leaves the attributes.  All but litdd are built-in to Asciidoctor,
and I can reroll with a modification to extensions.rb that implements
that one.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUPG+rAAoJEL9TXYEfUvaLAvIQAJju+BdmAI1S26zRBjesWfgg
oyBv8HaA96ynxwfq1UpU2SAkS64NXta8MwynKueO4AoIcBIMAtMk4r+2mVANVc9M
3HGyLuXLjB31uNTAKVmaAVKmvRf+2EBe1jrn0RmqnkoDhAWHTAr7BaBR3TwAia/V
gh5R62umBVVTxIbRQ7fetWn7NTmOpTJN9Jgu4BEaIoSoUmeAG7wuT1yl5tmUUpAk
+XKQwDos4KKDiP9hl+e3I/ohKfrc2u5WMq9al0wWkxuvFQwytaf1gdtm0b9mtYWd
YALf2ntsbWq8xOlnGsKJ40BR/DKjpiapw8g2dDoScEc5sx9JXHAn9croKvL3TjLW
3nuiQ84SmvK9GUztRGMy5gUmlQfwRNr7jVLYnXDp6c6UXO3kXijboOSlz2Zw+VTZ
tPR+URWRTpjF7Hrb1BNc5EbkWDGB0p6lULH387dhH0Pulvr8kquCGJVfOQTRgf4N
YvCUT5ffP4LH8ksQcqsogwCfzGaylzYPit3xqYbJmlAyVX4zh8q38I1QvMKuilFC
i1SCMKxYTB1zFC91y7ROyElqmnA4yBcvRZdIWmxtRCH1O2W7o5J1jIDVQV1nZvSG
lKwclMIXi5qvQJ7gwNA+AcyTyyRGiWOCIlk2BQOVrnOE+CIuWf5EuH06CoBPPhcj
850LzUI3+8oCUw6NyMu1
=aDBE
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
