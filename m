Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 409482095B
	for <e@80x24.org>; Sun, 19 Mar 2017 06:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbdCSGqA (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 02:46:00 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:36679 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbdCSGp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 02:45:59 -0400
Received: by mail-it0-f49.google.com with SMTP id w124so60391500itb.1
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 23:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TjR//pJji1hFeaKUMlJpWMcs5GFznIKLqVPTrRXoDdA=;
        b=bZXJz5ojiCSnfGR687mIGT4DK3G5TzuyT23VeqoPMY+EVBdHDY4KSoHF2bH1kjhpUU
         MyvgQlwvFEpen7aPL1qpBy71LjBXLpqe86TSen7rgCGFWe0UYMHq9CJkEug3t8ztHDRl
         Y+1diSt8Z/ITjXpHgLKXI8lNgEJlAYUIdYzWITdnU9ouW5J7VcFYOxuryCZmfcta1r+j
         tZy/aiSbF5/x/fxDeDWzqiyGWa4QbsqDKE8rKzyFuR+ky0lLyhDMhS6Sto/hW1rh6dhp
         hmaodB06DS/Xm2d2q9NHBBISv8wnMXtpYJsnF8B94X/9mZn4fptfHOyW9AcsJfBb/grp
         cKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TjR//pJji1hFeaKUMlJpWMcs5GFznIKLqVPTrRXoDdA=;
        b=WVYGvvpNUEedAnaL6Em4lKXLXmrIvgimzkzDmOe0FFfL0rxcgU5yKtV79af0Pdd09M
         Iy56pY4Zuyp1eM2R3mjlXxwPa5ecKhnmYFC9KkKz+QFaeDNbwi822QucXEroUm/pwGRh
         dcL1V12xEhV5ruO9TIX+jF2mTHtGMtd9cFqkh9tvLPhUpEPTi5qyMjJJmITHI/M9HKym
         Oja6XkcwC6QWhUIaNgufTB5eWxZB0I0xdUeXAo2GEvmHqevim6prgoDVnDbRHFhnjpaV
         2SDhhpfMxtmf/yLScgpxspySKUETRhM+RSSPwdU/F8aMJaQd/qpbhszFkf+1k4IAPo0u
         MRVg==
X-Gm-Message-State: AFeK/H0ZTrPkUmj0EpTx4C4At8jj60dgr+njY5c7TpFFcN6/xk1cgpTpeOA9Kv8A0/w0vbtHk7g/G42AggZDxQ==
X-Received: by 10.36.90.144 with SMTP id v138mr5470601ita.24.1489905857360;
 Sat, 18 Mar 2017 23:44:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 18 Mar 2017 23:43:56 -0700 (PDT)
In-Reply-To: <0dda5b86-2f2b-8f46-98b7-476b6351442b@gmail.com>
References: <20170318103256.27141-1-avarab@gmail.com> <20170318103256.27141-2-avarab@gmail.com>
 <0dda5b86-2f2b-8f46-98b7-476b6351442b@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 19 Mar 2017 07:43:56 +0100
Message-ID: <CACBZZX4fWHKQUVjzbMXXt9vtEGyi4nAqXjf4fGKBCr3yprcu8g@mail.gmail.com>
Subject: Re: [PATCH 1/8] tag: Remove a TODO item from the test suite
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 19, 2017 at 1:48 AM, Jakub Nar=C4=99bski <jnareb@gmail.com> wro=
te:
> W dniu 18.03.2017 o 11:32, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason pisze:
>
>> @@ -136,7 +135,6 @@ test_expect_success \
>>       'listing a tag using a matching pattern should output that tag' \
>>       'test $(git tag -l mytag) =3D mytag'
>>
>> -# todo: git tag -l now returns always zero, when fixed, change this tes=
t
>>  test_expect_success \
>>       'listing tags using a non-matching pattern should suceed' \
>>       'git tag -l xxx'
>
> Could you fix s/suceed/succeed/ in the test description,
> while at it?

Sure, part of v2 now.
