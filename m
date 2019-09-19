Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40FD61F464
	for <e@80x24.org>; Thu, 19 Sep 2019 18:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404271AbfISSrc (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 14:47:32 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44127 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391151AbfISSrc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 14:47:32 -0400
Received: by mail-qk1-f195.google.com with SMTP id u22so982032qkk.11
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 11:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QuOZbvKzQcH4BO8DxthSAciLaFUwa1+K3GQ+VuXbmd4=;
        b=AXzDb4ofZOWGDJ/fMU0XThtObLsHNGTwgJziXjMlQHBpkPbP3+LeC/AvoxLiMEtcZO
         6RZCiy6e71mSy7JwYndMYkbgx2GHZNKoRua5gnd+WaglVFS/4wejQZgQajp25Ph/xTMa
         QhOl/yo2a0hzAvxUXBdoYxlf0/8xriwAunuhhl1yO4JyxF/2F80w2UF2TZszAWxuK2Yy
         7fOfPWcGifdShFLGrWYfiI9dFiNpUi38hr59yt89hAcN0oTT+1zb43apbNMJEWTR58Go
         7XO8hdPSaRBg8xHiW0rTP1EB7zy0pUHsBxaeGm/igRFQioGXk01I8wEb/TGqWvjHoWk7
         dd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QuOZbvKzQcH4BO8DxthSAciLaFUwa1+K3GQ+VuXbmd4=;
        b=gLMEOrRZUABJvmKCsd6iVOukyq18UZFbIuZj2pT9TYiuRWx6VNx5DjJx9/gWzIRvsz
         wnGZanncRfZH4v4uvuLLkPk+2CwCpQ8S1hpdNXtkJClBrSGkP8wBaK+XzuLxwjhAT6zI
         g2jHeBNsuWitnNZrXujCWw6Z/aPfhG3vHyN15db2RHZMfqctMNb8i5fnAChF154dRaRM
         WfQ/ULDaFSWf+hqkkyDBjvG3E9p4UjtqtHuaRGjHn/TbiImPOnQrJt4UqfEvACeUqDr+
         E8ArrLmXt57y53jKSyq0tJJXaj5SllYOGLQQM9bfCDuZKqGCA40IpqHSQYX0sM48hQbP
         XaUw==
X-Gm-Message-State: APjAAAWVxnox5cjSURcDwLbjE/ZH3QE0T5v5OrhgAgIC/UgvluMaUeC3
        1snA8eAadZkqvm9008wUP4RvOdbeqgykNA==
X-Google-Smtp-Source: APXvYqyF9aVAXFOznGLysNMlUOHJ6i/4p06MBCHiay61O3GD8rhOMmf+lLpcLLiDhZ3iIavSk3Uk+g==
X-Received: by 2002:a37:7e84:: with SMTP id z126mr4160972qkc.448.1568918851030;
        Thu, 19 Sep 2019 11:47:31 -0700 (PDT)
Received: from navi.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 14sm4656982qtb.54.2019.09.19.11.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 11:47:30 -0700 (PDT)
From:   Pedro Sousa <pedroteosousa@gmail.com>
To:     git@vger.kernel.org
Cc:     Pedro Sousa <pedroteosousa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH] doc: MyFirstContribution: fix cmd placement instructions
Date:   Thu, 19 Sep 2019 15:46:34 -0300
Message-Id: <20190919184634.8869-1-pedroteosousa@gmail.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using the pull command instead of push is more accurate when giving
instructions on placing the psuh command in alphabetical order.

Signed-off-by: Pedro Sousa <pedroteosousa@gmail.com>
---
 Documentation/MyFirstContribution.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index f867037..fb15af8 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -97,7 +97,7 @@ int cmd_psuh(int argc, const char **argv, const char *prefix)
 ----
 
 We'll also need to add the declaration of psuh; open up `builtin.h`, find the
-declaration for `cmd_push`, and add a new line for `psuh` immediately before it,
+declaration for `cmd_pull`, and add a new line for `psuh` immediately before it,
 in order to keep the declarations sorted:
 
 ----
@@ -123,7 +123,7 @@ int cmd_psuh(int argc, const char **argv, const char *prefix)
 }
 ----
 
-Let's try to build it.  Open `Makefile`, find where `builtin/push.o` is added
+Let's try to build it.  Open `Makefile`, find where `builtin/pull.o` is added
 to `BUILTIN_OBJS`, and add `builtin/psuh.o` in the same way next to it in
 alphabetical order. Once you've done so, move to the top-level directory and
 build simply with `make`. Also add the `DEVELOPER=1` variable to turn on
@@ -149,7 +149,7 @@ a `cmd_struct` to the `commands[]` array. `struct cmd_struct` takes a string
 with the command name, a function pointer to the command implementation, and a
 setup option flag. For now, let's keep mimicking `push`. Find the line where
 `cmd_push` is registered, copy it, and modify it for `cmd_psuh`, placing the new
-line in alphabetical order.
+line in alphabetical order (immediately before `cmd_pull`).
 
 The options are documented in `builtin.h` under "Adding a new built-in." Since
 we hope to print some data about the user's current workspace context later,
@@ -167,7 +167,7 @@ Check it out! You've got a command! Nice work! Let's commit this.
 
 `git status` reveals modified `Makefile`, `builtin.h`, and `git.c` as well as
 untracked `builtin/psuh.c` and `git-psuh`. First, let's take care of the binary,
-which should be ignored. Open `.gitignore` in your editor, find `/git-push`, and
+which should be ignored. Open `.gitignore` in your editor, find `/git-pull`, and
 add an entry for your new command in alphabetical order:
 
 ----
-- 
2.9.3

