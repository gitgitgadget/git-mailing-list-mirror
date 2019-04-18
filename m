Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 778AE20248
	for <e@80x24.org>; Thu, 18 Apr 2019 13:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388911AbfDRNQl (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 09:16:41 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45931 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388579AbfDRNQk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 09:16:40 -0400
Received: by mail-ed1-f65.google.com with SMTP id k92so1746072edc.12
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 06:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=H03PXG/M6PE7vLsHKTxGgbAqZFgS0uGIQZ3s3KjUgC0=;
        b=OG7SsPPET5f29L09iq6fV7ufmsaItG7oyJ+lD0J9YRVW3ZLJEpe9aFWZBHoTovxEo7
         q8/erZMJcOcUiTL2NQBffVJfrxDlGFkec0ePWySIwa1MQFO2dU+2rTFjuPe6HKiwoVQz
         i6/4EY/a2u1dmbTz1CtDLKUp6JvXo6qlhRFPL7bTd5lIAaE6vU79/9AQBDaCZ+1q6Sgw
         bMUZCCBvDXlAUd7W346H5e+0oRJ2BS/J10wUcf6h+2tl3YlPZIVNjWYvTX26gVKJADSF
         hQWpLyYD/LP2d2b4DXNL4YzgckjES9j/pfNJ2Xup3L+IgbAnjAXBxfHrh0m6Vzb3TKwb
         PBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=H03PXG/M6PE7vLsHKTxGgbAqZFgS0uGIQZ3s3KjUgC0=;
        b=JPJs+VUcPgnJ3zaLSCGJV/rwoF4gleQJRZ78q5ujPlcBps8HNBx9PO3kAPNoAewUeK
         U18NIOwC+YVG7OGtpSUF9MCqZOv3M6opXnF3INRwHeHJJjsE4YqKn1PSlt0/D0NfN7PT
         gR2jWPrYVF+BsLUpigpX5dUfs0LOs0QrC5/nrP1pcxaGvh+U2LfbGghGcFBXpHedPqW/
         6UIEP4TsK8rDQxVti97gNV5Ti2HJYtSJgyJIKz3GYAX3ywo3+HsF0p0LdkpKYLzRhIR5
         ij/AkwfMB4i26a9pdUHfv02k2fdMjuH5axH+TAUDYNbqGciFl+aK9XBFOi1/Hp/8fjb4
         ffUg==
X-Gm-Message-State: APjAAAX/0RrrjLtaP5j6kd3hAItr/DsiehxjCFWFXSPjG6vyPxWMBZwI
        Op/ETR+N4snL+heeDyaDOIIHuDxi
X-Google-Smtp-Source: APXvYqxu4FW9fRVkjEfGvlFNHGEcCS97ena10GQO0KRqPoB1DOaicBpTVQNQd8Bi9hC3uZeFXLY0lg==
X-Received: by 2002:a50:a90d:: with SMTP id l13mr60761772edc.45.1555593397683;
        Thu, 18 Apr 2019 06:16:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d17sm510372eda.91.2019.04.18.06.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 06:16:37 -0700 (PDT)
Date:   Thu, 18 Apr 2019 06:16:37 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Apr 2019 13:16:28 GMT
Message-Id: <pull.168.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.168.git.gitgitgadget@gmail.com>
References: <pull.168.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/8] Assorted Documentation-related fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
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

Changes since v1:

 * There is now an extra patch that gets rid of the NO_INSTALL variable in
   the Makefile altogether.
 * The generate-cmdlist.sh patch now results in more robust code (thanks,
   Junio!).
 * Patch 2/7 has a much better commit message now, and instead of filtering
   out excluded commands from the command-list.txt, it expects excluded
   commands by looking not only at $(ALL_COMMANDS) but also at 
   $(EXCLUDED_PROGRAMS).
 * Instead of the fragile logic to generate 
   Documentation/GIT-EXCLUDED-PROGRAMS that I hoped would let me get away
   with less work, I now imitate the logic of GIT-CFLAGS (and the resulting
   patch is actually a lot easier to read).

Johannes Schindelin (8):
  remote-testgit: move it into the support directory for t5801
  Makefile: drop the NO_INSTALL variable
  help -a: do not list commands that are excluded from the build
  check-docs: allow command-list.txt to contain excluded commands
  docs: exclude documentation for commands that have been excluded
  check-docs: do not bother checking for legacy scripts' documentation
  test-tool: handle the `-C <directory>` option just like `git`
  Turn `git serve` into a test helper

 .gitignore                                    |  1 -
 Documentation/.gitignore                      |  1 +
 Documentation/Makefile                        |  3 ++
 Makefile                                      | 53 +++++++++++--------
 builtin.h                                     |  1 -
 generate-cmdlist.sh                           | 10 +++-
 git.c                                         |  1 -
 builtin/serve.c => t/helper/test-serve-v2.c   |  7 +--
 t/helper/test-tool.c                          | 20 +++++++
 t/helper/test-tool.h                          |  1 +
 t/t5701-git-serve.sh                          | 32 ++++++-----
 t/t5702-protocol-v2.sh                        |  5 +-
 t/t5703-upload-pack-ref-in-want.sh            | 16 +++---
 t/t5801-remote-helpers.sh                     |  2 +
 .../t5801/git-remote-testgit                  |  0
 15 files changed, 101 insertions(+), 52 deletions(-)
 rename builtin/serve.c => t/helper/test-serve-v2.c (81%)
 rename git-remote-testgit.sh => t/t5801/git-remote-testgit (100%)


base-commit: 5ee42463399ca3cc75b7e6e4368a3a5df5b010f2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-168%2Fdscho%2Fdocs-misc-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-168/dscho/docs-misc-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/168

Range-diff vs v1:

 1:  81c08b178b = 1:  81c08b178b remote-testgit: move it into the support directory for t5801
 -:  ---------- > 2:  fda0b10c84 Makefile: drop the NO_INSTALL variable
 2:  7dc5293e9e ! 3:  9b498a6f21 help -a: do not list commands that are excluded from the build
     @@ -70,7 +70,7 @@
       
       command_list () {
      -	grep -v '^#' "$1"
     -+	eval grep -ve '^#' $exclude_programs "$1"
     ++	eval "grep -ve '^#' $exclude_programs" <"$1"
       }
       
       get_categories () {
     @@ -79,7 +79,7 @@
       }
       
      +exclude_programs=
     -+while test "a$1" = "a--exclude-program"
     ++while test "--exclude-program" = "$1"
      +do
      +	shift
      +	exclude_programs="$exclude_programs -e \"^$1 \""
 3:  96ced7e17c < -:  ---------- check-docs: do not pretend that commands are listed which are excluded
 4:  31d8e43cbf < -:  ---------- docs: exclude documentation for commands that have been excluded
 -:  ---------- > 4:  ac3670a805 check-docs: allow command-list.txt to contain excluded commands
 -:  ---------- > 5:  f8d133c597 docs: exclude documentation for commands that have been excluded
 5:  fb3daa6427 = 6:  05d4ad62d6 check-docs: do not bother checking for legacy scripts' documentation
 6:  2e19f538bc = 7:  cf73021574 test-tool: handle the `-C <directory>` option just like `git`
 7:  411587e4b8 = 8:  88a5ab2332 Turn `git serve` into a test helper

-- 
gitgitgadget
