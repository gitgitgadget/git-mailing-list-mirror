From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: On undoing a forced push
Date: Tue, 9 Jun 2015 15:00:35 +0000
Message-ID: <20150609150035.GA102463@vauxhall.crustytoothpaste.net>
References: <20150609121221.GA14126@lanh>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 17:00:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2L1E-0004nh-3q
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 17:00:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933146AbbFIPAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 11:00:44 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:38261 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933003AbbFIPAm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 11:00:42 -0400
Received: from vauxhall.crustytoothpaste.net (107-1-110-101-ip-static.hfc.comcastbusiness.net [107.1.110.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 589D12808F;
	Tue,  9 Jun 2015 15:00:41 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20150609121221.GA14126@lanh>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -1.5 BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271189>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2015 at 07:12:21PM +0700, Duy Nguyen wrote:
> diff --git a/transport.c b/transport.c
> index f080e93..6bd6a64 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -657,16 +657,17 @@ static void print_ok_ref_status(struct ref *ref, in=
t porcelain)
>  			"[new branch]"),
>  			ref, ref->peer_ref, NULL, porcelain);
>  	else {
> -		char quickref[84];
> +		char quickref[104];

You've increased this by 20, but you're adding 40 characters to the
strcpy.  Are you sure that's enough?

Also, you might consider writing this in terms of GIT_SHA1_HEXSZ, as it
will be more obvious that this depends on that value.  If you don't now,
I will later.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.4 (GNU/Linux)

iQIcBAEBCgAGBQJVdv+TAAoJEL9TXYEfUvaLwIcP/3zjdyh9Y7LmAPZBvYtnfJ1m
tSEL5CkMV9xTz4ZX8REpl7iElcwD5iwJBDj0WhppjbXRIQuSbNscRX3hoSuLUbuc
JNkNDDkD6JkvDSrNUyx7nA2aCZGuTR6KJBGTwZXuSamLtN3+SRnSKsoJC4v3Hz9R
PRa6W+VsAYs+1bMwWaSfikwRDyzTwjaoLFJ6wsojouqdNWIPqQdqloJCyDCQ7p7q
sID6gpyvwoBjqFRqmdi3xkVYULgWGP0pkZ+vUq4akeEJ+Rv6jNOFOBecMLN1v3Ce
LKc/n9lZsoS9N8f2EEV1dNoipiAyyAPg9qBmRGanLV7DThtm1XsMWRm+bJahopvA
80XqGIC4Ft6C13EPc0ZHiuWF1thN2X0iPrUP209OohRRBc+/6QnL5EYTFdD4BUGy
yYEQrGQpJlMWD9662kVwwe0KPe1igYBZ89mo1VQZAVjN2pI1p/fLReXCv9N3ff3j
JDoW+aRYeRLqUarisIUB6r5aJMHiRCXIo2R27+C6vB8wVWA2peS6SogAnohxL7lI
n5qeRaQACqI4q3s8KbYqq0K9fgeszWMHqhUeN+Mpe+EZKbyHf6IDsoBeCEohF8la
QZCFf7SV5pAR6e1HOUUdZomgH+KtTOkHzULXxtJvR/hrsy+RZJgwXcogdZGnLWWJ
ISpQpHTkiJ0vwxvPIh71
=8+u7
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
