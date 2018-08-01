Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 716221F597
	for <e@80x24.org>; Wed,  1 Aug 2018 17:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405027AbeHATF3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 15:05:29 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:42135 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404608AbeHATF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 15:05:29 -0400
Received: by mail-lj1-f177.google.com with SMTP id f1-v6so17541294ljc.9
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=tYogbWxvXAytGHcai2A3XwjWngC/wyBxy8Ee+uN7r9I=;
        b=Sptj5nWuqlxPng0L/I3cy+r7fyF8OxxHXYX1EYt8flWcbUVvgXeYxCw1aw2UdzbdQt
         jLsONTUBsu84TVIWJffm9kiaMOAGACcsHLMn5xQVxToJEWiWXatLjeaHDo+TZ9DnS5o/
         7+3pkWn2Kg6Jgjc12GYHOdGhqPW33BA/AzQHd2pS0c5rhm5P+A/aZRZdRN9QopFQgOa0
         foF+fFlAYFN+x6PnhrGzFR3f+ToDVz8PBSZJz6VgfEJ9VKqY5i7wZjLYWKBB0m4IOEEl
         JKgKUVjEPFTjmkksZb0OJ9iv4bG61l7W27wycApNQqHAevqQ0VJGRYZu2x2IVokEv4Fj
         x4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=tYogbWxvXAytGHcai2A3XwjWngC/wyBxy8Ee+uN7r9I=;
        b=WsO8J+gpITtAza9+/kDEk9fX0gh0d0vGOpzZ78Ovntu6Wk7Skm8ucXWros/fYVTcaG
         SjEN3OUX0Et2daFRV+s3gcoRS7Xq6z8RjCYJHO1C4ElDHzWJUtwm/JKpRZUsqAJI/Amn
         jHtEw2u/g9sWLlm4FMjd4NIT92QG8bJWk4DQ/B6ZLE8AC2sfhpCfnPRcNnZw2D5m0t3K
         NjBz624crVFdglOmWCrY+vpgf04k+bFrKPsSojcYb/EqycJ3NuXuJ+iMkWfRIMkzgKYf
         irWRvDTy8VuHyCil0OozKbXX3XTQSSfIWvO79CRU1fO4rsEJ9T4l4xGLF+ZHEoPNXrDk
         yBLg==
X-Gm-Message-State: AOUpUlFPPNli+8JRrwmxvpMo9CIGUTyvwWWj0tveGgqRlK4TTSLm+lAo
        aPQ7OGB9gm3j3tmIzn/BZR3BJ75/wO+2SUVD527QqiPh
X-Google-Smtp-Source: AAOMgpdTU1UAOPzTe0ZvdHGS1MnIIjkmd5yH36L7527JIgwzTFpDAxFJoSuyN9StsqtR5kVjNKm/cZfoBDZfcIBGUKk=
X-Received: by 2002:a2e:8457:: with SMTP id u23-v6mr19174810ljh.95.1533143927131;
 Wed, 01 Aug 2018 10:18:47 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 2002:a2e:5ce:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 10:18:46 -0700 (PDT)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 1 Aug 2018 12:18:46 -0500
X-Google-Sender-Auth: qKzfrqCBpDdTBhRjiT0JgSLKX-c
Message-ID: <CAHd499B2VingKU-+7idv9FROYgCmOAzZ7YAQgWdwY1YUeTUVHA@mail.gmail.com>
Subject: Fetch on submodule update
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Problem: I want to avoid recursively fetching submodules when I run a
`fetch` command, and instead defer that operation to the next
`submodule update`. Essentially I want `fetch.recurseSubmodules` to be
`false`, and `get submodule update` to do exactly what it does with
the `--remote` option, but still use the SHA1 of the submodule instead
of updating to the tip of the specified branch in the git modules
config.

I hope that makes sense. The reason for this ask is to
improve/streamline workflow in parent repositories. There are cases
where I want to quickly fetch only the parent repository, even if a
submodule changes, to perform some changes that do not require the
submodule itself (yet). Then at a later time, do `submodule update`
and have it automatically fetch when the SHA1 it's updating to does
not exist (because the former fetch operation for the submodule was
skipped). For my case, it's very slow to wait on submodules to
recursively fetch when I only wanted to fetch the parent repo for the
specific task I plan to do.

Is this possible right now through some variation of configuration?
