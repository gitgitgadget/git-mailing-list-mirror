From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Git Help needed
Date: Fri, 1 Aug 2014 20:05:01 +0000
Message-ID: <20140801200459.GA53075@vauxhall.crustytoothpaste.net>
References: <898fcfcd0c4f41da805abdd41622058f@DM2PR08MB477.namprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Cc: git@vger.kernel.org
To: RaviKiranGoud_Palpanoori@vfc.com
X-From: git-owner@vger.kernel.org Fri Aug 01 22:05:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDJ4k-0004kW-Ja
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 22:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809AbaHAUFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 16:05:08 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49256 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751460AbaHAUFG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 16:05:06 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [107.141.156.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 911282808F;
	Fri,  1 Aug 2014 20:05:05 +0000 (UTC)
Mail-Followup-To: RaviKiranGoud_Palpanoori@vfc.com, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <898fcfcd0c4f41da805abdd41622058f@DM2PR08MB477.namprd08.prod.outlook.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16-rc6-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254658>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 01, 2014 at 07:30:11PM +0000, RaviKiranGoud_Palpanoori@vfc.com =
wrote:
> Hi,
> I am writing below couple of questions. If it is not the right place
> to ask please ignore and suggest me what to do to get the help on
> these questions.
>=20
> 1) What version of SSL is supported by GIT 1.8.3 or GIT 1.9.0

The INSTALL file doesn't mention a particular OpenSSL version that we
require, but I know that it works with versions as old as 0.9.8 and as
new as 1.0.1g.  It may work with still older versions, but I recommend
1.0.1 or newer as it gives you proper TLS 1.2 support.

> 2) I have installed git 1.8.3 in AIX server 6.1 TL8 SP2. It worked
> fine and able to extract code from git repository directly as well as
> from ant. Everything went well.
> Recently Aix OS upgraded to 6100-09-01-1341. After OS upgrade my git
> commands are not working. Basic help and version works fine as
> expected. When I try to pull the code from git repository it give SSL
> library compatibility issue.
>=20
> The error is=C2=A0
> OpenSSL version mismatch. Built agains 1000105f, you have 100000bf
> fatal: Could not read from remote repository

OpenSSL 1.0.0 (which you were using before) and OpenSSL 1.0.1 are binary
compatible if compiled with the same flags, but they contain a hard
version check that fails if they're not the same version.

This means you need to recompile git against the newer OpenSSL version,
or ask your vendor to patch this check out.  This is true for any
program that gives you this error.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJT2/LqAAoJEL9TXYEfUvaLBfYP/1Wc/B6hYGbTYMiregT5uhaH
UCKJvvvUBzNPiCSuJgLrsNAIenrQyPD3SULUeMrM8RGau9In1VZdqCmgIecG99mD
kcqnkcCLB+QYU4E2X8hHHhuXRK1nzEFP9w/O2nF+9XgvHclBaqzdlIALb+IKt6A8
RkcgnnKSFPYfaVPTx1JmTIOXXG4hTIlC+bW2E8IplugnYmXQB4EJluYpmLw1JPF+
5rMR/C8ixENK1eXqG2OqX35niljAhvDiUKIDFxRZF3mS5hJCWIE0hpXwOlHsE/0y
RwJykwIcuD0yw51qlH/9SDaTrFLiO21TpyHFg9a+rO0aY9xUmiIORDwB6wHNS09i
GV37HJUY58IAAB0euAeJ8J9STTgRpbI47qMoJH9011WKklQ4XE8kOcUhAn0Esh4H
HlyJy6kIHrGBhc0I0kHsJTYsH98DVzC/fW+89F1LXrml3kNRnEFGqvmD1G49A3CC
D/BVKDj15G5FgXxb17jWzoMCNyvOa63u2EZ7rLyGzjqf7Txbkd9Ig1RBbbT7bNQf
YLy6bURUNSrnawXYZaoXd8SJ498ODVr558q9lbou1SvcQ3pzH8Kaa9pnMSBfS3A9
JS1NL744d5UJnWmNE2puqg+p3FVKpQBJKjBkT4yjpQI7LPh9SS8CjTwyMdkaFd+g
ldnS37TBDhfzik/R8W9U
=lZaj
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
