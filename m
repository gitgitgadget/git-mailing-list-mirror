From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] Define constants for lengths of object names
Date: Thu, 1 May 2014 23:00:41 +0000
Message-ID: <20140501230041.GC75770@vauxhall.crustytoothpaste.net>
References: <1398942410-112069-1-git-send-email-sandals@crustytoothpaste.net>
 <20140501172007.GZ9218@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aT9PWwzfKXlsBJM1"
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 01:00:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfzyF-0003CU-Mn
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 01:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbaEAXAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 19:00:48 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47453 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750795AbaEAXAr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2014 19:00:47 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:b5e1:3ff0:63e4:293d])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id BDC4F28087;
	Thu,  1 May 2014 23:00:46 +0000 (UTC)
Mail-Followup-To: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Duy Nguyen <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20140501172007.GZ9218@google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-trunk-rt-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247891>


--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2014 at 10:20:07AM -0700, Jonathan Nieder wrote:
> Hi,
>=20
> brian m. carlson wrote:
>=20
> > --- a/object.h
> > +++ b/object.h
> [...]
> > @@ -49,7 +56,7 @@ struct object {
> >  	unsigned used : 1;
> >  	unsigned type : TYPE_BITS;
> >  	unsigned flags : FLAG_BITS;
> > -	unsigned char sha1[20];
> > +	unsigned char sha1[GIT_OID_RAWSZ];
>=20
> Maybe my brain has been damaged by reading code from too many C
> projects that hard-code some constants, but I find '20' easier to read
> here.
>=20
> What happened to the
>=20
> 	struct object_id {
> 		unsigned char id[20];
> 	};
>=20
> 	...
>=20
> 	struct object {
> 		...
> 		struct object_id id;
> 	};
>=20
> idea?

There didn't seem to be a huge amount of support for it.  Also, there
were concerns that some architectures might impose alignment constraints
on it that made sizeof(struct object_id) !=3D 20.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--aT9PWwzfKXlsBJM1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTYtIZAAoJEL9TXYEfUvaLJocP/1TM4Mt+x1ZuizndFN47FHdf
YGQtZ9bXTunXqlSHkrrExnBmyq0vnyrq0sjPjfLOIUfYIzENBDBQxS/Op9YOX3M9
V34Y6dhz6RFBXVFWPbrG1be5Md7JMVKk1TCi6tJUvLvFU5V23xRGVzt9fuWOXZOH
ul+0GftrpxwQONZWgGBnkKCfv/8d59B6ZpN7J6Vi06dsRcNKlLfnVB1BwwRQ1tjq
zqbRXHCt1izYFBNW2Ri1XXMjedfU8D73Z2BVPTIThNysY4WSZdbPltVYxzWfNHOf
TULIL3qz9oQk6n6nCS9OVtVwjeTi0G4qZNjTy4jaGsM9/kuy4JOfD43i/IRaua1g
NQy5SuZTLR1+w9AVVapUY26LNLTEcCTbHyQ8laYaU4Y4WRg/gNOP+CfqIkyvT94Y
cDvg2XLXLDspC05lh4IV7s/2OO/moAd0M2SnUdF/0qKRw4/ORngnP8s7lF6ZLvEe
BkP9v1zNoR45Pzqw8Hdp0xmsWqTwxeUypfA0+ur4Vj0AlecdioGVrXtOp72WbhPj
wq7ivBRnsHm260yQJaYXSuikvUDYbKmLKMndKbCVy01GXEB4aJnUtiIC6htj7m38
fU2l1Nht2hzZg+Cyz7lWIe+sgwCy1WUzAu35ybtW9MQctDX9esjWFPM3a9jHT1Ca
D3SzYr5+rcqS72K4kQGA
=cLj5
-----END PGP SIGNATURE-----

--aT9PWwzfKXlsBJM1--
