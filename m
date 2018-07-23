Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7F6B1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387999AbeGWOyL (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:54:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43284 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387940AbeGWOyK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:54:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id v13-v6so435559pgr.10
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=a8DF69YWEyK9dnhho3FzApO9P0xd3DbiSaOpF0XgyWA=;
        b=eVqsllp+Z6mfnmrGbNd/fQtdUdi725MaYZJzyJOktT/aF/QIxLWpkWsdFdo5vg+/I7
         A+st4BGgK2u0DWeHCjkB+ehi4VF9K9F2bsXHAaI2vb+6ZDhbkBrPeyHkfY2Bg0sEoOrE
         GLZPm6VRFWWl3tdlD00roXDESjorovJwfEG2o0IuhrYEkrw6RwbZvZ9ELeaCmnacVqkk
         uXIProqWvoQTo4SV259OSnMkCPJpAVpu1S6jDFIaAy6k9z0QNIV+30F3XN8rz0jN+mUh
         acCvmbXsGiIucVmHU1vVcq+RnAM6qSih1DjTuryA4wJUM/DJM390runtRbSoNhTaRJtn
         b90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a8DF69YWEyK9dnhho3FzApO9P0xd3DbiSaOpF0XgyWA=;
        b=mfLS3zuOtWrFkl/fD2dD2oiSRhTH1ot5aDeBVsR/ZVZCKy8Pv26NU0i3F/bbYZubrE
         cRtHReY/2JO1bfbFYuR0pv1/WhsBKLAOZnEimq+upJTrwMI/31nWTNz3gGtG9FuUO3Gn
         3N+6pmLTIjjmFEkOTLNVdrBWgy2SL7lvLRR2gyY/QJVSriaNUZXBHDVXwnVrFV6jL6yj
         CRRzl+ubCSjK/z+u6Ss3Ohch06aMlpF//XTvWqNZRhQmUC7rkcukVhzNfOiEJKfgDlvX
         9CE55fYoqS5wI/+0W1wSBf7XgdSD8tSYpd+zHLoKryqmnpKMCAcG0897IDL6YH+9OklP
         m+bQ==
X-Gm-Message-State: AOUpUlELyNT0euEObnC5eSCVF+ZUkGlqM9l87YOX+jFUvwovNu9GbioV
        AuOclBG+W2JZ+MNq5GekbzhGsQny
X-Google-Smtp-Source: AAOMgpcEe7lodwqhNNITUuv3G0+SQN6/2g6a6PNQUOAJzYgWmolJrQzYZYT6PYE1ohnksm5AAznWMA==
X-Received: by 2002:a65:6143:: with SMTP id o3-v6mr12663811pgv.52.1532353968605;
        Mon, 23 Jul 2018 06:52:48 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id b62-v6sm27810211pfm.97.2018.07.23.06.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:52:47 -0700 (PDT)
Date:   Mon, 23 Jul 2018 06:52:47 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Jul 2018 13:52:36 GMT
Message-Id: <pull.2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/9] Add support to develop Git in Visual Studio Code
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Visual Studio Code](https://code.visualstudio.com/) (nickname "VS Code") is a light-weight, cross-platform, Open Source development environment, with an increasingly powerful extension to support C/C++ development. In particular the intellisense support as well as all the other niceties developers might have come to expect from Integrated Development Environments will help accelerate development.

This topic branch makes it easy to get started using VS Code to develop Git itself.

To get started, run the script `./contrib/vscode/init.sh`. This will initialize the `.vscode/` directory and some files in that directory. After that, simply open Git's top-level directory as "folder" in VS Code.

The files have to be generated because of the curious way Git determines what flags to pass to the C compiler, in particular which constants are defined, because they change the compile flow in rather dramatic ways (determining, e.g. which SHA-1 backend to use).

Johannes Schindelin (9):
  contrib: add a script to initialize VS Code configuration
  vscode: hard-code a couple defines
  cache.h: extract enum declaration from inside a struct declaration
  mingw: define WIN32 explicitly
  vscode: only overwrite C/C++ settings
  vscode: wrap commit messages at column 72 by default
  vscode: use 8-space tabs, no trailing ws, etc for Git's source code
  vscode: add a dictionary for cSpell
  vscode: let cSpell work on commit messages, too

 .gitignore                    |   1 +
 cache.h                       |  24 ++-
 config.mak.uname              |   2 +-
 contrib/vscode/.gitattributes |   1 +
 contrib/vscode/README.md      |  14 ++
 contrib/vscode/init.sh        | 375 ++++++++++++++++++++++++++++++++++
 6 files changed, 405 insertions(+), 12 deletions(-)
 create mode 100644 contrib/vscode/.gitattributes
 create mode 100644 contrib/vscode/README.md
 create mode 100755 contrib/vscode/init.sh


base-commit: 53f9a3e157dbbc901a02ac2c73346d375e24978c
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-2%2Fdscho%2Fvscode-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2/dscho/vscode-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2
-- 
gitgitgadget
