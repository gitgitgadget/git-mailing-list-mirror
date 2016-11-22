Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC04A1FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 15:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755409AbcKVPLd (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 10:11:33 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33409 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753170AbcKVPLc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 10:11:32 -0500
Received: by mail-qk0-f195.google.com with SMTP id x190so4522759qkb.0
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 07:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hU3TwynnO1rnMJLfPq2x8Dr/lejQ6UC7CVsQGhAK+nQ=;
        b=jTcv0nYU3UVAZSrXBPrUCmd68Ag71mSFU6hjq4CvPmY1gwOHQs1rTBZ660XGjhntv8
         o9vVLYhBxt5k1NU2R921WrBTJzFelMT5OFQTUmtK4EkBAy7aFDO5gBzDQsMp6AuT1k8q
         Qmu6bD9XGOR5iOTUJ1r2SnKdLaN5aUzFkFB9wQ7T1+v5m9EldF0ANyKuuuhyLNkqAzab
         vFBdI37Eh9e/ox7eavDIIYmp/IT3K8g8shqlWtLn1Uiktbyta9IMFXfK4OpivoSFbik9
         9II/ZCCg2HifUcd1o2qkObV8Bl8LRNqtU/ICazKwxXnxy8adONL1AovEl24viWFO/jji
         EMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hU3TwynnO1rnMJLfPq2x8Dr/lejQ6UC7CVsQGhAK+nQ=;
        b=S8tWPH3gmVQFk6i31SMcJeQJ/MYgs0rHXKt4YxM5KlEgNzXkkF6ZpzuSq0z2WdLmKY
         /73K9FZ+2huqFtFaTyStyaWr++DStngeBuuTXs8nx5pYBtLkquaJFCquk89OZwg0bq53
         TQdGDJzU4HVvzHFSYTGFEauJUCK5VHUjohoaZtSsk0VTRswCo7wZL9Hrld0UwYq7xvyQ
         5rLIcqX7E2lttbm567wz4Ja0pg6sfPKAj88LQR8ts/h5tT+FF3fqfhkyLwCBeOunc5nw
         ekR5T5/2ETpIGGROqYna7SP1/xiuFPyaMhBSmXyHtCgNHTT5dKR6PLR1Ay+PPgi/cFMm
         Yegg==
X-Gm-Message-State: AKaTC01/TR2jH7vG9HuuvynuWSgOndGku/Nw3qz2YxeeDNcY56lGm3jaCn9mDuxWaBvpf5axHN3u7ubl6Ag/HA==
X-Received: by 10.55.68.80 with SMTP id r77mr24967179qka.318.1479827492067;
 Tue, 22 Nov 2016 07:11:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.129.65 with HTTP; Tue, 22 Nov 2016 07:11:31 -0800 (PST)
In-Reply-To: <CANYiYbGtfZKshmfYxHM0sL2Z67=3KTF0kixP1OjumRw87e9XkA@mail.gmail.com>
References: <CANYiYbGtfZKshmfYxHM0sL2Z67=3KTF0kixP1OjumRw87e9XkA@mail.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 22 Nov 2016 23:11:31 +0800
Message-ID: <CANYiYbFSpUmtv1eO_GE_yRU4CsXzd29qV2LTbXa67d=Uxbw2=Q@mail.gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.11.0 round 2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git 2.11.0-rc2 introduced a very small l10n update.  Because the
update windows will be
closed tomorrow, I made a batch updates. See commit:

* https://github.com/git-l10n/git-po/commit/275588f93

I have a reduced diff for this commit using a custom diff driver, see:

* https://gist.github.com/jiangxin/6384b1e865249228e00385fab84ef3f3


2016-11-22 22:59 GMT+08:00 Jiang Xin <worldhello.net@gmail.com>:
> Hi Junio,
>
> The following changes since commit 1310affe024fba407bff55dbe65cd6d670c8a32d:
>
>   Git 2.11-rc2 (2016-11-17 13:47:36 -0800)
>
> are available in the git repository at:
>
>   git://github.com/git-l10n/git-po tags/l10n-2.11.0-rnd2

--
Jiang Xin
