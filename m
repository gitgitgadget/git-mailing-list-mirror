Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E66391F404
	for <e@80x24.org>; Fri, 14 Sep 2018 18:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeINX0v (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 19:26:51 -0400
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21710 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeINX0v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 19:26:51 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Sep 2018 19:26:51 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1536947769; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=LraOry5T7qFAuIbjVG9ob8JD6L+WzlAg1qGq6414hYRUU13gkjF4Y8ZPhK42cc4gvgPekqyiG1QhvaCypss+Md/jTs9GufM3t3nCV+i2Xk8+L6BMp7/R4X9wbHsfNd9ZwRjX6DR4z5ZQHHzLSVsKM13febKdEVYj01sseiHtVUM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1536947769; h=Content-Type:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=DTitcrD4oWUfxHXQNAH1I8yPfXiQDA85HCuCGxFojaI=; 
        b=EkgGDyjcwnGHVsjbW9v8fH/d5KE/KIexbVsXMkoXEYiomerOPBko7+tBqW5fk81nVtSGqpCAjxpAoYNJ4VciWG7KSicpgXCFi7pBuwfT9Bi8pQBg1ueOCexbj4K2MmjUcqwSE/vs1HiOiMUj01c/tkXLNzOd7J0oMZjCPTQgyNM=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=astrangergravity.com;
        spf=pass  smtp.mailfrom=john@astrangergravity.com;
        dmarc=pass header.from=<john@astrangergravity.com> header.from=<john@astrangergravity.com>
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174]) by mx.zohomail.com
        with SMTPS id 1536947767630201.86695299050905; Fri, 14 Sep 2018 10:56:07 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 203-v6so8195827ljj.13
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 10:56:06 -0700 (PDT)
X-Gm-Message-State: APzg51ChyfJxocRH7SDSa2MbtGsKTM5jZtZsmV5ESdt4idL/7W9x5K/Z
        hvhYjJXHFMqUxD9nnACs47UC9JWySVkd05Pxwts=
X-Google-Smtp-Source: ANB0VdajWH2WSMMXGEg5QtkQMHeYb/kGIJFkqN9be7OTTz34q6NRLCm3AT0MMnQWX5qex3hF4xFrdTehAvwrMMkDrwA=
X-Received: by 2002:a2e:9941:: with SMTP id r1-v6mr8322124ljj.53.1536947765693;
 Fri, 14 Sep 2018 10:56:05 -0700 (PDT)
MIME-Version: 1.0
From:   John Austin <john@astrangergravity.com>
Date:   Fri, 14 Sep 2018 10:55:39 -0700
X-Gmail-Original-Message-ID: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
Message-ID: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
Subject: Git for games working group
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-ZohoMailClient: External
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey all,

I've been putting together a working group for game studios wanting to
use Git. There are a couple of blockers that keep most game and media
companies on Perforce or others, but most would love to use git if it
were feasible.

The biggest tasks I'd like to tackle are:
 - improvements to large file management (mostly solved by LFS, GVFS)
 - avoiding excessive binary file conflicts (this is one of the big
reasons most studio are on Perforce)

Is anyone interested in contributing/offering insights? I suspect most
folks here are git users as is, but if you know someone stuck on
Perforce, I'd love to chat with them!

Happy to field thoughts in this thread or answer other questions about
why git doesn't work for games at the moment.

Cheers,
JA

