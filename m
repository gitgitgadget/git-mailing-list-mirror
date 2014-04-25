From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 04/14] appp.sh: use the $( ... ) construct for command
 substitution
Date: Fri, 25 Apr 2014 22:58:43 +0000
Message-ID: <20140425225843.GA238861@vauxhall.crustytoothpaste.net>
References: <1398260646-2660-1-git-send-email-gitter.spiros@gmail.com>
 <1398260646-2660-4-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Cc: git@vger.kernel.org, matthieu.moy@grenoble-inp.fr
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 00:59:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdp59-0004XB-UL
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 00:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbaDYW6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 18:58:51 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47326 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751287AbaDYW6u (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Apr 2014 18:58:50 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:e557:515c:f5ce:8138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 886BE28087;
	Fri, 25 Apr 2014 22:58:49 +0000 (UTC)
Mail-Followup-To: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	matthieu.moy@grenoble-inp.fr
Content-Disposition: inline
In-Reply-To: <1398260646-2660-4-git-send-email-gitter.spiros@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-rc7-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247127>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2014 at 06:43:56AM -0700, Elia Pinto wrote:
> @@ -25,11 +25,11 @@ fi
> =20
>  cd - > /dev/null
> =20
> -SUBJECT=3D`sed -n -e '/^Subject: /p' "${PATCH}"`
> -HEADERS=3D`sed -e '/^'"${SEP}"'$/,$d' $1`
> -BODY=3D`sed -e "1,/${SEP}/d" $1`
> -CMT_MSG=3D`sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}"`
> -DIFF=3D`sed -e '1,/^---$/d' "${PATCH}"`
> +SUBJECT=3D$(sed -n -e '/^Subject: /p' "${PATCH}")
> +HEADERS=3D$(sed -e '/^'"${SEP}"'$/,$d' $1)
> +BODY=3D$(sed -e "1,/${SEP}/d" $1)
> +CMT_MSG=3D$(sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}")
> +DIFF=3D$(sed -e '1,/^---$/d' "${PATCH}")
> =20
>  CCS=3D`echo -e "$CMT_MSG\n$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp' \
>  	-e 's/^Signed-off-by: \(.*\)/\1,/gp'`

It looks like you may have missed a usage here due to the line break.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTWuijAAoJEL9TXYEfUvaL4pIP/j9Fv+/MLD93aVoHrWxcpV03
vbGYB/6paU2mXpLTTnOinsQL0vvBSZMFIoA73AAAdvmxpSTEPCEdTtM12xS111dp
HcDsYBX/b5W+gGfbH+fOTELOBoTqbVG0X5FO0FFp2+gE5TiLL8TeLkpO5SfeEH6r
QvkNum3v8yVg/fK6Ork/g93kGnx4RVAgksZbkgEq6RYEb0hGPyXViP6VnU/16Rgl
ElRVUWNrqiI/sGfwnPHCbL1nbmY7UeWLenT+43QUaQ27AHedlN84h+jazApoRhcv
P4QJXyETO2fDamdYZGnn0zOId+Coq0ypZtcqfvmHc0TSa9r/l9eohHlcdyqSlRZF
Iza1ThibZTjuuoX0kobFPa+adGJE5nK29AcVwHdLVdwCrmGjewjzxuYbFFx3nogL
V0JDU8+0sFifRwfcN45cPT1PqEJn6iYlJ4XcVERQgd2iP78uq9+Axs9V82SPuFuE
Knmzj7yIx9kfIjzxULtBZ9KmggBrNuguISbCbGEih9pz6lBuHCk0ugu1TFHyXngZ
3D+wacyHt8nB/0ci74n5GWToOemSB1hQFmTMsFuq+NxuKqGBPyRyA1w0CvUAe2mC
hVIzKoCARGksYjDOFisTG/zMD7MOK+/VXGKlUcUf5yJjFYlzYlpBCv7dKtn9frGN
r7KEdAWIdHjsZ7U/aKNs
=gMBG
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
