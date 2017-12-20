Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 144B01F404
	for <e@80x24.org>; Wed, 20 Dec 2017 13:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755121AbdLTNOF (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 08:14:05 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:46435 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754835AbdLTNOE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 08:14:04 -0500
Received: by mail-vk0-f67.google.com with SMTP id m15so13449670vkf.13
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 05:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GzgyPSGitLbGKXK1mq24OF4u0xKwEVvMdWcpfmSUeXs=;
        b=K20zkh0z33sHXIiraXn98hyIa1bHiFoS82OCtxSVDlSYtvZo6oiFQWSnSj74pywlYK
         rK5C+Q4/gtu1yZN4fcb4fnW/L8Gd7mZ2eO/mkovMcKq/5f1bniz5kSJLKPIjD66u4S4n
         ReZgBAisrxCODuaNdSF3VLq9v94Ak7Rv631HUa2grPwEkE87i8AWXeKBcQYkAIPhpYoJ
         r8EIBPM7UbK6Vd3fQRlJ5fNWaYpwYI8cMYrpWqiEG2SiE/sbwpfGyqdumh27V/9kB9N+
         ds07aD7BE3k12YpLfkcWtV0d02NsRrCLiYYvVqTdiJt9suFpJUYappVozEPoeTzVCNWe
         MX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GzgyPSGitLbGKXK1mq24OF4u0xKwEVvMdWcpfmSUeXs=;
        b=dtsmNxSFZtk2gp5Q9LAMJbKVgAKA90iQvcZa+d/xKer8E8ygvT5KY11PRDZTI1rEE2
         MjbIXfPUmKqiZ4Dz94l73TSiX/Xyy4UuWbARoNkC6cD6HKJlCFTJT+C0qx7jZ2pWb2Jp
         XTCVuwyucm0RmLbT3cSOU6zLsKoM24tf6iBSILP4OGs+mIxIUQpurdNozUTuA3tY7gCo
         X7P0T8L79aBnY7h0YMeSYBE4+8M+LbShNewIpwjcwONp+V0DS+6khe7JfYX5h1zTtgf3
         47Gq9eztsZtcffIbWurbnaC4pl1+E15bGgztJCGZF5SCvzq02fmqeTHBc8P13sZbz7Ft
         9Dkw==
X-Gm-Message-State: AKGB3mLsunfKbYv1SafpqhML/40OP9gJu9bCdelgfMkG1kKSuoG4Qawg
        dkGaOcyrhIJiz84VPIVvjDEAC28pLTpFLPKHj+EFuMzo
X-Google-Smtp-Source: ACJfBosx0DBphldemys+hcsI1r8CQKeB3lIrKG+zlwmY/FXZdYgF6z0rjtJN4nrcwO9Lv6QZ7LjQmJCKNCGRX4srz6s=
X-Received: by 10.31.174.139 with SMTP id x133mr6526242vke.55.1513775643234;
 Wed, 20 Dec 2017 05:14:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.31.110.198 with HTTP; Wed, 20 Dec 2017 05:14:02 -0800 (PST)
From:   William Pursell <william.r.pursell@gmail.com>
Date:   Wed, 20 Dec 2017 05:14:02 -0800
Message-ID: <CAJPQ5Na1Z5QpgqS+wUVPGq-E+wOgsW5m4NzGEUcAnmDnRz+9DA@mail.gmail.com>
Subject: [PATCH] doc: Fix specification of default (auto) for --color
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Current documentation for branch, show-branch, and grep contain the following:

--color[=<when>]
           Show colored matches. The value must be always (the
default), never, or auto.

This is incorrect, as the default is "auto".

Signed-off-by: William Pursell <william.r.pursell@gmail.com>
---
 Documentation/git-branch.txt      | 2 +-
 Documentation/git-grep.txt        | 2 +-
 Documentation/git-show-branch.txt | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index b3084c99c..1e4dc3d91 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -128,7 +128,7 @@ OPTIONS
 --color[=<when>]::
  Color branches to highlight current, local, and
  remote-tracking branches.
- The value must be always (the default), never, or auto.
+ The value must be always, never, or auto (the default).

 --no-color::
  Turn off branch colors, even when the configuration file gives the
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 18b494731..cb62fa30e 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -201,7 +201,7 @@ providing this option will cause it to die.

 --color[=<when>]::
  Show colored matches.
- The value must be always (the default), never, or auto.
+ The value must be always, never, or auto (the default).

 --no-color::
  Turn off match highlighting, even when the configuration file
diff --git a/Documentation/git-show-branch.txt
b/Documentation/git-show-branch.txt
index 7818e0f09..4a7be5f0c 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -119,7 +119,7 @@ OPTIONS
 --color[=<when>]::
  Color the status sign (one of these: `*` `!` `+` `-`) of each commit
  corresponding to the branch it's in.
- The value must be always (the default), never, or auto.
+ The value must be always, never, or auto (the default).

 --no-color::
  Turn off colored output, even when the configuration file gives the
