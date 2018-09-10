Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4466B1F404
	for <e@80x24.org>; Mon, 10 Sep 2018 17:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbeIJWAX (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 18:00:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43170 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIJWAX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 18:00:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so10779960pfi.10
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 10:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mgQrnrX/pIQOUL6QgMeBuYMTEmTcFoABfhpG47S5/sE=;
        b=f2ZAsVIuQ1PGvk1jNpPOYiRdNnQ+5E3jQ9LE1RJOF9SWUkDGVthNoaVBK3dYB+r76w
         9xXzwuCoOErzZUW644AW82crTWuFtfY9jYHHkczoGHHwV5rP3DNhlTw9tE3ji/ALMF54
         dRTw+E6YSrZUtg7wW1/N1/ygdEOf/8MdL+C4PUi4c1RLlkDiscHAn1jF6vq3LxthiH6d
         hwu9SxEs4bvfl4tw+/1NznVKehjn6qvbDbyZjlWrf7b7vUTy3jfelhgEzYog1teltGRC
         XZhOAWCfoxq1/SjuEnFmMFSP0A7ZfimLg8G09bFrMtP2CVc3XEp+6NlqYp7o9s1ArY3t
         vYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mgQrnrX/pIQOUL6QgMeBuYMTEmTcFoABfhpG47S5/sE=;
        b=NO1lWSnTFxG1XcDGDFKI0i5lvi/cHlX9EHYd9nQpje5+tJAWI/oX3n3RozpWJ917J0
         PeZtYQZ01whqQbl73DZJ6t63gTxlO1Ae+zC9/NDGXkGl+Dp93qmMDxnqO7b5/nMMxokb
         xQn26ScK5p6JsrHo3gSH1Y3VTHKUBPpWqXqT0yvSsfS3h/l1w32td8fAYfZj4n/wt72w
         4mT1rOm3D/54/4Hi93h5pKcrN5jlEYotn7iTNabpFno7tSurUWh5SE3jArakNmkIumsN
         BREWtPk+Hv+Dt112OCvkOqjeAuMev/jH/ZL2V9hGSIxr3zNZ7m/zLy7Qh8X9OAz2Qr9l
         sQ5A==
X-Gm-Message-State: APzg51A7WDf0oZPkCFlz2ewNV2deG75v9U7+OzNAULsA+JaivuNCOZ+U
        +EovfLMqtRsuI9ny/Xzahjt5ND6y
X-Google-Smtp-Source: ANB0VdYRx77m5pd3OAe/HJxMh7u9oLDh1+VDvEombSPoioEvC5N/0ShgBuqpFItk9BR63t+oRBXIGg==
X-Received: by 2002:a63:3281:: with SMTP id y123-v6mr23816894pgy.310.1536599120896;
        Mon, 10 Sep 2018 10:05:20 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id z20-v6sm37134330pfd.99.2018.09.10.10.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 10:05:20 -0700 (PDT)
Date:   Mon, 10 Sep 2018 10:05:20 -0700 (PDT)
X-Google-Original-Date: Mon, 10 Sep 2018 17:05:15 GMT
Message-Id: <pull.35.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.35.git.gitgitgadget@gmail.com>
References: <pull.35.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/2] Fixup for js/mingw-o-append
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The recent change mingw O_APPEND change breaks writing to named pipes on
Windows. The first commit adds a new test to confirm the breakage and the
second commit fixes the problem. These could be squashed together or we can
just keep the fix and omit the test if that would be better.

d641097589 (js/mingw-o-append) mingw: enable atomic O_APPEND

The new mingw_open_append() routine successfully opens the client side of
the named pipe, but the first write() to it fails with EBADF. Adding the
FILE_WRITE_DATA corrects the problem.

 Signed-off-by: Jeff Hostetler jeffhost@microsoft.com
[jeffhost@microsoft.com]

Cc: j6t@kdbg.orgCc: johannes.schindelin@gmx.deCc: gitster@pobox.comCc: 
peff@peff.net

Jeff Hostetler (2):
  t0051: test GIT_TRACE to a windows named pipe
  mingw: fix mingw_open_append to work with named pipes

 Makefile                           |  1 +
 compat/mingw.c                     | 38 ++++++++++++++--
 t/helper/test-tool.c               |  3 ++
 t/helper/test-tool.h               |  3 ++
 t/helper/test-windows-named-pipe.c | 72 ++++++++++++++++++++++++++++++
 t/t0051-windows-named-pipe.sh      | 17 +++++++
 6 files changed, 131 insertions(+), 3 deletions(-)
 create mode 100644 t/helper/test-windows-named-pipe.c
 create mode 100755 t/t0051-windows-named-pipe.sh


base-commit: d641097589160eb795127d8dbcb14c877c217b60
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-35%2Fjeffhostetler%2Ffixup-mingw-o-append-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-35/jeffhostetler/fixup-mingw-o-append-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/35

Range-diff vs v1:

 1:  03453cb521 ! 1:  ecb30eb47c t0051: test GIT_TRACE to a windows named pipe
     @@ -140,7 +140,7 @@
      +
      +. ./test-lib.sh
      +
     -+test_expect_success MINGW 'o_append write to named pipe' '
     ++test_expect_failure MINGW 'o_append write to named pipe' '
      +	GIT_TRACE="$(pwd)/expect" git status >/dev/null 2>&1 &&
      +	{ test-tool windows-named-pipe t0051 >actual 2>&1 & } &&
      +	pid=$! &&
 2:  f433937d55 < -:  ---------- mingw: fix mingw_open_append to work with named pipes
 -:  ---------- > 2:  f0361dd306 mingw: fix mingw_open_append to work with named pipes

-- 
gitgitgadget
