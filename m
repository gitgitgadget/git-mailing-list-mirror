Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4CB62047F
	for <e@80x24.org>; Sat, 23 Sep 2017 09:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750847AbdIWJye (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 05:54:34 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:44900 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbdIWJyc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 05:54:32 -0400
Received: by mail-pf0-f170.google.com with SMTP id e1so1655232pfk.1
        for <git@vger.kernel.org>; Sat, 23 Sep 2017 02:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Trpv80I72SANPvrAP2IOSKorHOtodXBEOw2JlJMpBPg=;
        b=AL5krRERMcLVT/WE78OTIyZCWbm/0rlTsygrYXw73R13SbkD/AQn9vq5i1cJqchXI2
         TebnTNdF19QqyzO9rVFy3ZZgdtMA7mXr2r7u8+aqjOvj4jQPhUo9CHjSIPMt97YLNlz4
         ujELvPwJxbCViS6PUZnqFf330tuMmdqHCjyWsd6FrXvJvcfuyCsGirLpIOqFTl6Evcvm
         1u2GPLZt+F6p+PEAYJKQAYlcL+F0PT6fZC/gqQdbwks34faYK1hQcqlHPL6ncrHTYCQA
         6vi0sx3UR/BBn7qNst74AwkR4YlKqDaisE4z+4uYD2Gf8DqHV4NpUnB/UFN6ih0tXljB
         TrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Trpv80I72SANPvrAP2IOSKorHOtodXBEOw2JlJMpBPg=;
        b=gXFp6Cs9Vm9wqGBrqt/5LRBjGzzPXL2Gm4ZILfFz3z9366CPI4OeMEAkeq9s5qG8ae
         Kly5KUxzZ+msr5zO+2aouRI79J1/WvaOz5LBVBNQ2M3gb2ROYWaXcHtg/qu4kuChtboO
         BbMTsEuNL3waLCypLtivTsTYfT76sg4Bbpj1DM1mtc8N8++Xpij71x1Ssh96vrCPrR2g
         nI0InDkc3TOuqyjvOQiJlBGDsu3StLcykDSaK2GMNxGd0DwZocyJKk7UnmsfN6ls+9TI
         TskBGTDJIkUoAr+DExyURSssuww2c+KTKRYUQkdaJUkc24dLk3lamHq/3klAlW4E56GU
         Xu3A==
X-Gm-Message-State: AHPjjUheWJ/pJL8q9eiKDxUOT9PqVjlaFBflqu3wl7swO0GvxKhhPTci
        nsg73bZSZrTtQ4YWdj7Ozd/y4oQj16Ws+ThgE61gdHRO
X-Google-Smtp-Source: AOwi7QBNwRMwoVujvptTSJLG976khGRnhsY21XRN7rxbhkVt25iQJ8lAdsZOyq7N7TTCG7HWJu4oOM7YLLp5wSzb4Gk=
X-Received: by 10.99.98.70 with SMTP id w67mr1780528pgb.362.1506160472170;
 Sat, 23 Sep 2017 02:54:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.142.137 with HTTP; Sat, 23 Sep 2017 02:54:31 -0700 (PDT)
In-Reply-To: <20170923043701.4s3xuytp5hdjwmsy@sigill.intra.peff.net>
References: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net>
 <cover.1506120291.git.martin.agren@gmail.com> <20170923043701.4s3xuytp5hdjwmsy@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 23 Sep 2017 11:54:31 +0200
Message-ID: <CAN0heSrPBDi4q9fqr=qoTbjRHpFS_VEL0O8=MFFJ4DLCuJwahA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] reroll ma/plugleaks; more `object_array`-fixes
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23 September 2017 at 06:37, Jeff King <peff@peff.net> wrote:
> On Sat, Sep 23, 2017 at 01:34:48AM +0200, Martin =C3=85gren wrote:
>
>> Martin =C3=85gren (6):
>>   builtin/commit: fix memory leak in `prepare_index()`
>>   commit: fix memory leak in `reduce_heads()`
>>   leak_pending: use `object_array_clear()`, not `free()`
>>   object_array: use `object_array_clear()`, not `free()`
>>   object_array: add and use `object_array_pop()`
>>   pack-bitmap[-write]: use `object_array_clear()`, don't leak
>
> All six look good to me. Thanks again for poking into this. I'm afraid
> to ask how far we have left to go on running the test suite all the way
> through with leak-checking turned on. :)

Thanks for reviewing.

Unfortunately, I have not figured out how to get LSan to simply report
the leaks and continue. Its default behavior is to abort if there are
leaks. That's useful for finding the first leaking test, but not much
else. (Later tests might depend on that test doing everything it should,
so now those later tests will start failing and/or executing different
code paths.)

I can tell LeakSanitizer to exit with an exit code instead, but then all
leaking git-processes exit with the same exit code. That also interferes
with the tests.

What I would like is for the git-process to exit with the same exit
status it would have had without the leak-checking. That would make it
possible to run the whole test suite, collect all leaks, identify
duplicates, sort them, categorize them, prioritize them, track how we
are progressing...

I did spend some time looking into this before I gave up. I'd love to be
told I've missed something obvious.

Martin
