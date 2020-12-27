Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB10C433DB
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 16:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A0B22516
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 16:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgL0QGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 11:06:36 -0500
Received: from mail2.pdinc.us ([67.90.184.28]:44692 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgL0QGf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 11:06:35 -0500
X-Greylist: delayed 1246 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Dec 2020 11:06:35 EST
Received: from lovegrove (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 0BRFj2K0030785
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 27 Dec 2020 10:45:03 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 0BRFj2K0030785
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1609083903; bh=OlRuvYErm3nkzgOrE/GGR7spLa0mDgOuIzEVX7273eU=;
        h=Reply-To:From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=nvgMSKxuk9dtKJS/mcNIT1R9hvtkmvS3daJlK0tbgVDDW/K/huh3MVefg1ClIMxYz
         tMinenfNM2PLfFJt4Od+ESJwUbZi7qVsDVHxKfG0pQcwbUUmm0Sb+qmcq3p36Mxuaz
         02TI/85NWktYHEev5TBd2BYweauZ+vJOfLaY4w6fmF+AAa++TuBa1hYj/orT4d+Q+g
         FVFpucSNT8IPuwhuOo1ehjqIoZla/Z3ExLKH0FShUacFFUekIFKoRGzffgaJJFQHRc
         Cf2u/HjT4WPEx9vSiiDtCOELT4Wg/5EXkQOtRJaRqZSrcE9reJoa+0xqxFHFvpqWxw
         uGninCy9y5Tuw==
Reply-To: <git@sfconservancy.org>, <avarab@gmail.com>,
          <christian.couder@gmail.com>, <peff@peff.net>,
          <gitster@pobox.com>, <felipe.contreras@gmail.com>,
          <git@vger.kernel.org>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Cc:     <git@sfconservancy.org>,
        "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>,
        "'Christian Couder'" <christian.couder@gmail.com>,
        "'Jeff King'" <peff@peff.net>,
        "'Junio C Hamano '" <gitster@pobox.com>,
        "'Felipe Contreras'" <felipe.contreras@gmail.com>
References: <20201223061718.102779-1-felipe.contreras@gmail.com>
In-Reply-To: <20201223061718.102779-1-felipe.contreras@gmail.com>
Subject: RE: [PATCH] CODE_OF_CONDUCT: expect tolerance, not respect
Date:   Sun, 27 Dec 2020 10:45:13 -0500
Message-ID: <0ecd01d6dc67$4463c620$cd2b5260$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJlYoIGHzEBboNr3WAXA2P+FvptaqjuBLVQ
Content-Language: en-us
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Felipe Contreras=20
> Sent: Wednesday, December 23, 2020 1:17 AM
>=20
> A lot of people confuse respect with tolerance, but they are not the
> same thing.

We respect the rules and rights that are given to the members of the git =
community.

We tolerate the output of those same members. It does not imply that we =
have to agree or even use it.

Behavior, opinions, and patches are best measured by its inherent value, =
quality, and utility.

>=20
> This was debated when Cambridge University decided to implement a
> freedom of speech policy demanding respect, which caused a huge
> backlash, not just within the university.
>=20
> As many argued; respect cannot be manufactured at will. If you don't
> respect an idea (for example that the Earth is flat), then it doesn't
> matter how hard you try; you still will not respect it.
>=20
> In that sense respect is like belief; nobody can force you to believe
> the Moon is made of cheese.
>=20
> You can pretend to believe in something, and you can pretend to
> respect something, but you really don't. Any policy that asks people =
to
> pretend is not a good policy.
>=20
> What should be asked for is tolerance.
>=20
> Tolerance simply means allowing an idea to exist, and that's what the
> Git project should ask from participants within the community.
>=20
> We don't need to pretend we respect other viewpoints, we just need to
> tolerate them.
>=20
> [1] =
https://www.theguardian.com/world/2020/dec/09/cambridge-university-reject=
s-proposal-
> it-be-respectful-of-all-views
>=20

I have been reading and following most of the posts here, at centos, and =
several other mailing lists of the past few weeks. I agree with this =
patch, as it is efficient, accurate, timely, and most useful.

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  CODE_OF_CONDUCT.md | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/CODE_OF_CONDUCT.md b/CODE_OF_CONDUCT.md
> index fc4645d5c0..3324d9f151 100644
> --- a/CODE_OF_CONDUCT.md
> +++ b/CODE_OF_CONDUCT.md
> @@ -22,7 +22,7 @@ Examples of behavior that contributes to creating a =
positive environment
>  include:
>=20
>  * Using welcoming and inclusive language
> -* Being respectful of differing viewpoints and experiences
> +* Being tolerant of differing viewpoints and experiences
>  * Gracefully accepting constructive criticism
>  * Focusing on what is best for the community
>  * Showing empathy towards other community members
> --
> 2.30.0.rc1


--
Jason Pyeron  | Architect
PD Inc        | CEO
10 w 24th St  |
Baltimore, MD |

.mil: jason.j.pyeron.ctr@mail.mil
.com: jpyeron@pdinc.us
tel : 202-741-9397



