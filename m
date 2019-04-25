Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D33D1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 13:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfDYNAp (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 09:00:45 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:45750 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfDYNAp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 09:00:45 -0400
Received: by mail-qt1-f182.google.com with SMTP id b3so1222379qtc.12
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 06:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=uV1c81JbeSZS2B9jaxyUqMpRjzFrU0/Y90XOjxApez0=;
        b=Xr4CzzY6s1Ow2xU3ZIPdweSZ9Enun2js/r0dKyulAgxV6qyiXt9qUxw1bofiYpZugG
         6G+42rbI6LJ1l+eus+AUjncsnlFoWWzN0/pA7l544sy4k9/PhzQMwOIRW/1SW+aNnWhy
         5nOdXH6LLAaq8jIrGtbuGA4u6dfpJcNkih3yw49ls3rMKRwuW/Ru2H82uOWGcvjUsJlW
         dTPrTIttqpy+NIHnh2njBhJPuflrGuI5Nyvo4WwtYdJ8SJ0Dzlca0VmCMkHRcdEjKZW7
         s5MgCDI5MhmGCLqxqh2/z0vTQvgAonl2pJe/sJHa7p3qB0M5Kl62FizD6+zg/czAJ6du
         UF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uV1c81JbeSZS2B9jaxyUqMpRjzFrU0/Y90XOjxApez0=;
        b=LkpwjG0rnYNC3r9v4OK2Vh/k5IJkwwj7TiuFWunOvkwgNB6vEfSmbC3X+Ry0ssVzvz
         x9DJddcpHh7CDFXY4n5x8mSRc9YTA++PelGdep2esePoEiMpZhpVPnECVpXPT9gSbqcE
         LMA1T19JmwSodP6MyKk7juSV7ZcmCB3mEKCBzIotzwr4k22X969WthW3o36gnsJi61S+
         ygK4/tA6/xl1osYuVfVdyZGca2rbZVGoX673iw3T8BZsTh6siNmEjJDKNEZcQVMndg5k
         pZWidDekyFmtUe4g9gTYJgMOjztTdE9KaEt/bMbn35rLXjK5sxwLc9lKfcDxL8NgHPr1
         UrnQ==
X-Gm-Message-State: APjAAAU4BAqCF8w5XomZ+59iI7217VAhGxtFnnGdXb9B75YVEgJ8jgqg
        dGdzK3iiCuB7viG4a66aOXAtp6SusDVHqWPP1FhHOu3k
X-Google-Smtp-Source: APXvYqzL33icfN0fXVfYXdIAQwI6/ENw+breANAV/0EezvD7zc4u22ytdWSWclHNJxH3JhZCwlKdvy7DrMzkxpwvFlY=
X-Received: by 2002:ac8:25e4:: with SMTP id f33mr30001319qtf.259.1556197244002;
 Thu, 25 Apr 2019 06:00:44 -0700 (PDT)
MIME-Version: 1.0
From:   Jeff Schwartz <jefftschwartz@gmail.com>
Date:   Thu, 25 Apr 2019 09:00:07 -0400
Message-ID: <CAL3M-FZ7b3H7Z+Vr9Wbey5iYVoWiUBnDKVEenyAMrUXeNfL56w@mail.gmail.com>
Subject: Request to add option to interactive rebase to preserve latest commit date
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using interactive rebase has one flaw IMHO and that is the way it
handles dating its commit. Can you add an option to interactive rebase
that would make it use the date from the commit that is most recent
and not the date from the commit that is the oldest?

-
*Jeff*
