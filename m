From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: On undoing a forced push
Date: Wed, 10 Jun 2015 12:18:51 +0000
Message-ID: <20150610121850.GB664685@vauxhall.crustytoothpaste.net>
References: <20150609121221.GA14126@lanh>
 <20150609150035.GA102463@vauxhall.crustytoothpaste.net>
 <CACsJy8D32vjn=GuJj60hFKMwgqbV6L1G9OyEBguCD4c0Nb_kjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 14:19:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2eyG-0008H7-T1
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 14:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932806AbbFJMTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 08:19:00 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:39210 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932694AbbFJMS6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2015 08:18:58 -0400
Received: from vauxhall.crustytoothpaste.net (107-1-110-191-ip-static.hfc.comcastbusiness.net [107.1.110.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B62CD2808F;
	Wed, 10 Jun 2015 12:18:56 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACsJy8D32vjn=GuJj60hFKMwgqbV6L1G9OyEBguCD4c0Nb_kjQ@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -1.5 BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271285>


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2015 at 09:43:34AM +0700, Duy Nguyen wrote:
> On Tue, Jun 9, 2015 at 10:00 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > You've increased this by 20, but you're adding 40 characters to the
> > strcpy.  Are you sure that's enough?
> >
> > Also, you might consider writing this in terms of GIT_SHA1_HEXSZ, as it
> > will be more obvious that this depends on that value.  If you don't now,
> > I will later.
>=20
> It's a demonstration patch and I didn't pay much attention. I think
> converting this quickref to strbuf may be better though, when you
> convert this file to object_id.

Yeah, I didn't realize until after the fact that it was only supposed to
be a demo.  I agree that strbuf might be a better idea.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.4 (GNU/Linux)

iQIcBAEBCgAGBQJVeCsqAAoJEL9TXYEfUvaLwxYP/1CmPEKud2fvWy7IfLgmFYTR
muWbdcZyQuxBOqFJIO2anFxFtVFvhM5gREvlmiHvRJ3IfDDATrMYkXQ0xdVY14b9
6IMXXSgnttkNOmVf1g3oUcaNlVSbjXHOlml5+gOlgYG3pHhkZXkcSl1ZMVJWvHS5
bYFrExkPZ8FNYf7MvxUTUyCwhAmYrDsRWTn/RwnVyGP0Re/G+/Qhq+plOkMzQoTc
u8Gq5hTrprmF0QlcXa3shSCstnQEDtCbLEse+A73En/J7IXsxSCZv+AzyeE+yd2F
nUXzaDnmDyT7YqxLQ342Qex8/UDq40X9kFAJR5+E6CK99z6pGFv1brZrq76de0s1
Vdcr+7iWD4Uh54ren0K2ZqASi5I6JwbEQoIUClX50bKrDPAJ6BZSKQbuDT1nJDaj
WXSOKj/XNawHbBjlHdx9c6JQI7U/fHrOklKh+NiYFWqLi/qTrrlzEm7QW9T4D/dp
X5TS621/s0wG5BWs5FkzfLVLtolft0D3SnNdDwLOxhfzbEZkVGdjWG2nqy9Yck6J
H19LJXKxbLQoEDbqlidy1Ue92vLTxY6h/VDNNfk6MyU6DrgPreli8ZTqA92aQbWf
sZ82Qbayzy9NuRsnEDYnxHkxEHJXomU7/8aGymTUELGST1eeQjQM3pjW/0Kh0YXJ
fbhdRofjJKVoe99/etTQ
=8xwq
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
