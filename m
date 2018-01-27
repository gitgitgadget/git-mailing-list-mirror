Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AE281F404
	for <e@80x24.org>; Sat, 27 Jan 2018 19:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752810AbeA0T7y (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 14:59:54 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:53252 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbeA0T7x (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 14:59:53 -0500
Received: by mail-wm0-f53.google.com with SMTP id t74so7181980wme.3
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 11:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ZEozudJ6vyGjmDEG7OQzWzkBw7AY9A/52V7KY5k3tqw=;
        b=kIwRq5HUR8OxOJXh25z+80iBaWYRRoNq4vQXAwT7dw17lrGXQ6eODf2sbe6JiaBiIA
         yVG4XxJShrWAxpii+5KDlKOu8ozM/OvupTp6A5xE+ETEUluDyXijIhbFNCAGKuAbqqPq
         Eqe34WQCMvr6xVA06n6GZzQCHOqyfj2YbijdTGAcqQoahgpxDrQKX0p4GBULaO16llgC
         72KUoFcM1+gh+fKshZhtjBPTv6VIBYfPd6yIwopR2gWZAECfsvNUwmoO5YHQk8Fg5hfl
         htaiW43/RwA+7ACxbjLl8/B+gVo29p5M+pLrX/4xwWd8/zYSWjjDGrfAtrNEVrVy9Op6
         jIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ZEozudJ6vyGjmDEG7OQzWzkBw7AY9A/52V7KY5k3tqw=;
        b=LH+E3isvrTgYCffHQJWoy3YgHykYJ/Zhe+PVHgZJyotQK9VhMiAYtNCvLqbRt8Yguo
         hxSpxbQyUHJcP2T45IVfyUBzLPStNWi/7Ldj97pajJ6kV2tdr877j704SZRo0pti2AHA
         PKIJmGbOwZgz4hoARSPMXDGDNmFpPDG6AtbY+9EMRoIMuJJ96gW9te7fwM2k4R7NJkrC
         BGFRqObw9kVkqHS7GDBlq366oP1gNeOgdiflLpJK/CtshFQmmaxAlZlB6IrtDaofuLRX
         faz6YmDk8fRQ+Svm4vtR30FjeE5pYwPm7D31fDbXJBUdkG5gxnpkfuNMsAZ40fVnhdb1
         bHvw==
X-Gm-Message-State: AKwxytfMkvoN4tDI10xklFlgZATqgjAg9Qymf6a7J0z42V9o28u6uvys
        rMOOK8DLWodNIIUfbq7JYmk=
X-Google-Smtp-Source: AH8x224YUSt4Uzaubc6D5CZO8eKW6R695/OlHa6Oah3yinHYTf5GVPBTcZkUHbkiBaGLIImU8L9Zxg==
X-Received: by 10.80.231.129 with SMTP id b1mr39614678edn.219.1517083191980;
        Sat, 27 Jan 2018 11:59:51 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id y5sm4268545ede.71.2018.01.27.11.59.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jan 2018 11:59:51 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Filip Jorissen <filip.jorissen@kuleuven.be>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Cloned repository has file changes -> bug?
References: <BCFDB3A3-B515-4932-AC67-F720AEB4B0BE@kuleuven.be>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <BCFDB3A3-B515-4932-AC67-F720AEB4B0BE@kuleuven.be>
Date:   Sat, 27 Jan 2018 20:59:50 +0100
Message-ID: <87607nvzrd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jan 27 2018, Filip Jorissen jotted:

> I think our git repository is bugged. The reason why I say this is the
> following. When cloning the repository, the newly cloned repository
> immediately has file changes[...].

If you run this:

    git ls-files | tr '[:upper:]' '[:lower:]' | sort | uniq -D | grep '^'

You'll see that the reason is that you have files that differ only in
case.

You are using a Mac, and Macs by default think that files that are
different binary strings are the same file, since they don't consider
case to be relevant. The file FOO, foo and FoO and fOo are all the same
file as far as your Mac is concerned, but would be 4 different files on
Linux.

> How can I fix the repository?

You could check it out on a OS that considers files that differ in case
to be different files, e.g. on Linux, move them around, push it, and new
clones should work on your Mac.

Alternatively I hear that you can create a loopback case-sensitive FS
image on Macs.
