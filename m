Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F91120248
	for <e@80x24.org>; Fri, 12 Apr 2019 12:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfDLMAd (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 08:00:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45705 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfDLMAd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 08:00:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id o26so8060466edv.12
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 05:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:mime-version:content-transfer-encoding
         :fcc:content-transfer-encoding:to:cc;
        bh=BrIXCjVvEyIQwE5Gi4X6LLLrWuaqUi5ldueKiV3mrvs=;
        b=ciKdp7Nj1KFTzxu5XABB8ECi/ySRKR+QYP7eZe4fvEQjpsiTKa+vosiDhSvS7Ms+7/
         p+I36RZD2RzGLlHiwLZwP2tscg08p6pJNxBKAYw8SGX1tkQKouWsZ13cP+RjYarxoj1t
         tDArzvn3K2zmeeJSYf608mkN48InXRELrFbSOG5zR6q3hYLAJF6YGrr61pohkXKgXfi2
         vSxEJzdHNg3dbKoTzGJaB6oOH7tKJAIdPg1LkiZrDzSmgRFkrPE7r3rqBook+xbdfzi6
         eG63+HRzOQ8fg8A4YITLOaD/3ypodZEdor4tB8yDJBG5/9H8NIQUPWB5UWVJpngZSRK2
         vF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=BrIXCjVvEyIQwE5Gi4X6LLLrWuaqUi5ldueKiV3mrvs=;
        b=iGAlNYn44NyaDWKIuZlIDwVD200IBCCvAuyIZUR96Fphu+81rHGQsKao/4017B/uWh
         7MNkS9zIy+SMreLFu0SQGmkMkQCkPMKZK+h7xkweGpA1f53KocQUxfKpmJj08Og28y1x
         4/DXN+fNPEK085OkOR8mR2e0lQABDEtVC4ihbvID+NM954iWk4sgQXmwWEv0czfioaPO
         5ouzRSoKpVQPsAyj14U3uzDW/9pqkhUFYfC/fO6GawZo7QHyoawn5kaQaqrmZnDDUctN
         PCVAqop3Ih4QeGXbkM1WY+Vc85+sHOUoKZ6W2lMlyDNFE9jU/ZkNrfPFtcXu4AUCo7Hy
         8Q/g==
X-Gm-Message-State: APjAAAVcnm/7wW1SKut7pY9AOwSji0LijybgVoU+CStNAo307DqWzpWy
        w2S8EeVco8ynpehxuYFPC0mu0mgH
X-Google-Smtp-Source: APXvYqx6iXHfjFiKganS/OXDVmW2dm4ZSx1NnjCRL4eAYiLHiNS3ul7FC0Mdmk53hRzdZBOpDJynLA==
X-Received: by 2002:a17:906:7c96:: with SMTP id w22mr9414013ejo.76.1555070431496;
        Fri, 12 Apr 2019 05:00:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm7365805eje.38.2019.04.12.05.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 05:00:31 -0700 (PDT)
Date:   Fri, 12 Apr 2019 05:00:31 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Apr 2019 12:00:23 GMT
Message-Id: <pull.168.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/7] Assorted Documentation-related fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While working on better support for make check-docs on Windows, I noticed a
couple more things, e.g. some "commands" were reported as being listed but
not built, e.g. gitcli (i.e. the parts of command-list.txt that are marked
as "guide").

This patch series cleans up those loose ends: after this, make check-docs 
reports no issues on Windows.

Johannes Schindelin (7):
  remote-testgit: move it into the support directory for t5801
  help -a: do not list commands that are excluded from the build
  check-docs: do not pretend that commands are listed which are excluded
  docs: exclude documentation for commands that have been excluded
  check-docs: do not bother checking for legacy scripts' documentation
  test-tool: handle the `-C <directory>` option just like `git`
  Turn `git serve` into a test helper

 .gitignore                                    |  1 -
 Documentation/.gitignore                      |  1 +
 Documentation/Makefile                        |  3 +
 Makefile                                      | 58 +++++++++++--------
 builtin.h                                     |  1 -
 generate-cmdlist.sh                           | 10 +++-
 git.c                                         |  1 -
 builtin/serve.c => t/helper/test-serve-v2.c   |  7 ++-
 t/helper/test-tool.c                          | 20 +++++++
 t/helper/test-tool.h                          |  1 +
 t/t5701-git-serve.sh                          | 32 +++++-----
 t/t5702-protocol-v2.sh                        |  5 +-
 t/t5703-upload-pack-ref-in-want.sh            | 16 ++---
 t/t5801-remote-helpers.sh                     |  2 +
 .../t5801/git-remote-testgit                  |  0
 15 files changed, 104 insertions(+), 54 deletions(-)
 rename builtin/serve.c => t/helper/test-serve-v2.c (81%)
 rename git-remote-testgit.sh => t/t5801/git-remote-testgit (100%)


base-commit: 5ee42463399ca3cc75b7e6e4368a3a5df5b010f2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-168%2Fdscho%2Fdocs-misc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-168/dscho/docs-misc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/168
-- 
gitgitgadget
