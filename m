Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82C1C43334
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 10:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240792AbiFTKpk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 06:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240600AbiFTKp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 06:45:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F1C140EA
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 03:45:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id f16so8484018pjj.1
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 03:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5vl+DFz02aJL1cCCtjqghaiG3ieMJQUgHr/fjBOHnpo=;
        b=CWkO8YGdIQUKCxm4aArGsYU8/GI/P6jJHAmnQ3i4BXhUQMt4K0gc9PrGUo7x2vjnnH
         +DjP5Ygv0MfJX3Am6YMhIxDMJItH1D8Kidj1a4SmzlI9GZGe32iMziQt0VrrR2cCPv3W
         vLtADWVb5CoSPvdSqQez2gzJfwBa63JlY8u1IJ0vS+qIGqabgjCPMt+3XpowoqS+WbrB
         Lz58WtcQ5Bg8dawUy6dAGuk0ECaz5Lhr3VpGLi3N/tgmklz1eal222usJBBNoFBksNm2
         nIZj1fi3yUwFHT6V9Z/BBq+CC5PCvYDso62/aB6zCWs3YQMomP8zC570yXDZGgLg89qb
         LeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5vl+DFz02aJL1cCCtjqghaiG3ieMJQUgHr/fjBOHnpo=;
        b=eEtTTD4Tr4C9Ql0CunBpyQyIYS/DJCA0sXDnYOZSlZGn7W+MXr7X0HQwOZhOgpl/Mz
         DgXfSlpIJwQZue/QsvopU7/iHq6AJmMm7NMPPUYkuI0yVMe91w1I4EO2IehovzOCfDSX
         FUe/SpJS2RJjdj0VYUpVlN6tVY0PkohUf8ibGBTq06E4+++tMVQ5Jz4VlQcP/bikTaBk
         p4oPI7iePVJc6RVEeA6ABoh+EBYDQffYVc8ZQ6BXwW+3C3xwgUMXf1X0xZoaZzEyO980
         AjsLaLSg3znTdIWQW9Je4JwmnU8UpNVwMYXgLMZZiQLbYS2dOjwq44UGnT1SDTH1sd5d
         QEtw==
X-Gm-Message-State: AJIora/RimcSz0pPddFMz+WTOkJjhzOyG6z1y987bJ8vgDTUyIt67BUf
        N0NirneVdb/mp249FmOnhkJxGM4kVFI=
X-Google-Smtp-Source: AGRyM1vQFpfGbm6J2XlhD/MVuPEsQkisoBQixInxTg7GNVnVn8uU1XhhFBD3NEbV/DI9axLWrUj40w==
X-Received: by 2002:a17:90b:3b92:b0:1ec:b866:c398 with SMTP id pc18-20020a17090b3b9200b001ecb866c398mr1296828pjb.237.1655721924608;
        Mon, 20 Jun 2022 03:45:24 -0700 (PDT)
Received: from localhost.localdomain ([2409:4060:e8c:d9c4:5844:edf4:906a:a823])
        by smtp.gmail.com with ESMTPSA id 186-20020a6219c3000000b00525243d0dc6sm1762334pfz.15.2022.06.20.03.45.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jun 2022 03:45:23 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Git <git@vger.kernel.org>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [GSoC] Abhradeep's GSoC blogs
Date:   Mon, 20 Jun 2022 16:14:41 +0530
Message-Id: <20220620104441.10413-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello developers, this is the thread where you can know about
my weekly GSoC blog links.

My Project - Reachability bitmap improvements

Blog update
------------

Title - GSoC Week 1: Let's Get started
Blog link - https://medium.com/@abhra303/gsoc-week-1-lets-get-started-fad78ec34dcf

Summary -

This is the first blog that I wrote for GSoC. Taylor
suggested that I should work on "integrating a lookup table
extension" first as it is smaller compared to other sub-projects.

The idea is to have a table at the end of .bitmap file which
will contain the offsets (and xor-offsets) of the bitmaps of
selected commits. Whenever git try to get the bitmap of a
particular commit, instead of loading each bitmaps one by one,
git will parse only the desired bitmap by using the offset and
xor-offset of the table. This will reduce the overhead of
loading each and every bitmap.

