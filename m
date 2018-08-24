Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37D101F404
	for <e@80x24.org>; Fri, 24 Aug 2018 20:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeHYA3H convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 24 Aug 2018 20:29:07 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42654 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbeHYA3H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 20:29:07 -0400
Received: by mail-qt0-f194.google.com with SMTP id z8-v6so11624668qto.9
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 13:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BtXMxlcvMesCz1KU4JwiJf5QPij0+wsgui0dL8FBpC4=;
        b=fT2rfa4EVjq6Mttz2dCBCmIvAjM2vJFiWtU7juXaTmyNy4Pb8OcJxbrti7XrFUuSNY
         9r5xlcbj7MSptQ2g7rvyPYTtKAXzUTyorub38h+T+aR7BIF19tYOkxcK064qblFScAhQ
         KF9mPbKKbSUQW7WtugcICJDRNYLVIOyTk2B7PC6NwVvH01SSxKIfqEOw2PLj5PRn3EZL
         94XQbqICK6AHHRfjQ4lFf2/6BNL6rhwQ+U7bR1Fk911bcAxouKPgIe1wAYeVBZKPz0wV
         mGUorqMDC2+jMee8ctoqweOdyyGSqEWFZEq3aCRqdxQlNuGbaX3yF7Qq4sFLmzGE4V+k
         0vqA==
X-Gm-Message-State: APzg51BX6CySLG+adtI9Kdio6UHlFkz6JNyhwV4qtaYQl3UAGTdzNhRG
        SUfSu1h/XDdny6QiDqcm2MbiELar77D5+RgNndF7jJKP
X-Google-Smtp-Source: ANB0Vdb+eqpkuFHlFJjrwBAWJoy/jp35wS72OpKK+10Q0Uu+ulnFBrLMo3oy5iXZ2U+5gI4IzVZKv1f2+ggPfQh2IZ8=
X-Received: by 2002:aed:24c3:: with SMTP id u3-v6mr3634642qtc.50.1535143972029;
 Fri, 24 Aug 2018 13:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAPig+cS4yeHNbc1Anq1DtLPEEGLpGeGEV74JHZrYft2wRmZAPQ@mail.gmail.com>
 <20180824152016.20286-4-avarab@gmail.com>
In-Reply-To: <20180824152016.20286-4-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 24 Aug 2018 16:52:41 -0400
Message-ID: <CAPig+cTONP22UFdHKBfef_qbzHXX9PBH4h01_0_wPF6TV9xrWg@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] tests: fix comment syntax in chainlint.sed for AIX sed
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, benoit@openbsd.org, kn@openbsd.org,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 24, 2018 at 11:20 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Change a comment in chainlint.sed to appease AIX sed, which would
> previously print this error:
>
>     sed:    # stash for later printing is not a recognized function
>
> 1. https://public-inbox.org/git/CAPig+cTTbU5HFMKgNyrxTp3+kcK46-Fn=4ZH6zDt1oQChAc3KA@mail.gmail.com/

It would have been nice for the commit message to explain that the
problem was caused by the comment being indented, since it's otherwise
not otherwise obvious to the reader without chasing the link to the
email exchange, but probably not worth a re-roll.

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

FWIW,
Acked-by: Eric Sunshine <sunshine@sunshineco.com>
