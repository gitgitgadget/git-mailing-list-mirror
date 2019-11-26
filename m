Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DD9C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 22:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1496420835
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 22:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Kkmt8OEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKZW1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 17:27:40 -0500
Received: from mout.gmx.net ([212.227.17.22]:35747 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbfKZW1k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 17:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574807240;
        bh=/k46fNJyjXpYCTcEPD4rW8BcRFVUFfSZoncZVgoaxV0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Kkmt8OEk8P8R3Q7gmoWwxE1ypC1bDWiTZwBnd8wXsnB0tySX9aycb0SdYSxfkQ7EX
         dooX5axSIN13L5FZsx1/BnVx2C7xncWu27Bl6pJPgvq/Le6ubs9wRAIpHsKGzkv1xN
         cAQpV04H2at8n0oypgUj6qqYJY/4UqKU+g36YrBA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCbEp-1iilj9210l-009jEv; Tue, 26
 Nov 2019 23:27:20 +0100
Date:   Tue, 26 Nov 2019 23:27:03 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Andreas Schwab <schwab@linux-m68k.org>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH] t7812: add missing redirects
In-Reply-To: <87blsyl32c.fsf_-_@igel.home>
Message-ID: <nycvar.QRO.7.76.6.1911262325390.31080@tvgsbejvaqbjf.bet>
References: <20190724151415.3698-1-avarab@gmail.com> <20190726150818.6373-7-avarab@gmail.com> <87blsyl32c.fsf_-_@igel.home>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-442079199-1574807240=:31080"
X-Provags-ID: V03:K1:lV4H0culDzeEBmbyf3eGvspmLzke/OD+4vF0m5ho0FQ7mh9Ez5a
 0az+kyTHT4Q5Hss38AHlsSqrHKadD7Zd9qSx16OD7KtoEVkH9U3W11MytJEtpL9UmKiKkNh
 KrtadZtOL554OsNGjLLN4VTkqSZgD26+QulasBKET7pJVzOiyomcx9QzgW/qTisE+MK/UGu
 Al6O8tc8VjlTPxvIHSGAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R4Hf3G5OjFo=:rOavIRymXj1HlbvN1P9323
 wdVwhtWHctZbdT2Lsy6+wpS/WGttpNbZdnX/JpZcVBG2S5cGXKrwH4Q/miqs037Iw9g7kPtgp
 b5nh2YjPUgaUqo2Z7UgQxhUyFag415/8EkISeHNcgHQuKqxqXsLIw1DKGf5UfBM1I9d4GQaVD
 atVqRYiPuhpFn/G4Q4yCIoRRnvP07DVKMHqDoJnNaboeDX4uE4ftmTok4FV/kElQ+HXUug49x
 rnIxIlp3UE5Q1eHLjQ17pzrEexlI2u4K+6uDLOJCz4oUAEkogusfv+t9Qk0QTknjrgbVlfBHZ
 jy1DO2HQeVBEaxqrFJ14iQ9X+Z9RDL2WqzvCWCP0sZTylu5Q8SoX2BNZKJGpCdZCjkfGRpAyU
 6luBP9QbkGXhewPve6qvkz5Ydn1uIQda+PNX0PvWtYt72RJc8C+BOcAo5V0/F86NzFumyuNpd
 mdoYPkrcKa2GduRSgdftN9YA9mIrncSHkpxvvjWX53AiltAXqX99fz/W+5WineyWyln7BBCyL
 SeCuyJuRREgw2/gSG/Zrp1jY1Hhz3NsqrCNzuR2lPOQ2yWfowfz32RtqE5KL6e1G0h+OCgw6a
 1t7TPFJmngV3y1zMex6TnzL1YJJozjzdrn553KU2z5E4PsltWJKuAWI4W5nEfwb1pIZWVPMx8
 6ZvlowEeAofwxcgfQMLhEstLwmdkajldjxnijXo0GJTIHB8FRVwJ4nNoUealLdj1M/z1yj4cC
 23HXxgsI0T7NZOzXqNAeCnObwXDC0t4s88BSbme36qbbFDPb6Nh9mtFbHQfrP87X4dnNuvt0B
 zUKysoXH84rmO9kAgIsIS423acjtMheZvGbRfRq/EBf8fSdV764z2Yi9ny/XZcsHKMpwGA2uI
 ohC4QohDo7H7ZRaf/7xx/c42AoFJ5L3VUm9AWHITioUKWTbesv9yxoNLkC8ZfT2g0V5/g0EqJ
 aNKtC20XDcHM3T22/vxCINOse9O7EkI1NN/Cgji54pDfcsHlFWQMHYiITIfIyH9asUxiOyEJa
 +LdTY/RjjRPfTm1/xuwJP06YIabmW1L89DUjEDbVwmtQpe/ELFJTldOimY7bZ/JXKHG/jBGwI
 SsP11vC//BEL9QuV/fLOEJwAl2ns8ZKGVgjHl9oVX/RKEu2byz0Qr3viVvV3mNWheF8c6yuLG
 Pl8qQ/PLedJUjqwEjtF4WDHO0FGojxAMSn+s3cwJWpw7S1wD+rKqRci5GOBtj6JeehySWYyMo
 SBRzxS1fu0YjZl14oPijsaZ1b57bfc4aK0JOZ//VpbIhL8j0cxnhs3c9e5S0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-442079199-1574807240=:31080
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,


On Tue, 26 Nov 2019, Andreas Schwab wrote:

> Two tests in t7812 were missing redirects, failing to actually test the
> produced output.
>
> Fixes: 8a5999838e ("grep: stess test PCRE v2 on invalid UTF-8 data")

Apart from this line which is cuddled with a real footer (but is no
footer, and the commit reference is not in the recommended format either
because it lacks the date), this patch looks fine to me.

Ciao,
Johannes

> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> ---
>  t/t7812-grep-icase-non-ascii.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-as=
cii.sh
> index 531eb59d57..c4528432e5 100755
> --- a/t/t7812-grep-icase-non-ascii.sh
> +++ b/t/t7812-grep-icase-non-ascii.sh
> @@ -70,14 +70,14 @@ test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2=
: grep ASCII from invalid UT
>  test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII fr=
om invalid UTF-8 data' '
>  	git grep -h "=C3=A6" invalid-0x80 >actual &&
>  	test_cmp expected actual &&
> -	git grep -h "(*NO_JIT)=C3=A6" invalid-0x80 &&
> +	git grep -h "(*NO_JIT)=C3=A6" invalid-0x80 >actual &&
>  	test_cmp expected actual
>  '
>
>  test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII fr=
om invalid UTF-8 data with -i' '
>  	test_might_fail git grep -hi "=C3=86" invalid-0x80 >actual &&
>  	test_cmp expected actual &&
> -	test_must_fail git grep -hi "(*NO_JIT)=C3=86" invalid-0x80 &&
> +	test_must_fail git grep -hi "(*NO_JIT)=C3=86" invalid-0x80 >actual &&
>  	test_cmp expected actual
>  '
>
> --
> 2.24.0
>
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AE=
C1
> "And now for something completely different."
>

--8323328-442079199-1574807240=:31080--
