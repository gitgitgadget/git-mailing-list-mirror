Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BF9D1F461
	for <e@80x24.org>; Sat, 31 Aug 2019 12:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfHaMvv (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Aug 2019 08:51:51 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:41707 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfHaMvu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Aug 2019 08:51:50 -0400
Received: by mail-lf1-f43.google.com with SMTP id j4so7317285lfh.8
        for <git@vger.kernel.org>; Sat, 31 Aug 2019 05:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=eTWNy6DOw6DqKuSsey9HNMxALT4Od1tLeZAIurlT9Nc=;
        b=l9/OjnnEJo334vUm1Ei1M/I5NJaMAkldqwvb+gWpx7SMxl60vBpUZnbYbZuOouaSBH
         yyfocf1tsHKqYJed2lXKxWqTm5l+6Tmr1FyhQa/5LXEpiIgVgJnq2QIFcSxELoUQLnXk
         ld8DAbo9Xr4gu9f+8/j4+3gOk/ONcxl86W3oj4ao9abjdulFzfkr/XR7b5hrGNUbLPGG
         3Wiu9O3rlLegYi6by3wC9NbdjF1qQPsMG8zatqXWzlZWBUSNuS/WRejjIYyHLr5vYMWo
         MzTFZ575ADT5qeVO+W/JBzV+x7WG9ShoidQBaj57aNI/USkDbMGZ7QzVmSzyilTUUe/3
         Nx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eTWNy6DOw6DqKuSsey9HNMxALT4Od1tLeZAIurlT9Nc=;
        b=umfdmPkLFC3TeOeI8kbm0WyCFQAslSOkLpEnHrSRTYfbm3OkhFWSe2pA+uNvvMr0iK
         0IUDMMHnC7/ZqsOSqOtwzDi/bgq7eSbvHUo8AIHeH3gRmwn7K+rDq1+DnvBY9UlZK9qE
         3+CCbfPZ804o/uFq5rsN3as7OTippF+rY/tZgLWQJXDwIYxvv9Uxw/JTRqDwv2d60DBb
         fXgBrx8h68Xk6u2LraWA4ruocx9dZ1iPrcSkfw4GydPFytVIQ0BhkOWwJ9/yYyMsL61g
         c2BluG0sHbhnpdEyqYyg4uTMyHUjO6GUh8fhm20dLl/Co0GyO5kgDvRxBgGzd+PcliOE
         CXVg==
X-Gm-Message-State: APjAAAVsWU4arWfGCcHmR9BTYTEC06YeLURlcfBTR2yY8eEFVFmnANOn
        pMjiQ/ePscxOoaopRDw7KMkViSi3ReMxggXAVGrpTQ==
X-Google-Smtp-Source: APXvYqzPfD6ylnAvTQjL+un5dZnpqnqOGjURuOpsTBQAPu+fsSAHo0DmhThQZbqY9Lj3m4Vh7JvydqJAdzq/G7i/SHA=
X-Received: by 2002:a19:f007:: with SMTP id p7mr12324777lfc.24.1567255908847;
 Sat, 31 Aug 2019 05:51:48 -0700 (PDT)
MIME-Version: 1.0
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Sat, 31 Aug 2019 12:51:37 +0200
Message-ID: <CAGr--=Jw4DAqTi3ROujtE=xBMYErMws6B6vhuXYMQA+5Q1ccow@mail.gmail.com>
Subject: feature request, git-gui: add hotkey to toggle amend/new
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In my pursuit to fully utilize git-gui with only using a keyboard, I
suggest that there is a hotkey to toggle between selecting "New
Commit" and "Amend Last Commit".

Not sure which key-combination that fits this purpose best, but my
suggestion is CTRL/CMD+Z.

Best regards,
Birger
