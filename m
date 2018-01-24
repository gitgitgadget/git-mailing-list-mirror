Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 654421F404
	for <e@80x24.org>; Wed, 24 Jan 2018 13:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933779AbeAXNpG (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 08:45:06 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37534 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932103AbeAXNpF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 08:45:05 -0500
Received: by mail-wm0-f68.google.com with SMTP id v71so8738482wmv.2
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 05:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VfwEr+bhNoVNYGW8aNfa4JBBc+SE36K/VweIFPtp0rY=;
        b=kZDcVfyX0GeLdUkFykfCzSQC1Celv62VAd8dSJxrAGP4MnU9RDjolcofQ6UATlJGyW
         MIoLjc5tLpseLuC7xJCqbA/1Q5yfB+OXkkmhicpnZh5VBX4bpHnBmFCcMF6PQQ4BqhR4
         KswWLVhYs2h1XSTNsfWJPg14E8sOasiDjwy4jn1RBMfxVNSU6hhTh8v6UKdVWxJgVVVQ
         1bnC5aNRLdvrJN1F2l+sI8O5jbxED+4q5YKvfo7OX5gIgYRBiQimf6DKu76Fpxbg5A0R
         k5EQgYXhisMqi5l/m7jOP8y4bo99GPQCrDwxx/kr6z91jLPyjcbqaZSXcC+mFn18kKBb
         plhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VfwEr+bhNoVNYGW8aNfa4JBBc+SE36K/VweIFPtp0rY=;
        b=lGXt5DY6ZIbL0a1cPlG8EuN0L9oCoQK6j1bZA3Z/10ORLTqwbjWDwbLOcAmAixa2xx
         tBNXbxqX4t39svFwtDUukh0GRs/dvPewC1rWcMPGFCVHquRLAddrdG+Epf/Nse33zwMh
         Xy8xSIi3cbEhXAJ1LbfHHrj8KLpIMLKEONlc0tXBeQzxMRQ95mm4M+KepyMLAtc4doIB
         DZ3ozT/2I/UVsV/1e4Ab44j9SDoNuW5cHxY0cnAkTrMaODg+tso1+CLjC9JR/HXFce/Q
         JLLLh6I4aPNJw5jhVVPe0ySK8gfpMxX5j5rWxWFvA+9aZ8sPWFLpDqeaftwWH3Q47xgU
         Ca7A==
X-Gm-Message-State: AKwxytfZTQFeipOi6yp0gXa4lRHOaz1DALLRnN8bUpBo/e+zEaNkF604
        cCnWsFo8NeomaGDKPy8VmcXHa8n673nPI+pxKWy17N9r
X-Google-Smtp-Source: AH8x227yVvvtbsAafG9e/iXzB+Azrv8snhhfxpQaw2Pbp/Dx+CEvrZBCnA5ncQR4b3lxOOMl7H8e4ShY9J+2EbE83SU=
X-Received: by 10.28.208.142 with SMTP id h136mr5249793wmg.133.1516801504240;
 Wed, 24 Jan 2018 05:45:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.166.115 with HTTP; Wed, 24 Jan 2018 05:45:03 -0800 (PST)
In-Reply-To: <20180123001648.24260-1-isaachier@gmail.com>
References: <20180123001648.24260-1-isaachier@gmail.com>
From:   Isaac Hier <isaachier@gmail.com>
Date:   Wed, 24 Jan 2018 08:45:03 -0500
Message-ID: <CAG6xkCZn6m2n0rDvpN6MmZcOr2hJBRCfhrppC37f-DUj3_JZsw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Implement CMake build
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Isaac Hier <isaachier@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I realize this is a huge patch, but does anyone have feedback for the
general idea?

On Mon, Jan 22, 2018 at 7:16 PM, Isaac Hier <isaachier@gmail.com> wrote:
> This patch adds a mostly complete (aside from building tests, documentation,
> installation, etc.) CMake build to the git project. I am not sure how much
> interest there is in a CMake build, so please send me feedback one way or
> another. Personally, I believe CMake will help with Windows builds and is
> somewhat easier to read than a Makefile. I considered, adding this to the
> contrib directory, but CMakeLists.txt almost always reside in the original
> directories, and I'm not sure how wise it would be to do otherwise. If you are
> interested in a CMake build, I would be more than happy to finish up the work
> here. Decided to wait until I discussed the issue here to finish the final parts
> of the build.
>
> Isaac Hier (1):
>   Implement CMake build
>
>  CMakeLists.txt              | 1849 +++++++++++++++++++++++++++++++++++++++++++
>  cmake/GenerateCmdlist.cmake |   83 ++
>  cmake/fopen_dir_test.c      |   11 +
>  cmake/fstat_test.c          |   37 +
>  cmake/gmtime_test.c         |    7 +
>  cmake/iconv_test.c          |   13 +
>  cmake/inline_test.c         |    9 +
>  cmake/mkdir_test.c          |    7 +
>  cmake/mmap_test.c           |   35 +
>  cmake/parens_test.c         |    6 +
>  cmake/snprintf_test.c       |    7 +
>  cmake/sysctl_test.c         |   11 +
>  12 files changed, 2075 insertions(+)
>  create mode 100644 CMakeLists.txt
>  create mode 100644 cmake/GenerateCmdlist.cmake
>  create mode 100644 cmake/fopen_dir_test.c
>  create mode 100644 cmake/fstat_test.c
>  create mode 100644 cmake/gmtime_test.c
>  create mode 100644 cmake/iconv_test.c
>  create mode 100644 cmake/inline_test.c
>  create mode 100644 cmake/mkdir_test.c
>  create mode 100644 cmake/mmap_test.c
>  create mode 100644 cmake/parens_test.c
>  create mode 100644 cmake/snprintf_test.c
>  create mode 100644 cmake/sysctl_test.c
>
> --
> 2.14.1
>
