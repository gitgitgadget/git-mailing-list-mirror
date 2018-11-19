Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCD4C1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 20:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbeKTHAY (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 02:00:24 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:35243 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728938AbeKTHAX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 02:00:23 -0500
Received: by mail-ed1-f54.google.com with SMTP id x30so43534edx.2
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 12:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:user-agent:date:message-id
         :mime-version;
        bh=4eIUsT2XL21IGfs0eIrvnhJE9SJ3fkXOnUdq4YY5RFw=;
        b=ogTTLx3Sb54hD0naIVZlH/HeWdShpQCOf7wHEmUj57Zaa7r5BodxlAf2THE5O+aSli
         7z3Lu7KMzq/Rx0lUBiE+UCT0yqjdGlwmEWuoi693KVDl4zqolmN1RC5sKCZHtyw+KJ3T
         i+txheWSjsh7G1LAczr5o+DYhZoheY+UCM0BevmQc0SpN1VdKabf78TEnlbbu6nycU8W
         m1IeMvyyIkRqm/8JmaE4ZkWn6zff5Oy4DCvoPDexv3GTGfECHTBFeNFtEduClaVFaHFP
         EL7tqkzNIvHbW0mytG/ii6JjU17KygFrTQUj1GAO/i5p+ZjJnZhjM3Uv3nEJA/1fGav2
         b7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:user-agent:date
         :message-id:mime-version;
        bh=4eIUsT2XL21IGfs0eIrvnhJE9SJ3fkXOnUdq4YY5RFw=;
        b=ukHp+ypdCJd7S4ChaGITeNzaBbxs3QKQmjjkgXzVbFFWxihLyropnc7vApG1FX5GKW
         XmrO4cTMaoGEAwJdQnbw2YdgE/Da2T9kqOYVfFzmeB/vCqVsbN6swY6eaTP13E6AZ3St
         qKllUUv858j3umvSA/NI6KrjN+G2cJCyxgzTSuGX8ZCwgMOpJxXj+JYsNbeWAaudaar2
         hLSu+CRtz1ezGQFyp3gHkKgrnQzLYZXzntPeqJpZkeztSKMUhOS1Xx+Ro/H5ocL0SbXQ
         YiV+nLkoJ5uCl6B8Y5b1pMEOcggb0kdx6iADkARPaMcqhDKjIrQyg/HKFZanhY8Oesvl
         niNw==
X-Gm-Message-State: AGRZ1gI2Ysb6erjUNHf46UOimN4SMffyW4aQkojfQ88+tReOUcpJcXmF
        qvqmKXoGiij7nD0pOKj8FnonUAFvRzY=
X-Google-Smtp-Source: AJdET5f4cTwPg3XLcSniSKIyr3IcK01dzlvUm6nKXYPln0913rdo3wfdtQfDFqlssBgobaUlJ+2Y1g==
X-Received: by 2002:a17:906:351a:: with SMTP id r26-v6mr17844660eja.193.1542659702529;
        Mon, 19 Nov 2018 12:35:02 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id k32sm3552137edb.42.2018.11.19.12.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 12:35:01 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Erik Faye-Lund <kusmabite@gmail.com>
Cc:     git@vger.kernel.org, ziade.tarek@gmail.com
Subject: help.autoCorrect prefix selection considered a bit dangerous
In-Reply-To: <1290787239-4508-1-git-send-email-kusmabite@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
Date:   Mon, 19 Nov 2018 21:35:00 +0100
Message-ID: <87y39oztzf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replying to this blast from the past:
https://public-inbox.org/git/1290787239-4508-1-git-send-email-kusmabite@gmail.com/

I apparently like to live dangerously and have help.autoCorrect
enabled. I just had:

    git puss

Auto-corrected to:

    git push

When I meant:

    git pull

(For those wondering how I could have mistyped that, "l" and "s" are
right next to each other on a Dvorak layout).

As seen in the E-Mail from 2010 this intentional, i.e. "pull" is pruned
since the "pu" prefix isn't matched, but "pus" is. This was meant to
correct e.g. "git st" to "git status".

I don't have time to poke at this now, but wonder if:

 1) The correction facility shouldn't at least have a list of "this does
    stuff over the wire" commands and would then use a more conservative
    estimate.

 2) Whether we can do better with typo detection. E.g. add commands like
    "pull" to the list if we have a long enough prefix for them, and if
    the number of characters entered matches the number of characters in
    another command.
