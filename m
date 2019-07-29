Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77B131F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbfG2UIK (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:08:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42001 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730159AbfG2UIC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:08:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id x1so13296957wrr.9
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=XZDN62W2L6AYEG6KDJ8ZYuQrTNaJZ8mCQ59qe3uEtWk=;
        b=bleG8wMJTKJSwdRobWJj2cyc9tuJX6wWLL5jrq9qNF4eamJpE6K/S8KMksoBWqxFs7
         CR6MK2fDQLnx4bOx9hx+RZ+w1vit/GoXUs9E0/qV3Zo5256bZV0yRhYQSYvvdiLrd05k
         Nn11riOlnSrdWJGNSMWK1JZyz+Fa71NRs+valfkl6oNboMlaN2L1FKngIfRQzKCubqK7
         hZl5kqKH5OTkF21h/qJWpDf7JhH21MGuQbP49IMHhlTNq8OaDJ/KENO5C03ieeKPIjg8
         WJbqKweKTrQ3z6M+7Wm19qQC+4g22xVRjij0043kuYvcCil5J5CS5rTWa+DDlbc8W/1v
         TwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=XZDN62W2L6AYEG6KDJ8ZYuQrTNaJZ8mCQ59qe3uEtWk=;
        b=jS8uSaWuWxW6bjNVESqm1Q6bow9FVVm3Yu3TZrhTk7buO7Ei26kcqjfW2W1IjyuCtT
         /EGTYvmSsy5VvTcbt/B5+mTSHIz7jXivhDWulE/P89ScVqVs+Kaf7BiGfss0zFVJ9BPt
         2HBtSOzbfkwuGNVFf9h1Pgk+j32kyEnbmQRaKOH0NbRp4cTZXlI1XL5DjL+cAmVu/8FF
         6cjgEr5r6ghBCVzfwTxvdVJXS6coySt8JOx3OE4ISR1i5uWyqAQO1UotOEwnvJlg+ibK
         hRM+Qu/sYgSI0SDEpG5vXPyb4s/o7DGgylQxK3Mq5uatutT+0LnQFXJrmJj6QBTOxOwF
         Fc5w==
X-Gm-Message-State: APjAAAVomMArDMO3p8OEiDsTK3leb0HTpf1790EYOw6JcBjmc1fkMbXb
        oSYa8U2we18/jwO5RhbI1OsiiWsA
X-Google-Smtp-Source: APXvYqxFzaT6N/HaF0WenjTagJHOV1Mwogbrl3WoikJaNICQaF2A6vJe5+KADNgNdVTlf8i9nnD1vg==
X-Received: by 2002:a5d:6190:: with SMTP id j16mr271422wru.49.1564430880718;
        Mon, 29 Jul 2019 13:08:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z1sm63534526wrp.51.2019.07.29.13.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:08:00 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:08:00 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Jul 2019 20:07:36 GMT
Message-Id: <pull.287.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 00/23] Reinstate support for Visual Studio
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A long time ago, we added support to build .sln and .vcproj files for use
within Visual Studio, so that Git could be built in that popular IDE.

