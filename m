Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09B28202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 00:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752380AbdF3AIn (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 20:08:43 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33758 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbdF3AH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 20:07:29 -0400
Received: by mail-pg0-f45.google.com with SMTP id f127so55145533pgc.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 17:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yIoPukvRJ5naBgTWBsUM2qm/wdPkiM9ccQGcGx4JVaI=;
        b=lLvDwmo7+bRN4s/DiBDOuaeUxXxT6Apx4RwK/EYZs4oDDOWFXxn/rUzNX0pSwGnF0E
         wLHpJJh9nTXK/JJJWRT9oYjdRSwhjfQ+YtOEXIlxULsgT5ZtWsziL3H2bT4OOiOddQ2L
         N0iduLFdZVjIkltdJ8jPK44qphA3UWSaCPkX5hvrQju/KCn+AJUf7xM9CH+zHRHMi4Ey
         nyYmKh/GVYYIUV67KaUn6e5j+q4xJwJhn/9Jsk6nvrpkgc97CSmxLgkhmUQhWFvKANgf
         aqKDe2Sndxoijlih26ZWkbO5zb2Icf1TzggY6kTCDhR5M+tSQX0PyJevx1Qr6SbHxq2z
         d9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yIoPukvRJ5naBgTWBsUM2qm/wdPkiM9ccQGcGx4JVaI=;
        b=Dk02CQlHI6jsFVhQTEVCPjeYyOZ4TGS7bR7x7Bq9cm8g3UJaZiYXRJzgqMw9nfdSr0
         d0/xITGjSn7yCtvlW7ChUZKPx9VN+1itD88AzcNQOVH/gvemLh8EXOR/fmpezB9Kz+Jb
         G/Q32aHGgKFPvMOwbqxiB8V1ridxA3nKxODZe9JyDuWCt+IvJb1SkVbS5uhLKoGI/1Xm
         gajfthd/xl54YkeOXo0ONKzeoMIBxkWoKrkzFT731WlRZO2Mr7dlVsFSy5ZKl/yBp5j0
         G/uKRcMzTcEmviXQlIMwI6BbFbQRWAh4/6ZEBwHyqohb3bOpS4P0GOJig5lvyqRUDpj+
         Bz2w==
X-Gm-Message-State: AKS2vOwt6tywPiP4cHVtBru2YeVwTmG0MCG8LHQP03Mh7bwM4zmGYozY
        ESKlzvgxsARS5PpP
X-Received: by 10.99.127.78 with SMTP id p14mr18571357pgn.124.1498781243101;
        Thu, 29 Jun 2017 17:07:23 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id o84sm16933090pfj.109.2017.06.29.17.07.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 17:07:22 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 00/25] Reroll of sb/diff-color-moved.
Date:   Thu, 29 Jun 2017 17:06:45 -0700
Message-Id: <20170630000710.10601-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reroll of sb/diff-color-moved, applies on top of the hashmap patches[1].

* Supports different whitespace modes correctly now (and has a test for trivial
  white space changes)
* The fixups[2] have been squashed.

Thanks,
Stefan

[1] https://public-inbox.org/git/20170629235336.28460-1-sbeller@google.com/
[2] https://public-inbox.org/git/20170628005651.8110-1-sbeller@google.com/


Stefan Beller (25):
  diff.c: readability fix
  diff.c: move line ending check into emit_hunk_header
  diff.c: factor out diff_flush_patch_all_file_pairs
  diff.c: introduce emit_diff_symbol
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_MARKER
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_FRAGINFO
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_NO_LF_EOF
  diff.c: migrate emit_line_checked to use emit_diff_symbol
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_WORDS[_PORCELAIN]
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_INCOMPLETE
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_FILEPAIR_{PLUS, MINUS}
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_HEADER
  diff.c: emit_diff_symbol learns about DIFF_SYMBOL_BINARY_FILES
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_REWRITE_DIFF
  submodule.c: migrate diff output to use emit_diff_symbol
  diff.c: convert emit_binary_diff_body to use emit_diff_symbol
  diff.c: convert show_stats to use emit_diff_symbol
  diff.c: convert word diffing to use emit_diff_symbol
  diff.c: emit_diff_symbol learns about DIFF_SYMBOL_STAT_SEP
  diff.c: emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY
  diff.c: buffer all output if asked to
  diff.c: color moved lines differently
  diff.c: color moved lines differently, plain mode
  diff.c: add dimming to moved line detection
  diff: document the new --color-moved setting

 Documentation/config.txt       |   15 +-
 Documentation/diff-options.txt |   34 ++
 cache.h                        |    2 +
 color.h                        |    2 +
 diff.c                         | 1306 ++++++++++++++++++++++++++++++++--------
 diff.h                         |   39 +-
 submodule.c                    |   84 ++-
 submodule.h                    |   13 +-
 t/t4015-diff-whitespace.sh     |  434 +++++++++++++
 9 files changed, 1613 insertions(+), 316 deletions(-)

-- 
2.13.0.31.g9b732c453e

