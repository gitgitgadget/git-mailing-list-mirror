Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CD871F576
	for <e@80x24.org>; Tue,  6 Mar 2018 07:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750819AbeCFHk5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 02:40:57 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43807 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbeCFHk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 02:40:56 -0500
Received: by mail-wr0-f193.google.com with SMTP id u49so19816851wrc.10
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 23:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3gwTmpPWM1U/J16OMtyiRcfV2eGGu/I8I5RBimRezHA=;
        b=p3dPK+mfAQ1w9I32zpSD8+D3F+cUZAjFa4h1j1qT1nHWWqnxeG6qI784kGtxC+mymZ
         neJLs6DsWwaDpxSDZAEI+7pjCEj+FUdA6X9L6gSfUXoaD+Z+xOfzxvd7gFmAqY0N0ZD4
         2gXACfvyhthn/BSN1yI2ahIKCNVVTr91XbrIBREdkeGXNgF3AD6k7APVwyOIH7Pi9AJs
         Oes8gHe4Z55lOVzZn83sNnNwBDvZU+3HEwc8CN98jGD4bgi8DEHy2Zgb0oyKks+xY0L4
         O3pM0BLmDOQJC6aGB+dAxYszNqg99pjtQB82EhPuUjSvNtnCHhroe6MJOyL971BXOSL6
         1o2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3gwTmpPWM1U/J16OMtyiRcfV2eGGu/I8I5RBimRezHA=;
        b=lcc7cIkv8x6Y8Cukoq+oNAXgeaC/f3+VGa8p1FdBofJ81CwF05jKg0tkkDcksF1oUE
         fqSzPfqGITdWPPORkRsq1vEuiSoNc1yQ9fpbzgNAIVxKJLYQ6viHLjMwdYQLfAatLqrt
         sEdXwF/C+mGIHr6acHr+pa1a+fFZF1s/cAdDUmwWgcPnxyCzQgA4uRx8zWBtrkx+IPCL
         B54JUn+E5s4hpdvGIoRDBmTpghbKhAxxMPsWDbcED/yEH/SCcZVW70NqheX8eL3daT8v
         z2lc/tJfALCKgWBIXkQEXW8hOfOVc/627F3Uxl4C5lERqdmwdfP7dWi4qrFsB8hdHofq
         5How==
X-Gm-Message-State: APf1xPCkS5actkL4b7l9xgNrNEEJL6pAR3rhPhvKWnvvuo2enVAKikWs
        mZjVtQSfBg1ctpxJrwFJ0He/ttT9
X-Google-Smtp-Source: AG47ELtViZeiAcwuMvZvJSA2Fk/dyh215eP3b/5n3E5+SLqPRH3rWYCPVqfHuFzHEoinkIhEJvUaNA==
X-Received: by 10.223.171.167 with SMTP id s36mr14043362wrc.52.1520322054815;
        Mon, 05 Mar 2018 23:40:54 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s78sm32704608wrc.93.2018.03.05.23.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 23:40:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] Documentation: list all type specifiers in config prose
References: <20180306021729.45813-1-me@ttaylorr.com>
        <20180306021729.45813-3-me@ttaylorr.com>
        <20180306065253.GC3522@sigill.intra.peff.net>
Date:   Mon, 05 Mar 2018 23:40:51 -0800
In-Reply-To: <20180306065253.GC3522@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 6 Mar 2018 07:52:54 +0100")
Message-ID: <xmqqd10h7it8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +The type specifier can be either `--int` or `--bool`, to make 'git config'
>> +ensure that the variable(s) are of the given type and convert the value to the
>> +canonical form (simple decimal number for int, a "true" or "false" string for
>> +bool, either of for --bool-or-int), or `--path`, which does some path expansion
>> +(see `--path` below), or `--expiry-date` (see `--expiry-date` below).  If no
>> +type specifier is passed, no checks or transformations are performed on the
>> +value.
>
> Perhaps it's time to switch to a list format for these?

A very sensible suggestion.  The original was already bad enough but
with complete set, it does become quite hard to read.  Perhaps along
the lines of...

    A type specifier option can be used to force interpretation of
    values and conversion to canonical form.  Currently supported
    type specifiers are:

    `--int`::
            The value is taken as an integer.

    `--bool`::
            The value is taken as a yes/no value, and are shown as
            "true" or "false".

    ...

