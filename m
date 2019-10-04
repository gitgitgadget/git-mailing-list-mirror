Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 613AA1F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 15:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389708AbfJDPJ2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 11:09:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36803 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388802AbfJDPJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 11:09:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so7682212wrd.3
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 08:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7LykGDhs2SU76jy8bLReMk7rmhtvnUK5OKGGpveG5nY=;
        b=cPqRAlHbrAdaRQmNzuNQn4cxcUtBqeMVwFsaURXbVUNJKYicbV5ELbvX1A95Vbp6x4
         fG928Iy7VuGnOwAjxSSl1cCfFlIhkJlIL3MTXPcXKN2C5wc2xL2um0w5f9qx7hPIdH9J
         6v+P/c6AlaiAsHMQMDck6h87R7rHQEkvPq5I7rsHeEI+HvrpMfaufVjWhRknt8/pcSna
         5iW/jGflVd6wR2Diy44t+8cAKBaDzlDL6lPneppZ9kpEm2KgxvBaUwBP7QS6y8uJK1Md
         gRIHV33anF+BxJ5Yxd2Tp1XOg/O8KTxenU3Xrr6uJnngQSXPEkg/M6P3114vDaMIqXa+
         6PcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7LykGDhs2SU76jy8bLReMk7rmhtvnUK5OKGGpveG5nY=;
        b=i1VUWyBk+nHZ38gry7eeVmYOG75gpWHYoeLXt/T4A//O+qZUXj2X0abTO8xE8WMArI
         ToFE6N8G2M/+FXZSVkB6tR79DBq2HQnaZ/MenyOOaWuVX0GfPIclfF++xnFDbFabtfWz
         +NG71M8NkFiyzUcytV66RNkyQpLCdDrBHFzs/BqnIqKIZ4KNvHUw+tSqPAyn+1/k4jMa
         mVK3fq3+t6Fh0Pe+MvnT/Zn/X92P0KCUKygBhMM/OqNtx+OPSW385yzgtH6zYQ2LcB1x
         46uoxDw7FJLc4hlcZ2zjI+XnS1O2UwosSkfsjw1/NE6j2BiWjT1PtZqe7gTNVmHI0Wrj
         C//Q==
X-Gm-Message-State: APjAAAUUEoPR0GcUqyiIB2YGzjFPunMiSMtSImkmMUkNJbAkkyI0+ZJp
        OBJ1Wpi1OxJbKYOIIhRaOTrm1wg3
X-Google-Smtp-Source: APXvYqwVfbiV4KD6dywTtpTZJAr1TfAiNYc6buwukaJobB0IZ/Buz5loJF5PKGq2/FhWopQDOtPxhA==
X-Received: by 2002:adf:e701:: with SMTP id c1mr12295404wrm.296.1570201765074;
        Fri, 04 Oct 2019 08:09:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11sm7531305wmh.34.2019.10.04.08.09.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 08:09:23 -0700 (PDT)
Date:   Fri, 04 Oct 2019 08:09:23 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Oct 2019 15:09:09 GMT
Message-Id: <pull.288.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.v2.git.gitgitgadget@gmail.com>
References: <pull.288.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 00/13] ci: include a Visual Studio build & test in our Azure Pipeline
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git's Continuous Integration (CI) includes an Azure Pipeline that builds Git
on Linux, macOS and Windows, in the former two cases even in multiple
configurations (using GCC vs clang, 32-bit vs 64-bit, etc). On Windows, we
only build using GCC, using (a subset of) Git for Windows' SDK.

Recently, a patch series made it into Git that re-instates the ability to
generate project files for use with Visual Studio. The idea there being:
contributors can check out a special branch that has those generated files
in one generated commit on top of e.g. Git for Windows' master, allowing the
contributors to build Git in Visual Studio, without the need for downloading
Git for Windows' SDK (which weighs quite a bit: ~600MB download, ~2GB disk
footprint). The tests can then be run from a regular Git for Windows Bash.

