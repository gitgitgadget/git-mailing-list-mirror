Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F0AC433DB
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 13:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D92DA230FC
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 13:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbhAVNBC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 08:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbhAVNAa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 08:00:30 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF23C06174A
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 04:59:50 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id x23so6400427lji.7
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 04:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=YaA3nllIxPzvtWzWp1yopkE9L7mIar2qbs+xRu81w+Y=;
        b=XgNZil6rTmyTqmnVoFOPlBdVAlD+KptRAvZRPPUNwkXl0+sIbJUenHHTO/4XeLKOFn
         dRNutF191Au4Ba/O18a3GLoZReVyuUaFV/HQgcY+qnV08i22gPm8Upk6E/jm2CoiYmgQ
         2i1L6Bj/lHgfYRZI2Mjzk0VYgy9iQ/VO7LdYyi37aeDEp0Cz0EkHoKQTMXP2m+a3hcob
         9UtU3Sjb7Ld2gqfbTgFlbXHUqVo8QIKqAHiQIGB94obV2YqCaPtxyeRkhWfBAJ7VMU0D
         kCYFDPMKmMSbKwPjLBh8P2lYjwRsJvtQ22imMMH11EPv2Lb6EuDcci7A2uu2hDDJ0Eop
         8fGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YaA3nllIxPzvtWzWp1yopkE9L7mIar2qbs+xRu81w+Y=;
        b=dJGmFMdrS8Y52+2ZCCtOrLV+PELVw/hcFOmNOE5DlpkuMExY13iMWr+j5oeWB7Gl4b
         G4euAGXiVCgttqxUfK/lkHWo9IjzloTNYf1QF2cuoQa0rEzNbFYpOlrydjQ/7d1KzmHF
         /JPILntaKZ8z7ALjfHsgyZxjkd4XMuoK/3pg/Bq5NzYEOF/uhFeHn6QCAjYA1nPrRflI
         yz0BWObHOnMNeIipZBZjaJAKFj7sdu+2yNUKeyBLP5bNVHJ5wqT7MTHGC0G86mU1lWqc
         QTS0Wp7XOPDWsNQU1WCigRRr/ZgErgr+a848HAv8LW89Z8fnt2OT91JGKuoLr67Gu2L9
         h84g==
X-Gm-Message-State: AOAM531u3KNVdKZ5N8ThnJoGSaw2oS0qkkKz0XC6yGDXVsIiXmyywf4E
        SjjvrUaEZ95mWoEHUPzG/LC8g2ChRhVGMk4KYWxjtgAenjlU4A==
X-Google-Smtp-Source: ABdhPJxDPgWusbZAlChL0UdiD1+h8SQILqzoL+doQFty9PJpI8N3wHDaIf+csT690bfbBb9XKH2K6q3ta0AFEVqFrKY=
X-Received: by 2002:a05:651c:3ca:: with SMTP id f10mr1185988ljp.508.1611320388929;
 Fri, 22 Jan 2021 04:59:48 -0800 (PST)
MIME-Version: 1.0
From:   "Patricia B. C." <pati.camsky@gmail.com>
Date:   Fri, 22 Jan 2021 09:59:38 -0300
Message-ID: <CAK8LAYVZKjbMEDWTyvQv2eY+qR0qw1=mn=c4KCZvit7gsqTibA@mail.gmail.com>
Subject: Can git change?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!
My name is Patricia and I work as a software engineer in Brazil. I
also teach sometimes at Le Wagon, a programming school.
I brought the discussion about changing our repositories' branch to
main instead of master. The response of one of the owners was that
"Git has not changed it, so we will not change". So here I was,
wondering if maybe Git would hear me out :)
Do you have any thoughts on it?

Thank you!
Best regards,
Patricia Camiansky.
