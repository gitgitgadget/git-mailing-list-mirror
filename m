Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 650B41FAE2
	for <e@80x24.org>; Tue,  3 Apr 2018 19:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753310AbeDCT4D (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 15:56:03 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36254 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752525AbeDCT4C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 15:56:02 -0400
Received: by mail-wm0-f43.google.com with SMTP id x82so37443387wmg.1
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 12:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vDODhh90cVCOAjwxC/uSenqDWqW2zPiLAO7vgW1o62M=;
        b=S4MVEmlKfEn1s+sRHJ0qrkLOc2NbHLsp0TE+JbzFjAtn82eXstERdtnJdLxyQk1FZC
         TBffj077WribL1/SK4vbzkNqDIWx5XQlV5eRN6SF0DiwuQTmrtvqZUoYdsJGTNXbte99
         ISnapAphs732x31jDTtpNOqwzZFDkfIMxYh6PIBU98JhDLFd33r05KUKfOyao3p6Y/qe
         T+cDk4UttBpjwwY1HDkCcUZkIJn55iyq/DNZiItU/wxXqteH61JZ0oP4EMiL0YJQcq/S
         zneySrYOhjs7RuOHN+jV1og1ZMjlthh0XWzSTlTtHXEJvWQ/RvNi7sf+x08IhcCbGXqm
         1FCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vDODhh90cVCOAjwxC/uSenqDWqW2zPiLAO7vgW1o62M=;
        b=IBSJb3Yt4KLptdhRSr2lyjgG6X7JcJdPrrm7gw9elb+BWwWaqy5OKQBJ70NH0U7jq8
         4LF/50EVc5utrdike42cC5n9d7A4JapoiUuedwRGIi+W2ACQ+f+FmW/bnN6g/BMqp66h
         KAHVzZrH+/vdQFP1cMRdNy7guR29I2meXDd+qUkGAb6qD+iSmmU2pjEjbdpFxj/I+S6c
         qe1XrRCdhEbgvVSqYa7aosbi0dDXNrXK3hJi5Wyug+BjE6TlJQFYsNWttq+OAoAfjiCl
         taYU3eiAIKT+wvo8AD5IGG4dfWcS/jK1Hh6eQGe7JsKDTCZKmdrnysC5cYYh6Pq1DAAr
         j5pA==
X-Gm-Message-State: AElRT7FtnkrsUx8b/pNfW+TxXbRs0ahke03pf/Z20tI7hpZvhZY7pq5C
        DDUZgbWwpJwpfIoovXBwtWs8URbRoxScbEecVh3IrA==
X-Google-Smtp-Source: AIpwx49168IbInBtyT93mxqtWTTXcQvfi7PmLs6iRa9e0MrGpnRSzSj58LBZjXijZtBeXkKmgw4dSP8J8HUysw6r6XA=
X-Received: by 10.80.136.7 with SMTP id b7mr17777718edb.236.1522785361433;
 Tue, 03 Apr 2018 12:56:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.201.196 with HTTP; Tue, 3 Apr 2018 12:55:40 -0700 (PDT)
In-Reply-To: <CAGZ79kZ-k7Ho-_Cg3OLLypfjoEn8pTDN7dWpX0=8o+o2BvUcqA@mail.gmail.com>
References: <20180402224854.86922-1-sbeller@google.com> <20180402164742.11d4c5507d6ee737c9935d73@google.com>
 <CA+P7+xpDfKSvQZ+YktsSSBPTc3JXzc9dR36tohLctfDf04iaOg@mail.gmail.com> <CAGZ79kZ-k7Ho-_Cg3OLLypfjoEn8pTDN7dWpX0=8o+o2BvUcqA@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 3 Apr 2018 12:55:40 -0700
Message-ID: <CA+P7+xpiTL4jpjFjxu-wStiGado60P2jkBs0XrhkRXfzVp6UqQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Moved code detection: ignore space on uniform indentation
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Simon Ruderich <simon@ruderich.org>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 3, 2018 at 12:00 PM, Stefan Beller <sbeller@google.com> wrote:
>>>> The fun is in the last patch, which allows white space sensitive
>>>> languages to trust the move detection, too. Each block that is marked as
>>>> moved will have the same delta in {in-, de-}dentation.
>>>> I would think this mode might be a reasonable default eventually.
>>>
>>> This sounds like a good idea. "Trust" is probably too strong a word, but
>>> I can see this being useful even in non-whitespace-sensitive languages
>>> with nested blocks (like C).
>>
>> The ability to detect moved code despite whitespace changes would be
>> good, even while showing diffs with the whitespace intact.
>
> That is what the last patch is about.

Right. I was trying to say "I agree with the goal, even if we don't
necessarily allow every possible white-space + color-moved lines
combination" (i.e. to avoid polluting the option space too much)

Thanks,
Jake
