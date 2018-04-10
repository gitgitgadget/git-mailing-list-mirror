Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C92B1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 21:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbeDJVX1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 17:23:27 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:38941 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752125AbeDJVXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 17:23:25 -0400
Received: by mail-wr0-f177.google.com with SMTP id c24so14164201wrc.6
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 14:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=/eoqemnpEjBQ4MZZWguBSUQHlaIu6yX9Cf6r3ioU36o=;
        b=H0DixQAEaGbbAwW+1wSifDG6PiDYqJFCAWKTNuure3idn1bfegqGPLy8gqUS+95dIb
         5SRzGYyNN6WyKn4SGROmLsMxjLrZmwrBju1Gzaxc5HmC4GkwTe4T6mGCvCKvFV2Ii1tx
         dxb/YtAOmvFLHVeNb4/k2+FvBIfFSuwnnqah/9l7C4snhGEydOza3H0HepLf3T/9SFvz
         paqc65v710NLFGXI2fkec2VmeL//lqm91sk1y6E7j37lSFfGLazwBqgUJcTa6F6kfNPT
         FZzr4Y6PtJVmQ5OdheRoVt1IXyj/MMpgu6l3SauNg/22GPqPzrPQSnhxE/RoQ/2n7Qyx
         ZYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=/eoqemnpEjBQ4MZZWguBSUQHlaIu6yX9Cf6r3ioU36o=;
        b=R87pilHdGRprnQfFNI6I5EVX6b3V6wkxZUA9XOVnBuEp1oebCadlDjbc/6uguRX9LV
         jHWmbnSWmGJ86cNZW/T1mOOFRcxjwXqpPuZi7Sa5eIlDvutaIJ8+vlqiQn8ZOfTbE0k3
         NeSiEExd1EeJ5mKo2TL8uQ/WCZBNv3HtVXHDmS7/j5GDEofkTOVki6W8u91NVtItlxWS
         76j0krRFqGU5SrXZ7rov5tzd+tFTfM+436jdNEPgarCHZVT5tb+JpULQgOzIJuTFtpAl
         m8dhMErTSNh2NbSAjrbNuyxMCyxlaStb3FXu+XOjaWKVX+ZIzHnDUAh21vGKvHUlS77O
         bj8Q==
X-Gm-Message-State: ALQs6tC7ciJXc8hM0gV4apcJE6Ava6INM9M5mLad0sUcHYgRvuxM7ntY
        74CosIPOxcr5wyXtJp7I7yo=
X-Google-Smtp-Source: AIpwx4+3HkB/BIDeGsoB5nKWfnkfgckktIR+uHoWnqh3yBtw2jvnVV7kjrSwzuxjaNXKUHkBsAAosg==
X-Received: by 10.223.184.56 with SMTP id h53mr1433101wrf.87.1523395403636;
        Tue, 10 Apr 2018 14:23:23 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z12sm4095870wrb.29.2018.04.10.14.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 14:23:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/6] doc: fix formatting inconsistency in githooks.txt
References: <20180410183224.10780-1-asheiduk@gmail.com>
        <20180410183224.10780-2-asheiduk@gmail.com>
        <CAN0heSquxLpMfrLQs2em1amLv77-Uywr+885Viuq4-7DiWYmAQ@mail.gmail.com>
        <f45ef7cb-dc0c-8c63-1d2f-6ece0d0091cc@gmail.com>
        <CAN0heSojXxQZz50rwCJefkMpF4bPfpzt+=r9qcVoczU1+qN0Dg@mail.gmail.com>
Date:   Wed, 11 Apr 2018 06:23:22 +0900
In-Reply-To: <CAN0heSojXxQZz50rwCJefkMpF4bPfpzt+=r9qcVoczU1+qN0Dg@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Tue, 10 Apr 2018 22:44:51
 +0200")
Message-ID: <xmqq37023gdx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> Your reading seems correct, so I was wrong in my speculation. My guess
> is such a patch would be welcome. I checked a couple of man-pages and
> this one seems particularly heavy on 'git foo' as opposed to `git foo`.
> I think that's a reason to fix it, not to leave it behind.

Sounds sensible.  Hopefully there isn't a topic in flight that wants
to change this file, so it may be a good time to do a wholesale
cleanup of it.
