Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 536F2200B9
	for <e@80x24.org>; Tue,  8 May 2018 18:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755725AbeEHSVj (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 14:21:39 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:52903 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755685AbeEHSVf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 14:21:35 -0400
Received: by mail-wm0-f54.google.com with SMTP id w194so20242929wmf.2
        for <git@vger.kernel.org>; Tue, 08 May 2018 11:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=et/1abtXfpocRzQR6J/CgMotVrPd11XqNDeE8k49rL0=;
        b=owk9xl1tZ4vJm0dVFqg3gYhX1qMineJwo49hcpbNRKEwbbrNyDNfUyZFzuNcFWl3Mo
         diMPX/1CPtJMHUlJR7WMURJMrlPfMQLU1YeQbgd8rewy0/YJ9J1RSZyolqdDeMn2tOBB
         zDw6QG/3anPSC0bd71StxscjsmTvO7CjzNkHwsVJAeRiLKC/G9RE3Fz8PGVhoNbY8FXf
         8fQZ4iKggw/QhIxlKxiX+6ZzeMMp+HOPoynuWu4N89bPomWbi5kPwPOvUie60tLQlnzC
         AmSnUCOt7sUavRIasWAYfgb2ch73Xx/Q3lA7tnoPwQs4xtpksp/hea0mniDOcny6hHwy
         AM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=et/1abtXfpocRzQR6J/CgMotVrPd11XqNDeE8k49rL0=;
        b=E+pZCY91C217AYa+GfAP6WdXoPnkWZPl4dT2NM8xaUmNQXn9+iqZ+lCGbEgfKovNCF
         gDl4knnTP+r0qRVHp61AqWBsRxdLulWZuyKxwq7aMCU8+39bhc0fqrCfyvnliclNSYO9
         TE4cg5IsMlq18/Az50y2ZnnlQK33sKmHqh77ZnvjnYjLzjGXqpy5zpKiglxJLT7AUc1n
         U6j5B36JU68FNk7jPM4gbZDUutdVJLw3X/le485Ld/fhu+UkGrsCaWEHg8phT7iBxCJ0
         OjCrMe0taAawqEWYuilK1eGcSSRftt5jAKqO8uHtAuejIv7ETDbysHxgWVcROI61B83g
         BJNw==
X-Gm-Message-State: ALQs6tD8L0kXDQ8oE2E+t3dZkf1m6W6f+ETgKfJegM0HEFxK5+0ezNtn
        6CKOD/BNRE+xnXDU1WnDG0a101Wq
X-Google-Smtp-Source: AB8JxZo6qebav4bsuCcgYJ4XGBmDeXSKE1cAliDq7bA7t/aN09psCJKhJoMvJe7jZn9pXmPyVRP7PA==
X-Received: by 2002:a50:a4f6:: with SMTP id x51-v6mr55269378edb.247.1525803693645;
        Tue, 08 May 2018 11:21:33 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id i15-v6sm14385306edb.56.2018.05.08.11.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 May 2018 11:21:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        sandals@crustytoothpaste.net, sbeller@google.com, stolee@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH] pack-format.txt: more details on pack file format
References: <CACsJy8AkfNfupdr1MqZSaxNCbPwBVzxXNMMqPvwif0NtuCxDaA@mail.gmail.com> <20180508155627.19245-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180508155627.19245-1-pclouds@gmail.com>
Date:   Tue, 08 May 2018 20:21:31 +0200
Message-ID: <87bmdqxb2s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 08 2018, Nguyễn Thái Ngọc Duy wrote:

> The current document mentions OBJ_* constants without their actual
> values. A git developer would know these are from cache.h but that's
> not very friendly to a person who wants to read this file to implement
> a pack file parser.
>
> Similarly, the deltified representation is not documented at all (the
> "document" is basically patch-delta.c). Translate that C code in
> English.

Thanks, will drop my version from v4, although a comment for the enum in
cache.h pointing the reader to these docs would be very useful.
