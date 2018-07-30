Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B0F61F597
	for <e@80x24.org>; Mon, 30 Jul 2018 15:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeG3RST (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 13:18:19 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:35937 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbeG3RST (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 13:18:19 -0400
Received: by mail-pg1-f176.google.com with SMTP id s7-v6so7468243pgv.3
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 08:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CjixEzFxbca7syxEoLGePo6XNTvPivJXXxR6QvY4pmE=;
        b=eJi4dgLfIRsd1NY+tQv6W3P0JyL2Q8CQaV0Qmenwrbh0pru2h9VZ4EmCChaRvOFv7y
         kSfyqYioTNA33W8HaLdpUmUk7ZDXaeKhioPjVrDrpaSd27BNvdIezvaizC2zpN2xPea4
         DqzGEgcB8qB1zKL991WTQjeNOJBVYPt9k9ARhw+Ixsw0gek+WVPeVUrRl1o0GsLx/UeB
         XXgfuuS6VQPS5/wkhxl63bVsNCpccMVMktJoTG5+uuOS/tIgGWSaHRW2FwmQxEGMxgKS
         DwOwnHrKA6TIQh085rjSDXpVct9P02vZPwwByG0Mtnfjpk+0i8JGcwsYT9JHnlYw/fV6
         rMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CjixEzFxbca7syxEoLGePo6XNTvPivJXXxR6QvY4pmE=;
        b=lEiCznbWPivjNsLLaq4Z6jTEjY3muCSdNSlt+HcbWeig2B4LGeRNsdb+ZBOTW7iwtU
         F2aZPmYPQfgjj9PV4Hny0GpLRx4U/G4YVtsiQaYTYD8AN1IxofOeZ1BlJ3CUaWYtUd5c
         g0Qq1/UDhh0l6N7dBJpSNpOZRuZ7BDxfaVi7Y2i3gr9SIm1JD96y0PNoLaEl5F5gBO6B
         JZ+5EsYB8tfI9eMOvwnTCTdvmlPQv3Pp3jkiAkMNzXOg8WHOgukFTIPsuqm9sK4D0ehH
         saaEQda3r+yF14aSqOj218ogxgC8iFh+WS7yR08XBoQ6QgKZls9jQN4DjBaw/TuJIgju
         gN5A==
X-Gm-Message-State: AOUpUlEehvOTMkluBO/qX9UaRk8U8J38tmCrKQ8dBHXPyW7G9efnRodV
        AXoniour1Uf/mG3tPX27GwmuWZv5
X-Google-Smtp-Source: AAOMgpf2+1+ftMneP+HIClh8tX+dkO+j1nWUVXg40sUEBdj7MyU0Pet0Xb33ZAkVaBUUSi1qZ7lq2g==
X-Received: by 2002:a62:4308:: with SMTP id q8-v6mr18666971pfa.86.1532965366076;
        Mon, 30 Jul 2018 08:42:46 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id u42-v6sm21335063pgn.1.2018.07.30.08.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 08:42:45 -0700 (PDT)
Date:   Mon, 30 Jul 2018 08:42:45 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Jul 2018 15:42:33 GMT
Message-Id: <pull.2.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2.git.gitgitgadget@gmail.com>
References: <pull.2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/9] Add support to develop Git in Visual Studio Code
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

Due to the way Git's source code and build process is structured, it can be quite challenging to use VS Code effectively for developing Git. Which is a shame, as developing with vim and the command-line causes unnecessary churn, and it is quite understandable that most Git developers simply do not want to fight with a modern development environment just to try whether they like developing Git with it.

This topic branch makes it easy to get started using VS Code to develop Git.

Simply run the script `./contrib/vscode/init.sh`. This will initialize the `.vscode/` directory and some files in that directory. After that, just open Git's top-level directory as "folder" in VS Code.

The files have to be generated because of the curious way Git determines what flags to pass to the C compiler, in particular which constants are defined, because they change the compile flow in rather dramatic ways (determining, e.g. which SHA-1 backend to use).

Changes since v1:

- Clarified commit message of the first commit.

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
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-2%2Fdscho%2Fvscode-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2/dscho/vscode-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2

Range-diff vs v1:

  1:  e2e449a00 !  1:  bbf13e40a contrib: add a script to initialize VS Code configuration
     @@ -4,11 +4,14 @@
      
          VS Code is a lightweight but powerful source code editor which runs on
          your desktop and is available for Windows, macOS and Linux. Among other
     -    languages, it has support for C/C++ via an extension.
     +    languages, it has support for C/C++ via an extension, which offers to
     +    not only build and debug the code, but also Intellisense, i.e.
     +    code-aware completion and similar niceties.
      
     -    To start developing Git with VS Code, simply run the Unix shell script
     -    contrib/vscode/init.sh, which creates the configuration files in
     -    .vscode/ that VS Code consumes.
     +    This patch adds a script that helps set up the environment to work
     +    effectively with VS Code: simply run the Unix shell script
     +    contrib/vscode/init.sh, which creates the relevant files, and open the
     +    top level folder of Git's source code in VS Code.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
  2:  3770bd855 =  2:  6c8b5a4f2 vscode: hard-code a couple defines
  3:  de49c4bf2 =  3:  105b50c62 cache.h: extract enum declaration from inside a struct declaration
  4:  b3ce2ccf4 =  4:  4b95b1e2a mingw: define WIN32 explicitly
  5:  06dcf6d97 =  5:  3dd53c04c vscode: only overwrite C/C++ settings
  6:  08212c57e =  6:  384b08836 vscode: wrap commit messages at column 72 by default
  7:  2e880b6f1 =  7:  ba78af756 vscode: use 8-space tabs, no trailing ws, etc for Git's source code
  8:  ce216cf43 =  8:  358f38d3a vscode: add a dictionary for cSpell
  9:  4c2aa015a =  9:  b9c628b88 vscode: let cSpell work on commit messages, too

-- 
gitgitgadget
