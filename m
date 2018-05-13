Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A6A31F406
	for <e@80x24.org>; Sun, 13 May 2018 21:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbeEMVyR (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 17:54:17 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:53291 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbeEMVyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 17:54:16 -0400
Received: by mail-it0-f51.google.com with SMTP id n64-v6so7899690itb.3
        for <git@vger.kernel.org>; Sun, 13 May 2018 14:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Wh2Hn8FSwBMm6VCEfb0l8e5bdeldh8eutHrl1aBV6AI=;
        b=pDwBx7t8H2N/WIfHAbjZvBRrWGue0bUJ3OUF3+d+keDE1wwOx3EFjp4rgw9Y+SNMjp
         fhP0fTSasLlPbdG0uds7ZGbc8d0djAWTxHrmNa8BDtYVDpBBkA3Lp+2N0ST7wJrXGjOs
         pGR+DlGweeOYgi0xhJ49WYCJTbTsKGKRrkfljmugn6LBRVTTHuJJ9HCZF8+iURc824Mc
         8UN59RMbIu2X1B0twXoghRKQU3wmsn6VQH93gkhiY7O7aesHl3EwrceFE2xKvmCRfBa6
         JWuGSfHuvHodBg8gmn7JYEcH7k2lIvhYBHB23LifE6O4mTo6ll8qzNS9dawbecAe/rgh
         9oiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Wh2Hn8FSwBMm6VCEfb0l8e5bdeldh8eutHrl1aBV6AI=;
        b=YJndVXROYLR9WTdI2lEGt5OrwTnyqEplycky8ZmzfwHDa9ejius5n+K5gRZKlCnxdh
         Vxaikz8N62HYSqlyrI/EH41gDIKuqVfi1F8paIQNvMsnzKnMyf4zDAUmv9sUUBG91wZX
         eGtsQY3fq2KDbm/6Smr3l8XO9L/4Q5mrOKWwod/2JswhBzhkS0ZsSKOXMYh6mUUs3QDQ
         nMHA5hHfhoaDUYO8HYXKkVOuq56Oo9M0zdIVaShafOvKrBRfj/NdRpzKiSObR9kQQKZQ
         Z4v64vq6JHkWFcl/inkBxbnsPTJaEyD0NXC7UriWA3Q7KN0Nk7UoIzXiKoTPhx+dOa1I
         ZbTw==
X-Gm-Message-State: ALKqPweNeSkGMou/Ne+jmIS7iTeX82TPgJWkdEhs0+cmd3E/D7pb7MWH
        BA3aFP98ZvleUck2aXF1U1CohbTORLh5YQQfW//YoPg1
X-Google-Smtp-Source: AB8JxZqF9meV4E6TQItQ84sxTWNRJzdp099rGsBBcNnqS2GP1R3+5s6NRBbjWKUHRjFNn40zSYjznuvVt5yT4Ad3CZE=
X-Received: by 2002:a24:f00c:: with SMTP id s12-v6mr6510547ith.129.1526248455383;
 Sun, 13 May 2018 14:54:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22db:0:0:0:0:0 with HTTP; Sun, 13 May 2018 14:54:14
 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 13 May 2018 23:54:14 +0200
Message-ID: <CAP8UFD1-kWv+Pp7YQUWgmscTxQD=N4Xd4BbKnnKHD85LR8A2ew@mail.gmail.com>
Subject: Draft of Git Rev News edition 39
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Paul Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Ed Thomson <ethomson@edwardthomson.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Stefan Haller <lists@haller-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-39.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/290

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Gabriel and me plan to publish this edition on
Wednesday May 16th.

Thanks,
Christian.
