Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1643202A7
	for <e@80x24.org>; Tue,  4 Jul 2017 09:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbdGDJnh (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jul 2017 05:43:37 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:33200 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751910AbdGDJnh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2017 05:43:37 -0400
Received: by mail-wr0-f176.google.com with SMTP id r103so246284105wrb.0
        for <git@vger.kernel.org>; Tue, 04 Jul 2017 02:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=AQYXyH0VMDux/aiXEKF+kh0AMndEmtd6xphLOzkrXp4=;
        b=Bey++Zs5aPTufsLfKHVgWCRNETNMjVHNEbKP+4/Deft4gneX3M0fj4gz6iT97gqOTU
         GdRLqBmbZ4Hw+KbEswMvTozhJcElQc++M71/nAt16fgnbLM81DVjqcm2u7UqzdAI6HEO
         /r3FN+4+A4oARN6oy2QPv208QXANhO0t9nDvCIoU6c5RzLClr885LC3IuANrpDoLueQO
         eQWwKz+HMK5Ys1GBThVI1LfieD2GYB4G0y40lYZdOUAD9UGvVXT6TzSnkSt9hHpBbks6
         7N+CMiCrMIM8UVAHcq/Sc3zbJAoM5gVpg3Efjk9b/NirvbDgVpBpCXOYu8M/F9Ui8yYh
         jMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=AQYXyH0VMDux/aiXEKF+kh0AMndEmtd6xphLOzkrXp4=;
        b=cdSX1cU1uPaD3D+KbaFc5V9jM5d69rqoHns7xj2/HyPMzFWhrXlqlfy8+pi6evk1hR
         Q7UjwpRZsYoSek7oqQwUN89GbA0h2GvL8oLhHIKYz9wjTxmgdml6Ev0dN+RwyLFOU4qa
         v/vlqjBlalN6qf+kJOl6pd1tlzOzzHNY4zhsr9qhHxvg5Xwc8ajwqPbk+bjmLQmzzIAZ
         9VMQuLnUSijJjMDNdC7koruUdp3i0Ey6hCA54x3MJZsnYGWMwYA0TKNMDVW8JbUxNd3W
         j1D8NqlSmJ38zg2ZgJpRTefQFTd5HgdcfWTajlCVYthvGnZKP5p0z+n4XZ2PLHdeBOod
         CVmQ==
X-Gm-Message-State: AKS2vOzi0LezBVGj76eI0V9WtfHSL+PRtHsrzMrERb0IfG18486E2ezb
        ffRNg5jvdTL2Xw==
X-Received: by 10.223.142.80 with SMTP id n74mr41148235wrb.131.1499161415578;
        Tue, 04 Jul 2017 02:43:35 -0700 (PDT)
Received: from snth (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id 24sm22057109wrw.0.2017.07.04.02.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jul 2017 02:43:34 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dSKMn-0006St-Li; Tue, 04 Jul 2017 11:43:33 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Flurries of 'git reflog expire'
References: <20170704075758.GA22249@inner.h.apk.li>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20170704075758.GA22249@inner.h.apk.li>
Date:   Tue, 04 Jul 2017 11:43:33 +0200
Message-ID: <87podgbkqi.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 04 2017, Andreas Krey jotted:

> Hi everyone,
>
> how is 'git reflog expire' triggered? We're occasionally seeing a lot
> of the running in parallel on a single of our repos (atlassian bitbucket),
> and this usually means that the machine is not very responsive for
> twenty minutes, the repo being as big as it is.

Assuming Linux, what does 'ps auxf' look like when this happens? Is the
parent a 'git gc --auto'?

> The server is still on git 2.6.2 (and bitbucket 4.14.5).

You might want to upgrade, we've had a bunch of changes since then,
maybe some of this fixes it:

    git log --reverse -p -L'/^static.*lock_repo_for/,/^}/:builtin/gc.c'

> Questions:
>
> What can be done about this? Cronjob 'git reflog expire' at midnight,
> so the heuristic don't trigger during the day? (The relnotes don't
> mention anything after 2.4.0, so I suppose a git upgrade won't help.)
>
> What is the actual cause? Bad heuristics in git itself, or does
> bitbucket run them too often (improbable)?

You can set gc.auto=0 in the repo to disable auto-gc, and play with
e.g. the reflog expire values, see the git-gc manpage.

But then you need to run your own gc, which is not a bad idea anyway
with a dedicated git server.

But it would be good to get to the bottom of this, we shouldn't be
running these concurrently.
