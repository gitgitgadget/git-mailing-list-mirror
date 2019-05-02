Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1338E1F453
	for <e@80x24.org>; Thu,  2 May 2019 23:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfEBXPp (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 19:15:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35818 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbfEBXPp (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 2 May 2019 19:15:45 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:ace5:84c6:6a15:3d32])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0C02A60100;
        Thu,  2 May 2019 23:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1556838942;
        bh=oKLSHRtBrc/fSjo8NY6HrhvV8DcklH1i79EayTvqT/I=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=w4uhB6YmS8fWjwwTf1MAfD12jc/6sdSxTmJGgLeGvTFs9jyTMmUVJv+/2kVe9k/XK
         rBobL5vRk0722QqFggFQgkoQ6aw8k9zPRKc3FMww4/YMMGsZHMA7rbbumEczad3WKp
         2sK13LeNAOu0gtajC4ARsYigG30lmpZeRj950mKxEFUME5Pj/uu2KKkGKyRsd52pme
         unmoBvPNVrx7BFJnflP0Wzy5+3OobDMtCRmK+buB4EN799YTK12HlL54Dn50gbpoBe
         Nm8JASXry7Jq7Q4jHWHIR5yr0H4F4BSkffAhRGqGPqm+WlkqcG5Nw8F0gMROi8Dn8a
         66wqcNT+WY/R82AOyAxCqV8q19PTLKSNBJp2YkqvFPjL3ru2i7ki4R5ovk7/uM+WMV
         HqdEpUqVwsN2o2AGGOrY8YOCtPqB53KvvxYF8kx3a9oa9HClQdIWRl1NDmkXvcy7yE
         Shn9xHZ9yP5DlqeocXVAB5JMRfapzShs/9xAzRWLr/2j9UkcQhG
Date:   Thu, 2 May 2019 23:15:37 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, Git <git@vger.kernel.org>
Subject: Re: [PATCH v2] status: add an empty line when there is no hint
Message-ID: <20190502231537.GE202237@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>,
        phillip.wood@dunelm.org.uk, Git <git@vger.kernel.org>
References: <20190430060210.79610-1-johnlinp@gmail.com>
 <ae1332b8-a227-e83a-8862-8811b6a81251@gmail.com>
 <20190501234512.GD202237@genre.crustytoothpaste.net>
 <CAKO26MvXmOMHgqWSoVrmdwyDFyqDrChkMOHq6iuJAX8pvHzZoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
Content-Disposition: inline
In-Reply-To: <CAKO26MvXmOMHgqWSoVrmdwyDFyqDrChkMOHq6iuJAX8pvHzZoA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 08:35:23AM +0800, =E6=9E=97=E8=87=AA=E5=9D=87 wrote:
> Thank you for the support! I'll be very happy if my patch can get into
> the code base. Is there any improvement I can make for this patch?

The patch seems sane to me. There's less duplicate code than the patch I
started writing; the goto conclude seems to avoid most of it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzLehkACgkQv1NdgR9S
9ossYg/+KdVmtAB8qJppOelJ+OZXaTz1SoTDM0bWIZ7pI81BWcpjONTJc7hb6Zyn
tkWGySmwlxq4aGt69l7DwXkxmprpsdBDJNaCjX+K/BkaTGT2Efm0gD8GJK5aSCSn
+YH2m+plwUS/WeYGL3H0KwVDAJVAUQR1k1IWRAD9dFbbqaz5v7ttEbnDZnCUm6EU
/Jj7W636mj7ZXv7waIq793ET/gw5p7pIgXV/GUJ9+JM/JADSOr77/9hdtx7QHYdX
v509VlWrQ0SMt+JIQr50JQ5qMzXr9UOXJxHDqXJ+iT6lEhrnQXNUcByviiApz+Ol
hkzRX8VM67zxMIdfptphDzgEsK0e63WYOxNQpRMfkr82tdmJopP0azRxAL0lbzjM
egURJOwkFKK7QsB4LnIKkPn9UFFt3hgKwvC9CxhsPsc+ODBm8S/C2670Xf1Rb0Ed
kcUYLW+AKounCKXdnVGvdwc+wZ7Uj3xr8nnAXuW1M3Nzp2BPL7xmkGCdamwQWxPt
72Xb0nI/mhORUmU2Le4qNEPmMy/mO01NykSXhRY0/0roiG5Kiat0S4+tIMbQ4vk1
Sp5jbfbzZTLm17SF2vIqcL735o9alCknUYlc+sp8tuM+dGgpqRLiAdMmJt6rcWVU
2DB4C1qYZJ8d6tQ7rSiW7/KCfM4SBYCNS8cMPXLt1Fb8Ok/1isA=
=ZYAw
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--
