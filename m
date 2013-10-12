From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Git send-email fail on Mac OS X Lion
Date: Sat, 12 Oct 2013 13:47:11 +0000
Message-ID: <20131012134711.GG79408@vauxhall.crustytoothpaste.net>
References: <04374E86-02D8-4E76-A7F5-7DEE34F25C7F@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hcut4fGOf7Kh6EdG"
Cc: git@vger.kernel.org
To: "Fernando Ortiz (e2k)" <eratos2000@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 12 15:47:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUzXe-0005jA-CS
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 15:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281Ab3JLNrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 09:47:32 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:32995 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752205Ab3JLNrT (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Oct 2013 09:47:19 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4D6692807A;
	Sat, 12 Oct 2013 13:47:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <04374E86-02D8-4E76-A7F5-7DEE34F25C7F@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-trunk-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236048>


--hcut4fGOf7Kh6EdG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2013 at 11:06:17PM -0500, Fernando Ortiz (e2k) wrote:
> I'm getting the following error when I do:
>=20
> git send-email --compose --from Fernando Ortiz <eratos2000@gmail.com> --t=
o fortiz2k@gmail.com --cc fortiz2k@gmail.com 0001-Change-zcat-to-gzcat-to-f=
ix-build-restore-steps.patch
>=20
> Net::SSLeay version 1.46 required--this is only version 1.36 at /Users/fo=
rtiz/perl5/perlbrew/perls/perl-5.14.4/lib/site_perl/5.14.4/IO/Socket/SSL.pm=
 line 17.

Here's your answer: Net::SSLeay is too old for IO::Socket::SSL.  You
either need to use cpan or cpanm to install a newer Net::SSLeay, and
then it will work.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--hcut4fGOf7Kh6EdG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSWVLfAAoJEL9TXYEfUvaLLiMP/0CA8ogymxCHLAC8cubuekuP
wjKIR8C8PyV4sbNsVZ39m5YZ39QZZ1IuDUUaLZua6vGlsD/cXwEruIRvtn7tofyM
6ipZHSYff7GO8o1JPD6ERKWCScP6h2mBadwxRE53Y8QRzBzsv8OnA/QiIGil38P+
elOjVZB+K50xMsY0OzaVEf4YAOHcpo64NLN/O2O8KBX/OdisKoo0OuaArh6MdEsi
FSTt+LoNh8T7GuIRxF6900Hzsvsx0jhUk9HoDdGrQ/B3v9lNq/ig/ysPhiyMY2Il
wb8SiK+VDWuA2jWdJSA00ZoE1BnxqZ/NSqyzeqtaL/H+FXMxAAbEqKYohtwOcPeC
x2MgqnRQyDexG2XrPpdrOxqvFAe66rI1Biir0G5cdz3eQ3Qt1WvZ2Y4CoY2XLob6
dmxBLKpCgmPkPfeJCgGGN3KhEdlo5NBd0dX+zUsJOFA6OxIG4nAcGJ02OTxpXpZy
gWOe7lfaimZ/t5mnOqrTPhiWceyTP0q8uNfec7dbk+yRU3VntoCj0jMiJmrVXlRn
E5DdfmYpSazyeIBSvnpHXD2WXVcFE6gIJdH1lalxEcg6AelLKTMjYDnv+scV6lUt
pfr74V433LKOq5+gi56O6J8yhX9MehrzjTtiqFH4vFyC6v+Z5GB9/ZDjWfG4LM8g
DngQv2lf5kbhIoE8FbIh
=O7GB
-----END PGP SIGNATURE-----

--hcut4fGOf7Kh6EdG--
