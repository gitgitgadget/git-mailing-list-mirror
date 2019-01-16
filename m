Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C93AE1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 00:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfAPAfj (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 19:35:39 -0500
Received: from mail-it1-f175.google.com ([209.85.166.175]:53184 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfAPAfj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 19:35:39 -0500
Received: by mail-it1-f175.google.com with SMTP id g76so530161itg.2
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 16:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K9sv75sZiutqFXrc0S0CnbDtiDau1a+EpQP/tZ5GeA0=;
        b=n2YaloV5G1Gtf7wBrGMIV/X74F0g7EoXBDwOmrgfaoN0m0w6OoDwek+DZo77Zb8ycr
         LrESa9NSXFKtnfmvl20QfuXew/W8UjfejoM9UpP384TZvlZBvajByhwzCqMQ+S9wKY7I
         GXOA/CGkdZzBYDtJFlBrco+BHIaeN4JwOSIccP2ERw23/bZsgLU4GVBQINesQszZLD52
         l8RUzwts/4Ko+gDnRRy8ck5JwRNCvCv3XIewZ+7KsMZ2aRS9P0GOs3Ptfxkf8aMcVDhO
         VP46MlujPl0Cbve393zjixqBpPEPUQ43hdhAZ/NZDGcHWUWC+SoILZQ7GmnCQYv2yJ85
         6c9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K9sv75sZiutqFXrc0S0CnbDtiDau1a+EpQP/tZ5GeA0=;
        b=B6bYe3Z1+49fLoVKPPLaqGhNSY4HFABkgEr7XLoMcwZP6Q87G47uEPiWUe1KJ3UzMu
         DPcPM6W/UlM/mOntFDFQsN90eq8v9OOqooRvUwIwunhf+3gkcg9LIY5qkRAQ/OO9rQSz
         tToAGDJKvuRqGW3Qpjy0djJeDQKqE/oMsS8iezWvII3r7nn/pJwgpOZKc3XpfeltS2iA
         3Xtwn2Ehv0t8eoX55qJ1W63BQsVczDzw83oCOdw0F4T+5xIP8QRcbMIgvwFxvYKz+JeS
         8ZU8K9e9QrwKQ6GRraIdLl9d96WXI6S+JNsu5tsowW7ufIbPnF3TAs2qg4GUkqy3wIKh
         7rNg==
X-Gm-Message-State: AJcUukfDhX0j7rgY7SNddQlBeqnpfxU5YDXrJGiO/32hCWSCgUCA9Tg1
        xZxuFDFry2g3KuThFP58eSp962C8u4WnmeHiYmo=
X-Google-Smtp-Source: ALg8bN7sizO/skXu77XEzZetuD8qrptE6CwhWVeT8p/aq3QA9asvYeAAnBhglZOyED5KmLbGqbi7TDgpawiNcFtJhMY=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr4142471ith.123.1547598938656;
 Tue, 15 Jan 2019 16:35:38 -0800 (PST)
MIME-Version: 1.0
References: <xmqq4la9r1sl.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4la9r1sl.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 16 Jan 2019 07:35:12 +0700
Message-ID: <CACsJy8B5ARpXfOzuud-4BBxsT4ziNkgPBYUqNy231cGVhVNu7Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2019, #02; Tue, 15)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 16, 2019 at 5:31 AM Junio C Hamano <gitster@pobox.com> wrote:
> [Discarded]
>
> * nd/backup-log (2018-12-10) 24 commits

Discarding this series is not at all a problem. But should I be
worried about the silence on this one? Perhaps nobody is interested in
the idea and it's better to drop it?
-- 
Duy
