Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E10AD1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 00:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733025AbfJWATm (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 20:19:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38691 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732224AbfJWATm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 20:19:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id v9so8719825wrq.5
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 17:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=fyI9nWobnchHZSPjhHur3siIuvrXwUPfbL+4vF4fFm4=;
        b=TK7B9D+tMHJTkFk5jocTtmGZEKjkLBlXCnwAvqBSZj+C8l66HeUx0AXBEjU/9MAG2L
         trjkoS0bmP/2jl3Rq7rWkmkjUEvXfTtYD61+Do+tmxupihGp18g6v4AfwyvF4Flo6VLc
         avMDyK+5NaD0Qw5lyJPl7IYAyt3JIEbq6kqvNlEhEzQGFAXkZYMT699q4VHdEZpZTqon
         2g3JVpHryucMVTLMGAPbRq5Mk1JJechfjhFyf071l/N6RDWfqk9JgBFQMMty0B1pCasN
         TcdJVgCkiB4SK30hCOw1iPrV+Mt27uryDlGhjNYUPn2GJ7UzN+Fo9bo4MSIkKYoE3EvJ
         cZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=fyI9nWobnchHZSPjhHur3siIuvrXwUPfbL+4vF4fFm4=;
        b=LvJmW+OGdD737h+dt+XkIqdv/Kb0Zf+d9MH192ZPmjPGsgSvruxKXm3YbCTSUl0UFp
         c2hb/Cd7UiXPZ+eAWc763bCcWZkwQdnCxqWeuTmg1RehH5NgqvsU2Rw+WJeLhbZeocpr
         2Gqzl+8s/rWzqaRG9jcN4ZtigrJrurvFU+KxHKlrQ8BaXhC2kIyk5+q4vDD261c/Hqwc
         EuLPEOE0h5UhP5EjsAVn9xDeYCkTO2X1dHsl67ga4fei601YjEg/Uouz59EgMJEUScTR
         FO2tc24DaGn37kibOm0K9xFzU4DfLQv/JM6J0hB4UpeNPj2dGY7V5DF6uUQdZlRdmEYc
         Kkfw==
X-Gm-Message-State: APjAAAWYgrrVDicLa73U+Ko2qRsW0Js3hFa9DeIFs01gzcky9TJQla0p
        LMRhOphPX3rNz7HqdoUS37JecUUM
X-Google-Smtp-Source: APXvYqz1+46Hg/yw2q0yf1r8A+wwo1e7NVTXj4OK8pmZALFCgHXqhaLHJeZ9yZfb19Q1+YO0Xw7Lew==
X-Received: by 2002:a5d:614a:: with SMTP id y10mr5508924wrt.164.1571789979298;
        Tue, 22 Oct 2019 17:19:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n22sm16454601wmk.19.2019.10.22.17.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 17:19:38 -0700 (PDT)
Message-Id: <pull.400.v3.git.1571789978.gitgitgadget@gmail.com>
In-Reply-To: <pull.400.v2.git.1571316454.gitgitgadget@gmail.com>
References: <pull.400.v2.git.1571316454.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Oct 2019 00:19:37 +0000
Subject: [PATCH v3 0/1] ci: update caskroom/cask/perforce to new location
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running CI on Mac OS X in Azure Pipelines is currently broken due to a moved
homebrew package.

Change since v2:

 * The commit message was improved (thanks Gábor).

Change since v1: -The step is now more robust (by pulling homebrew-cask and
trying again if the pull failed).

Thanks, -Stolee

Johannes Schindelin (1):
  ci(osx): use new location of the `perforce` cask

 ci/install-dependencies.sh | 5 +++++
 1 file changed, 5 insertions(+)


base-commit: 108b97dc372828f0e72e56bbb40cae8e1e83ece6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-400%2Fderrickstolee%2Fci-caskroom-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-400/derrickstolee/ci-caskroom-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/400

Range-diff vs v2:

 1:  372ab24acf ! 1:  9d80e845bf ci(osx): use new location of the `perforce` cask
     @@ -2,9 +2,8 @@
      
          ci(osx): use new location of the `perforce` cask
      
     -    The CI builds are failing for Mac OS X due to a change in the
     -    location of the perforce cask. The command outputs the following
     -    error:
     +    The Azure Pipelines builds are failing for macOS due to a change in the
     +    location of the perforce cask. The command outputs the following error:
      
              + brew install caskroom/cask/perforce
              Error: caskroom/cask was moved. Tap homebrew/cask-cask instead.
     @@ -12,11 +11,27 @@
          So let's try to call `brew cask install perforce` first (which is what
          that error message suggests, in a most round-about way).
      
     -    The "caskroom" way was added in 672f51cb (travis-ci:
     -    fix Perforce install on macOS, 2017-01-22) and the justification
     -    is that the call "brew cask install perforce" can fail due to a checksum
     -    mismatch: the recipe simply downloads the official Perforce distro, and
     -    whenever that is updated, the recipe needs to be updated, too.
     +    Prior to 672f51cb we used to install the 'perforce' package with 'brew
     +    install perforce' (note: no 'cask' in there). The justification for
     +    672f51cb was that the command 'brew install perforce' simply stopped
     +    working, after Homebrew folks decided that it's better to move the
     +    'perforce' package to a "cask". Their justification for this move was
     +    that 'brew install perforce' "can fail due to a checksum mismatch ...",
     +    and casks can be installed without checksum verification. And indeed,
     +    both 'brew cask install perforce' and 'brew install
     +    caskroom/cask/perforce' printed something along the lines of:
     +
     +      ==> No checksum defined for Cask perforce, skipping verification
     +
     +    It is unclear why 672f51cb used 'brew install caskroom/cask/perforce'
     +    instead of 'brew cask install perforce'. It appears (by running both
     +    commands on old Travis CI macOS images) that both commands worked all
     +    the same already back then.
     +
     +    In any case, as the error message at the top of this commit message
     +    shows, 'brew install caskroom/cask/perforce' has stopped working
     +    recently, but 'brew cask install perforce' still does, so let's use
     +    that.
      
          CI servers are typically fresh virtual machines, but not always. To
          accommodate for that, let's try harder if `brew cask install perforce`
     @@ -31,6 +46,7 @@
          https://dev.azure.com/gitgitgadget/git/_build?definitionId=11&_a=summary
          will be finished once the next Perforce upgrade comes around.
      
     +    Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      

-- 
gitgitgadget
