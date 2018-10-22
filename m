Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1819B1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 20:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbeJWFGN (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 01:06:13 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:46004 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbeJWFGM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 01:06:12 -0400
Received: by mail-wr1-f49.google.com with SMTP id f17-v6so14662434wrs.12
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 13:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pUpyOawwg0YxEgPlGgW006dabj8I7cITK4d8MQI6mus=;
        b=LBvxe4f7pjmz1TyfzWHIKDjH+xydCJgnj9yucudQlgellhABFd+lHJU5X+s/hZOKRZ
         n0Ry3Iw+wmYwM+9kI6pwMnhJdhLl3y7zoo3n+sffzKzm9BKvdhRNS8bp7Y7TcqU/4ZoA
         lV1wLm646H7dWC15pHA7SwghirvBsu1TR4tptIJkRHEKrgiCydZcj08noI1p6h20LBPJ
         ZUcWgRDcuxkv0Q9Mni2xsBsOwCuCDMg21FRx+Nq2I3lV3mM9SHzpAqWqF36Qed+x2J74
         dY0xXYSBZUaDiEnJyT79xcJY9nqO2K6GnFTWBJqs+XnfM6rHdeQk//N3adqcbT0v4F/v
         W6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pUpyOawwg0YxEgPlGgW006dabj8I7cITK4d8MQI6mus=;
        b=XcJNYUvDIEkFlN3yWKEpS2HDU2Lt88lpPBg4v0cSD7ZOQ1fhOJXDaTWWBDBZmXyJTM
         7yfEkD2c2+XammfKo7QQAm14N6A8gkl2pV7HEvgpGs1LWTfnWCCjYwl4R3gMBeaMR9Uo
         2fooYtm1dSwXyDKtLgNCh2d4POPJlfmUFzrU3fBLe3//1jreP3m1TgV10HkVal8iQCmw
         Lupet7FqltG+3xjS7kggngS5edLznqqAXKBxGn3/bRkx2z8l/8jdj1ptk2n00MD3SGcI
         Jhoi1jJGWliS8dmAbaza93bHYpBgA9+Z//eN9GZUXL4vmBWyqDuLYcz2jJ00yOGmlBy7
         YRKA==
X-Gm-Message-State: ABuFfogFRlGcVC1LRLEDFUziS4LqeMJQRQbSWWIc9JXnVJ6d9tQSZcXN
        pwmCxSmuVjt3kWAz3oNhJme9ihGn
X-Google-Smtp-Source: ACcGV60kl/b3vTk8eNxBMHvuC2x08UiJ6wuH6ID02fGA8E1mHpsljjKeBSZ2S3aziolcijReGag6QA==
X-Received: by 2002:adf:ba87:: with SMTP id p7-v6mr44514873wrg.203.1540241166537;
        Mon, 22 Oct 2018 13:46:06 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:4936:e72c:acbd:e1bd])
        by smtp.gmail.com with ESMTPSA id r134-v6sm9526526wmg.9.2018.10.22.13.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 13:46:05 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH 0/6] various fixes for docs
Date:   Mon, 22 Oct 2018 22:45:40 +0200
Message-Id: <20181022204546.20354-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A small batch of fixes for the docs. All but the very first fixes
formatting and similar stuff. The first one makes parsing 
'git worktree list' more future-proof.

Andreas Heiduk (6):
  doc: clarify boundaries of 'git worktree list --porcelain'
  doc: fix ASCII art tab spacing
  doc: fix inappropriate monospace formatting
  doc: fix descripion for 'git tag --format'
  doc: fix indentation of listing blocks in gitweb.conf.txt
  doc: fix formatting in git-update-ref

 Documentation/git-bisect-lk2009.txt | 30 ++++++++++++++---------------
 Documentation/git-checkout.txt      | 14 +++++++-------
 Documentation/git-merge-base.txt    |  6 +++---
 Documentation/git-tag.txt           | 12 ++++++------
 Documentation/git-update-ref.txt    |  8 ++++----
 Documentation/git-upload-pack.txt   |  1 +
 Documentation/git-worktree.txt      |  4 ++--
 Documentation/git.txt               | 10 +++++-----
 Documentation/gitattributes.txt     | 30 ++++++++++++++---------------
 Documentation/gitmodules.txt        | 17 +++++++++-------
 Documentation/gitsubmodules.txt     | 14 +++++++++-----
 Documentation/gitweb.conf.txt       | 25 ++++++++++++++----------
 12 files changed, 92 insertions(+), 79 deletions(-)

-- 
2.19.1

