Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DFDA2047F
	for <e@80x24.org>; Tue, 26 Sep 2017 11:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030380AbdIZLWd (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 07:22:33 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:50786 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968096AbdIZLWc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 07:22:32 -0400
Received: by mail-wm0-f43.google.com with SMTP id b195so6683213wmb.5
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 04:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ve74kCUsLiR2cO1kUq0ir2wefNgqVDP75r+gSCsTxoE=;
        b=egxG4HgpgklGg0d+q/yF9HJtPljJUaqarimvNH/FY1wVeqE++X0vivXqHMAMqKgMUa
         Ifu2yuT/HDh9Jl9SvQrqWplBgppLvQ9LmB/L7NrdG5UCmGB9avAbMXohNbelrWq14hIJ
         I0D4YBof0TKKl96ruBMzLEmK9zzavUkIcditXhkq4QsxBL7R16mz4JlrS8ZEuXPk90Fw
         IDZvuGw7JIHIv46aXc2Gu1NF8yDGJ+h6zPZAlktQhNivgj7w+oi5CdMkY5OkcjrpiaAO
         lH/LukX1RYMLUaB/AW5aWA8GYcoDYiNABlvrStjXc9XiM3OjWsl8Aexv1aF+2IFSfk3N
         PhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ve74kCUsLiR2cO1kUq0ir2wefNgqVDP75r+gSCsTxoE=;
        b=jKolMZNixbVkpCce0FzWXSXayBbvqQFrI2mjrnRdx5nBR71wLr3MHT/C0Xh6eZlxGw
         9xDCT5f8hZc8sVqqXEwkyKlzANRmUNekz5EMJ19CO6/z4D0/XOYkf772hwt1GaPpLLi8
         ulY7ON7jzLfv19/7pM5iPjY++tVFix5n1RTkA+z+PIHf5cCla0A8H19py1Njq+rDGEUO
         YCR3fwWDDQVCd7KRMqQKyfSMyKNo3V349lHPiQPJTn7/8hYuNLsb/ynCm4Uc9metU8wY
         TdHSHwJX7sNXUAvME5DrKQYEq/gGNTmB2nLwwEpeq3EhV+JafCknfRR/14iJaoTpQqbm
         wxEQ==
X-Gm-Message-State: AHPjjUhv9DD0sH/jde7C10iU68ni3H1nhH3r3Fh1FQMKxZc0TivrBOGW
        Xm/KM+TNkDN8KWtxesOD8MnfmK9Y/V0=
X-Google-Smtp-Source: AOwi7QD5rWPZMvTtB2+TiqZ+w8twSYHzrpDgbljxK1CJN/xNgJLGWcx/Q6CP8Fy90VS6QeCN2lhhPA==
X-Received: by 10.28.238.73 with SMTP id m70mr1443138wmh.23.1506424951271;
        Tue, 26 Sep 2017 04:22:31 -0700 (PDT)
Received: from hanwen.roam.corp.google.com ([104.132.61.99])
        by smtp.gmail.com with ESMTPSA id f19sm15854873wrf.85.2017.09.26.04.22.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 04:22:30 -0700 (PDT)
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, bmwill@google.com,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 0/3] Comment fixes
Date:   Tue, 26 Sep 2017 13:21:47 +0200
Message-Id: <20170926112150.21850-1-hanwen@google.com>
X-Mailer: git-send-email 2.14.1.821.g8fa685d3b7-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

follow more commit log conventions; verified it compiled (yay).

(should I send patches that are in 'pu' again as well?)

Han-Wen Nienhuys (3):
  real_path: clarify return value ownership
  read_gitfile_gently: clarify return value ownership.
  string-list.h: move documentation from Documentation/api/ into header

 Documentation/technical/api-string-list.txt | 209 ----------------------------
 abspath.c                                   |   4 +
 setup.c                                     |   3 +-
 string-list.h                               | 192 +++++++++++++++++++++----
 4 files changed, 168 insertions(+), 240 deletions(-)
 delete mode 100644 Documentation/technical/api-string-list.txt

--
2.14.1.821.g8fa685d3b7-goog
