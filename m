Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BE3D202C1
	for <e@80x24.org>; Sun, 12 Mar 2017 20:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935444AbdCLUyL (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 16:54:11 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33901 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934692AbdCLUyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 16:54:09 -0400
Received: by mail-lf0-f42.google.com with SMTP id z15so34855652lfd.1
        for <git@vger.kernel.org>; Sun, 12 Mar 2017 13:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=JvGwQiNE0qbYhx6f7FUtdxpoLkNYnqJXzZbfN71rK6s=;
        b=JcxkvAtKZvwKVzBI2imtYFQQZ9w1VTcr5btIZVzZeRlBUeAbIMvdH0bgZ73NK1Jo4J
         v9vouZD/DpbDLY1hHqLyBEJq6dobUkmbovqyFdojwm1BkO8iP3W9yd0W+vq0a1HT6JUK
         V2UikuXFu9dXKLDy2TAtb4yEs2pbR81csgcjcsqMK6pdHA5J8EYnRX6ZUZKk0xrtHQpS
         qKpPBg1yyJCbamasi4A+PQCqlBubjWpUVZTXs+PRWchPuZJsjT97FuhgfaSaLEOWkVpN
         IDUy3ojw8wICCXz8D2dxb7QFgdEi1eKPNErfwN7btheGicRq6pFxdUBswlYMUP82NkWI
         qx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JvGwQiNE0qbYhx6f7FUtdxpoLkNYnqJXzZbfN71rK6s=;
        b=PaqOkurzwrrtoqfCPkMbyGV8JQmeZdzNd4K2jGKicqABlk65Am9ij3Jcyp+gdtdp5V
         b5yySYKii5wpIqrEA9HCvyDpuTYJqRaia1pjuLlKVN35p56JiUZWv9/Q9nDeihqhVM8F
         5tv7/DbFTgfBRU4hDi/ImSGdMBLc+k3T6D6Ddfjxici6+TDzo3JA5fZkY+ok5W2leztV
         TkHEy1v6sJLzNKsaBWyn3jVv6OKU38Gh4agNlh6rVwNqJEdXi+tLEFT38izrWZmibJDE
         LSU6W4uRsyzVF3iTomnJR30h7DRWAADtrNyrALQl30oO1yL4izE8AqTauQ9KfZNamI/x
         F3Cg==
X-Gm-Message-State: AMke39k+HiplSXV/M/NqB7Sc+lSxlRUNTb5ayP8KR1aIIq2pMLTtCmW2vqNEIzLre9Zs9hk7rtBTlXbjPD+Mlg==
X-Received: by 10.25.225.216 with SMTP id l85mr7006573lfk.129.1489352047076;
 Sun, 12 Mar 2017 13:54:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.150.19 with HTTP; Sun, 12 Mar 2017 13:54:06 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 12 Mar 2017 21:54:06 +0100
Message-ID: <CAP8UFD13UBQLYZcrWfosTciFRvHpNdYVNc-TPpHoX6xPM3bzUg@mail.gmail.com>
Subject: Draft of Git Rev News edition 25
To:     git <git@vger.kernel.org>
Cc:     Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Joey Hess <id@joeyh.name>, Dan Shumow <danshu@microsoft.com>,
        Marc Stevens <marc.stevens@cwi.nl>,
        Johan Hovold <johan@kernel.org>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-25.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/231

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Thomas, Jakub, Markus and myself plan to publish this edition on
Wednesday March 15th.

Thanks,
Christian.
