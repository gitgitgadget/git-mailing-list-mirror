Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7870F1FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 07:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933268AbeAJH4E (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 02:56:04 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:40940 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754199AbeAJH4D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 02:56:03 -0500
Received: by mail-wm0-f46.google.com with SMTP id f206so25109797wmf.5
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 23:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=OdZS/X4PhimwFhTqK1K7T/+mNIrt2sXt/HjYKMubWVw=;
        b=H5Ttpf7Gs8NTT4kcKf1qDdUsPXhbjv3oOthPulMSoHBu1MvLi8Yf77BlEMz8jijEiJ
         HCxRlNEvuPhzJ/wBPeVdaUaLbl5JfmhbERKQ5otI/oBn4fUa7Adlqrh1AHJ6Uerzorhx
         DDsw7VA8ojx7Hx4bmKmjFLq3T4U7WIrAeUf8MF/6s2tA5YzPXDoWFwOGAQ3yJjidyXH+
         HZJ8+pCGkjQ6lD1v99gh2YWFia9o6AkOkgr4X9E1+Vsf+70NpaGdcOTSUjYl1ynDhvCM
         L4lsu20v2GZrGTB6RKhe67aHe1FnLCbMXgA7q2zT2ot/HM4nUBQ6889PYNGdb5SuV6kH
         enqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=OdZS/X4PhimwFhTqK1K7T/+mNIrt2sXt/HjYKMubWVw=;
        b=dYoiK28Rzl2xP77mLJ2vF8f7sHbii6WF4a+xywLF0vmkyxDJAze5DGMUHN0IOVaDCR
         GLwq/D6f6ACNhmoqp4Ivl2Mx6TdEQPWIr9adiq6d4izdx5dTeb4+aRGpVRB7FyKaGEiW
         C7w8SAzKBlfNnxvnJQNL5oP1TgCMKWWP4J0MM+IsdoQgcjvSaSN6CX9mbyD5WQT+RXV1
         U4mUKGN76lV9PKdoAarX0SBqSkAHewvv7Gj8rc6GFxQFBDY9+hfUXPXyVNm3rG+aHlNv
         liLgwwrPe+0/eddrbfIu6HVYKAI8Iq+toIWQiA/ZVBSZR+B1auMRmxicC3leLvCo9E25
         Dfyw==
X-Gm-Message-State: AKwxytdG8BIND2fbmXrvkAJ2q/K/tewesKKoPzXjjLlchrH1X97qqX03
        W8Lt8Xr1MtYXeXhCX0rZVi8kYzRp
X-Google-Smtp-Source: ACJfBovScpXYVqJ0XRyWXKcOf21MBT1EU8baFlM49JVe6h6E41YjNPdknpVv3gjLkD1RLdwizFufGA==
X-Received: by 10.28.139.77 with SMTP id n74mr567686wmd.123.1515570961912;
        Tue, 09 Jan 2018 23:56:01 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id r4sm3704598wre.95.2018.01.09.23.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Jan 2018 23:56:01 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2018, #02; Tue, 9)
References: <xmqqa7xm38wc.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqa7xm38wc.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 10 Jan 2018 08:56:00 +0100
Message-ID: <87vaga9mgf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 09 2018, Junio C. Hamano jotted:

> * ab/wildmatch-tests (2018-01-04) 7 commits
>   (merged to 'next' on 2018-01-09 at 09f0b84098)
>  + wildmatch test: create & test files on disk in addition to in-memory
>  + wildmatch test: perform all tests under all wildmatch() modes
>  + wildmatch test: remove dead fnmatch() test code
>  + wildmatch test: use a paranoia pattern from nul_match()
>  + wildmatch test: don't try to vertically align our output
>  + wildmatch test: use more standard shell style
>  + wildmatch test: indent with tabs, not spaces
>
>  More tests for wildmatch functions.
>
>  Will cook in 'next'.

Please don't merge it down for now. I've got a WIP resubmission of this
which rewrites most of the later part of the series & addresses various
issues raised.

> * ab/perf-grep-threads (2018-01-04) 1 commit
>   (merged to 'next' on 2018-01-09 at 8fe1d71894)
>  + perf: amend the grep tests to test grep.threads
>
>  More perf tests for threaded grep
>
>  Will cook in 'next'.

Re: the concern raised in xmqqa7xsaqki.fsf@gitster.mtv.corp.google.com I
think it makes sense to just document (and I can do that if you agree)
that:

    test_expect_success SOME_PREREQ,$SOME_OTHER_PREREQ,$ANOTHER_ONE [...]

Will work as far as prereqs goes even though the variables might be
empty. It's much less verbose than the proposed alternative, and easy to
support.

>  Will [cook in|merge to] 'next'.

Refresh my memory, that means merge down post-2.16.0 at this point,
right?
