Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CA7B20A04
	for <e@80x24.org>; Mon, 17 Apr 2017 14:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753249AbdDQOdH (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 10:33:07 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:35134 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbdDQOdG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 10:33:06 -0400
Received: by mail-lf0-f41.google.com with SMTP id 75so66070953lfs.2
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 07:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pnl5bMojI8XC7aKqc+7Ts3KNoX3SbGpikECvgCizlhk=;
        b=tMr3IMhaR1YwNd3Sqg31Jq6vSxDum1RpGTS2YeMLYj6YioCqhQfrzi5TKGVkjvPZnl
         vOZTcDODvAYNNvKWEV2p64CdOzXhRucmm8DpzK/457Chl/Vad0DMhzqOhVP2YRBD7UdD
         CMiwGF3vzkMy5Qi/EdY9qn/IqC8v0B5kmOBaZH4V3tO82iwqY+ijocgAY3wGfrufYIf+
         EnFoLY1JwsvbMT16NQzdejFP4f4/CYXHhB2v6OeN1Xr4v7oFsJRy2J4mUaqwd6Ou7yXy
         1LlYh51FOtO46NJv3jDC7azTjqycZDHOlUJe/b8ZNyV6y5JnqcgKQDOYISd4N/NxcdJq
         /9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pnl5bMojI8XC7aKqc+7Ts3KNoX3SbGpikECvgCizlhk=;
        b=HkQelnvc0oGF714elVCpAX08xxX4aRqJd3MtV83sszvHZr7sry8cKfGLXb4z1Aw36p
         MODHsxxcO307IGQ5/JJu1hKXH4rBPEq4Z/xcKf2n9kEfTVcF7Gho9aawJRqxuny2LSZ1
         fzEGM1ct0z0NYaHYxRqwLYctE/R284XVefGOFIy1oyCudgDNlu8KN/JW6d+eG50AfnOU
         DguEmfSgXJh8thNxZ6KNbacaEq8GSGlVE7R8li4+30x3cyyjzul20R/25kM6GhO45D6A
         HyLFFk7jLWTrtcXtKoYWs5+ny6IArXR6+d4oijD33wGXpHZORWPNVtk2rTlFfGV32lFA
         ANcA==
X-Gm-Message-State: AN3rC/6XrViF/QaJ038sUlAM9RDk6qhkpei+z3nd545oCUTqvRmTtZTX
        rbs6GamN83CKwwJv+t45EH1nJLgTIA==
X-Received: by 10.46.13.2 with SMTP id 2mr2874941ljn.93.1492439584358; Mon, 17
 Apr 2017 07:33:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.67.78 with HTTP; Mon, 17 Apr 2017 07:33:03 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 17 Apr 2017 16:33:03 +0200
Message-ID: <CAP8UFD3G_m1q6tORDRpfqWXQwrtpx-xQTqxfj0K=xU5WdEC+uw@mail.gmail.com>
Subject: Draft of Git Rev News edition 26
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Ted Ts'o" <tytso@mit.edu>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        "Bernhard E. Reiter" <bernhard.reiter@intevation.de>,
        Werner Koch <wk@gnupg.org>,
        Peter Lebbing <peter@digitalbrains.com>,
        Christian Neukirchen <chneukirchen@gmail.com>,
        demerphq <demerphq@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-26.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/238

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Thomas, Jakub, Markus and myself plan to publish this edition on
Wednesday April 19th.

Thanks,
Christian.