This support languished for years and was finally brought back into Git for
Windows partially through the jh/msvc branch that was just merged into 
master. With the tremendous help by Philip Oakley and Jeff Hostetler, this
re-adds support for Visual Studio, focusing on VS 2015 and later (older
versions are currently unsupported, even if we worked a bit on that front,
too; If there are volunteers to add support for older versions, I would be
delighted to review PRs to that end on 
https://github.com/git-for-windows/git).

Note: the currently preferred way to contribute using Visual Studio is by
using Git for Windows' vs/master branch (which is automatically generated
using the make vcxproj build target that this patch series adds, updated
every time Git for Windows' master advances). My plan is to provide a
similar branch in GitGitGadget, based on top of git.git's master, once this
patch series is integrated.

Changes since v1:

 * The empty directory templates/blt/branches/ is now created as part of the
   build.

Johannes Schindelin (14):
  Vcproj.pm: auto-generate GUIDs
  Vcproj.pm: do not configure VCWebServiceProxyGeneratorTool
  Vcproj.pm: urlencode '<' and '>' when generating VC projects
  contrib/buildsystems: ignore irrelevant files in Generators/
  contrib/buildsystems: error out on unknown option
  contrib/buildsystems: handle libiconv, too
  contrib/buildsystems: also handle -lexpat
  contrib/buildsystems: handle options starting with a slash
  contrib/buildsystems: add a backend for modern Visual Studio versions
  msvc: add a Makefile target to pre-generate the Visual Studio solution
  vcxproj: also link-or-copy builtins
  .gitignore: ignore Visual Studio's temporary/generated files
  bin-wrappers: append `.exe` to target paths if necessary
  git: avoid calling aliased builtins via their dashed form

Philip Oakley (9):
  Vcproj.pm: list git.exe first to be startup project
  contrib/buildsystems: ignore invalidcontinue.obj
  contrib/buildsystems: fix misleading error message
  contrib/buildsystems: handle quoted spaces in filenames
  contrib/buildsystems: ignore gettext stuff
  contrib/buildsystems: redirect errors of the dry run into a log file
  contrib/buildsystems: optionally capture the dry-run in a file
  contrib/buildsystems: handle the curl library option
  .gitignore: touch up the entries regarding Visual Studio

 .gitignore                                 |   8 +-
 Makefile                                   |   2 +-
 compat/vcbuild/README                      |  23 ++
 config.mak.uname                           |  76 ++++
 contrib/buildsystems/Generators.pm         |   2 +-
 contrib/buildsystems/Generators/Vcproj.pm  | 119 ++-----
 contrib/buildsystems/Generators/Vcxproj.pm | 388 +++++++++++++++++++++
 contrib/buildsystems/engine.pl             |  55 ++-
 git.c                                      |   3 -
 9 files changed, 576 insertions(+), 100 deletions(-)
 create mode 100644 contrib/buildsystems/Generators/Vcxproj.pm


base-commit: 9d418600f4d10dcbbfb0b5fdbc71d509e03ba719
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-287%2Fdscho%2Fvisual-studio-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-287/dscho/visual-studio-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/287

Range-diff vs v1:

  1:  240ff42517 =  1:  240ff42517 Vcproj.pm: auto-generate GUIDs
  2:  a7898b0025 =  2:  a7898b0025 Vcproj.pm: list git.exe first to be startup project
  3:  d42fd0fe2e =  3:  d42fd0fe2e Vcproj.pm: do not configure VCWebServiceProxyGeneratorTool
  4:  f4d41c65e9 =  4:  f4d41c65e9 Vcproj.pm: urlencode '<' and '>' when generating VC projects
  5:  82e820017b =  5:  82e820017b contrib/buildsystems: ignore invalidcontinue.obj
  6:  60a45f2694 =  6:  60a45f2694 contrib/buildsystems: ignore irrelevant files in Generators/
  7:  b8eb868316 =  7:  b8eb868316 contrib/buildsystems: fix misleading error message
  8:  c10fd668ef =  8:  c10fd668ef contrib/buildsystems: handle quoted spaces in filenames
  9:  e908d01f07 =  9:  e908d01f07 contrib/buildsystems: ignore gettext stuff
 10:  3cfbb7843a = 10:  3cfbb7843a contrib/buildsystems: redirect errors of the dry run into a log file
 11:  eaf1dd449d = 11:  eaf1dd449d contrib/buildsystems: optionally capture the dry-run in a file
 12:  c696152c7f = 12:  c696152c7f contrib/buildsystems: error out on unknown option
 13:  b07e83440d = 13:  b07e83440d contrib/buildsystems: handle the curl library option
 14:  052a98b8bb = 14:  052a98b8bb contrib/buildsystems: handle libiconv, too
 15:  5c9702ea50 = 15:  5c9702ea50 contrib/buildsystems: also handle -lexpat
 16:  1d4c5539ef = 16:  1d4c5539ef contrib/buildsystems: handle options starting with a slash
 17:  59c50989ea ! 17:  bc6a10ba47 contrib/buildsystems: add a backend for modern Visual Studio versions
     @@ -296,6 +296,7 @@
      +      <DLLsAndPDBs Include="\$(VCPKGBinDirectory)\\*.dll;\$(VCPKGBinDirectory)\\*.pdb" />
      +    </ItemGroup>
      +    <Copy SourceFiles="@(DLLsAndPDBs)" DestinationFolder="\$(OutDir)" SkipUnchangedFiles="true" UseHardlinksIfPossible="true" />
     ++    <MakeDir Directories="..\\templates\\blt\\branches" />
      +  </Target>
      +EOM
      +    }
 18:  23615bc8cf = 18:  2a3379d721 msvc: add a Makefile target to pre-generate the Visual Studio solution
 19:  33bed9a7a6 = 19:  4dbbe3f4a2 vcxproj: also link-or-copy builtins
 20:  44f0f3235e = 20:  dc4a9cc620 .gitignore: touch up the entries regarding Visual Studio
 21:  8f19bb5a8c = 21:  3f862bf878 .gitignore: ignore Visual Studio's temporary/generated files
 22:  971247e320 = 22:  a81cc2ccce bin-wrappers: append `.exe` to target paths if necessary
 23:  db69b33ff4 <  -:  ---------- t5505,t5516: create .git/branches/ when needed
 24:  151b9921d0 = 23:  6452dc11bc git: avoid calling aliased builtins via their dashed form

-- 
gitgitgadget
