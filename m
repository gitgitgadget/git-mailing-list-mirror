Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD8211F463
	for <e@80x24.org>; Thu, 26 Sep 2019 19:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfIZTFo (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 15:05:44 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42592 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbfIZTFo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 15:05:44 -0400
Received: by mail-qk1-f195.google.com with SMTP id f16so2710782qkl.9
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 12:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g1PBwUPh5bRcef5zAjXgUDjR+MTHQp4u+X0g4rnEBZs=;
        b=naHTFp7McL9c131MOfNRdQ9MCjr2YGwNMSCFQ0FmmDS2zaLryUk36oa1gGHSi2xoKu
         ndvejWLS1bBDxcj8aqfrL3gjCSGKYhgvRSrAQmAswCtW3ipkQubDFJiStgXURxqPSeHx
         GRLO/l5gQF3AxjADuPT4v6onpQMvab6aYOPGxqQ2TxlfTtJRttoOx8Pde4ln6jFbTKkK
         czUg+IOg1TqpJinMygoCtPg0nThflKMDbn1wNqc/34OK4HMLTCl6Bipc5QMgPqv2teZw
         +z+Brhs+yFwx2sSTd6BPdSOKWCTm9C23kNU0SWkxbcAe7bL5QITdaURfiQfpNSBx3j5g
         Ky0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g1PBwUPh5bRcef5zAjXgUDjR+MTHQp4u+X0g4rnEBZs=;
        b=MiXmKLG9sDtxscZsIPoZ66sWBO7Cu3Z+PMaAduqPV932FacYS5dp8hhWa6/oljnBav
         CTw+safwgBJjnYNok74/eAhzODA4faUeOH9XPyeKAljZVbroIFIqYRN+3hQZALY8Y8tS
         dOWdnqIWOGepPe7mVyP2XFeJjArXLSnoNTBRYGmpczR7cOqDqEntPxvKSE5gQvKx0Rbh
         Tv4Y/QlT6W9qJFd2nGFo0vYnPR3JSgI5J3yRkGmzrmhADQxpZrdnVcAYbatHK9ZeF1DH
         /mtmf7AWY+UyRyMcGBHWCq1UzJGqXtSUN1Av1q97FJwT4Ob29ORkdaygUiryDYmpYfKE
         e79Q==
X-Gm-Message-State: APjAAAWep3BGkjMo6w8A3sLEGIaqREJYZHxELbH/bQnkJhRSbt4RG+M/
        X/+PBpkiqFw5KhnwXPyQcUsoxZU+lxGarQ==
X-Google-Smtp-Source: APXvYqxmLLiya0aX1ahpaAcYeLI9Z6WL3H3Rc31qFx0hL8YDbyQ3q9oBsmrzfLdJ9ngPsKPCh/ULbw==
X-Received: by 2002:ae9:ee17:: with SMTP id i23mr377150qkg.179.1569524743439;
        Thu, 26 Sep 2019 12:05:43 -0700 (PDT)
Received: from navi.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id y26sm1889875qtk.22.2019.09.26.12.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 12:05:42 -0700 (PDT)
From:   Pedro Sousa <pedroteosousa@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, emilyshaffer@google.com,
        gitster@pobox.com, jonathantanmy@google.com,
        philipoakley@iee.email, Pedro Sousa <pedroteosousa@gmail.com>
Subject: [PATCH v2] doc: MyFirstContribution: fix cmd placement instructions
Date:   Thu, 26 Sep 2019 16:05:22 -0300
Message-Id: <20190926190522.3424-1-pedroteosousa@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20190919184634.8869-1-pedroteosousa@gmail.com>
References: <20190919184634.8869-1-pedroteosousa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using the pull command instead of push is more accurate when giving
instructions on placing the psuh command in alphabetical order.

Signed-off-by: Pedro Sousa <pedroteosousa@gmail.com>
---
Changes since v1: Addressed Philip's comments on making alphabetical
sort instructions more explicit

 Documentation/MyFirstContribution.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index f867037..5e9b808 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -97,8 +97,8 @@ int cmd_psuh(int argc, const char **argv, const char *prefix)
 ----
 
 We'll also need to add the declaration of psuh; open up `builtin.h`, find the
-declaration for `cmd_push`, and add a new line for `psuh` immediately before it,
-in order to keep the declarations sorted:
+declaration for `cmd_pull`, and add a new line for `psuh` immediately before it,
+in order to keep the declarations alphabetically sorted:
 
 ----
 int cmd_psuh(int argc, const char **argv, const char *prefix);
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

