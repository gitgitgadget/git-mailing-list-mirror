Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 735F61F405
	for <e@80x24.org>; Sat, 29 Dec 2018 20:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbeL2UFi (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 15:05:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53485 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbeL2UFi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 15:05:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so21150161wmb.3
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 12:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=GjDu0kVEQ5kAjIWI8YXvz8SfXSf3TjF4TFWiMjZ6GWY=;
        b=Qi7bcv62WRiLcR5RfWXHQ6Ms17P0L5WdrCH5IV63DT8wcn2CHkY1YXEl7PQjqX0LFu
         fEYHX6EhDgwYoz18j8uwbAyKg4GGyyHEwL2ao5ILUiRtmqTw9a5jlaelRJZkmeyhcvW1
         B23l0TI1m2lbb3QngrLjj1z/J+g/8WTM2/wraKSy6lmPopfXSW1hmvAX/LT3yhrI4q4b
         AnVRiKN5oJRLnJ9qa0hWK0/ysxlDPpbTEwmt2RN0ohtDCX4aWl86vtb315hoPf9x3Y0m
         /doz/1HPZ/Sm8BRqZqRIr3g0vGZ4lGmkvhIXJzRymozMCsg7/RfYBbV5pzC19q8dE4lw
         hK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=GjDu0kVEQ5kAjIWI8YXvz8SfXSf3TjF4TFWiMjZ6GWY=;
        b=CJJPJ96/DoG81QfgV7q+FPDg0fyNJEhgm4cg3uqD/07dzKJHOD5DZGtdM1wVTpOSpk
         s+t09dWtXr0jSHjTPb2LkquYgEcANJIHre1cc55dDKpEy+uN7YXH4vnA/q/Tp3KjZby3
         jWstlx2iZTfhXowIHae9dEBynA9C66ZaBzhkivvpDqDuvUHw8ezXYNxxpRAiijwGg9fO
         SntDe3/JchaBZGeGlENYiVFL/w1wQ63/8/HdUorbO3jtvyA6FePSsYTcryvuM+nKe+S2
         1w70lw8jdAJTJowUBZ0lDVEcZO86VmdMWLbyMAzYQaHOWJWzsyCOZnpiw1mz+Qd38MOA
         h1qw==
X-Gm-Message-State: AJcUukdEpNQbiENEfzXW+rOlYrLCQr1t41p273i0qLzWWmm7GnoM1ZF4
        HoYZMjOC7H8E2DnOfTMcWr8Psf+5iViNZF6PZllAGAPpKE8=
X-Google-Smtp-Source: AFSGD/XgocMe3Cu/CD7yASiARYIyVG9wP5jTkAGT8TNOFjs0XszJNTAbdKaA2yaDYMSEkrJzCgpj7oPu3Qx+oh4awFY=
X-Received: by 2002:a1c:5545:: with SMTP id j66mr27883807wmb.15.1546113936197;
 Sat, 29 Dec 2018 12:05:36 -0800 (PST)
MIME-Version: 1.0
References: <20181227065210.60817-1-masayasuzuki@google.com>
In-Reply-To: <20181227065210.60817-1-masayasuzuki@google.com>
From:   Masaya Suzuki <masayasuzuki@google.com>
Date:   Sat, 29 Dec 2018 12:05:24 -0800
Message-ID: <CAJB1erUeus4p6YK5zrAmP45bDPmfvBGN6PUG3Dh+UwPZ-3AjKQ@mail.gmail.com>
Subject: Re: [PATCH] Use packet_reader instead of packet_read_line
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry. This is really broken. I'll fix the tests and send another version.
