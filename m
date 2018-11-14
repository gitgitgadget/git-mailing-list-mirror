Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E06201F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 16:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbeKOCf7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 21:35:59 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173]:34696 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKOCf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 21:35:59 -0500
Received: by mail-pl1-f173.google.com with SMTP id f12-v6so8043675plo.1
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 08:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fPJZPqKoU3G5dt+KQl1rj7fYbvvR4H6x7MvuY96KXLM=;
        b=L0yGvHVqv2WXkaIbH9CP1+IABmfewzIP8xtzOfa2NvSUPbZWW6DYlwJ+ZckNc4Hck9
         mRr7SuqN7UuICSlDmGKDXh6sTV+6BXA1K63Sc3dF6x/UUWyOiLs2EUdWM7oRMZdqREhG
         KftuhhFyH0jdKYYmxpmBZXS8U+uaRUTPUEVb83VeQUAaF8gaQKKQw5lf+T5D0UolFqwj
         RQAoPCCoQQ9ybU7554413yzZhcnZ4ZzjGbvMQ+7v7u+qq8VzZKTXWsJxCEwOs+gmpHam
         k7EN8tDI/5G3s4F/Np6YwKkPTCmrOHYmggSz5jZFXEGcAppXqS0Y7BbnVwRJs0GaZwYO
         y20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fPJZPqKoU3G5dt+KQl1rj7fYbvvR4H6x7MvuY96KXLM=;
        b=Q1nSfNQn+x8gH8+BIESipNfylLc5FJ0CSnaMo7fVxKsHU5L6TncyHuzMOrQ3DvS7pN
         dirdDM/F2Cj5DCDUCeQtlsqRHJuSnq++PLgR0+93HcQDTZYpVZ8LFwvVuvTk5lcUEJt9
         VyhmOZLzYhLhtQV9M1wekOS4+Il6nlVV74ziy/s48g/qbAKYk2doYM6euD6ZBOVn1CDe
         m3KsDGMjU+IbGMyQeDINzbeiy/NvGs+m9yrPpguO1EGnZoVTqthESnDM6QwtbOv8Stk7
         oq/I+CuI4pV1p02k2rYYUOoesIKKKTA+29+4rIWl8vGQT+vHmVWrN5Od1nBopE1kQEeD
         bBTw==
X-Gm-Message-State: AGRZ1gICC27naqI33OkZo+78GUn549hVXd91XLYv7S7UcENmx6CRHSA9
        r3Y+d6u5C8+OhDvc6k9KwKPZwpt1
X-Google-Smtp-Source: AJdET5ejV9cn8gpzgR1TuOZMHpIr67TeooNr/nkF73upxFWpPXDRJK77xmYCsLxzqEfW0/SMYjSoOw==
X-Received: by 2002:a17:902:a601:: with SMTP id u1mr2575195plq.77.1542213123510;
        Wed, 14 Nov 2018 08:32:03 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id a18sm28397741pgj.30.2018.11.14.08.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 08:32:02 -0800 (PST)
Date:   Wed, 14 Nov 2018 08:32:02 -0800 (PST)
X-Google-Original-Date: Wed, 14 Nov 2018 16:31:55 GMT
Message-Id: <pull.73.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.73.git.gitgitgadget@gmail.com>
References: <pull.73.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/5] tests: various improvements to the GIT_TEST_INSTALLED feature
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

By setting the GIT_TEST_INSTALLED variable to the path of an installed Git
executable, it is possible to run the test suite also on a specific
installed version (as opposed to a version built from scratch).

The only thing this needs that is unlikely to be installed is the test
helper(s).

However, there have been a few rough edges around that, identified in my
(still ongoing) work to support building Git in Visual Studio (where we do
not want to run GNU Make, and where we have no canonical way to create, say,
hard-linked copies of the built-in commands, and other work to let Git for
Windows play better with BusyBox.

Triggered by a comment of AEvar
[https://public-inbox.org/git/20181102223743.4331-1-avarab@gmail.com/], I
hereby contribute these assorted fixes for the GIT_TEST_INSTALLED feature.

Changes since v1:

 * Now we verify in test-lib.sh also in the GIT_TEST_INSTALLED case whether
   the Git executable is working (thanks, Peff!).
 * The commit message of 5/5 was touched up.

Johannes Schindelin (5):
  tests: fix GIT_TEST_INSTALLED's PATH to include t/helper/
  tests: respect GIT_TEST_INSTALLED when initializing repositories
  t/lib-gettext: test installed git-sh-i18n if GIT_TEST_INSTALLED is set
  tests: do not require Git to be built when testing an installed Git
  tests: explicitly use `git.exe` on Windows

 Makefile                |  1 +
 t/lib-gettext.sh        |  7 ++++++-
 t/test-lib-functions.sh |  3 ++-
 t/test-lib.sh           | 22 ++++++++++++++++------
 4 files changed, 25 insertions(+), 8 deletions(-)


base-commit: d166e6afe5f257217836ef24a73764eba390c58d
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-73%2Fdscho%2Ftest-git-installed-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-73/dscho/test-git-installed-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/73

Range-diff vs v1:

 1:  2b04f9f086 = 1:  3b68e0fe8a tests: fix GIT_TEST_INSTALLED's PATH to include t/helper/
 2:  948b3dc146 = 2:  80d50d5932 tests: respect GIT_TEST_INSTALLED when initializing repositories
 3:  eddea552e4 = 3:  49e408677a t/lib-gettext: test installed git-sh-i18n if GIT_TEST_INSTALLED is set
 4:  316e215e54 < -:  ---------- tests: do not require Git to be built when testing an installed Git
 -:  ---------- > 4:  b801dc8027 tests: do not require Git to be built when testing an installed Git
 5:  cd314e1384 ! 5:  fbdb659de6 tests: explicitly use `git.exe` on Windows
     @@ -2,6 +2,17 @@
      
          tests: explicitly use `git.exe` on Windows
      
     +    On Windows, when we refer to `/an/absolute/path/to/git`, it magically
     +    resolves `git.exe` at that location. Except if something of the name
     +    `git` exists next to that `git.exe`. So if we call `$BUILD_DIR/git`, it
     +    will find `$BUILD_DIR/git.exe` *only* if there is not, say, a directory
     +    called `$BUILD_DIR/git`.
     +
     +    Such a directory, however, exists in Git for Windows when building with
     +    Visual Studio (our Visual Studio project generator defaults to putting
     +    the build files into a directory whose name is the base name of the
     +    corresponding `.exe`).
     +
          In the bin-wrappers/* scripts, we already take pains to use `git.exe`
          rather than `git`, as this could pick up the wrong thing on Windows
          (i.e. if there exists a `git` file or directory in the build directory).
     @@ -68,11 +79,12 @@
      +
       ################################################################
       # It appears that people try to run tests without building...
     --test -n "$GIT_TEST_INSTALLED" || "$GIT_BUILD_DIR/git" >/dev/null ||
     -+test -n "$GIT_TEST_INSTALLED" || "$GIT_BUILD_DIR/git$X" >/dev/null ||
     +-"${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git" >/dev/null
     ++"${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X" >/dev/null
       if test $? != 1
       then
     - 	echo >&2 'error: you do not seem to have built git yet.'
     + 	if test -n "$GIT_TEST_INSTALLED"
     +@@
       	exit 1
       fi
       

-- 
gitgitgadget
