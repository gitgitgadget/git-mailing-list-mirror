Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F41F51F461
	for <e@80x24.org>; Wed, 10 Jul 2019 05:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfGJFGW (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 01:06:22 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:46972 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfGJFGV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 01:06:21 -0400
Received: by mail-lj1-f180.google.com with SMTP id v24so668444ljg.13
        for <git@vger.kernel.org>; Tue, 09 Jul 2019 22:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=cF64BJHeGSEsv51cLU3Y1GhUdOcYWOdQa1Axw7cLHyI=;
        b=TXoHdbzzL2K5EBERptJFDChLWPMI/DlxTo3ijGtbpoWMsJsN/jsBgJ188DBcuoiwz8
         o7PXCxmZBPiGkoap7G3uq9JBxLGk3nRHHe6O/QQSEETl26tnYb4MMGSGUtptCbPQRb/2
         Ca+BIDhhLevbKXwt8COXaIJdMEYYfKt1PHci0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cF64BJHeGSEsv51cLU3Y1GhUdOcYWOdQa1Axw7cLHyI=;
        b=iAdA8Q6aECfUj9HuRPlK7i07ZAG91pb6D6uDP2xGHQw8KL6Og8kwdaxUzl8pFniDj6
         adq2pUyMeQfpqJ+Ale3eFXmpF8b8hOPhZZLWb4pl7w9btY6EEiSqcSNvlMykMgyhUUsU
         +xxWIVKMAySyQU1pJ7xjqT0qW933VDlT9N9GhhsmEHk1ANfmjS+4S8DABYySG3Dz2hXJ
         ySFBvbK1CTtQ+hJ0qXRyG4Qt8PZvVXJRJtIChATR43XS9Rq6MQtS7qa0PYqezEF2CKDm
         TpXFZC3HQNb8TfyZyZsPdT7LrUm448HayLLlAR9+EUAn2cF7txXFyH8FG14A1SGadM1d
         rqQQ==
X-Gm-Message-State: APjAAAXvUxXXHrhk5l3YG2RtHzghSH0oDHqdoVt1w9VvRCxlCEyBq8Pn
        pbXne4n6N8rKXTyO1ZfjcCuLGqNF6rjnEbRU9qpUI97YocTqjVTR
X-Google-Smtp-Source: APXvYqzkb0hB3CtSTosVhhKW+HhB4bVEp9XsqjhYfQ9zUMKcYfWHe1Xl3irV6QVvxw6vEa3lplhwLhGcHgjNT7x77vU=
X-Received: by 2002:a2e:9b48:: with SMTP id o8mr16032561ljj.122.1562735179495;
 Tue, 09 Jul 2019 22:06:19 -0700 (PDT)
MIME-Version: 1.0
From:   Mark Florian <mflorian@gitlab.com>
Date:   Wed, 10 Jul 2019 13:06:08 +0800
Message-ID: <CANC=f2c8eynWJ1r=zwZq1qwrDE85LVFMU2mjLU26HYMDGaD4iA@mail.gmail.com>
Subject: `@` alias for `HEAD` not working in `git push -u origin @`
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

I learned today that `@` is a shortcut for `HEAD`. From `git help reivisions`:

    @ alone is a shortcut for HEAD.

However, when I tried to use it in a command I frequently use, I got an error:

    $ git push -u origin @
    fatal: invalid refspec '@'

I'm running git version 2.22.0 on Linux.

Is this a bug, or have I misunderstood how this is supposed to work?

Cheers,
Mark
