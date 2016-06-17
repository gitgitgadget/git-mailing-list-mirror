Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.3 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID,
	T_TVD_MIME_EPI shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB49F20179
	for <e@80x24.org>; Fri, 17 Jun 2016 12:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbcFQMrS (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 08:47:18 -0400
Received: from kitenet.net ([66.228.36.95]:43016 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752337AbcFQMrS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 08:47:18 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=NZTzgIKG;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466167627; bh=XYKdXJa5vLLkaj5yjZRieA0AjJGr47udAN9YRGQIjVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NZTzgIKGUaW7aj8ahhr8yI98qPCT2CAaWHEtqLqtao4yJTrmhcNV03tBTmkU6sv+5
	 DAQ7wkVU8fX3o3WvwvRsGrFQgegtnZjuCPTAwjNzIu6Y1HS8R5Ixcr6RrUVvAymx1g
	 UCLCCRLZwNmeBPZ5UbuM0RIn6BKfcmQJgk3y2vjQ=
Date:	Fri, 17 Jun 2016 08:47:07 -0400
From:	Joey Hess <id@joeyh.name>
To:	Michael J Gruber <git@drmicha.warpmail.net>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/4] add smudge-to-file and clean-from-file filter
 configuration
Message-ID: <20160617124707.GB24025@kitenet.net>
References: <20160616203259.5886-1-joeyh@joeyh.name>
 <20160616203259.5886-3-joeyh@joeyh.name>
 <3c7349e7-34a1-ed7f-721e-e7a7b191bb3d@drmicha.warpmail.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
In-Reply-To: <3c7349e7-34a1-ed7f-721e-e7a7b191bb3d@drmicha.warpmail.net>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Michael J Gruber wrote:
> I'm not sure this will save all feet. I foresee "why is smudge-to-file
> not doing anything" reports...

It could display a warning message if smudge-to-file is set and smudge is
not.

> In addition, it opens the way to doing completely different things in
> smudge and smudge-to-file - which partly is intentional, of course.

They can be implemented very differently, but need to provide the same
file content. Otherwise git checkout and git diff would show different
content for the same file, for example. This is up to the implementor of
a filter driver to get right.

> Do you make any promises that %p is a seekable file?

Yes, %p is a regular file and so is seekable, statable, etc.

--=20
see shy jo

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBV2PxS8kQ2SIlEuPHAQLthg//Tct+kh5rpw1nwLRHDIlWhy0N7iyFQvGo
x3IpBev9tO2W6c6bUHqvogQ7Ow8RmuhWGPJiezAE+A0jSe2cWXHnIcKtcrYgX39i
GYK/ySmMvWmKb6fT7Ydf543qcrRZC43T5w5oBhW/SddsaSEIt4exDSwFG1KNNFPh
OAhkCTcRLChmqFrmHnvgHCUwo6754RSfc584/HpjF/w7eNqROfcT2FDXcnGRUlxi
CuPSYXWAEvmfAVewsO0m5GvkDmFIm1S7w4PwyBLFXUT4QboAGMQncEa4WRJ4H50j
KllVNu8o5YBwsVFBnAfasFJbfZtrIe7EjlWW1OEAB3+trHYVbGFqLIwBzNp71N5D
XOKunUohaLmI8yDxC0Rv+bAG0qC82CZIp2l7LRVc9wo7L6XgDS6WtPa7SdCZvpYx
0cr1uAulfEW8HxBYQMyu3C9RKo8RQSX8OzU+y9pbeR2prERpZIpJEQAmUHBJR8Tw
9pLdxPbAEDqgop8zCHFtkqC/fLXSFwIxNtZUUdMBIqGx1R0v1XO/V3tOPaWKDdhN
QTDN0OfzVDM5jvAw9H6Qcgerx/ZAuQo1zgaqMuIMaqUzPwU5QJzgBGbsypBTnZuv
+yVSpLDs+rtX7ovzf9moebfFVDGl/HlKiXmO+6ZVwAiiykpYD+W3CV9gpE1KP0M5
pwAEjkyjUgI=
=fTnP
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
