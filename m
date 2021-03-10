Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E32C433DB
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32D5E64F9F
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhCJTEu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbhCJTE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:04:28 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5174C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:04:27 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id o11so19169557iob.1
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=AgPnwpCp434LeKPFZOr72Z1xWasL1/fzSlaHJWNG8BQ=;
        b=F0JupJLvYElnN+Sgif01m0id3Q46FVYfIpxFkOPv6l9DrBRX425RGJ84i4NzY2Ys1+
         Hb4IsHI9A5u0IXK18yo5hfq9gJbWxpda96BcrGzitKpTEzAUKMuP/2xH6hK+ejryVcsl
         9LaMrTmvPeDoz9HjaxBd1caIZXdwKaCPrLVtlRbF6jOOKIk5SXRpOG2HzJg76z19kNuI
         ho2qYEcPyVhYn+eSrLdURoSzM3Vgp3/GeQqBi5jgPlAvbgLzV+e/s9qF0wi+A1QutTP4
         X4lqxnOFyY2BtQJzgNUyTih6CNWyIirClwjjXjW430DUOxr3VoRngtNP8BWXWNQ4wz+H
         iqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AgPnwpCp434LeKPFZOr72Z1xWasL1/fzSlaHJWNG8BQ=;
        b=UWM0UZnqT/1hIHbnUiVlH4dRyRznw3wfm7Pd/kJKKaEVyjAQVuXoGkdC5BYMcwXWK2
         JohP3WAYHnQg0+K9+FkoJz2QmcB+2OHMLxW3x6qmNg0s8+Qh9imjaa13XAeGEw4pod5l
         YPwfNS+fZnBNy7gFaF14YFJc2AP8LTtjxi99bZc3IrHY+LhWl353cp3//aHiAicVQK+J
         uxgUZXxo02Ab7mim8EOKS0o9hOdMJFV/yeacfdTUHMDhE/UQFcZ1nlRmBcxKsW4wR/9/
         r4HhxcgECSlQovAXXDey901t9VZHdoxgIJszyuIUNQpEy5zNtCC14jcIxYORnKt5eb3V
         BCxA==
X-Gm-Message-State: AOAM5336aHlTq7k2X+kJiG4FatYwwaoLNQaryKo+fLc8wRLoVpSa2xKO
        gIOvJP59tysoLVKlHf0rPnfDvQeOdOtYk3KzyjShGOJw2kzUyQ==
X-Google-Smtp-Source: ABdhPJxGhTXwwD2zWyScC15FO+iYB7Pk7NxUYjJSeZ52mZbfNsNYJgjTYqQ+1/DTyxT6tOEiPb1Z9v51mDjYi0BqfYw=
X-Received: by 2002:a5d:9e03:: with SMTP id h3mr3460074ioh.94.1615403066932;
 Wed, 10 Mar 2021 11:04:26 -0800 (PST)
MIME-Version: 1.0
From:   Krushnal Patel <krushnalpatel11@gmail.com>
Date:   Thu, 11 Mar 2021 00:34:16 +0530
Message-ID: <CAFufNaq=FCfvBGBhnjatdn1KUoQYV=Y2zOWWMFWwDLwTR-ujrw@mail.gmail.com>
Subject: GSoC'21@git project application
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am Krushnal, a 2-nd year Computer Engineering and GSoC'21 aspirant.
I was going through the organizations and git caught my eye. I was
really impressed by gt as it is due to its daily use but after seeing
it listed in GSoC'21 I specifically want to focus on applying to git.

The project which I look forward to contributing is the git submodules
conversion from bash to C.
I would like to have a discussion on this project with either of the
mentors Christian Couder or Shaurya Shukla regarding the next
procedure for the selection process. C/C++ being my primary language
and being decently proficient at bash, this project is perfect for me.
I am ready to work on any pre-requisites required for the selection
process

Hoping for a positive response.
Sincerely,
Krushnal
