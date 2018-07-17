Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A04E1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 13:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbeGQOY1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 10:24:27 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39006 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbeGQOY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 10:24:27 -0400
Received: by mail-pf0-f194.google.com with SMTP id j8-v6so540774pff.6
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 06:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DoPR9uNofdRgYz/4ajdTOB9qUiUeBTXRM4q6XA49FeA=;
        b=jx7razeHP7oOlJnmkbGUUpvz4DszdNkPFbVnMqgV8MALa2zr+YYgyBzejd4OhI3ysn
         8reQL3tNh4WDHwJzI95hhHzSKw7PmDFuD9LAh8tK4hd4MEvdi7c+W0Vrh6nTGzojwmst
         D91mPsirX+XK65Y3+VKOQe2PV26Lo8ZbPIH4cYvqS4k9AZk7EG8/t8yab3+D2W9BBV9T
         NyvwySNTB7JTzbgV7WftTWndCcbOhMtNLwIjt9r8PQe9ka+AiOV7CRQLbV7vR5ysCvvC
         vjzpJQ/dgF/XP4Oo4VlgH2YKsnu2cIUuTBuEbpZ75lcrsiQUwgQJev1K42mPu9KzkwZG
         XucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DoPR9uNofdRgYz/4ajdTOB9qUiUeBTXRM4q6XA49FeA=;
        b=dKmEvqxb3GD1eqafWdNqk6oUYKE1mWQI89DwDIzre0iuOmLJ82jHKGhhfT0JJAlO0T
         aOhW2pv8zbT1U9LxYNWGouvA7SV0PL4pFwVfRlcBYodoRCgtazKnaN+14mBNfN05Xlo0
         +9sEP4Ww9HEz1j0nLF6EI9Ekmmby6vLsdpPu8ENU1POPHV6fEn6tA3OuGvK+F2B8jR3z
         vQX99ROm0H4gY3eQy1ZtKrG6urv3ybJD9Pt3ILq7i0xhI7rc+K0xj2bZvUCdGgBr2a/k
         GXIRPgDrtMLwJjfcFt2pqNikNhxmG3ZGrCde8SnS4pmwFd+xhM3fq33hXcmZ4wuEaJhB
         OrOw==
X-Gm-Message-State: AOUpUlFqKKRnnn7lG6EOGzFfECx5kl8p0q6eYy2J+Y37S3vdFpC3wdiN
        mlzVWN+gFSR3NvIVcJfv4mEJtw==
X-Google-Smtp-Source: AAOMgpeWziPq2/2GNbpNi9RTKzC5GlmR9h49CR+4FHvLf+mq2JsHEMeR3tGAnOA8ze4/YzmWQa1+7Q==
X-Received: by 2002:a62:ff0e:: with SMTP id b14-v6mr767990pfn.135.1531835500430;
        Tue, 17 Jul 2018 06:51:40 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id e126-v6sm3872073pfg.31.2018.07.17.06.51.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 06:51:39 -0700 (PDT)
Date:   Tue, 17 Jul 2018 06:51:39 -0700 (PDT)
X-Google-Original-Date: Tue, 17 Jul 2018 13:51:35 GMT
Message-Id: <pull.9.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.9.git.gitgitgadget@gmail.com>
References: <pull.9.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/2] repack -ad: fix after `fetch --prune` in a shallow repository
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

Under certain circumstances, commits that were reachable can be made unreachable, e.g. via `git fetch --prune`. These commits might have been packed already, in which case `git repack -adlf` will just drop them without giving them the usual grace period before an eventual `git prune` (via `git gc`) prunes them.

This is a problem when the `shallow` file still lists them, which is the reason why `git prune` edits that file. And with the proposed changes, `git repack -ad` will now do the same.

Reported by Alejandro Pauly.

Changes since v1:

- Also trigger `prune_shallow()` when `--unpack-unreachable=<approxidate>` was passed to `git repack`.
- No need to trigger `prune_shallow()` when `git repack` was called with `-k`.

Johannes Schindelin (2):
  repack: point out a bug handling stale shallow info
  repack -ad: prune the list of shallow commits

 builtin/repack.c         |  6 ++++++
 t/t5537-fetch-shallow.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)


base-commit: e3331758f12da22f4103eec7efe1b5304a9be5e9
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-9%2Fdscho%2Fshallow-and-fetch-prune-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-9/dscho/shallow-and-fetch-prune-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/9

Range-diff vs v1:

 1:  d2be40131 = 1:  d2be40131 repack: point out a bug handling stale shallow info
 2:  b4e01a963 ! 2:  c7ee6e008 repack -ad: prune the list of shallow commits
     @@ -23,7 +23,8 @@
          To avoid this problem, let's prune the shallow list in `git repack` when
          the `-d` option is passed, unless `-A` is passed, too (which would force
          the now-unreachable objects to be turned into loose objects instead of
     -    being deleted).
     +    being deleted). Additionally, e also need to take `--keep-reachable` and
     +    `--unpack-unreachable=<date>` into account.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ -35,7 +36,9 @@
       			opts |= PRUNE_PACKED_VERBOSE;
       		prune_packed_objects(opts);
      +
     -+		if (!(pack_everything & LOOSEN_UNREACHABLE) &&
     ++		if (!keep_unreachable &&
     ++		    (!(pack_everything & LOOSEN_UNREACHABLE) ||
     ++		     unpack_unreachable) &&
      +		    is_repository_shallow())
      +			prune_shallow(0);
       	}

-- 
gitgitgadget
