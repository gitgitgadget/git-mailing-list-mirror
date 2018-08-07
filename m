Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82E5F208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 06:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbeHGIer (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 04:34:47 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:40036 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeHGIer (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 04:34:47 -0400
Received: by mail-wr1-f53.google.com with SMTP id h15-v6so14518383wrs.7
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 23:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=fHUuxuyHb+j+wYxzUh6gkuxvKGBRENrqi9uV996hRNU=;
        b=Hm8kWDRRrbVsjGm3q80h8e75vUO+GllOUg1at1SrJGRfvrk1cJBKJinJ9n8I7qlVpz
         vUPJF8P5mBUJfc5on40iF9paLR9jT9Oe4YT+QXXEIMie5XY4QQU+NNB0EqfpApO38q4a
         1dQ41PsfPDyNQa9qKRp/ULsqm1NC5B7HzAPfmLQekGorc5v7SkpGXQkD+urDb0IYqXIF
         iPdqtDurqL3swSeLfZoCuPRakzlXVzg3iZtK5NmEBXv8zgwlcecKq96XGuLwz5sFCvHA
         2d2Xealc5c4mSJmbpW7ZNNM7DQ4tWQlBjU92xNbw0PJw4f9QoPrk1y7Kkag5ni7uuS77
         a6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=fHUuxuyHb+j+wYxzUh6gkuxvKGBRENrqi9uV996hRNU=;
        b=jmrqIyUWerIe0eF15+K+UGs91Mdwu8ridchBj4B8xlzcN/0n46HlALVo11HMYB5YZU
         ZjkdFyBdpi93li6eBt5fiwrmyUHSdWteNkOC+2JD/xSoWDtlbKrHYDE6zkZ/Jcvg50Dv
         UeQZgF6PiJIAG4obLAxOJI6eacrrcr/UF4DDoI+ZD6aL7neT9IfpJdh8XKNE/6seH65M
         WV5m+HfMYFLmfPF33r1QijBZAEdF/i5gHMfkq8CjnBN5Z879gKAIezhPkuvm6GD/Q8Fk
         r/EZPR+T3P8SQvVYdnUsks2VslLSlCMQI44j1TxOFILbnuB38UiWSjgeI+gEDR23o+HZ
         4y3Q==
X-Gm-Message-State: AOUpUlEFRpXLO3fqjRovqZWmGP1QTEKwen8SjKr7cvrQLw2195z89O6x
        3oeQYejMoGmV/VVRYWGvAgs=
X-Google-Smtp-Source: AAOMgpcuwW6DO/hPwBs20rrl6i+4L24fhItpy2ac68yGaIKcMhi/Tg2S+Kt9OCZnYXjrYoXxKhOyFw==
X-Received: by 2002:adf:9aa3:: with SMTP id a32-v6mr11960890wrc.75.1533622920047;
        Mon, 06 Aug 2018 23:22:00 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id z3-v6sm398137wru.27.2018.08.06.23.21.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 23:21:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2018, #02; Mon, 6)
References: <xmqqtvo7m8c0.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqtvo7m8c0.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 07 Aug 2018 08:21:58 +0200
Message-ID: <87tvo6snll.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 06 2018, Junio C Hamano wrote:

> * ab/newhash-is-sha256 (2018-08-06) 2 commits
>  - doc hash-function-transition: pick SHA-256 as NewHash
>  - doc hash-function-transition: note the lack of a changelog
>
>  Documentation update.
>
>  Will Merge to 'next'.

The tip of gitster/ab/newhash-is-sha256 has a unicode-corrupted
signed-off-by line from me. See
https://github.com/git/git/commit/f855a19d45 not sure how that got
there...
