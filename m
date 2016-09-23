Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 764CC207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 16:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758113AbcIWQex (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 12:34:53 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:36300 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754046AbcIWQew (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 12:34:52 -0400
Received: by mail-io0-f169.google.com with SMTP id m79so123974853ioo.3
        for <git@vger.kernel.org>; Fri, 23 Sep 2016 09:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2dObjhgxxVx87f28wmPfGPkeSJrqoT3/E/BCkjCU8uQ=;
        b=J4CJgh903gaSdpf1HbJWorSY2ZhP9VC9HTCRpCqYNeR3Ua3RI2EbGVVRDpDrTC1roz
         3Kiti7w2qqpcsxB30YHNp51XANVCecBwuTy0UQkc+bI0OrvXAam6HvtVhZlCsF25EUT1
         4wtVErO3S3ax1oMYUi7Q1JvqLHoyimKUCzC+E8pvx+NlJyKDS945BbJer80PQc2G2oEn
         egfthJcLXgr8+ddCVs79P4zpvQ5FZBfyYMhkl9Xblvlf2pR8tFrY2GY033aXFW8IHs4F
         RKrogCpkzZfILNbHQAZ7r6zh0xc5gAcfSW2qUENUszotFbZEcoG1XoJRTk4n7lOfSjkl
         FPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2dObjhgxxVx87f28wmPfGPkeSJrqoT3/E/BCkjCU8uQ=;
        b=OQ6Croa4LRnHl2oAxe56A4knS22qgWmWy7f2hVloexJqfqInNUwG+YEruQXjpFUKky
         OpJooe5STD6Trw24NffEye+QlUdCgAdECNTsLDKdTlW+jv2zSLQwBoaS/45FilUku23R
         7hXAo6VU6pAHFMDB9O0rTTJlhtbj6Ojj9l3pY7PVACKfaJG528iS0s07PswtBlRoWQec
         YwizbUngW1X117HlS7W3I7/Qv/OHxmYkIpF2hkabYRKBNcuiK1wcUxpOYJYMrfohpsQ7
         3T7osRtrQnY17QmmT7cQI+LhDTADQEQWfuc91jS7SJEFLNzQ8CyiV+xglstZpHA0wWjH
         Oerg==
X-Gm-Message-State: AE9vXwM5E70q+lJG6gLnl1OIQGjAV9bnc3IyaGCUERWa46703212xI1yjfuBUEZgoJuUT7ApPzScq+ki1vtEX+up
X-Received: by 10.107.201.78 with SMTP id z75mr10025294iof.202.1474648491677;
 Fri, 23 Sep 2016 09:34:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Fri, 23 Sep 2016 09:34:51 -0700 (PDT)
In-Reply-To: <CAKoko1p+M3X_y+DH+65fUDRZjkiZrKE3Z-jjq=RSjqoi7He8pw@mail.gmail.com>
References: <1474495472-94190-1-git-send-email-bmwill@google.com>
 <CAKoko1q7Mb6_cnaA1ecZJ2y1PWUrW4RSu6RiviyN91JV5-QR5g@mail.gmail.com>
 <xmqq1t0c7ur2.fsf@gitster.mtv.corp.google.com> <CAKoko1qch_odsEWba0rtCv-DWO0ABS2yprnwGPCgyT6-7H-LdQ@mail.gmail.com>
 <xmqqponw6e3x.fsf@gitster.mtv.corp.google.com> <20160922041854.7754ujcynhk7mdnh@sigill.intra.peff.net>
 <xmqq7fa36bwm.fsf@gitster.mtv.corp.google.com> <20160923034113.4rnps3nogvzxkfjx@sigill.intra.peff.net>
 <CAGZ79kZ+LTd5PuT4+Z9K6d+GQ-33E=tLY1Fokbp22uNoygaEtg@mail.gmail.com>
 <20160923060643.3ubr5gn7qczzs2ut@sigill.intra.peff.net> <CAKoko1p+M3X_y+DH+65fUDRZjkiZrKE3Z-jjq=RSjqoi7He8pw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 23 Sep 2016 09:34:51 -0700
Message-ID: <CAGZ79kYF6nYL42VQ_mbVzD+2QFLPELe9-8DOQjbSwArM20SCKA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ls-files: adding support for submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 23, 2016 at 9:16 AM, Brandon Williams <bmwill@google.com> wrote:
>> Yeah, a positive "I support this" flag would at least let us correctly
>> flag errors, which is the best we can do. That won't work for
>> non-builtins, but perhaps it is good enough in practice.
>>
>> -Peff
>
>
> So it sounds like we agree that this prefix option should be pushed to
> the top level.
> The question is have we come to a consensus on what we should be
> calling the option?

The option itself is very similar to -C, which changes the directory to the
given argument before executing the git command.
e.g. in git:

    git -C builtin ls-files
    add.c
    ...

So for the submodule case we'd want that plus keeping around that prefix,
which makes me wonder if we could just store the argument of -C into a global
and use that when --keep-prefix is given, so you'd do a

    git -C path/to/sub --keep-prefix ls-files
    path/to/sub/file1
    ...

maybe --[keep|use]-[path|prefix] ?

You could of course go with a fully independent option, but how
would that work together with -C ?
(first change the dir and then change again while remembering the prefix?
or the other way round?)

> Leave it as submodule-prefix or do we need to come up with a different name?
>
> -Brandon
