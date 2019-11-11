Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CB691F4B5
	for <e@80x24.org>; Mon, 11 Nov 2019 23:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfKKXxq (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 18:53:46 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38236 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726896AbfKKXxq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Nov 2019 18:53:46 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A393A60458;
        Mon, 11 Nov 2019 23:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1573516425;
        bh=lw9R1AVIeylAfBLVNgZmCdXQARghdbWcaLjpynR+ckc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ZboJkqWgWjSC5phoOQBlm4peqxm13vWZv+FDuxi4DEwYA2O1l6/bwzlYkfPmHvuHL
         shLgD9ptBLixbvTJL4xt6LKpFAT5Ehntw9l2/m+3QVo/vGSNZP7TBmIlg/xNmmXWPp
         FugiNeflZwrEcGNzChGSjSlvAwcNc88wgGZN5v3cBFNvKKCzDtDmW1ofM8wrfaAqdT
         g60siItS3bb/xypBBFgLYe30EUawa8S+7srVhq2WOXMbD9HMGzpOQ7DoW64VN+QwR6
         ImhKK9T1fi8US1q4C28O2VkUQxt0PIt2blOXgiVx3hAVL63EnLyRdYyMetzGD/I5bH
         XKgMgHMNkn0Zejzcmj8FTvMqQ7M4T7XDNbUrG+6676lAu69MQf9DcN26sGgBCvvzX5
         4vyCkdkaNvwrXsnZBSHhaR2o+23/7BAwnmMbaeqMvNG73E91U/3qhQjic0qAaVANSf
         QwdEJyfyy6NsvlLFT5GajNP3kPL+hcMV0Mp1KhVqNkHmeDpzhtd
Date:   Mon, 11 Nov 2019 23:53:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] getting rid of sha1_to_hex()
Message-ID: <20191111235338.GA9216@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
References: <20191111090332.GA2275@sigill.intra.peff.net>
 <xmqqmud2hj9l.fsf@gitster-ct.c.googlers.com>
 <20191111092144.GA12607@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20191111092144.GA12607@sigill.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-1-amd64)
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-11-11 at 09:21:44, Jeff King wrote:
> I actually worried that I might be stealing brian's thunder. But AFAICT
> this cleanup has been waiting for almost a year, so I figured it was
> fair game. :)

Oh, no, not at all.  I'm delighted that it can go, and thanks for
sending the patches.

I think I had intended to remove it but hadn't because I was worried
about affecting topics in flight, and then promptly forgot about it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl3J9IIACgkQv1NdgR9S
9ovuLQ/8Deka/YeSj+F0e8LOEDRFliPOC3FKOmSSojZRz5HiPa+GO7iv4NkY/6o5
i6yclk8GN7uUwYG6Yk/rauqxbZsZYHEjY5YylOl5NunvZ3nwKmbXTUWM6d0M2Q6W
x26X0OnJx23n7hKccGYHoKZS6eHHstIJzhGdyWyAqpi1CiJaMyUGrm2vofD/nnIS
BOZiME/DvZhoHFHovRyuHP4n/Nag0ouE2QWojm0kuJVwZj2o8WIGSv+8snwAilfM
MpP71ca2C5eWca+MQ2MkRzvzV2T/23wzyZ1exQUT7vpKslDccbQtE0NvXoptZFRT
NJVT6/6bLQDt9XgoYfFhK+F/h6pweHa5vF/xWIYfdqwKn4hWjMtasEEZkDYsvIKd
gBAPZb0y1oCBcwVgVy5x1tG2zvTlHDi6d5nR0upOyX0OSxVS2jRKQqecMRZCu3Wl
bgVR0sqzMpgKlBrQK208gGZCQrWYEcx3sQF+K8dbLMh1EmRXjl1dZe6wSc5rDJfX
j9PkiwpSAi1ALiItKanvAghF0XfyrjR7jd0o9DR0fXEjSdl4rWWBpTkFa4udKWml
DAc9gD1HTyWwzM8O+HM/fBxr4JbDpUnsImdzZeTw14rM9iWHLFdIXs1+EIQ22pEp
AMvwIhWKwhIxJHZ/N3V+62pu36454hH7gQQWfMVMRwkfXZrtsxE=
=z2fJ
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
