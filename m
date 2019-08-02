Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BC361F731
	for <e@80x24.org>; Fri,  2 Aug 2019 22:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbfHBWQg (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 18:16:36 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:33131 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbfHBWQg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 18:16:36 -0400
Received: by mail-lf1-f54.google.com with SMTP id x3so54067877lfc.0
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 15:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Fs9sxHDuXnaWg9tWQvUL/ByYwxpM9XJ3LbSw3K247UY=;
        b=N88zBuIGj0tjZwKVX/jzD6LrwpNy6VUOOD1REhapuicsc+RCf4ezoMmI4S8wNo1/CH
         Uk4lY+wW2c6JV16raqY/95HbkkC4ZoBAuaGVEcDuPiVKyiMq9cF4u0e2y5A26k0KQ5Ow
         n1PHd+jN9paW/XdbRTnqowJy/EkBZVd+xlkOW48E/Qn11d8p9jPV1oh1bJNAf6mQ48eU
         CP+swE56tPxodOsF4s2euEwBQz0GZLNJ2yVZH22MXKli7pl8VRfoNhWxAZeOi4fyNi0H
         uJxNHroEf75aYL03md2NE5PdT8MnX6nOmonFUb8l/+YDXxg01v+GCZfOy4vEBn3lA6yR
         mb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Fs9sxHDuXnaWg9tWQvUL/ByYwxpM9XJ3LbSw3K247UY=;
        b=n5iWBdCNuzV22FI+sQI6LUCyiV8YS7BfOHirmmGC6bzU8RmeYEiOdy29goPfHjqdtA
         I9iAFh6DZJ/yRTTsm80Ev5Sw2upfVztsFjAAeejUg/+NVR3CVEYGdGX5wQcPFY4jIZEg
         sJMoZVzDGn899tUTaLamhmYgwSVFmtSR9QbJN7DtoSpT5dGEwXcomIm/exKM9NKt0aO7
         H5aFt4hZTSQGduSImxGaevnqmty5cAJ3UzDCTYgF2MzP37YtJAd+FdvsR0s2q6kr3XhU
         l6+8x5iCPkwjgpThoOTNeNIRlxjraONWwEBgklVMhBHg9bDqxyN6FjFJoa0Xr21gDjIR
         BmgQ==
X-Gm-Message-State: APjAAAVMgRq4kBK2xB2lWPf7BjSwjHutagf1eDbM+CS6Tea+6Gl6xGSI
        Nv/KdERkszeMcVvWcorJv9CaRIoLToL0EAhELfcIS45yZZs=
X-Google-Smtp-Source: APXvYqy9mY6UZmh9NnB5DrJOSkcqZ+Vyu7Y1T1hXx0oBfLFnlYw+snm2aYvwqLB2mGrDBBDs6K/yOgbvDBJCbPceRyk=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr65402189lfu.141.1564784194210;
 Fri, 02 Aug 2019 15:16:34 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander Mills <alexander.d.mills@gmail.com>
Date:   Fri, 2 Aug 2019 15:16:23 -0700
Message-ID: <CA+KyZp6h=wPKR7mVHWsFikTbA6WWwk-KcoLi7iTNC28wAiKEKg@mail.gmail.com>
Subject: help with git log --numstat
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all:

Another question that came up for me recently.  Using:

 git log --numstat

I am seeing multiple emails attached to a single commit as described here:
https://stackoverflow.com/questions/57333971/git-log-numstat-has-weird-data

does anyone know what that means?

-alex


-- 
Alexander D. Mills
New cell phone # (415)730-1805
alexander.d.mills@gmail.com

www.linkedin.com/pub/alexander-mills/b/7a5/418/
