Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B5F21F461
	for <e@80x24.org>; Thu, 29 Aug 2019 17:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfH2RBf (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 13:01:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55222 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbfH2RBe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 13:01:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id k2so3047967wmj.4
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 10:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lYZGZJbE6XsEHhIMgcx1602NzvpnrujKfJgUFHIuscI=;
        b=nNtmDpI1/RJ+KTMsWLwP15I0lGbres2oAgsYGw4NEiJR0Y8Qp68+j6QDnQhJWQQhx+
         b+HT+GGFBu78pxHrkISaHiuchq/yifYOSDu0slxnOOcq4bFLCwRbAWz0ZEmW1iMXmYq5
         Vq7FXDp3wgn55M9UVBk2sOi+tjob5pDUjPbOLx6On2UP/EDwD27XdOZt1TErE9xSH0tG
         C2gdDBH7Pv24utBkebYVPlIry7vfcbleaojdqbDGgkmmX1MH0btWcQh+J4szkxJgEDTB
         Atz+Q99so24tHdx5gwTnH/W2fKpJ1f0pkuUPNKLl2zk5PYKPYAyGAr7GHsTeE21ITICR
         pmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lYZGZJbE6XsEHhIMgcx1602NzvpnrujKfJgUFHIuscI=;
        b=guHPGbd1AP9dDlkcgr7jO8wlUkjhYQtVmIGK6/pYhf6OFXs2MWrU3tLZNyFzcEUGHf
         vNeAx/yfUDD5XqHaGodQsVx8PULtBO7gWnhbLsmGSqv2Syh49SluX97dVZASMS4bAZwA
         LxUu28Xzo8xHvnwVzSSJ4PAa0oQbo0lY/QK8UEDuWa15CFcwGoAR7XhyTHNHmpGWWECA
         Igpq38VdZwWVjiuLbD9nVKx7HS2Y9wBDSjPfmXuJNE1rfNG+zaT4hiOenTaLW+50B4w2
         Etipn8/36vhTeb/EX79MWzSjUy+TxSniOXSmyJE3L9zKsGWz0gtJGyVWCXf3AOCgRY0y
         7g1w==
X-Gm-Message-State: APjAAAVt75exMTLR8MgWBBiGdF97N78j3TwYfO0KbwdYbBMGyxsnFETH
        mtWPkFCmdJWReYoVniOz8xtmQ8FD
X-Google-Smtp-Source: APXvYqzBE5FMzEzKjlZrDtUewg2z6z8k1+X3lgFfYYUK9N0ROXwozor8112BC6dKm2YqsltjKsn6Pw==
X-Received: by 2002:a1c:c78f:: with SMTP id x137mr6219105wmf.42.1567098092766;
        Thu, 29 Aug 2019 10:01:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k6sm8846265wrg.0.2019.08.29.10.01.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 10:01:32 -0700 (PDT)
Date:   Thu, 29 Aug 2019 10:01:32 -0700 (PDT)
X-Google-Original-Date: Thu, 29 Aug 2019 17:01:30 GMT
Message-Id: <dcf5c60c69d8275a557ffe3d3ae30911d2140162.1567098090.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.325.git.gitgitgadget@gmail.com>
References: <pull.325.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] checkout: add simple check for 'git checkout -b'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git switch' command was created to separate half of the
behavior of 'git checkout'. It specifically has the mode to
do nothing with the index and working directory if the user
only specifies to create a new branch and change HEAD to that
branch. This is also the behavior most users expect from
'git checkout -b', but for historical reasons it also performs
an index update by scanning the working directory. This can be
slow for even moderately-sized repos.

A performance fix for 'git checkout -b' was introduced by
fa655d8411 (checkout: optimize "git checkout -b <new_branch>"
2018-08-16). That change includes details about the config
setting checkout.optimizeNewBranch when the sparse-checkout
feature is required. The way this change detected if this
behavior change is safe was through the skip_merge_working_tree()
method. This method was complex and needed to be updated
as new options were introduced.

This behavior was essentially reverted by 65f099b ("switch:
no worktree status unless real branch switch happens"
2019-03-29). Instead, two members of the checkout_opts struct
were used to distinguish between 'git checkout' and 'git switch':

    * switch_branch_doing_nothing_is_ok
    * only_merge_on_switching_branches

These settings have opposite values depending on if we start
in cmd_checkout or cmd_switch.

The message for 64f099b includes "Users of big repos are
encouraged to move to switch." Making this change while
'git switch' is still experimental is too aggressive.

Create a happy medium between these two options by making
'git checkout -b <branch>' behave just like 'git switch',
but only if we read exactly those arguments. This must
be done in cmd_checkout to avoid the arguments being
consumed by the option parsing logic.

This differs from the previous change by fa644d8 in that
the config option checkout.optimizeNewBranch remains
deleted. This means that 'git checkout -b' will ignore
the index merge even if we have a sparse-checkout file.
While this is a behavior change for 'git checkout -b',
it matches the behavior of 'git switch -c'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/checkout.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6123f732a2..116200cf90 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1713,6 +1713,15 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.overlay_mode = -1;
 	opts.checkout_index = -2;    /* default on */
 	opts.checkout_worktree = -2; /* default on */
+	
+	if (argc == 3 && !strcmp(argv[1], "-b")) {
+		/*
+		 * User ran 'git checkout -b <branch>' and expects
+		 * the same behavior as 'git switch -c <branch>'.
+		 */
+		opts.switch_branch_doing_nothing_is_ok = 0;
+		opts.only_merge_on_switching_branches = 1;
+	}
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
-- 
gitgitgadget
