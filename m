From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Determining update/merge/current state of a workspace
Date: Mon, 3 Feb 2014 00:50:29 +0000
Message-ID: <20140203005029.GF635004@vauxhall.crustytoothpaste.net>
References: <85ppn540wi.fsf@stephe-leake.org>
 <20140202230456.GA56790@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O98KdSgI27dgYlM5"
Cc: Stephen Leake <stephen_leake@stephe-leake.org>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 01:51:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WA7ka-0001qX-09
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 01:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbaBCAuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 19:50:37 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51609 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752604AbaBCAug (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Feb 2014 19:50:36 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:fd82:88d3:586c:5bd8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1D42C28074;
	Mon,  3 Feb 2014 00:50:34 +0000 (UTC)
Mail-Followup-To: David Aguilar <davvid@gmail.com>,
	Stephen Leake <stephen_leake@stephe-leake.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20140202230456.GA56790@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241393>


--O98KdSgI27dgYlM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 02, 2014 at 03:04:59PM -0800, David Aguilar wrote:
> I think you're looking for "git merge-base".
>=20
> If you do `git merge-base HEAD origin/master`
> and its result is equal to `git rev-parse HEAD`
> then you know that master is an ancestor of origin/master
> and can be trivially fast-forwarded to origin/master.

In newer versions of git (1.8.0+), you can use "git merge-base
--is-ancestor" for this instead.  The commit message for 5907cda implies
that it is more efficient than the old way.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--O98KdSgI27dgYlM5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJS7ufVAAoJEL9TXYEfUvaLQOkP/iOgo8hsbyxKq917Etxn9ES8
sEjSN5607DtnJ4NXZBOv8yLRIxTcVi5uisVR6nrcrlLuFtJP/w20ATBDP07xDcnF
PdLeVlGFEJG/8eixYrluKZwElHajf67SgTmaytqUw8DRKmDAIx0EtwUxqy7X7XCV
avLnygI9MYeudpWEXIpmENpOsOmgE/QAk8AIJXI1qEs6KU3bopPGYN2dgviIZ0LW
QrxFOQIOpNsMbJ1oClpv5SebEvRfCSrJRa5BGYTvgHrqZwjKWvRWMiEgZOt6xLqB
8wBl/AnHAGrk/ySV0q/fKO9NHWwa16PzBA5e1QcTLLxywmYTmPk71MqHiegCU0jd
S1fF4Ow2neTLTZqL0Be8pdCaaV/5/xIfkvKQsxUkrtR75jHdwlK9JyOWQ5jvBwKl
yxEsIchTNEM2lKtFq8UkvDkChSp6CzCJTIY7VldX9/O9kNLFfHVr64j7SdV7DcCq
8rQ2Q5woUl3EXaQV91PujHUIeVok+11tqk443RZcwovsHNWrOrwkGRL5hPnqY8xV
UTiqyCRFLQkK9JTvDhlxROLR+u/VidD/fAIfuY03bVJEu2yHT5VXilAQmcZOBn8B
ABcanzdlDQtGRWWkP+DAzNIRp7JThMNfebpU8ridffYOqZL4KFwWU4kjyg567P7e
7r6x6kc5xiMvufcifxsw
=K7dD
-----END PGP SIGNATURE-----

--O98KdSgI27dgYlM5--
