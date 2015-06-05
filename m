From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Pack files, standards compliance, and efficiency
Date: Fri, 5 Jun 2015 19:42:00 +0000
Message-ID: <20150605194200.GB356121@vauxhall.crustytoothpaste.net>
References: <20150605014120.GE305479@vauxhall.crustytoothpaste.net>
 <20150605094545.GB11855@peff.net>
 <5571BEA0.2080305@alum.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 05 21:42:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0xVM-00055Z-R3
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 21:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbbFETmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 15:42:08 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:34137 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932118AbbFETmF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2015 15:42:05 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:a919:bb7f:1b0f:9a5b])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C98502808F;
	Fri,  5 Jun 2015 19:42:03 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Duy Nguyen <pclouds@gmail.com>
Content-Disposition: inline
In-Reply-To: <5571BEA0.2080305@alum.mit.edu>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270878>


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2015 at 05:22:08PM +0200, Michael Haggerty wrote:
> I don't know that there would necessarily be problems, but I would worry
> about code involving structure assignment. For example, suppose the
> following snippet:
>=20
>     void f(struct object_id *oid)
>     {
>         struct object_id oid_copy =3D *oid;
>         /* ... */
>     }
>=20
> The compiler is allowed to implement the copy using instructions that
> rely on proper alignment. Such code would fail if oid is not properly
> aligned.

We use oidcpy which doesn't use object assignment.  I brought that up
previously, and Junio was opposed to doing *dest =3D *src.  So I don't
think this ends up being an issue.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.4 (GNU/Linux)

iQIcBAEBCgAGBQJVcfuIAAoJEL9TXYEfUvaLnxwP/1WgrG3acsf02vwpA64ferBJ
J8UZoYIHWTjIOXpcB6Pv7DjsJ3YxLbBv4wpjWCEgqPFMtD3SXE39mAo5mdHIlJSv
PyG6azI/bLt6mvCBOSwKhkiL7nUCaQVa6Q3bG3+0l131NOOrFayoqlvuTb0CNzBe
rSBaz95ON+gN90a7TAw//U4xfIADFpu+6lyU/yBagSOMy00iz9DT++jXjv+SpeW9
7SWzahDJI7iqgRNwkeH36PBP3aRHo6QmOj5v8sdqnvrgwsJqmTkFHd/KvrnIK75V
ryKP+xDSpEs6jD6lv5TmKNmReNSPOjJ4186vagi8rJolc5kitYFbw8UYMLDp3AOG
SBJClRW/+2oGSTu3hVEqDFPFOStmfMDqzcPsFXU9ob5rrSFrMHkcXgrgocibu4EP
rfKIpdwuPMLsfT4Jq4i9YUF6O4EXvyahf0QuUzSr6/MfQd86feHTTrjYNyb13QU6
x5NzsYAwFEsVdodKduhxy7nazMyA8lMTLeEdP6brB0FyPt/JnqM4/YXYRBAcWBG/
3EbPPI5gkoaGt+FQ0EjBPKJp4NpoILbLBZvt0mqhDu6lN0PrRtZ1HFMf7nEQBJJi
ZRMl7t/lHPRn/Nl5FeUcD2EQ/eekg7jieHWOHq88MnUXcCCeISc1iYw9uKh7f0rn
f/2yIPnbmKTf9CpDxyv1
=gvBA
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
