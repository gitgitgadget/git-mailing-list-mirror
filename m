From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH/RFC 0/2] add a perl compatible regex match flag to git
 describe
Date: Sun, 27 Dec 2015 23:39:51 +0000
Message-ID: <20151227233951.GA52863@vauxhall.crustytoothpaste.net>
References: <1451257192-5755-1-git-send-email-mostynb@opera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Cc: git@vger.kernel.org
To: Mostyn Bramley-Moore <mostynb@opera.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 00:40:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDKuy-0002Iw-Vi
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 00:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595AbbL0XkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Dec 2015 18:40:00 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:42542 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752690AbbL0Xj7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Dec 2015 18:39:59 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [107.16.112.78])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 40386282CA;
	Sun, 27 Dec 2015 23:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1451259596;
	bh=JnyUyR2KuKMKQzH5HmtcHLPAyZAbRTC0wq7T8t/ukRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z9VJk1QgEcHj7+JEYMLhd97VoEQqPjl9XnCCEiTYiyuaoE8BKSnDipzbuvdvfHV4T
	 8Eql5oCO02yKFZmvffxGT6N/hVPvm+zxWDjEgAO0Q/YsdBYpAlzT7RWwLz2J3Ke6X2
	 jUbBBgoskf4iNtF3L8gu2r9jb1cGpAGCYMcVBtNyHThtlhCA678LI0RNibczY73e2a
	 8B+KHYlTdTqmHeTZwnIErLeSbCuKorKsigP9zcVDdgoltKmAGcEo4Vlf+UOLaBhEIi
	 L/7BHBUk48rhKc2otrgsiMyFqg394tvbOw70uEtSRw5inAQiFuXNFsipMsSeTBdx4l
	 +tNJgO0tZGvc/CVhQGWlyRxVm3yy0TfqmChEGmD+BxEgjO2yncwyCFgJk4zqdzc3Va
	 1cVNS3m4f4TxXWDz8uH5nwr0/k/QCyhyB8v0s+kETq1My22vrrXynuelpOe7wWDtjF
	 5MIxZOy2hWBH70on9JLEs7AeBGlyqDmYTKLNi+2JXKD52a5PGOC
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Mostyn Bramley-Moore <mostynb@opera.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1451257192-5755-1-git-send-email-mostynb@opera.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.3.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283022>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 27, 2015 at 11:59:50PM +0100, Mostyn Bramley-Moore wrote:
> git describe currently only supports glob matching with the --matches fla=
g.
> It would be useful to support regular expressions.
>=20
> PCRE is already an optional dependency from git grep, I wonder if posix or
> extended regexes would be preferable?
>=20
> Some old discussion of this as a candidate feature is here, though nobody=
 put
> together a patch as far as I can see:
> http://comments.gmane.org/gmane.comp.version-control.git/173873
>=20
> Mostyn Bramley-Moore (2):
>   describe: mention glob in the --matches help text
>   describe: add --pcre-match option

If you're going to implement this, I'd recommend an option that adjusts
--matches to accept a PCRE regexp instead of adding a new option
accepting its own pattern.  I'd also recommend calling it --perl-regexp
for compatibility with git grep.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.10 (GNU/Linux)

iQIcBAEBCgAGBQJWgHbHAAoJEL9TXYEfUvaLdJ0P+wRGkN20z5tgsKsUglPTiEAk
cN4vBHT7KndJUMzGWKqbDRQh1lUHLoFmbwCuMRSXXCBIQH7wSeTemZI5yjwJ/PZn
E1kDRMFpNWW1df2BUSJ/xTsqLkIWVarKo8HwQyKaRPDIxq4VglDYIVkKsN57Q4fu
JmiJniIOuKjyCqjhc7/XCglUZT3L7Y81vY7lnm2vfhnSc8758VDA761i29184eDk
wmp1TJOLcZVenr4A5mZYNb6KRf4pd79FyCRW4vekzEB7gxVfaRZmvZNYirMd95p/
8ERTWos9puhwcdBoH/ZtSyPDxsHd7JJ6nAoisybzH7rtK2Gn6PJNx+QTP/8DsqIh
ug2X/ysbL+FRUlDlkzSTVx6TCsnzTaQZhks4YEJTFg1IP7v4xOvbXCRSZJRIAjUW
QB+GGD4EDzxqdK3sAdziAJgNOc3H0x3EMUciEeQLLHEofgXYU+WUCWVoTDPXB6D/
7d9j5Izj54svNIwnvWxGKBqtIix6kOZz1dIUD+1murI7TBYv6ryTKuoKBNGhRPD+
ee7OQQTf0EzZnZjDbRf8ArOMVXSppwqL7Hf+5wPQzWlQqQ2W0AlSBfPs11FKlW+I
KIaRS//EeECwMb8kkrG95RcYApApHr8HP2Hnawjpio99scBsLYX1VLkKhgcd4bTl
a++w9fJDnq7Eaqf2tIFH
=5h5c
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
