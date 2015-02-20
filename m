From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Git Scaling: What factors most affect Git performance for a
 large repo?
Date: Fri, 20 Feb 2015 22:58:27 +0000
Message-ID: <20150220225827.GA23852@vauxhall.crustytoothpaste.net>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
 <20150220000320.GD5021@vauxhall.crustytoothpaste.net>
 <54E7B077.3050501@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Cc: Stephen Morton <stephen.c.morton@gmail.com>, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 23:58:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOwWt-0001eT-HT
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 23:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600AbbBTW6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 17:58:35 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49154 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752484AbbBTW6e (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2015 17:58:34 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:c808:e39c:abee:cc11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id AEAC02808F;
	Fri, 20 Feb 2015 22:58:31 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Stephen Morton <stephen.c.morton@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <54E7B077.3050501@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264193>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2015 at 11:08:55PM +0100, Sebastian Schuberth wrote:
>On 20.02.2015 01:03, brian m. carlson wrote:
>
>>If you want good performance, I'd recommend the latest version of Git
>>both client- and server-side.  Newer versions of Git provide pack
>>bitmaps, which can dramatically speed up clones and fetches, and Git
>
>Do you happen now which version, if at all, of JGit and Gerrit support=20
>pack bitmaps?

They were originally implemented in JGit, but I don't know what version,=20
sorry.  Some googling tells me that it's probably version 3.0.

>>2.3.0 fixes a performance regression with large numbers of refs in
>>non-shallow repositories.
>
>Do you also know in what Git version the regression was introduced?

v1.8.4-rc3-8-gfbd4a70.  It was fixed in v2.2.1-65-g2dacf26.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU57wTAAoJEL9TXYEfUvaLCnAQAKCJjzWOcYODe+jFmdCwXzMG
1njVU83uRy/73kbff+YTt80bFHxDRp7q55fsGK9vj5AWTdPgIzkaXzr+sjfdCWa1
xq4a2Uu34AWCDfho1SXSibC25PcajavDwdUC63A1q6+YtnmbMkLztlBcFVr4D8lu
/gu3WHHjM3uddj2/M3dkNMyomdmCqgq79UUA8JL1MWf5YwXUfcQraSJm5pkVT+BI
MUBAd6BE+Kapg2EfuJt+r+y8++p0vit/lc0ms028oKrsiAl8ASHGwgkjfmP22t0q
+Z31dVe9BahcXo3KLxmRe76JufJ0Uhm6iyu0IIpxZ6gqmWQPzs/N/WbtpnK3p0b9
WqDXccyMHWmyciVV4G/cbTubI/u+3jlpdjrDIEwVfnwK7N6XxNB9poSsCZ9DhU56
cFij2hQH55AZhqC1bMn0h1mx9IFePmmOndLC9goNro6PDOONABpBb02eWIHzld2/
HsuETQ5cOwHDhy/yD3PtCKRo/cy3Ce6VmiA9SfN7X0bfWGVjD+GhzEY8TnGXf0Ss
b96f2Ufwfub4eE0oPpdldHFgefawrSaS+v6DtO3bFNt99hgNIHZ3ZH2ZKytDUjdH
bh6PLNQp1Rjsp0V7iT75aIG/pRvUnPyqn6RjJuGjx2plRT0+/7Y0K1KH8aop7EBL
sCyLYBjyIx0ONa9mRBle
=yMRW
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
