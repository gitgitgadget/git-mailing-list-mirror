From: Joey Hess <id@joeyh.name>
Subject: Re: git ls-files wildcard behavior considered harmful
Date: Mon, 30 Mar 2015 19:36:14 -0400
Message-ID: <20150330233614.GA17089@kitenet.net>
References: <20150330230459.GA13927@kitenet.net>
 <CACsJy8BDoXHS6nj7pEe0i8T=bMD8aG5FwuXABKgPOQBeMOr+Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 01:36:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcjEN-0001tL-Hi
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 01:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659AbbC3Xg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 19:36:27 -0400
Received: from kitenet.net ([66.228.36.95]:56022 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbbC3Xg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 19:36:26 -0400
X-Question: 42
Authentication-Results: kitenet.net; dkim=pass
	reason="1024-bit key; unprotected key/testing"
	header.d=joeyh.name header.i=@joeyh.name header.b=PyjVWQjk;
	dkim-adsp=pass; dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1427758574; bh=GvTNNRdXT79dd5vUcTRvkJfocy3NlU9IH+R5F5vsuT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PyjVWQjkv+/8/6OSuC3kuXZTzptkTD+007YlUE6+7duGnsCKbm4cgxYlKI1NTWcQX
	 TdwY3VpoN71suU5qWE0M3KdPGHLCy7JKx83LqUZ7mZ5E5s+U1LD/librx9S3jmYTzo
	 v1o/ZelEVCY0GnU/YKtczrvC6x1bbr4JxpK4XaOo=
Content-Disposition: inline
In-Reply-To: <CACsJy8BDoXHS6nj7pEe0i8T=bMD8aG5FwuXABKgPOQBeMOr+Vw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-93.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_RP_RNBL,
	RCVD_IN_SORBS_DUL,RDNS_NONE,SPF_SOFTFAIL,USER_IN_WHITELIST autolearn=no
	autolearn_force=no version=3.4.0
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266490>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Duy Nguyen wrote:
> You can do "git --literal-pathspecs ls-files ..." or set GIT_LITERAL_PATH=
SPECS.

Thanks! --literal-pathspecs does allow getting around this.

Now I'm wondering what other parts of plumbing might be doing globbing
that I did not anticipate. Maybe I should set the environment variable
so I don't need to worry about it..

--=20
see shy jo

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBVRnd7MkQ2SIlEuPHAQI/zg//QCDQwthRlSeX1kw5Vef37AU4/a/MlvIP
nzEOhypj5zlw8DZnWloxeJwqA4UhRLoHzn0LvhJAiJ9cLNabL4AGQAFKEySeJafR
/bS4UXIBXdf9lNz6FfHdl2DAvhT/cSGWbMkCsNvKVPfWSl237XpMRiplNFvOLTGE
/pKOn5zXcfP/3dGE9A+IZHORPkSRAVYEIJfuY1GFAkvjYO+r3QjdBtoX0RWwXhBs
m3FiqqtIwDqq+1uS1OuPwUuiUBc2xkT6TcoEBbfeJLm6g84EyBFjQI08vHHYdwiv
ZLlaNLcNd4/o5BAdDiH/plBWqeGr8ouFrg5ukandW3yGi51HY61NyCiJ+t2cPUD0
rpOnBh5Nr8gkbqdx0XT7JNHQvW1KofevA4sLFuYlJAdPOBEesSAkmJ6GDQsYUHmC
lddMs1HkZC9h9sRx1K7YME5mnJZZXVZ9bJGWrhsNWJZCbibHveD0hj6wsjIjq4Df
sUncIGvy4bykBWytYjwWX0p1Op5CXDOj+x7JbvfB1/KGf9inyVVDoY/vUHjlV49P
UQ965nWaxB0Cjk5aqELl7gusPkeYNKnH/NgOznVee9GMXaJyuBh6ic00/WgdxY3q
imhaneQh2r7xYZFD6a9mK0LaNmxiDVuORse1obR2KpYuT/o9QsKrs17l0tbDnE91
VcG2ahVd45Q=
=Hjq+
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
