Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A3AC433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AFF860F0F
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhJ1UfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 16:35:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:35253 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230323AbhJ1UfX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 16:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635453174;
        bh=0mc5dNPLhi43YW/lDo3j2Ve/lalRI54Qw/3gG7PBcF0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RlwPxptw/G9NmO7hFKAPravPAt6rFdTe7uPjwurucMtUiJuLNafYuy7KVHXCpVyqV
         Q8qe4WnxAUEV9e1SkkRGcuotR+6uaa5sWQz8ZEkGDZyim++CSpN2vD8GBgA2/PMXdp
         O8/JaQJnVYPnHL6EDdXclaDAwNHiH9zferrjZ2eg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([213.196.213.185]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbp3-1mHFbZ0YSB-00P4Mz; Thu, 28
 Oct 2021 22:32:54 +0200
Date:   Thu, 28 Oct 2021 22:32:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org, vtbassmatt@gmail.com
Subject: Re: [PATCH] helper/test-genzeros: allow more than 2G zeros in
 Windows
In-Reply-To: <20211028085446.78536-1-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2110282229280.56@tvgsbejvaqbjf.bet>
References: <CAPUEspi_nxpYzJOjJ0osRRLVQ42uPRA9=9eWp3NBtbpeVtJZng@mail.gmail.com> <20211028085446.78536-1-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-855368057-1635453174=:56"
X-Provags-ID: V03:K1:8qAbtxs2I+v6LX6i79rBGEcl44BcJXhpB9WPBNcKSB+6hbhUvFq
 1RQY2WYRR9V0lTKl0FMuzWFBskpJAbwTY8DqTz4oPnlegk6Ie4MIm5LwCaBUveOEZlil/3O
 RarpOa7c1Y+iX2wjNyQBvZk4jmsDmdK5HTTGOtc1i1u25yu1Xa7+llVSYHOlQErnIQBcPKq
 m8k0aAClhTa/8DI7F+isA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UnQadkwXD4I=:6lm+Bq66qtTOVdiJ+L/QE0
 aNW65/Miyt320m2665pjJ/wLi5OrRf1aFQS/o0CLYXN5Dp3Oa3Iv4Hj4Rg3DaXvcs8QxHtNiW
 wXj0eotrP0Mq3Zy8yl1FzQnxVbK+6xDBXmea+5pjmGJb9ySkBobEdBofm/RHz+BjhxO4P8Ih4
 ALOJxqdMPs5SeeIxrPa4ZZs2OiQpcG45k2li1aS6ac0i6srjQNWfss0mW4Y71rZ1tqvJNkkxh
 sWNEaMs6yF0WqqAdCsHQzjdBKLImLY+l83ez/WasShM5CKJ5P+XrmIpakqLFbbA/ELe2svXdN
 dg7OnxyztmwPdzCbytYFaC2jY1/QVDHHYsW05cDs0xWsZbMXR9NAGZP//MHneFiWjxEyhG4lA
 rbdDJ+5wkITfoU7OwutwJqmzhwSBpVunINcfP3qwFN35BNtX+jsmMsN6yzPZFgs19OEEQ2F1r
 Z8Dtk4nloxJLM9C1RDb4k1iwjMv9LdwvO2KZ1eafT6LjyUoXAK1LPQliH/fqD4hH4qV8UJ/6p
 5CIWc8ZPOJB2yjFiVgRjRQxECaH4Mwr11MU07gG/PK3IBXzehUB9MCHAIQp9BIj+7iXCCoWVC
 FIge3yoiSa3PMEYOBfxXb8eg9ujEFte0MBX9zLT6a3piw+mmVuIJpUO5T3zfco9TGVyFyYdX3
 2bHCFR6Xpvo3wwjEVuT9crAL0PeMZRymrvUtXe85ekxnDRMzqXYmv2Q4Quu7hJjUD1ULa40fe
 picztcdEqmNhlVIQ6SpnQQ9hQmreMGDjCRwO/AdQZZU35veL0mb1DDONPi95zyW/hTVrLQFM6
 lo+sejfQE0FwOgvJi41Ex83bWiIDkksvT2req3RbNLiXIFmqFAOypy86Q+u+Eyx+suh2m8GWN
 KinWYhLyT9OSB2NIZvZQJEeJJVLf9r+z6ONzBmgUPR0EL/Tnxt1EUtjMFJAoQFuUKHXEIFPGU
 fp2Ew7w84+mBEBwb55A572HwY7AL1fXrW2cZ0mPZkxmFcy7m8h45/Wdryl4khOj6WrXxMwshg
 y1a+dkAU1E6VCyMhX1zJMOWSV6vf5ErDIFnZhPlpUpdZ5cXupCNJpdpJdOl84KpkVPFBddsB/
 85zOyqxwb6o35I=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-855368057-1635453174=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Thu, 28 Oct 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> d5cfd142ec (tests: teach the test-tool to generate NUL bytes and
> use it, 2019-02-14), add a way to generate zeroes in a portable
> way without using /dev/zero (needed by HP NonStop), but uses a
> long variable that is limited to 2^31 in Windows.
>
> Use instead a (POSIX/C99) intmax_t that is at least 64bit wide
> in 64-bit Windows to use in a future test.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

Thank you for this patch. I integrated it into the patch series.

Unfortunately, it is incomplete, not because it does not work, but because
it comes at a hefty performance cost. In my tests, generating a gigabyte
of NULs took around 27 seconds with `genzeros`. Compare that to ~0.75
seconds with `dd`, and it is not funny, stop laughing.

Happily, I was able to rewrite the core part of `genzeros` to write chunks
of a 256kB array instead, which pushed it back down to ~0.6 seconds.

Will send out a new iteration as soon as the CI build passes.

Ciao,
Dscho

> ---
>  t/helper/test-genzeros.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/helper/test-genzeros.c b/t/helper/test-genzeros.c
> index 9532f5bac9..b1197e91a8 100644
> --- a/t/helper/test-genzeros.c
> +++ b/t/helper/test-genzeros.c
> @@ -3,14 +3,14 @@
>
>  int cmd__genzeros(int argc, const char **argv)
>  {
> -	long count;
> +	intmax_t count;
>
>  	if (argc > 2) {
>  		fprintf(stderr, "usage: %s [<count>]\n", argv[0]);
>  		return 1;
>  	}
>
> -	count =3D argc > 1 ? strtol(argv[1], NULL, 0) : -1L;
> +	count =3D argc > 1 ? strtoimax(argv[1], NULL, 0) : -1;
>
>  	while (count < 0 || count--) {
>  		if (putchar(0) =3D=3D EOF)
> --
> 2.33.0.1155.gbdb71ac078
>
>
>

--8323328-855368057-1635453174=:56--
