Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A6FB1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 05:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750929AbeDYFGH (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 01:06:07 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41469 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeDYFGG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 01:06:06 -0400
Received: by mail-pf0-f193.google.com with SMTP id v63so4583799pfk.8
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 22:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ZnUTjgFx6JdtRiPEVmhdYtzdrVqzG1ehUdqqXmfsJOs=;
        b=jRFSeWKz7Gb2SGpJ9v/4aottcav6EWqVvg287BzZJIud5EQYLVKixs3jAljxX2UsCd
         1PN0yU8Xch8ICuqcNv+Em98n2sDB61bsUBqU4NtF5rxIfIAR2QNtSBSULJ6KIN2TYT1z
         /uPx3cGm9ickpUjaI2nbGyA91FgABnwHQorHMoOgQJYmCkXi8rnd6lfhuytzd+rgEIjS
         EPEONetSplw8G9QYv4U5dHg5wgBHbmGI8JAxj0CRX2gXWztfspGuAYfKT1wx7Q3uPzZ9
         txrQzJkJUgJx4rtN+z0EIifMHLVsV7Uqo8VAKGfgHG0Y+Aur8V9tu8Snz3ziOVKsZBDN
         Fv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=ZnUTjgFx6JdtRiPEVmhdYtzdrVqzG1ehUdqqXmfsJOs=;
        b=KFuweO9YM0lEVsuHTh30M/MycxoeeY7Q30YgY9Db/fEoppMUO+eELn9dzY7dgdJ2Qf
         3SQ0ZrGzvTAqP4xWzZaOD/5SY2C44ZGXj9bF6W1/9ITByOT+JTyC9+zDt5h7cPuxlNTp
         dZYOVtiDYrHMOXjOUXbx13zQhHKEM4rWKSTdXhe5dVMVhNpQM/C7VlOkVR0CNZQIiJ6p
         ZZF1/lGDolUH0nLyOkMUfgNZ2gNBf2HvfXJXFfif7jaYItm9fJ20qisCp7J/vjaPAxZ2
         NycJmCnSHifv/YP9l+oec1sfOBf0cDf9SB3zPq5hm/fiCXnS2Wcayay6MPNMDc92s+cF
         6p+A==
X-Gm-Message-State: ALQs6tAnZ04mCU0MOqxuekdYH9SlSovalNDmv3NxJrA4ZEW7j8Vl5cri
        QvB50+MoeeUlrdtUBp6zx5iFUu+DjfvSeAjXOd8=
X-Google-Smtp-Source: AIpwx4/FrQco+Zu9uLYR3lWPMdjO5ySqkPjUalRin5AR7Eo6f+2WLV+HkzUARU2C/55QvwctdKQmHsn6Fm9dPsqf1Nw=
X-Received: by 10.98.80.80 with SMTP id e77mr26858872pfb.16.1524632765701;
 Tue, 24 Apr 2018 22:06:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.150.4 with HTTP; Tue, 24 Apr 2018 22:06:04 -0700 (PDT)
In-Reply-To: <20180425020013.GF245996@genre.crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <20180423233951.276447-26-sandals@crustytoothpaste.net> <CAN0heSoU4wDAcfF_EGYSA4gjbpCgTyk0fGPsmPTwv65FfZCQcg@mail.gmail.com>
 <20180425020013.GF245996@genre.crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 25 Apr 2018 07:06:04 +0200
Message-ID: <CAN0heSotp4ebXWc6NRHOa2j7kQg4XsCo+8RNz786dPGyUTvb-w@mail.gmail.com>
Subject: Re: [PATCH 25/41] builtin/receive-pack: avoid hard-coded constants
 for push certs
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25 April 2018 at 04:00, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Tue, Apr 24, 2018 at 11:58:17AM +0200, Martin =C3=85gren wrote:
>> On 24 April 2018 at 01:39, brian m. carlson
>> > diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> > index c4272fbc96..5f35596c14 100644
>> > --- a/builtin/receive-pack.c
>> > +++ b/builtin/receive-pack.c
>> > @@ -454,21 +454,21 @@ static void hmac_sha1(unsigned char *out,
>> >         /* RFC 2104 2. (6) & (7) */
>> >         git_SHA1_Init(&ctx);
>> >         git_SHA1_Update(&ctx, k_opad, sizeof(k_opad));
>> > -       git_SHA1_Update(&ctx, out, 20);
>> > +       git_SHA1_Update(&ctx, out, GIT_SHA1_RAWSZ);
>> >         git_SHA1_Final(out, &ctx);
>> >  }
>>
>> Since we do HMAC with SHA-1, we use the functions `git_SHA1_foo()`. Ok.
>> But then why not just use "20"? Isn't GIT_SHA1_RAWSZ coupled to the
>> whole hash transition thing? This use of "20" is not, IMHO, the "length
>> in bytes [...] of an object name" (quoting cache.h).
>
> Originally, GIT_SHA1_RAWSZ was a good stand-in for the hard-coded uses
> of 20 (and GIT_SHA1_HEXSZ for 40) for object IDs.  Recently, we've
> started moving toward using the_hash_algo for the object ID-specific
> hash values, so I've started using those constants only to identify
> SHA-1 specific items.
>
> In this case, using the constant makes it more obvious that what we're
> passing is indeed an SHA-1 hash.  It also makes it easier to find all
> the remaining instances of "20" in the codebase and analyze them
> accordingly.
>
> I agree that this isn't an object name strictly, but it's essentially
> equivalent.  If you feel strongly, I can leave this the way it is.

I see. So one could say that in the ideal end-game, GIT_SHA1_RAWSZ would
be gone when the oid-hash-transition is over. Except since we also use
SHA-1 for other stuff than object IDs, the real-world ideal end-game is
that we only have a few users lingering in places that have nothing to
do with oid, but only with SHA-1 (and maybe in the gluing for
calculating SHA-1 oids..).

I do not feel strongly about this. I was just surprised to see it.
Thank you for explaining this.

Martin