This patch series adds that axis to Git's Azure Pipeline: the project files
are generated, MSBuild (which is kind of the command-line equivalent of
Visual Studio's "Build" operation) is used to build Git, and then a
parallelized test job runs the test suite in a Portable Git.

These patches are based on js/visual-studio.

Changes since v2:

 * The overflow check introduced in v1 was consolidated into a single
   helper.

Changes since v1:

 * "While at it", we now also check for overflows when doing that -1 -
   <unsigned> arithmetic.
 * The JUnit-style XML is finalized also in case that the script aborts e.g.
   due to an incorrect number of arguments in a test_expect_success call.

Johannes Schindelin (13):
  push: do not pretend to return `int` from `die_push_simple()`
  msvc: avoid using minus operator on unsigned types
  winansi: use FLEX_ARRAY to avoid compiler warning
  compat/win32/path-utils.h: add #include guards
  msvc: ignore some libraries when linking
  msvc: handle DEVELOPER=1
  msvc: work around a bug in GetEnvironmentVariable()
  vcxproj: only copy `git-remote-http.exe` once it was built
  vcxproj: include more generated files
  test-tool run-command: learn to run (parts of) the testsuite
  tests: let --immediate and --write-junit-xml play well together
  ci: really use shallow clones on Azure Pipelines
  ci: also build and test with MS Visual Studio on Azure Pipelines

 Makefile                                   |   4 +
 azure-pipelines.yml                        | 164 ++++++++++++++++++++-
 builtin/push.c                             |   4 +-
 cache.h                                    |  13 ++
 compat/mingw.c                             |   2 +
 compat/vcbuild/scripts/clink.pl            |  48 +++++-
 compat/win32/path-utils.h                  |   5 +
 compat/winansi.c                           |   2 +-
 config.mak.uname                           |  19 ++-
 contrib/buildsystems/Generators/Vcxproj.pm |   3 +
 read-cache.c                               |   4 +-
 sha1-lookup.c                              |   4 +-
 t/helper/test-run-command.c                | 153 +++++++++++++++++++
 t/test-lib.sh                              |  38 +++--
 14 files changed, 430 insertions(+), 33 deletions(-)


base-commit: aac6ff7b5beeea9bca66ecda6eec60fc1dd447ec
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-288%2Fdscho%2Fazure-pipelines-msvc-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-288/dscho/azure-pipelines-msvc-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/288

Range-diff vs v2:

  1:  4d0b38125a =  1:  4d0b38125a push: do not pretend to return `int` from `die_push_simple()`
  2:  8800320590 <  -:  ---------- msvc: avoid using minus operator on unsigned types
  -:  ---------- >  2:  7fe2a85506 msvc: avoid using minus operator on unsigned types
  3:  8512a3e96d =  3:  e632a4eef4 winansi: use FLEX_ARRAY to avoid compiler warning
  4:  0345b08f54 =  4:  cd96d7ff70 compat/win32/path-utils.h: add #include guards
  5:  5add01f8ff =  5:  bf09257f65 msvc: ignore some libraries when linking
  6:  5c880f923e =  6:  39c707464c msvc: handle DEVELOPER=1
  7:  1f2245a228 =  7:  91b09cfdd8 msvc: work around a bug in GetEnvironmentVariable()
  8:  582b299634 =  8:  cca891450d vcxproj: only copy `git-remote-http.exe` once it was built
  9:  38ccf999e7 =  9:  e6e60b3c2b vcxproj: include more generated files
 10:  24b1c7bff3 = 10:  d2c4973431 test-tool run-command: learn to run (parts of) the testsuite
 11:  7be13d19e1 = 11:  0644a2f8da tests: let --immediate and --write-junit-xml play well together
 12:  bde1e8ef65 = 12:  4495c392fd ci: really use shallow clones on Azure Pipelines
 13:  7af1c01a08 = 13:  b1ff8eff4d ci: also build and test with MS Visual Studio on Azure Pipelines

-- 
gitgitgadget
