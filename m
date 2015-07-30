From: Joey Hess <id@joeyh.name>
Subject: Re: git pull --upload-pack reversion in git 2.5.0
Date: Thu, 30 Jul 2015 14:31:44 -0400
Message-ID: <20150730183144.GA6360@kitenet.net>
References: <20150730154523.GA17002@kitenet.net>
 <vpqvbd1k1ke.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 30 20:32:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKscl-0000kv-ST
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 20:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866AbbG3ScH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 14:32:07 -0400
Received: from kitenet.net ([66.228.36.95]:60911 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235AbbG3ScF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 14:32:05 -0400
X-Question: 42
Authentication-Results: kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=ay0wSdy7;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1438281104; bh=6DH269jLTfc0WN1KvQJcsoDoZv57YHisf2fZrF/5f0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ay0wSdy7d3WbVhaR8tDPqVeI7vvLx3shpt0J3CK2Ebjr0narh0zIqmnH/BgWI6Uxg
	 4t3jAc6C8dWTBAbL1RXkd+bART/6MGYxuiRztcIMGprKKXMw2jmtqcW2mO3wngQ+LL
	 Kji97XILJa3inG8FCxj85Xfqqgqedjc+Cx4QOEFs=
Content-Disposition: inline
In-Reply-To: <vpqvbd1k1ke.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-93.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_RP_RNBL,
	RCVD_IN_SORBS_DUL,RDNS_NONE,SPF_SOFTFAIL,USER_IN_WHITELIST autolearn=no
	autolearn_force=no version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275024>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I think this comes down to a lack of quoting where git-pull runs
git-fetch. Before eb2a8d9ed3fca2ba2f617b704992d483605f3bb6,
"$@" was passed through to git-fetch, but now there is a $upload_pack
which is passed without being quoted.

--=20
see shy jo

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBVbptkMkQ2SIlEuPHAQKIag//f6SNiPASSKB6gQ8DkNtfoilyArLNuOSh
hGbUAdqWVnTit5zGbP50QA7JIzCIGrRrNkl/3UDxPl7JcxVm9q6mfypVavppi05A
73j4d4eOS+tMjfqVqsO0OorDOEsSOq1EMWDdKfBF2nzfl/E4spkBxKwJLzI21Hyj
oZXqw08N4lU4oGM+7ePND86BwgUFiBLBwKagZu3kSsNsemE30EldWhhkvKjeDLzh
BxQ5qsPg7QiYY803WTD7E/p+9VkS+MVeKSfJE0zwrvJH3XfotySxL5hLoH9wCgRR
ts70w86M9KRzUT6zgzYmj+HBEBjNot7V4j+FVjrqkLQ4LszeoKBuI7t5Nnw9AAxY
gvClqopjzdVwNy+JF4WGuWCgGIopiJ1tydUsrNBQciiCII2pKvQVAByUxxVs/XfK
7iiGxovldRjkpPEV7wnxDOBMXo0e+xA5o09+kFA80Z3Q8hWmYssAm5VUrp0D369Y
yZu/9X1bdekuawhwSaEFM6J1qFQYVbLFVCoIu/I6qgIRzth6skyAssjRBn2gUp4i
9wYK1of6+dk0hsEXnYEFkcXjSvNJx8+iie7SSvGObcVImbJ9FdOIPP+1bCOP252b
wf/ZEqiyynQjKHCqimOT/8WcbZMtAQ/o0Fi6oG7BcdurCgPL142l4Yc+/oXhU1/B
XbC1UNyWA+s=
=sfPl
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
