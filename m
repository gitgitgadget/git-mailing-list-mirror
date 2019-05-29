Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 253161F462
	for <e@80x24.org>; Wed, 29 May 2019 12:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfE2MgI (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 08:36:08 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:37833 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfE2MgI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 08:36:08 -0400
Received: by mail-ed1-f50.google.com with SMTP id w37so3568836edw.4
        for <git@vger.kernel.org>; Wed, 29 May 2019 05:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=B+UXeugrJsb6dsbCHif0Fj0uN4gqJrsJz76CUq8I/Ac=;
        b=PN3/mKFaIVOqsoifSMJGIBkcSkmjVYaqOCVTAaierCDMuXiG0whI8w6Tb8QI7gWh/n
         GH/2GoRhnKGxIuVdqmeIZnHiU72i2wdWunfqOOCsLxKWXg+Hc6bXFwnCuIkeCH0YaArW
         Y6G4TZMyLkkudeJ8T/MHUWJaM+ZAVNBqkuse6Eb4Sv4brDTVRQ0GZzUKY5qMXb+c99IO
         9AcqiSTbDEfd6ablpeIpnZQQAk9SRA2bbOQLa0ZzwL6wi9TFra7Ac07xp1L+WC/vwTWU
         BB3PmTWWHjT78Mf9KrnELzuOe9PPu1IVuYnxQ2F/L7YxwnvnroINbpNLJh//+z3W9lAa
         ARVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=B+UXeugrJsb6dsbCHif0Fj0uN4gqJrsJz76CUq8I/Ac=;
        b=KpgtfSACa6Ll3pPDpVTN5+/949vx/sPLR6z3+llOU8mMA3+CZLYkbtSgKiKMIyOuXT
         Uia6fVFZD+NhnhBOW6v2xlsQTEx5u4DMWjTCCGRB/yWIsiCoxsj+yBRn3CW5JS84rK3f
         O62EaBvzKkvHdFeLzu6L87Uycwlz/GtHpbI9s2oRsR8/Fwq9+Xm3pvinMa53Ws3OKlGP
         /YDf2ndzrxrpfQU1XxTwnc+CErNT/ew6RqFvN+1Tw4ZVB97DpdCn6q78WXTmW8aFmfqO
         st7zJqK73its7Ksg/eADKwYc8MXXhJnb5/bKm0pTPHb1MGwZt5OeFiGrXOAptMULFSDo
         T4Fg==
X-Gm-Message-State: APjAAAUNTvomo7yJ5LkdKttwd1Ty/3PHmLqYLoJROlDgXCgZxh+ANQLb
        x/Gdrbu+ZI7dKnhP6oAuwrpnNMhg
X-Google-Smtp-Source: APXvYqzbXjU8E+w7uCyCkbCLOHfdPDuOoW2CdFBn2JAOMveSnrVh7kP98xdKTf4HR21uakZHvEmTEA==
X-Received: by 2002:a50:8832:: with SMTP id b47mr19860228edb.28.1559133366210;
        Wed, 29 May 2019 05:36:06 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id h8sm2811562ejf.73.2019.05.29.05.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 05:36:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: ab/send-email-transferencoding-fix, was Re: What's cooking in git.git (May 2019, #04; Tue, 28)
References: <xmqqtvdez0yo.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1905291424140.44@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1905291424140.44@tvgsbejvaqbjf.bet>
Date:   Wed, 29 May 2019 14:36:03 +0200
Message-ID: <877ea9mo98.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 29 2019, Johannes Schindelin wrote:

> Hi Junio & =C3=86var,
>
> On Tue, 28 May 2019, Junio C Hamano wrote:
>
>> * ab/send-email-transferencoding-fix (2019-05-19) 7 commits
>>  - send-email: fix regression in sendemail.identity parsing
>>  - send-email: document --no-[to|cc|bcc]
>>  - send-email: fix broken transferEncoding tests
>>  - send-email: remove cargo-culted multi-patch pattern in tests
>>   (merged to 'next' on 2019-05-13 at 38c6a1e7e0)
>>  + send-email: do defaults -> config -> getopt in that order
>>  + send-email: rename the @bcclist variable for consistency
>>  + send-email: move the read_config() function above getopts
>>
>>  Since "git send-email" learned to take 'auto' as the value for the
>>  transfer-encoding, it by mistake stopped honoring the values given
>>  to the configuration variables sendemail.transferencoding and/or
>>  sendemail.<ident>.transferencoding.  This has been corrected to
>>  (finally) redoing the order of setting the default, reading the
>>  configuration and command line options.
>>
>>  Will merge to 'next'.
>
> I just sent a reminder that the tip commit is broken under NO_PERL, and
> accompanied the report with a diff that could be squashed in. =C3=86var, =
please
> have a look and say yay or nay, and please let's only let this enter
> `next` once it is fixed (because otherwise the Azure Pipeline will spam me
> every tim `next` is psuhed -- thanks, Emily, now I mistype this every
> single time).

Sorry about missing this. Your prereq addition in
<nycvar.QRO.7.76.6.1905291106540.44@tvgsbejvaqbjf.bet> looks obviously
correct to me.
