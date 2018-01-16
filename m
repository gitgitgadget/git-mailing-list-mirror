Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B80041F406
	for <e@80x24.org>; Tue, 16 Jan 2018 07:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750852AbeAPHAo (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 02:00:44 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:36437 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeAPHAn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 02:00:43 -0500
Received: by mail-qt0-f178.google.com with SMTP id a16so17078187qtj.3
        for <git@vger.kernel.org>; Mon, 15 Jan 2018 23:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rGcEYkSEomVvatEKZWjnM4sHxgGjJas7gndSWP9DmVA=;
        b=LjN3BsXVxJU8egqYIjN0MYu5B5TSB4hD/B0janduSdkDN9oEItgQnW4XbK1Aw4TIIR
         +2x04l44/A9JKAoFgNaK4s72hACFVlUASFs/9q+iCcTxWsORU1z/NFHWBoiSdhDDZsdi
         74tTHFGb708DNEqZQVx30eHhcNxMhZcK/TnXHu/oFsF8rOvK05J2LcFlbiOY/A/xisOG
         q3lmNRlm7gusWpFQmGdxyUJs+B4piv4EMdkDO11xCFfcn3TjVNAvd6QhUSMltXT7HqHy
         1jjxbN0g12cbjTj6fC45dJaYK+jaaCHwT9SVHLyU9XtDeBZbZw0+KuHa5/eVjZOCdaPc
         5EaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rGcEYkSEomVvatEKZWjnM4sHxgGjJas7gndSWP9DmVA=;
        b=oAF9yOz8GN2yOC71jMylXaA3CQEVaTflQ2CAN/FMjQPw0AZCL6Dya3bqaXJZyE1hRe
         q9RuE7xj6FfbpWcdnDpC15so6Z2TeXCb9fi18gTfRSDWmQE7e01jDZwrSEbnCYlrECF1
         2tp0eSGkRfMNqSg+50/a3Qm9Wr59JkDOyjX0YcmxNbIfbGhW7JSYVpfz+JdSDbBQsYRK
         Zg4M+fh5VMK5cuvpzhVOLnKS/xRX82O2mHN5tGZmIc95tGh6GqA45E+IduiaSd/95y0M
         FUPmo/m6YkcaVR6J931Abu4VNr+mF8mlUeg7B1db29YBbrRTpV471TN7PsOcudWnxnD2
         h8kg==
X-Gm-Message-State: AKwxytfpfHNigslvWqEeaGrktR8uzKIz1gL66hphyMSSJkuCMdrzgb+m
        yA1q7r7BQXRBgphcqEdKh/qJ1Nd+aiQbP4DGjNs=
X-Google-Smtp-Source: ACJfBov7VtMERsNqsqqmbJZlpkhdDEzaNONF4BDdwpkIWg3IdJO2YWOdo4Dwl5Z28fsHe+MEokrdNjp/fIAt6hYq9/I=
X-Received: by 10.200.64.90 with SMTP id j26mr34644812qtl.29.1516086042939;
 Mon, 15 Jan 2018 23:00:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.16.154 with HTTP; Mon, 15 Jan 2018 23:00:42 -0800 (PST)
In-Reply-To: <20180115214419.GE4778@sigill.intra.peff.net>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <01020160df6dc532-75f3ef78-26cb-4751-9ded-eb0e8d23833b-000000@eu-west-1.amazonses.com>
 <20180115214419.GE4778@sigill.intra.peff.net>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Tue, 16 Jan 2018 10:00:42 +0300
Message-ID: <CAL21Bmm0u4NgnPZMOh8PZqQ0is3inANKmCAr7MTaQHVyEOO7XQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] cat-file: move struct expand_data into ref-filter
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-01-16 0:44 GMT+03:00 Jeff King <peff@peff.net>:
> On Wed, Jan 10, 2018 at 09:36:41AM +0000, Olga Telezhnaya wrote:
>
>> Need that for further reusing of formatting logic in cat-file.
>> Have plans to get rid of using expand_data in cat-file at all,
>> and use it only in ref-filter for collecting, formatting and printing
>> needed data.
>
> I think some of these will want to remain in cat-file.c. For instance,
> split_on_whitespace is not something that ref-filter.c itself would care
> about. I'd expect in the endgame for cat-file to keep its own
> split_on_whitespace flag, and to set it based on the presence of the
> %(rest) flag, which it can check by seeing if the "rest" atom is in the
> "used_atom" list after parsing the format.
>
> -Peff

Yes, maybe we will need to leave some part of expand_data variables.
But, if it would be only "split_on_whitespace", it's better to make
just one flag without any other stuff. Actually, I thought about
moving related logic to ref-filter also. Anyway, it's hard to say
exact things before we code everything. Do I need to fix commit
message and make it more soft?

Olga
