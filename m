Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4612B20248
	for <e@80x24.org>; Sun, 14 Apr 2019 21:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfDNV6k (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 17:58:40 -0400
Received: from git.icu ([163.172.180.134]:36828 "EHLO git.icu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfDNV6k (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 17:58:40 -0400
X-Greylist: delayed 573 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Apr 2019 17:58:39 EDT
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
        by git.icu (Postfix) with ESMTPSA id 59EFB22079D
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 21:49:05 +0000 (UTC)
Received: by mail-ua1-f47.google.com with SMTP id v7so4874441uak.13
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 14:49:05 -0700 (PDT)
X-Gm-Message-State: APjAAAWX0NClQfdzabBO/FTIqRGVSYWvPGHbfF/y0z837xtgtIOU/pMd
        D05C5HB6bg4jP+Mmumgo4VvOaOj9FJX0ZM+d5/g=
X-Google-Smtp-Source: APXvYqyEeDhsqruPJIrY9MLdylVGZHaoX/mrnJ8o1SROx+GpB+U0P8Ja2gQjU/wvuJuQSjFZZoTWWXu06aquaC3qtHI=
X-Received: by 2002:ab0:2814:: with SMTP id w20mr7032885uap.97.1555278544575;
 Sun, 14 Apr 2019 14:49:04 -0700 (PDT)
MIME-Version: 1.0
From:   Shawn Landden <shawn@git.icu>
Date:   Sun, 14 Apr 2019 16:48:53 -0500
X-Gmail-Original-Message-ID: <CA+49okrda1=dV=rN23oFg7LQmRp+idkDDDxFQ9R5jhGJFHKpEg@mail.gmail.com>
Message-ID: <CA+49okrda1=dV=rN23oFg7LQmRp+idkDDDxFQ9R5jhGJFHKpEg@mail.gmail.com>
Subject: allow a differn't diff.context config for git format-patch
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I send patches I want them to have lots of context, but when just
looking at a diff, I can always open the file for context.

-SHawn
