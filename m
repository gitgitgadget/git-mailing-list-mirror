Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EE8F1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 13:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbeJ0WhB (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 18:37:01 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:40663 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbeJ0WhB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 18:37:01 -0400
Received: by mail-wm1-f47.google.com with SMTP id b203-v6so3865383wme.5
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 06:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5R9EOeluNsiZCgxHtcRWgonkeVSWfQOivYuAMdxV3P0=;
        b=IlXufsw5kI8glrDRvnTJPhPcaiQxmTwWRiosFfdu1l7nuV+uRaxFDWKTCeCmq5NpV0
         iojrOGp3roEoSYrHnXuuB+iEEJqnWcMZ9tKkvg6Jnrunx9GF61E1E+AaJBlNCS90z1m0
         dWGe9WHi8TKGZKh9c9am0xvunV6quSOPFmeWcYz35IPHnNvusTdMaJIE9PkRuj5jQbbv
         IZPhnl1T1WD8a4+V/P3UjUkhMI8FaAb/AikXiBDN4PAuWolOo93kIIBJpuPc/Gutc2gM
         mXiMTTz9/slQflp2d8JW+REjjFGpZmkh9ps63/s6xJa/OnXAhcdxWVjFJikdClCUITBL
         yH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5R9EOeluNsiZCgxHtcRWgonkeVSWfQOivYuAMdxV3P0=;
        b=YMNocPLMHQhlph4/x5HYcp2dc+RUfOv1xKH2AkO153WRZBfFNwcE3SNVFCg0B9JCZ3
         YrXfcxKUQ/Layei+j2jr0fck9+DqqIkP3BhFCztifbRqzmVtECyOh9IBe/8d3gVPGEQT
         fV2XFhubXrE1pBNCHOpe7aK6oXsL863S69uu+tsQXn7o7lHJ0b2/nHPn0EdTWOUv9pva
         6HtzUQcrwcvt2nvtNmzQKsulmC4t52rr9wcmNGQJu12EWsx1q+kEy0BGJW7+BLJM7fMo
         kv6ZWfdM+ryUza7Wd/qrPzjGme4z6Nv8ecV1NHXzajUWVNGDDak2HqwoJJCcbyF9lAbF
         8NYw==
X-Gm-Message-State: AGRZ1gLM7aI67UQS/9t+tTGxFTo6GzQGakcbZGq+taUaEWbcEvIU+EZH
        dWIYGe9JGhDk8qfpb4tbFAE=
X-Google-Smtp-Source: AJdET5cXfq8F6VOB8uZqQGWNM/DvwrB30pOYD88dBYAtOyqcD1WwEKPdJJqr0W3hIRGEBXxLFxIlXA==
X-Received: by 2002:a1c:3d03:: with SMTP id k3-v6mr1636369wma.90.1540648554797;
        Sat, 27 Oct 2018 06:55:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c24-v6sm24308197wre.44.2018.10.27.06.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Oct 2018 06:55:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (Saturday, Oct 27)
References: <5db6213b-b7d0-b995-de80-9671604416a5@gmail.com>
Date:   Sat, 27 Oct 2018 22:55:50 +0900
In-Reply-To: <5db6213b-b7d0-b995-de80-9671604416a5@gmail.com> (Derrick
        Stolee's message of "Sat, 27 Oct 2018 09:27:21 -0400")
Message-ID: <xmqqsh0ra3yx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> In an effort to ensure new code is reasonably covered by the test
> suite, we now have contrib/coverage-diff.sh to combine the gcov output
> from 'make coverage-test ; make coverage-report' with the output from
> 'git diff A B' to discover _new_lines of code that are not
> covered. This report ignores lines including "BUG(".

Thanks.

> Uncovered in mater not in master@{1}
> ------------------------------------

Does this typo indicate that some part of the process to produce and
send out this report involve manual editing?

I noticed that my name appeared in this report, but I've updated the
line to BUG(), so hopefully it would disappear from it again ;-).

