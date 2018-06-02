Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AD4C1F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 04:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750892AbeFBEcv (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 00:32:51 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:39126 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeFBEcu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 00:32:50 -0400
Received: by mail-lf0-f51.google.com with SMTP id t134-v6so17596973lff.6
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 21:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lYw9eUDtIXKGZdgvTRAJZiLUMOoFzGeTxnsFUvKaqBw=;
        b=NmsK7GgCGBTFqx4l8rxSicTsEWEWoq2v/XQ3tuWEgJ6/LO0X17dxBsZVBN2w0Yl1x8
         gMHzbLH7U/B2qwZgcMDmtvkuKjETBHJlEzyeGGIUjHPOIx+YFmawp9MpD3BJTK0h1BU0
         QoxsAap9MmShaF7Vu5f5kRDeN145zmP8sk2TBnlcP0b3g/Sy5qAe4/YDQlRFz3hrOHLK
         Xyyyk1UCdvyrVi1vM8zV0CGQHujbT1qwDIdhoC4GNOfS9VIZsB3GCTVLfRneOz6E2bXJ
         Vb+XxA0hxp7/8UTQwkcolxowAJQq7A40ceNn/1qUEzBJjyVrE99jBL3TQiDqXYLOJ9H7
         fwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lYw9eUDtIXKGZdgvTRAJZiLUMOoFzGeTxnsFUvKaqBw=;
        b=qpmuuG16VHBLfEpU4EbtD11gIosgqtPaG+GVR+GMOL81oGSJkbgCVtJ1nUfmkfH4PA
         6F4pJ1Ve9giQ5ni6w69QFcu/vzAyx+Yz++RyMgtcnfil7jFWLF7uPfuS5Mayr2STQQiz
         846Es93QsblpFDLg4zo6EPZfqDDl5WLku5w/Nc/sVFZhj/meUeZ82VjsvMuruuESU73C
         kI75Fz3a4IPtoJNG+qEHQztwhVhd+LSfQzbtAz2e0cjWVG0x1OsTFpDzNZlkIzGYMdOs
         qFQ0CWOGInatlSYAe61MsH1Y809SMvy1nkWSV9bVKN5W9QFv+lwEO2VCaJUicVUfo+ib
         DFdw==
X-Gm-Message-State: ALKqPwd+jQTbUdtl9FqAq8v3uMKOeHlrg5tx6vMqW8F6gvbB0Og+PK52
        TVnDva9Jd2nwo2Sy/5/aa8lKdw==
X-Google-Smtp-Source: ADUXVKKDCFE1AXnISU1GxPhLQrhRHBp7ilRDXX56UDkUrU15MhJ4N4UXVzmZdu9rn24+Goz45sMLrA==
X-Received: by 2002:a2e:5591:: with SMTP id g17-v6mr10160708lje.4.1527913968312;
        Fri, 01 Jun 2018 21:32:48 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm644776lji.0.2018.06.01.21.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 21:32:47 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/22] Mark more strings for translation
Date:   Sat,  2 Jun 2018 06:32:19 +0200
Message-Id: <20180602043241.9941-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.309.g77c7720784
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I originally wanted to have a look regularly at what's in 'pu', catch
translatable strings that are not marked so and ask for updates. But I
failed horribly at that, so for this cycle I just looked at all the
changes between the last release and master and marked strings.

This series probably won't end up in 2.18 because now is probably too
late for big changes, which is fine.

Nguyễn Thái Ngọc Duy (22):
  archive-tar.c: mark more strings for translation
  archive-zip.c: mark more strings for translation
  builtin/config.c: mark more strings for translation
  builtin/grep.c: mark strings for translation and no full stops
  builtin/pack-objects.c: mark more strings for translation
  builtin/replace.c: mark more strings for translation
  commit-graph.c: mark more strings for translation
  config.c: mark more strings for translation
  connect.c: mark more strings for translation
  convert.c: mark more strings for translation
  dir.c: mark more strings for translation
  environment.c: mark more strings for translation
  exec-cmd.c: mark more strings for translation
  object.c: mark more strings for translation
  pkt-line.c: mark more strings for translation
  refs.c: mark more strings for translation
  refspec.c: mark more strings for translation
  replace-object.c: mark more strings for translation
  sequencer.c: mark more strings for translation
  sha1-file.c: mark more strings for translation
  transport.c: mark more strings for translation
  transport-helper.c: mark more strings for translation

 archive-tar.c                         |  12 +--
 archive-zip.c                         |  14 ++--
 builtin/config.c                      |  48 +++++------
 builtin/grep.c                        |  12 +--
 builtin/pack-objects.c                | 108 ++++++++++++-------------
 builtin/replace.c                     |  90 ++++++++++-----------
 commit-graph.c                        |  20 ++---
 config.c                              |  76 +++++++++---------
 connect.c                             |  87 ++++++++++----------
 convert.c                             |  42 +++++-----
 dir.c                                 |   8 +-
 environment.c                         |   4 +-
 exec-cmd.c                            |   2 +-
 object.c                              |  10 +--
 pkt-line.c                            |  26 +++---
 refs.c                                |  40 +++++-----
 refspec.c                             |   2 +-
 replace-object.c                      |   6 +-
 sequencer.c                           |  26 +++---
 sha1-file.c                           | 110 +++++++++++++-------------
 t/t0021-conversion.sh                 |   2 +-
 t/t1305-config-include.sh             |   2 +-
 t/t1308-config-set.sh                 |   2 +-
 t/t1400-update-ref.sh                 |  20 ++---
 t/t1404-update-ref-errors.sh          |   4 +-
 t/t1450-fsck.sh                       |   2 +-
 t/t3005-ls-files-relative.sh          |   4 +-
 t/t3210-pack-refs.sh                  |   2 +-
 t/t3310-notes-merge-manual-resolve.sh |   6 +-
 t/t5500-fetch-pack.sh                 |   2 +-
 t/t5505-remote.sh                     |   2 +-
 t/t5512-ls-remote.sh                  |   2 +-
 t/t5570-git-daemon.sh                 |   6 +-
 t/t5801-remote-helpers.sh             |   8 +-
 t/t7063-status-untracked-cache.sh     |   2 +-
 t/t7400-submodule-basic.sh            |   2 +-
 transport-helper.c                    |  89 ++++++++++-----------
 transport.c                           |  18 ++---
 38 files changed, 466 insertions(+), 452 deletions(-)

-- 
2.18.0.rc0.309.g77c7720784

