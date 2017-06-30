Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52EB9201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753094AbdF3Uxy (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:53:54 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33294 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753139AbdF3Uxw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:53:52 -0400
Received: by mail-pf0-f178.google.com with SMTP id e7so72484190pfk.0
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2CQhZdrDo6vw7Btd1fF3102U4YuYbU4c0Pb1/k7cVpU=;
        b=Ye0oqe5kqGC2cEULuHIBxKwvJxhfxNJjikT0xRKQiifq/nio/jGHZc2RkiWAY0FI5p
         jORsDq/QtAoNWMYoKM8/o5Z9iTJJlhoyFsmxpITM3diV3f6Kbkhl9+vq8/omLc4WEAIe
         iOE+4S9h/rxgN9Z/Y+mzK+etz6bSvO0lvjc/C/E6cljPnqPI5u0brj8qGfbB23Kkcufw
         5ZiSa/dtYzu0i4g/lDFZu8eETmmyYgNwPrpqGB1Vtc84ZUQ477u+03kcrTw0h8NzKsUe
         5KWt+3u7sCrN/GQm2h4lazctzWaYH7Da58w5+I7y27wxYaftD1FLyKX7loE94WSuWofb
         Zxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2CQhZdrDo6vw7Btd1fF3102U4YuYbU4c0Pb1/k7cVpU=;
        b=geXpDG2aeX4kHOyvgXfjK36eQZ4D9ibM+eyjN42GllceyZ7/JnxByD/AkWl0uK/6GF
         OZuLO6zY+Zv9nXOdXQiJLNJ+NmKKEpthYtoPGAsldrAxPuM9JgvKNMeCS0A04+nZ2z+6
         jklBPO2RF7RWgoUYGeD/x+ny2d2mWmc8GQyO8f8u5FsI9qQWql2v9pVmU9uR9f3aIE6o
         fF6oNOtMhYOE0EbYbIlgMr1XSbvILhxHbZ7TuNbSp/oxFJHj5ViJ+/0HdpiuXsIqUAjb
         BY6r/v18/AjwBf07KwNFPaxO8kVUtwX7eG1GwP+5f24ymWBoU17PsmWZ8qkUufr2B8ul
         yXgg==
X-Gm-Message-State: AKS2vOxksmEq/XZ9Ylw4fcVKXmvvidSshfhOETaqBRbW17C67k9ozKho
        3J5F53Iq91IaMEgp
X-Received: by 10.98.15.67 with SMTP id x64mr24586115pfi.216.1498856026001;
        Fri, 30 Jun 2017 13:53:46 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id t83sm20957388pfg.91.2017.06.30.13.53.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:53:45 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, simon@ruderich.org
Subject: [PATCHv2 25/25] diff: document the new --color-moved setting
Date:   Fri, 30 Jun 2017 13:53:10 -0700
Message-Id: <20170630205310.7380-26-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630205310.7380-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
 <20170630205310.7380-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt       | 15 +++++++++++++--
 Documentation/diff-options.txt | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 06898a7498..74382e5ff5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1077,14 +1077,25 @@ This does not affect linkgit:git-format-patch[1] or the
 'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
 command line with the `--color[=<when>]` option.
 
+diff.colorMoved::
+	If set to either a valid `<mode>` or a true value, moved lines
+	in a diff are colored differently, for details of valid modes
+	see '--color-moved' in linkgit:git-diff[1]. If simply set to
+	true the default color mode will be used. When set to false,
+	moved lines are not colored.
+
 color.diff.<slot>::
 	Use customized color for diff colorization.  `<slot>` specifies
 	which part of the patch to use the specified color, and is one
 	of `context` (context text - `plain` is a historical synonym),
 	`meta` (metainformation), `frag`
 	(hunk header), 'func' (function in hunk header), `old` (removed lines),
-	`new` (added lines), `commit` (commit headers), or `whitespace`
-	(highlighting whitespace errors).
+	`new` (added lines), `commit` (commit headers), `whitespace`
+	(highlighting whitespace errors), `oldMoved` (deleted lines),
+	`newMoved` (added lines), `oldMovedDimmed`, `oldMovedAlternative`,
+	`oldMovedAlternativeDimmed`, `newMovedDimmed`, `newMovedAlternative`
+	and `newMovedAlternativeDimmed` (See the '<mode>'
+	setting of '--color-moved' in linkgit:git-diff[1] for details).
 
 color.decorate.<slot>::
 	Use customized color for 'git log --decorate' output.  `<slot>` is one
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 89cc0f48de..bc52bd0b99 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -231,6 +231,42 @@ ifdef::git-diff[]
 endif::git-diff[]
 	It is the same as `--color=never`.
 
+--color-moved[=<mode>]::
+	Moved lines of code are colored differently.
+ifdef::git-diff[]
+	It can be changed by the `diff.colorMoved` configuration setting.
+endif::git-diff[]
+	The <mode> defaults to 'no' if the option is not given
+	and to 'zebra' if the option with no mode is given.
+	The mode must be one of:
++
+--
+no::
+	Moved lines are not highlighted.
+default::
+	Is a synonym for `zebra`. This may change to a more sensible mode
+	in the future.
+plain::
+	Any line that is added in one location and was removed
+	in another location will be colored with 'color.diff.newMoved'.
+	Similarly 'color.diff.oldMoved' will be used for removed lines
+	that are added somewhere else in the diff. This mode picks up any
+	moved line, but it is not very useful in a review to determine
+	if a block of code was moved without permutation.
+zebra::
+	Blocks of moved code are detected greedily. The detected blocks are
+	painted using either the 'color.diff.{old,new}Moved' color or
+	'color.diff.{old,new}MovedAlternative'. The change between
+	the two colors indicates that a new block was detected. If there
+	are fewer than 3 adjacent moved lines, they are not marked up
+	as moved, but the regular colors 'color.diff.{old,new}' will be
+	used.
+dimmed_zebra::
+	Similar to 'zebra', but additional dimming of uninteresting parts
+	of moved code is performed. The bordering lines of two adjacent
+	blocks are considered interesting, the rest is uninteresting.
+--
+
 --word-diff[=<mode>]::
 	Show a word diff, using the <mode> to delimit changed words.
 	By default, words are delimited by whitespace; see
-- 
2.13.0.31.g9b732c453e

