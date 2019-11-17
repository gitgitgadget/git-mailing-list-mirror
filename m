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
	by dcvr.yhbt.net (Postfix) with ESMTP id 22FD31F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 21:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfKQVFG (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 16:05:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41455 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfKQVFG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 16:05:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id b18so15659459wrj.8
        for <git@vger.kernel.org>; Sun, 17 Nov 2019 13:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iPP2L+QLMwVwdGWwkh9hsFgKDoFcPnodHgLy7oJcjDw=;
        b=GrRrKmDypZN80s/FzKeefRxZQKKGtpYD9M9HB4TLPZYFiyAILZKZRXBllyra6cZqcO
         s5ZtK4vbNIVnItXQ3ETjC4/rgYGBqNK4i+Gcc+BXBh54wEEaDh8baiHfW9gG59afjtve
         WJ1A5yj+7I66fIrZz8oS8TrQF23vIXlLS3YU+fHHiSmZKAJ0zbA9VqMrD9mFkyVnpgQN
         QpYuTS/1kmqjPKTktDkwNFOjxqulMLSGBFpYEeloM76PEeEqgUSI7UzuYu/DfyeSqqL7
         nD8oYEY/caT/64ct9Np0If6roFLNDoGXtp75ddWNipbUjB73UqqyrC43R5Vu9Xq6ooRH
         vvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iPP2L+QLMwVwdGWwkh9hsFgKDoFcPnodHgLy7oJcjDw=;
        b=WctxNUJP1Flz0GYN5X8hKsyNY4o2uepcxN1y9kpDMDOWcOPlrFop8rxjZ0UO9miWRP
         AYqDE4Sh9bgcRgRmUMl3pkv+8IIElnTM+twP15M+MXwPWOD+f4e/v9HQbsELXUgOj4Pv
         Lzlb6dTOfa4hQPEVgBNpNxBfrQERxJfQ7OU0I8HflvtMInytUI2acyuf6QNnmMTBtO8d
         P6q9w/l8HaeluQxh5X8AaeKFZ8pYfYufJapTkvplK5SVGgustCk1P9G4eWhVWDXg/bv3
         u3MMzkXttpIALmo7zi4Jhyufm105J28LyWeAj1jnyKHX9gbcJEBu8sVt+uVQPbrJ675T
         d1fg==
X-Gm-Message-State: APjAAAXGF8T6v2HVndnQS0y59IRaZMQp19q5kMyemrgpuBoAZigsRfZc
        NOnnwtDQrYHIp2MJ/fuGcZQnnMiQ
X-Google-Smtp-Source: APXvYqyraAGgo2sAn3uCYavMo8/6xySofMOKiURbPRZyjLbO4UnsDrLS8Xaw3LuIT7HBAy4ZyxT85w==
X-Received: by 2002:a5d:660b:: with SMTP id n11mr27747131wru.146.1574024702775;
        Sun, 17 Nov 2019 13:05:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y8sm4186856wru.59.2019.11.17.13.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2019 13:05:02 -0800 (PST)
Message-Id: <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
References: <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 Nov 2019 21:04:39 +0000
Subject: [PATCH v5 00/21] [Outreachy] Move doc to header files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the documentation from Documentation/technical/api-*.txt to the
corresponding header file, as it's easier for the developers to find the
usage information beside the code instead of looking for it in another doc
file.

Also documentation/technical/api-*.txt is removed because the information it
has is will be redundant and it'll be hard to keep it up to date and
synchronized with the documentation in the header files.

api-trace2.txt is not removed because it has lots of valuable information
that seems more appropriate to be in a separate doc file not in the trace2.h
although the functions documentation is moved to the trace2.h

api-error-handling.txt is not removed as well because no other file seemed
to be more suitable for the doc it contains. I'm open to suggestions though.

The ll-merge related doc was removed from api-merge.txt to ll-merge.h, while
the rest of the file is left as is.

Signed-off-by: Heba Waly heba.waly@gmail.com

Heba Waly (21):
  diff: move doc to diff.h and diffcore.h
  dir: move doc to dir.h
  graph: move doc to graph.h and graph.c
  merge: move doc to ll-merge.h
  sha1-array: move doc to sha1-array.h
  remote: move doc to remote.h and refspec.h
  refs: move doc to refs.h
  attr: move doc to attr.h
  revision: move doc to revision.h
  pathspec: move doc to pathspec.h
  sigchain: move doc to sigchain.h
  cache: move doc to cache.h
  argv-array: move doc to argv-array.h
  credential: move doc to credential.h
  parse-options: add link to doc file in parse-options.h
  run-command: move doc to run-command.h
  trace: move doc to trace.h
  tree-walk: move doc to tree-walk.h
  submodule-config: move doc to submodule-config.h
  trace2: move doc to trace2.h
  api-index: remove api doc index files

 Documentation/Makefile                        |  11 +-
 Documentation/MyFirstObjectWalk.txt           |   7 +-
 Documentation/git-credential.txt              |   3 +-
 Documentation/git.txt                         |   3 -
 Documentation/gitcredentials.txt              |   3 +-
 Documentation/technical/.gitignore            |   1 -
 .../technical/api-allocation-growing.txt      |  39 ---
 Documentation/technical/api-argv-array.txt    |  65 -----
 Documentation/technical/api-credentials.txt   | 271 ------------------
 Documentation/technical/api-diff.txt          | 174 -----------
 .../technical/api-directory-listing.txt       | 130 ---------
 Documentation/technical/api-gitattributes.txt | 154 ----------
 Documentation/technical/api-history-graph.txt | 173 -----------
 Documentation/technical/api-index-skel.txt    |  13 -
 Documentation/technical/api-index.sh          |  28 --
 Documentation/technical/api-merge.txt         |  72 +----
 Documentation/technical/api-oid-array.txt     |  90 ------
 Documentation/technical/api-ref-iteration.txt |  78 -----
 Documentation/technical/api-remote.txt        | 127 --------
 .../technical/api-revision-walking.txt        |  72 -----
 Documentation/technical/api-run-command.txt   | 264 -----------------
 Documentation/technical/api-setup.txt         |  47 ---
 Documentation/technical/api-sigchain.txt      |  41 ---
 .../technical/api-submodule-config.txt        |  66 -----
 Documentation/technical/api-trace.txt         | 140 ---------
 Documentation/technical/api-trace2.txt        | 243 +---------------
 Documentation/technical/api-tree-walking.txt  | 149 ----------
 argv-array.h                                  |  62 ++++
 attr.c                                        |   3 +-
 attr.h                                        | 141 ++++++++-
 cache.h                                       |  41 ++-
 credential.h                                  | 236 +++++++++++++++
 diff.h                                        | 126 ++++++++
 diffcore.h                                    |  32 +++
 dir.c                                         |   2 -
 dir.h                                         | 119 +++++++-
 graph.c                                       |   1 +
 graph.h                                       | 121 ++++++++
 ll-merge.h                                    |  73 ++++-
 parse-options.h                               |   4 +
 pathspec.h                                    |  35 ++-
 refs.h                                        |  51 ++++
 refspec.h                                     |  16 ++
 remote.h                                      |  57 +++-
 revision.h                                    |  59 ++++
 run-command.h                                 | 252 +++++++++++++++-
 sha1-array.c                                  |   2 +-
 sha1-array.h                                  |  80 ++++++
 sigchain.h                                    |  45 +++
 submodule-config.h                            |  38 ++-
 trace.h                                       | 133 ++++++++-
 trace2.h                                      | 124 ++++++--
 tree-walk.h                                   | 122 +++++++-
 53 files changed, 1934 insertions(+), 2505 deletions(-)
 delete mode 100644 Documentation/technical/.gitignore
 delete mode 100644 Documentation/technical/api-allocation-growing.txt
 delete mode 100644 Documentation/technical/api-argv-array.txt
 delete mode 100644 Documentation/technical/api-credentials.txt
 delete mode 100644 Documentation/technical/api-diff.txt
 delete mode 100644 Documentation/technical/api-directory-listing.txt
 delete mode 100644 Documentation/technical/api-gitattributes.txt
 delete mode 100644 Documentation/technical/api-history-graph.txt
 delete mode 100644 Documentation/technical/api-index-skel.txt
 delete mode 100755 Documentation/technical/api-index.sh
 delete mode 100644 Documentation/technical/api-oid-array.txt
 delete mode 100644 Documentation/technical/api-ref-iteration.txt
 delete mode 100644 Documentation/technical/api-remote.txt
 delete mode 100644 Documentation/technical/api-revision-walking.txt
 delete mode 100644 Documentation/technical/api-run-command.txt
 delete mode 100644 Documentation/technical/api-setup.txt
 delete mode 100644 Documentation/technical/api-sigchain.txt
 delete mode 100644 Documentation/technical/api-submodule-config.txt
 delete mode 100644 Documentation/technical/api-trace.txt
 delete mode 100644 Documentation/technical/api-tree-walking.txt


base-commit: d9f6f3b6195a0ca35642561e530798ad1469bd41
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-434%2FHebaWaly%2Fmove-doc-to-header-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-434/HebaWaly/move-doc-to-header-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/434

Range-diff vs v4:

  1:  7f2f4c45a6 =  1:  7f2f4c45a6 diff: move doc to diff.h and diffcore.h
  2:  f87ca0228e =  2:  f87ca0228e dir: move doc to dir.h
  3:  495fe333bd =  3:  495fe333bd graph: move doc to graph.h and graph.c
  4:  90baf409ec =  4:  90baf409ec merge: move doc to ll-merge.h
  5:  a76a2e2244 =  5:  a76a2e2244 sha1-array: move doc to sha1-array.h
  6:  5719b8141c =  6:  5719b8141c remote: move doc to remote.h and refspec.h
  7:  f84c1338fa =  7:  f84c1338fa refs: move doc to refs.h
  8:  a007b50b9b =  8:  a007b50b9b attr: move doc to attr.h
  9:  88553030f5 =  9:  88553030f5 revision: move doc to revision.h
 10:  0042d10223 = 10:  0042d10223 pathspec: move doc to pathspec.h
 11:  240a4bcb32 = 11:  240a4bcb32 sigchain: move doc to sigchain.h
 12:  3e0d3f2415 = 12:  3e0d3f2415 cache: move doc to cache.h
 13:  4f805c8737 = 13:  4f805c8737 argv-array: move doc to argv-array.h
 14:  ea78cb4ae5 = 14:  ea78cb4ae5 credential: move doc to credential.h
 15:  7097de91c3 <  -:  ---------- parse-options: move doc to parse-options.h
  -:  ---------- > 15:  0e9e89fd83 parse-options: add link to doc file in parse-options.h
 16:  03aa723fb7 = 16:  474911ff77 run-command: move doc to run-command.h
 17:  44a47075dc = 17:  f313d74e1e trace: move doc to trace.h
 18:  5b20c2794b = 18:  9063c2fad2 tree-walk: move doc to tree-walk.h
 19:  251a08c1d8 = 19:  039598b04c submodule-config: move doc to submodule-config.h
 20:  1f08493281 = 20:  cf3e3dd0c2 trace2: move doc to trace2.h
 21:  5f21417393 = 21:  3771f7e2cb api-index: remove api doc index files

-- 
gitgitgadget
