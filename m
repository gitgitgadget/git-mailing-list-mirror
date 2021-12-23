Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1380C433F5
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 09:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347545AbhLWJub (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 04:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239351AbhLWJub (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 04:50:31 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D8CC061401
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 01:50:31 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id o63so9159391uao.5
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 01:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/5F3u4nxWGpbeq1XjGvGHZZW876Q7DtA8AAibYLRrjE=;
        b=DmiFWFo4ADJxsldOzrzvdoDfi0gzPX3MY984dHPufVR1wNr8ch0yW81KITtex+RSjy
         OcxAcG8iCGklOgYZmZEgF/avxYS8NA8kaWCkiLSS32XVw169rWNZjcOeL8A4w008ic6L
         DCpmfjkwUOExQWuyjEapaKJ0mNOqZRASS60mJ0BZtygoDZSxNOtM2yVJHXKM3iS9ua5M
         SCVtMHSfDfrV5HbG1Ne8Dxuo2s4ry24knA0GxtBiW9gJhHlV/fw0KxLQnTvWMuKM3nzl
         fPvDrgoC2zKqQeyEXQ7yFeeDhXa6wyMA1eGvsApUsy2Dgbsg47/nlWyUcOteDbmlNyAL
         ZtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/5F3u4nxWGpbeq1XjGvGHZZW876Q7DtA8AAibYLRrjE=;
        b=rPNykhBBJaJCCwrj4V8rLscxob5nXkhdIq29+ed3E8vULfT9w6oqIaiB2iAywhfSNx
         aPqeeQ0r4WYx5t4K24GJE1GlRPtNG/GDFQTG7oXDYrbhXLB0mh18zkp6STCHuNQ1VDfy
         G7dQ931jlIIztLE5PC4L7Qa7u09moEciZ5fTIiE6RY/La0u+rrbbkcWMqRCdgMtpTiaI
         aqpt8hkAjf4icEQNQH36O1tRnzlf/zyWlWxOdnXCKbH0QWCmEEwQ35445dFpoLYJTq8w
         RdqPYdeeyvu9tlZssW77TagYCrdoA9Fk6tEucw+UNJ2pLTgwp49EelU1spop4ZOODzyu
         JaSQ==
X-Gm-Message-State: AOAM531LwLzjftwOf3H57s4OMnAZ+3nnc5qaMD+WNCg5ZIkZ7LVLsTqJ
        fx8sVGOb3gJzYenOOdLIWDKgCqF7L4YT++O6c8zGd2vPlSPbow==
X-Google-Smtp-Source: ABdhPJwp53OYtLm3adF5HEkukAEDrJPKrdO5M1pfkJZDa6oAiLiLLHx/ZluCgsJNky+5OvVynZk0K48/n+yj0G85B+U=
X-Received: by 2002:a05:6102:3a66:: with SMTP id bf6mr430859vsb.43.1640253030191;
 Thu, 23 Dec 2021 01:50:30 -0800 (PST)
MIME-Version: 1.0
From:   Teng Long <dyroneteng@gmail.com>
Date:   Thu, 23 Dec 2021 17:50:19 +0800
Message-ID: <CADMgQSSzKrJFd3QE_iA-0r1KaiC4QSbZfDubUdZV_fbgdOo-rw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] ls-tree --format
To:     avarab@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> FWIW here's the changes I had locally & cleaned up now that did the
> alternate --format approach.

Oh, sorry for the late reply, thanks for your advice.

Base on this reply and the RFC patch, I need to read over them first
and make sure I'm clear about what you mean.

After that, I will reply again if there exist any doubts from me.

By the way, If I want to base one on your RFC code, how can I download the patch
and do I need to add some information on the commit message?
