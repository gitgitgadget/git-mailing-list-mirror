Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4E611F406
	for <e@80x24.org>; Thu, 14 Dec 2017 08:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750941AbdLNIrs (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 03:47:48 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:43690 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbdLNIrr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 03:47:47 -0500
Received: by mail-it0-f68.google.com with SMTP id u62so9653089ita.2
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 00:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CUJW6/cL8MVpTGmokMa1XrXnwrQB0dVJbTZfYvRjLS4=;
        b=Nq0lH6BERUIMN0F8PrTLl2AfKPL7OA54rJuCIveSiDT8rweHUCP36Bkr8yhQOSI7QI
         vNKvwB+YwyRzCnOqNXZ9knR8idlpH6NbbsbwPzjCM4+po8DhbK0/SG4Ud1VqJkmO29lG
         cfOSSuShFK5STo7uKssGCuLZJdZ32D2EC8TnQRwFmWm8wr10xNJa3nL3AzrtiJKzZ+DO
         NV7DsrDradYg9S/ek7en7gGTlRq5+HK3hb16kGcXyODGruRNOp88ST+TdA9RK7vjN+hD
         c6qBKMjOGpcBZI6Eylnuf5yh4CcUseY8F9KTgt8PVo3qWGj2HoTgnYyo3V9cFZ9mMHou
         kKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CUJW6/cL8MVpTGmokMa1XrXnwrQB0dVJbTZfYvRjLS4=;
        b=d/Uy3rIxeE7Ozvq/10qYRQsK5XMNls8F1twgZSxL3eh1vY6/WrdBzTMCUIJT6Lb4ov
         7AIPdZbSDvajUC6y3rBvCOmfVDFf0T9uRBNE+p7v7Y0wz61jTrFfTZL955uLM+2lSETI
         GF05Vf9dVMpmLGozmwrkex+SriqEEflsakTXvuc2h3cIB5DWbo9MG7ol01bZgFLrVn3v
         eWcGPgGlUyop0WI7785NUvU/kx2aTV8gx1ct0eXJsGdV9BltYi4eei5QaoBcz6+pBhCs
         QPj46/2IT8yanJcms8Por2UjbsNOCdOZE89rYhnOkAmDqDYnpsZq2xdPr5YSDPvOb9UE
         dNQQ==
X-Gm-Message-State: AKGB3mK3CxCSAIBDkPDJUrzFpRTbhzOyD1uLPbDTy3q0pVlPcQE1eekY
        8Qjk1nhtgOmUvrb1HI7Xti9fkDtnphTV8994NrM=
X-Google-Smtp-Source: ACJfBovVk/FnUCl+7z072AJNbMxzwi5mNM/lyidGHeo7mM6keSKCutD6IrZy+QwJdQ5aWJfBERe0ZmvCCfD6Ijxv2NM=
X-Received: by 10.36.192.2 with SMTP id u2mr2268472itf.119.1513241266904; Thu,
 14 Dec 2017 00:47:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Thu, 14 Dec 2017 00:47:46 -0800 (PST)
In-Reply-To: <CAPig+cSev+U9Cchyz1c4uQUsf8O4N8vVGTAsa5FiSA5mTOekxA@mail.gmail.com>
References: <20171213151344.2138-1-chriscool@tuxfamily.org>
 <20171213151344.2138-4-chriscool@tuxfamily.org> <CAPig+cSev+U9Cchyz1c4uQUsf8O4N8vVGTAsa5FiSA5mTOekxA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 14 Dec 2017 09:47:46 +0100
Message-ID: <CAP8UFD03hycHW5LSeNjkEKOLgULTPnWkAeBUJH3aL5YOp5Zr1Q@mail.gmail.com>
Subject: Re: [PATCH 3/8] perf/aggregate: implement codespeed JSON output
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 13, 2017 at 7:25 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Dec 13, 2017 at 10:13 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Codespeed (https://github.com/tobami/codespeed/) is an open source
>> project that can be used to track how some software performs over
>> time. It stores performance test results in a database and can show
>> nice graphs and charts on a web interface.
>>
>> As it can be interesting to Codespeed to see how Git performance
>> evolves over time and releases, let's implement a Codespeed output
>> in "perf/aggregate.perl".
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
>> @@ -174,6 +181,63 @@ sub print_default_results {
>> +sub print_codespeed_results {
>> +       my ($results_section) = @_;
>> +
>> +       my $project = "Git";
>> +
>> +       my $executable;
>> +       if ($results_section eq "") {
>> +               $executable = `uname -o -p`;
>
> Option -o is not recognized on MacOS and, on at least a couple of my
> Linux installations, -p returns only "unknown".
>
> A combination, on the other hand, which seems to work nicely on MacOS,
> Linux, and BSD is: uname -s -m

Ok I will take a look at this. Thanks!
