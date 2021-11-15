Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2623C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 06:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEE6763211
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 06:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhKOGKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 01:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhKOGKk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 01:10:40 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CF7C061746
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 22:07:43 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 131so43759984ybc.7
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 22:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=KgiVGb7Zx8NfND5FvDAhG/JvR0hkaK/xy06Fd+JJrSo=;
        b=Of0ghEP0CRWqtHqRVE1kluK445ocY6ij7INzMxv9E/qlW7GEmethKE9C6AUT5ZjD8p
         oo1farjDyk20bUxAiqHkFUoCxCJhu2kW6qvROhfwNdgQMR8gK/WZg/78PSwDiESmN3YB
         qzace9xqKA9JekdUBUNnPY5HsYVce978qR4oDYxVQjr5h0g3ny5bC1k7bT7BwiiBhuLq
         FVwGLSmrlFl3RCRr/M5/mPHLjeG0dBtNCGmKKWajkamVBDm4mPt822pgKGx3YtWYyerE
         prrGQAxsCL/WHlGHXQnez8wYQHt8gHWVv713hfWcTqxtMNplMUyZO4UdeoT8sZ/p3gAT
         8PQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KgiVGb7Zx8NfND5FvDAhG/JvR0hkaK/xy06Fd+JJrSo=;
        b=Hzc7SAWVPRabJ37aqED8XiieYxNpuKsTPk5dfhZ2IE/y9R/z0XdIxOp+zJPKLq6REe
         gYcTTyzueCITUFVl43BpPZfBjTNLgNcwLLIyw3h354JNfNPHJOx3qlm7+ld6HGR+pjM2
         mdzj5R3hU/IfXF5UaQvg9+7XQVsH5IcWDpPIwhmI6xvCOmbVUeRRybngroTQlYEpCvnm
         06vCZ3UBnmT+d4ZBKXV10UONJAFW/s3CjaA39stsDu3NQ6DINafsugkWii3NYsS+ma+l
         HbFz64y0xoCQhpqjxRzXLWQDYYSMTXhEqLKm9rr2489W1fSBJeWuLvB5azPI3XlS8pSG
         YJAw==
X-Gm-Message-State: AOAM533DNQ5fCsx6T2/OCvdG7xTp+X1iU4fd8BAchEY3643FjtJewqZT
        LG9BGbV2VoajVuawenfjXi1cNH8sam1NE0Fmnc5P0szaQSTQQw==
X-Google-Smtp-Source: ABdhPJwyGkgaEwIIGieCZy4gVr84Mt9i6JMbaxG2bVK4miKP9ukbWDaZAx/Q/JBkp8UlOb9hKxUEKsXDAKUndNw+JAw=
X-Received: by 2002:a25:bf81:: with SMTP id l1mr39427604ybk.289.1636956463054;
 Sun, 14 Nov 2021 22:07:43 -0800 (PST)
MIME-Version: 1.0
From:   Dhruva gole <goledhruva@gmail.com>
Date:   Mon, 15 Nov 2021 11:37:32 +0530
Message-ID: <CALQfBwzkmXy2hkkModKgSYhUS_yYO4vi1KdsfAG976+5tD42PQ@mail.gmail.com>
Subject: Interested in contributing towards this project
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am an intermediate C programmer having used C in many embedded projects.
I was looking to expand my command over C by expanding the
applications and thought of git as a great place to contribute code
to!

If you could kindly direct me to some beginner friendly issues that I
could help with, or any documentation that needs fixing or updating
then I would be happy to do so.

Regards,
Dhruva Gole
