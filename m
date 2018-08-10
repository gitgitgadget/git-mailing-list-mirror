Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E60A81F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbeHKBGf (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:06:35 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:47056 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeHKBGf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:06:35 -0400
Received: by mail-yw1-f73.google.com with SMTP id 2-v6so14928394ywn.13
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fOM3rpJ3GpSUGUwUPKrjP/msfizuKjQX7UbE1pt4aDQ=;
        b=dRUmqTWOa19lUCkNJmr5L5kPiZmwoaK9F4rTzzbBa5aVQZixmbZ5EKC28daslJ/K5e
         pU3DelHU+ixIzdVfCZmi6gpRgiSp461OfOcRcpvpyWEdSSQpeFFs6140QLNniqJc1opI
         C335CuKvFWxbKC9HA62tqS4DuZjxzHOHt1GFY2Z5pRiQhOAfHlYO+TkdjSkR4yQuOEkn
         3qI+Aan6/vp8Mm2C88rSS6WTh2PyRNzd30y3nGZ2WOqIiZOZK43pZWe9qWAyWovnGDo1
         rFT6ZgP/7YxrUcjlSWx7g5wLKG4L082TDCISaatRn+QH6ABiQ55HDF4C+1SqZ4xCxw5o
         uxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fOM3rpJ3GpSUGUwUPKrjP/msfizuKjQX7UbE1pt4aDQ=;
        b=NnCQHmv9kDsOQIGC5BQmhmzby1IMdNwuK/yNBiBGXhL1DY9eLyoctih2C74pT9S9m3
         GV4M3SPW9dLOTzFDoW7uq+2UfE6p8esIDKcnkgsNl3bgZ+CwfT8nkZ652qOAts17DKjH
         FZGUzE+r3cY4ucQKl3iWG9gpDLfHJ05Pm5KUmpytKr0C3s3W0nANWO3HzCz6El0pFRNZ
         IoNv43U8hQa/GyBC3b9it83+/3w8quSZ8DzZNyHF6iuI+fDFr6PIE/YZZj0qAVQ3GiUB
         WvMMslltY23mGiezRafcsE2nBonboLEwRxDoX7ZDgdmux3rVxLF2gVIgmH479CAMLDVw
         vpHA==
X-Gm-Message-State: AOUpUlGL0aTFMXF5ntomiqx2vMRbUuW8+RsCE9WEicVDgC+lK6ambXkU
        hH+VswTmeUq1hC6HFAePXc2S8lQqW+BW
X-Google-Smtp-Source: AA+uWPyFtWzZCwDTm7JLOsbgF8KX8QMQWXwwNJfitI3s88ZH0OnXqdQQ5yYfSkRUOYUFKjK5xkMmQNhnmxK9
X-Received: by 2002:a25:8489:: with SMTP id v9-v6mr2402306ybk.60.1533940485221;
 Fri, 10 Aug 2018 15:34:45 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:34:33 -0700
Message-Id: <20180810223441.30428-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 0/8] Resending sb/range-diff-colors
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is also avaliable as
git fetch https://github.com/stefanbeller/git sb/range-diff-colors

and is a resend of sb/range-diff-colors.

It is rebased on the version of range-diff that Johannes just sent out
(pr-1/dscho/branch-diff-v5 in GGG repo), and squashes the fisup commit
(which had to be adapted slightly in one line, too)

range-diff below.

Stefan Beller (8):
  test_decode_color: understand FAINT and ITALIC
  t3206: add color test for range-diff --dual-color
  diff.c: simplify caller of emit_line_0
  diff.c: reorder arguments for emit_line_ws_markup
  diff.c: add set_sign to emit_line_0
  diff: use emit_line_0 once per line
  diff.c: compute reverse locally in emit_line_0
  diff.c: rewrite emit_line_0 more understandably

 diff.c                  | 94 +++++++++++++++++++++++------------------
 t/t3206-range-diff.sh   | 39 +++++++++++++++++
 t/test-lib-functions.sh |  2 +
 3 files changed, 93 insertions(+), 42 deletions(-)
 
./git-range-diff \
  5bf616af71afe1c4c36da7f21077662febf28cbe..c1b144ea695514cfe185fe70089198621c38d01c \
  ccf8c1bb2459d33c7dc97098c08c47ca7d77ed3e..4dc97b54a35c60c25ab7634441d60711ead0e84e \
  >>0000-cover-letter.patch

 1:  7f88339e03e =  1:  0fedd4c0a20 test_decode_color: understand FAINT and ITALIC
 2:  13e8528be69 <  -:  ----------- t3206: add color test for range-diff --dual-color
 -:  ----------- >  2:  6a1c7698c68 t3206: add color test for range-diff --dual-color
 3:  2f80811b319 =  3:  7e12ece1d34 diff.c: simplify caller of emit_line_0
 4:  15af0d378c8 !  4:  74dabd6d36f diff.c: reorder arguments for emit_line_ws_markup
    @@ -35,7 +35,7 @@
      	case DIFF_SYMBOL_PLUS:
     @@
      				set = diff_get_color_opt(o, DIFF_CONTEXT_BOLD);
    - 			flags |= WS_IGNORE_FIRST_SPACE;
    + 			flags &= ~DIFF_SYMBOL_CONTENT_WS_MASK;
      		}
     -		emit_line_ws_markup(o, set, reset, line, len, set_sign, '+',
     +		emit_line_ws_markup(o, set_sign, set, reset, '+', line, len,
 5:  dce49bb58fd =  5:  e304e15aa6b diff.c: add set_sign to emit_line_0
 6:  7581e16d63f =  6:  8d935d5212c diff: use emit_line_0 once per line
 7:  d070d393f73 =  7:  2344aac787a diff.c: compute reverse locally in emit_line_0
 8:  669e7516e03 =  8:  4dc97b54a35 diff.c: rewrite emit_line_0 more understandably
 9:  c1b144ea695 <  -:  ----------- fixup! t3206: add color test for range-diff --dual-color
