Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C54C1F404
	for <e@80x24.org>; Sun, 12 Aug 2018 06:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeHLJJw (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Aug 2018 05:09:52 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33606 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeHLJJw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Aug 2018 05:09:52 -0400
Received: by mail-oi0-f49.google.com with SMTP id 8-v6so22387677oip.0
        for <git@vger.kernel.org>; Sat, 11 Aug 2018 23:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=w9V2yGruo7SS/USOBbhIu/1g9jFO8cuK3SadE/HKLeE=;
        b=sASwd5s16xCuHsn/FzQe4XUYOY8DyQBUWq0Dc6HyqjRV860A0Qe549Gew3eeWUIJ84
         VAJnb/4bt0BkkpogrsxZQE2fo6DgaFgD1udWGhq9MxvvfFI2FqLYgAaB2qhUeaM2BczJ
         BtMe+EPImjxurMYAhr3uNunKlUKwSfs4MG9ybxFetg5vtCeQaMBCpX4mR4BQU9/+A2G/
         sQGcLb0npIHkBYtfh747mQtTLU4FP4qIP92BKYqYjgbqHWrHGfYE/Y9tNTaxZPUrkdHK
         ZXpqz+B0ObHD4XmEBxfvXhmDuexq1He4gTu+YPFzv5y3UKl5IBHn514QCmMqG8+k9AAC
         Y/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=w9V2yGruo7SS/USOBbhIu/1g9jFO8cuK3SadE/HKLeE=;
        b=HDGJ+TMw4PCgd9r8psnATtqX2Bpvx4HOqAeNjDc4d+6jnAUIjma29V+XGcwBGpDu1Q
         D56ihVMzqMLHh+kWaIMw6HLp01roC5GnQiJSY35i/OTEY54JTyLkky0egxHmEzxUP+F8
         apoPoh4rUEbu1SwSHR+f6q4kJW+WxPUobm4BgkUJ6cUeQ234HA1K+cHeRkNczkT6cqVF
         zYeg6+AtQGchgh98i31FArOzM6uHX3kLGPusjp+m9yfnegjD/JKKqK5lLJKS6beox3jq
         0lQHhMmIWykihRaD/V43m96DhCGN9vREAqh4eHqwxz5VjQw/c+HZPPC0NFjolUECoUkK
         GLgQ==
X-Gm-Message-State: AOUpUlGqEnfvWLAPLYBmW/fyq8la+C7pnYukIoo6EVpylCxoGAlMhh1K
        gSorljWmpQhFKlLfPNpXjTfeZMmsZt7kbvEe44g=
X-Google-Smtp-Source: AA+uWPy/XZ/7tz+NtT7/BAPByccTRu4yJqELeU1fHQbcPhctjEiY/D05mmBDtvYW+FXCX9iGAAL5zhqFJ33FQAzsoBQ=
X-Received: by 2002:aca:f305:: with SMTP id r5-v6mr14057635oih.230.1534055578050;
 Sat, 11 Aug 2018 23:32:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:70d9:0:0:0:0:0 with HTTP; Sat, 11 Aug 2018 23:32:37
 -0700 (PDT)
In-Reply-To: <CAPig+cTca5YsXeXYbEEuq8Y_GraUYWwzdKO7r+PR9=JRTR_xFA@mail.gmail.com>
References: <CAPig+cQK7JSosa0hNhgw7xoSui2f0m6yfRLWytsg_Zow3bN5bg@mail.gmail.com>
 <20180812040620.15298-1-wchargin@gmail.com> <CAPig+cTca5YsXeXYbEEuq8Y_GraUYWwzdKO7r+PR9=JRTR_xFA@mail.gmail.com>
From:   William Chargin <wchargin@gmail.com>
Date:   Sat, 11 Aug 2018 23:32:37 -0700
Message-ID: <CAFW+GMDu-FVFXZeB=fV5a+HyGXea-UoMpZS90T9b2G_=xd3iLw@mail.gmail.com>
Subject: Re: [PATCH v3] test_dir_is_empty: properly detect files with newline
 in name
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review.

> We usually avoid "touch" unless the timestamp of the file is
> significant.

Makes sense. Will change as you suggest.

> This is an abuse of test_must_fail() which is intended strictly for
> testing 'git' invocations which might fail for reasons other than the
> expected one (for instance, git might crash).

Interesting. I didn't infer this from the docs on `test_must_fail` in
`t/test-lib-functions.sh`. Sharness, which is supposed to be independent
of Git, explicitly says to use `test_must_fail` instead of `!`.
(Admittedly, the implementations are different, but only slightly:
within Git, a Valgrind error 126 is a failure, not success.)

I also see other uses of `test_must_fail` throughout the codebase: e.g.,
with `kill`, `test`, `test_cmp`, `run_sub_test_lib_test`, etc. as the
target command. Are these invocations in error?

(I'm nevertheless happy to change this as you suggest.)

I'll make these changes locally and hold on to the patch, waiting for
others' input.

Best,
WC
