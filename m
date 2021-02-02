Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977FBC433E6
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 17:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63A4364E2A
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 17:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbhBBRZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 12:25:57 -0500
Received: from mail-ej1-f43.google.com ([209.85.218.43]:45439 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237491AbhBBRXu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 12:23:50 -0500
Received: by mail-ej1-f43.google.com with SMTP id b9so11587023ejy.12
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 09:23:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2u1YMGlamSJ4nvd5AJfegII3j33ryckalMWXPXzMKMc=;
        b=BpLu5x+tO54aP6jRj+zqId88UTM+i3NYNrmo7axFSDedov1BbTy6J5D/7RFBhS4gG5
         gsUKUGPGVZgWXY/VoNG5mCgrIKWoMzHkekAwMydspo3tRZx60k1V56rA7P3jjEt7DONb
         /fu2CSf9MFevuar3IzLDQpv9fJw/WPUHNpBTfDBsAh/CI2eyWHDqyzrFnA+jlVFlb9oy
         iBBFwOMX+g9pqH33kNJpYyKofPM1zh7JRpPHcuwnBSngHavgDEXkuqLBxE32lhMEznwi
         tFuT55jLHnTkWDfzpGeYQ0ITF8VY57FbcXncqk1tHrVO7viLyrcT/uPHJsFrZsgc+tuz
         rA7A==
X-Gm-Message-State: AOAM533qSJ0C6hJymOPNtfqLBczN5CNCGcPk7j1Cpxqrt3e1xUUsN921
        dFBkAEHdT4fvopWlpz/pDFzfan+FqQsRIvz7b08=
X-Google-Smtp-Source: ABdhPJxQCIdDfiqK8hdPj4V8Q5fVdIE41XgweqWLTfWhk98CVSbNCF3xlMD+irgeQEa+yL2D/kzNMaNI8iuKBTYi0Ns=
X-Received: by 2002:a17:906:2617:: with SMTP id h23mr23575503ejc.168.1612286590289;
 Tue, 02 Feb 2021 09:23:10 -0800 (PST)
MIME-Version: 1.0
References: <xmqq8s87hvd7.fsf@gitster.c.googlers.com> <20210202103733.42513-1-jacob@gitlab.com>
In-Reply-To: <20210202103733.42513-1-jacob@gitlab.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 2 Feb 2021 12:22:59 -0500
Message-ID: <CAPig+cQoTpsYS+2pccHmzx=Xoc34u166cYoC=GAcEndofN4gcA@mail.gmail.com>
Subject: Re: [PATCH 1/1] t5544: clarify 'hook works with partial clone' test
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 2, 2021 at 5:40 AM Jacob Vosmaer <jacob@gitlab.com> wrote:
> Apply a few leftover improvements from the review of ad5df6b782
> (upload-pack.c: fix filter spec quoting bug).
>
> 1. Instead of enumerating objects reachable from HEAD, enumerate all
> reachable objects, because HEAD has not special significance in this
> test.
>
> 2. Instead of relying on the knowledge that "? in rev-list output
> means partial clone", explicitly verify that there are no blobs with
> cat-file.
> ---

Missing Signed-off-by:.
