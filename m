Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 369691F45F
	for <e@80x24.org>; Wed,  8 May 2019 22:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfEHW2C (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 18:28:02 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:33381 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbfEHW2C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 18:28:02 -0400
Received: by mail-ed1-f51.google.com with SMTP id n17so277830edb.0
        for <git@vger.kernel.org>; Wed, 08 May 2019 15:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=F5kcTj3PgwpgCuTX3WQY1l13R0Dzw+MH21XLUCbvA5Y=;
        b=B+wDgo6e9y0o9TCbMemwMnZnGF/wH5OEkSuuuB+YEzZJGLEz+OPNr+VioP5bUYJuv8
         DVlUK63ZgyIRYqkLWCmeGxC4emsnIEjsefZpSd8w4N/IH5AUWkbisOqNWkS/2l/4B8B9
         5MiKJzkWVcXpVunRvKEp/OCYrZnGRQNONlgOVHsZMdwaiYGWQb43CaJOQpQb25ItZdYt
         0Pmqoiyh/7Tyxmpa1fc/UfPDdSpoJf5CYFlzJBcRPBMoBUgKzZk3uNJt0nvW8U5tTveE
         HQpaooS+znKsNokYFX4D4iH6Bnk8EOhynGCp/dctklJNLh8wlNIeHGUuWhV05ASJS7o8
         rExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=F5kcTj3PgwpgCuTX3WQY1l13R0Dzw+MH21XLUCbvA5Y=;
        b=mr6bVqcwDdaGq1uV4wCbny4PWkdXppUysxCnfA2JKJ3uyp2GNkJ6spImZ5F2SDC8w4
         h6djnsGU1YUX8VP/7uBLpchHqIAb8FVm3scQc5DjESQX56wk+GSuCTHh3fbO9BC/iYFN
         kSQqU1Dwk9y7xJpxwYxzIL2b54X+TuWXCZv5afK40f0zZXq6sy7WKSchIqBekVDxEDAG
         eFZLnJlqzAEaEkqtayBEh926FY00U/TU/lHnYmS0FDZvCYqk9Q3cP4bzEpALfX2rUwVZ
         YvDTNpKgvpoOWZ/EzXOWrICoWh+6AedAfSL1x09T261Gic17TpMdc7VGaOo//7JKII72
         pQpQ==
X-Gm-Message-State: APjAAAUi0L6DAkvotYTYYDuy7AfI+8bR5oC48gT9M8YmBmESUVUtEZKc
        aNYaeQQi6R381UTCx9ekzu4=
X-Google-Smtp-Source: APXvYqx+8Moh9J9/vXxNGhcGAjVoqebiR44PmiExeJw51rTQXcxKxWp1FT9++uXb8o0iMbocVJHuCA==
X-Received: by 2002:a50:ea82:: with SMTP id d2mr206491edo.246.1557354480533;
        Wed, 08 May 2019 15:28:00 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id o47sm71081edc.37.2019.05.08.15.27.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 15:27:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeffrey Walton <noloader@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: Git build on antique PowerMac
References: <CAH8yC8nTyq5Fjc-6fUNn1iwkCO9i1Vrc0vFqxEVg4Eor3h-0Lw@mail.gmail.com> <CAPig+cSzsmeHp1S5WG3TVXEyZKt9eVrsCsWEkpwbNUZK_SJ53g@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAPig+cSzsmeHp1S5WG3TVXEyZKt9eVrsCsWEkpwbNUZK_SJ53g@mail.gmail.com>
Date:   Thu, 09 May 2019 00:27:56 +0200
Message-ID: <87mujwh98z.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, May 05 2019, Eric Sunshine wrote:

> On Sun, May 5, 2019 at 3:43 PM Jeffrey Walton <noloader@gmail.com> wrote:
>> I have a PowerMac I use for testing. [...]
>> make -C t/ all
>> readline() on unopened filehandle       test_must_fail
>> run_sub_test_lib_test  at check-non-portable-shell.pl line 34.
>> Modification of a read-only value attempted at
>> check-non-portable-shell.pl line 34.
>> make[1]: *** [test-lint-shell-syntax] Error 255
>>
>> Does anyone want to take a shot at this antique system? I can provide
>> SSH access with root.
>
> As the author of the code triggering that problem, I can take a look
> at it. (You already have my public SSH key on your Solaris box.)
>
> Given [1], I can see (I guess) why it's complaining about modification
> of a read-only variable. However, the unopened filehandle complaint
> looks odd.
>
> [1]: https://www.perlmonks.org/?node_id=570712#default_unlocalized

It's because "while (<>) { readline }" didn't use to be supported until
5.10, and he's on 5.8.

    $ seq 1 4 | ./miniperl -we 'print $]; while (<>) { chomp; print "$.: $_ -> " . readline }; print "\n"'
    readline() on unopened filehandle 1: 1 ->  at -e line 1.
    Use of uninitialized value in concatenation (.) or string at -e line 1.
    readline() on unopened filehandle 2: 2 ->  at -e line 1.
    readline() on unopened filehandle 3: 3 ->  at -e line 1.
    readline() on unopened filehandle 4: 4 ->  at -e line 1.
    5.009004
    $ seq 1 4 | perl -we 'print $]; while (<>) { chomp; print "$.: $_ -> " . readline }; print "\n"'
    5.0280011: 1 -> 2
    3: 3 -> 4
