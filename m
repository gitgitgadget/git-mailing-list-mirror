Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.4 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID,
	T_TVD_MIME_EPI shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1023F20179
	for <e@80x24.org>; Fri, 17 Jun 2016 17:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449AbcFQRhf (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 13:37:35 -0400
Received: from kitenet.net ([66.228.36.95]:51778 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355AbcFQRhe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 13:37:34 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=K2HvlriE;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466185045; bh=dJmGL3SQX+3yqy+AL7RjdZmjQEtVkGGiepiUs/jibDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K2HvlriEA2vLTQ7IQBOL1Frp6PvT0WVPhflgkGjSIDnz9RgdWIyf0vRtYyU8+pygC
	 dSsUAbID9gggPUrVYL+XJrZJ7xR0H5ZNhF9LWFwuYU1Qyz7TqvjrjCviB2qDM1dVA/
	 8+e323k19DdT++3FpQljQS0SHisjFindy1/3fPLw=
Date:	Fri, 17 Jun 2016 13:37:25 -0400
From:	Joey Hess <id@joeyh.name>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] add smudge-to-file and clean-from-file filter
 configuration
Message-ID: <20160617173725.GB15901@kitenet.net>
References: <20160616203259.5886-1-joeyh@joeyh.name>
 <20160616203259.5886-3-joeyh@joeyh.name>
 <3c7349e7-34a1-ed7f-721e-e7a7b191bb3d@drmicha.warpmail.net>
 <20160617124707.GB24025@kitenet.net>
 <xmqq60t73igm.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline
In-Reply-To: <xmqq60t73igm.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Would an interface that always appends the pathname at the end of
> the command line string work?

I'm ok with this, and like getting rid of %p as it's not distinguishable
=66rom %f without reading the documentation.

The sh -c trick can of course be used if some other ordering of
parameters is needed. Probably anything using this interface is gonna be
implemented with the interface in mind from the beginning and won't need
such a trick.

--=20
see shy jo

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBV2Q1VckQ2SIlEuPHAQI9txAAso/1mhKO5KqhIKbRiLdwERaZltUb2QEe
wbohlq8hWMZ2M3VTQLbxW1RE7IGr0VbYMyMnQLm2Lp2SqSOln5mkV0YH9v8vLckS
VxMjvA1DAP6mdd3x77HaOB1JUaWpW5eqBsjRny43pq4BoykbGRnv/7y5uNjb2FMf
9p3bKMJA10Rvffq7cJlPlw0Ue4rlstqMo7O6MPtQcpqvEmqabtLWYxz+Q9bSvrLm
TxpPkrVTv4rt+PVCxhz4utxPkVZjtcQuNf1EQyRS8E/zoV9Qi0OaFl1jzTdqSHP3
2fAORARu83J3Mf4KSqisdcdCpZ3ub1uGYWWtDiMSugAvNn6ws5+irEbu38BMXLUN
HfrqVLKyHXWdGmMNcPL3He64jvphNIRqoTyWqT2A3RDbZ12lJJ6k2UjmLVQpeeOf
WKi0vbtfIVSloxmUPexXkjiFHwqokLN2rd1QTwbYipJkmOI3+eTWBaDFFSMOO4iH
0WN0Ea0ySEC75TjQDHk8O8FfLubQaS7e8QZt6xyHIP/bMGwAQJq4M6kBSE6njabh
c8OQvich6IN4XL0Wv03vFBAyQr/DeB3Z8ruqHNeZEc5+yc5zrst0s3mpb9tzVEbY
1TVLSDDxnsCxpaQY0LGH2XeD9KeQ21Mkik0GqmDMBqB84wNHpTgBLTMlICgkwxxc
u6GbRUGGZOE=
=pfLU
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
