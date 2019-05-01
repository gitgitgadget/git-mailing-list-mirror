Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7F6E1F453
	for <e@80x24.org>; Wed,  1 May 2019 18:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfEASmy (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 14:42:54 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:42307 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfEASmx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 14:42:53 -0400
Received: by mail-ot1-f45.google.com with SMTP id f23so15495739otl.9
        for <git@vger.kernel.org>; Wed, 01 May 2019 11:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F+goupEmhU0QOg3NIkbQ8UlQYR+vf4Eh28IauyB4FcE=;
        b=rVL9Pss4sNBFs3gjnKh9PotHNqypGYzxnEkuaDOexpzvbOWNbDdUcDl8OTLApjj1Zv
         dhBgyPZ8vBYdtioqt9KYdAt7N2c0kZYZFLFaVv1A4ak8oPdDmVU5UlZW/BrVodMuvLG0
         tD/ZWGVYSnqTZAcaFvQGExxRvXHgBXiBCEl8tHwOBJXm4UTpbliH8Yz4xCLqbgOVkL/I
         xl3+PA4+uZgjUp65U6EZtjp5cPJS7/Y5CnpeyX4tu5D7X3h/1K837ooLC89P5SA+8bms
         glmrlSCpnG9nvT4wEDXNGsqkPhFGG5M38qMSwafXlFL2iiw0SMFwTb6z3CS+SXh3afTF
         kr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F+goupEmhU0QOg3NIkbQ8UlQYR+vf4Eh28IauyB4FcE=;
        b=f1Z0KDUcvQ937w3HNrXTT/YEU5wbJV+XzUztzSz3Onm+NO5e1sdnTahOlWFsNmSOlU
         cy8I6cLxrsSUhR6EN8IVZouzU4iLYn/hhCwJPrzzm40cf1NjD/68zNOdc0K89MIvnpZB
         jzrk0ykwP/0SG8gtuP3fqu3agsT+Fyu+uOAntESIToQzaJWLgEMciPtFPMud8E/eques
         Pj9sypuc0J6bDMoNU6tuQ5UCW5CwA5ul25mTH2TjuUbidTrON+u4JwWz35cuW3pKX1Ky
         QKOtYEPIlYM6PJPoe9pAXm1dR/0XFA0BvtgzHT8ZxJiksN9GAYuyMP2+ezFT4my/Oc3N
         FKSw==
X-Gm-Message-State: APjAAAWhIfla8FgRA2iJWrDKi4LBJ836Fn58BRtrVGzcNgTGy77Onpo6
        UqcNa/jW8WUiQcARjIIyZkWKvUbAHXLZNU4QD/qV6LV4JPE=
X-Google-Smtp-Source: APXvYqxaNVCl6t6cJshh3WHo0vtfpJBOdK1+YO6eeu333KSdmcIHSTc3w2UxwU0Jd0psJ/CEBcpVBetcXnnz2Qgu+zM=
X-Received: by 2002:a05:6830:109:: with SMTP id i9mr18624629otp.96.1556736173043;
 Wed, 01 May 2019 11:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <1b8a01d47466$9775c130$c6614390$@abilitybusinesscomputerservices.com>
In-Reply-To: <1b8a01d47466$9775c130$c6614390$@abilitybusinesscomputerservices.com>
From:   Martin Langhoff <martin.langhoff@gmail.com>
Date:   Wed, 1 May 2019 14:42:42 -0400
Message-ID: <CACPiFCL0UZv6WBMq3ZdrGE6bWNGLye22xEWUadneB8gzTAOzsA@mail.gmail.com>
Subject: Re: if YOU use a Windows GUI for Git, i would appreciate knowing
 which one and why
To:     _g e r r y _ _l o w r y _ 
        <gerry.lowry@abilitybusinesscomputerservices.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 4, 2018 at 2:34 PM _g e r r y _ _l o w r y _
<gerry.lowry@abilitybusinesscomputerservices.com> wrote:
>
> [1a] Which do you prefer:  Git GUI, Git command line?


git cli

>
> [1b] What is your reason for your [1a] preference?


I'm a cli guy, I know git well, and it gives me all the power.

However, understanding history/branch structure is not something you
can do well with the cli tools (git log has an ascii art branch mode
that works for some situations).

For a number of reasons, I often find myself looking at new codebases,
and wondering how they got to where they are. Visualizing and querying
history is a killer feature for me.

> [2a] if applicable, which Git GUI do you prefer?


gitk ; if not available, whatever I can install quickly that (a) I can
just start in a checkout and (b) has a good branch history view. In
other words, the more they resemble gitk the more I like them :-)

> [2b] What is your reason for your [2a] preference?


Best for navigating history, complex branch/merge patterns. Handy
search including pickaxe.

It doesn't support the "normal" workflows. It's just an outstanding
complement for the cli tools.

cheers,


m
