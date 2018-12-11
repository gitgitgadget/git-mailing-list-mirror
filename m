Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43A4C20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 00:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeLKAJF (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 19:09:05 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:56664 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeLKAJE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 19:09:04 -0500
Received: by mail-yw1-f74.google.com with SMTP id t17so7751946ywc.23
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 16:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RIDx9OXSv3QZa+rnjqsldZ5uKRqOMI4tp2FUkBcok94=;
        b=tQ77CXvlgTS1bnqlj6r9/9DNnCnKw9bSsy7khaMUtXuATUmA+lLZrDEXNWHMaqAaqg
         YCSq4juv/m9tYF5vKAfBp5zsydw+l/gnp+nP4BEII0fXIrmv9r0SYTo1aBpWKFeauvpw
         FRLb2h0CaoS8u5Wb5jiM8REoLg6QMT3B0kXqvfrd60iow2x/fpAEoCJEhZxHrt63sryd
         mUj9nKs9PUUjELF5g+1RCAOgstm20h6mSCJ+EvAxaIptCxcZdbmlXK+w5rH3whFquSKV
         f/AQTIqOHW12muFX9Q9ENl0IOSTOEXFDgh+WFWjXW2mL7IVUh1fy2BRlGut5HI7xhbMC
         SYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RIDx9OXSv3QZa+rnjqsldZ5uKRqOMI4tp2FUkBcok94=;
        b=B4BQ2LRG8V0ozVCkG4M6NkgUhnIyMTULWxP/gsXXrpD/ZqAuWSM/yjAB17pgkwvedr
         jM6saQK7IITOXIY5Hsco7JFp8CkiaQSl3X6+3enhhtoPN1o7/phlfvJEVxSzES0BDZ8D
         QME1Rfrz3xFX5r7IYTpbRuIgVhBjEb1NdKTKX5swaSdQQJxqhtL5tZr3XhssD57MF8sR
         vc23oR0UurBc5FLQno5wNgh3F7/vCeY48w6kIUFjAtU2/ecRQ3PvbrSoeOZrf/OWQUPQ
         8NrxR/5SUrBi/oGxyTy/D+XEtvtbjsy+SpgE4Vc0g/2yzMRgALU4Cuf1gAiMlnra9QPR
         WL4g==
X-Gm-Message-State: AA+aEWZgg9l7LCaOJ7hXoeB2IaFePTr5xYqdQTm2C3rvnpOaQYjMjjsH
        aIfds3lLZGgde2oYesU63LuV+sCcbhkC
X-Google-Smtp-Source: AFSGD/W5QmbEX+x/wywb+nEXKt9nkWxmnPk3eEdhovbEKOyy8UCXB0oFGlLQ8vO/W1E2C4U7w/bD1GxbG+ZQ
X-Received: by 2002:a25:ea14:: with SMTP id p20mr1932828ybd.28.1544486943640;
 Mon, 10 Dec 2018 16:09:03 -0800 (PST)
Date:   Mon, 10 Dec 2018 16:08:59 -0800
In-Reply-To: <20181210224901.GL4633@hopa.kiewit.dartmouth.edu>
Message-Id: <20181211000859.130266-1-sbeller@google.com>
Mime-Version: 1.0
References: <20181210224901.GL4633@hopa.kiewit.dartmouth.edu>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH] Re: [wishlist] submodule.update config
From:   Stefan Beller <sbeller@google.com>
To:     yoh@onerussian.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---

> > So you are proposing a variable like submodule.update
> [...]
>
> Glad to hear that. Not sure though I would know where to stick my
> nose to figure out what to change. ;-)

The update_module is computed via the submodule--helpers
update-module-mode command, which is a small wrapper
around determine_submodule_update_strategy()
which you already touched in the other patch that makes
--reset-hard another mode.

This contains code and tests, but we'd need some docs as well.
I am not sure about this patch as it allows for easier experimentation
with submodules (e.g. "git config submodule.update '!git reset --hard'"
sounds like what you're trying to get) and using them, but as discussed
below this might be too much convenience already and we'd rather want to
have it properly integrated into the real commands.

> Well, not sure... In the long run, if UX is to be tuned up, I wonder if
> it would be more worthwhile to look toward making all those git commands
> (git merge, git checkout, git rebase, ..., git revert, git cherry-pick)
> support --recurse-submodules with a consistent with the non-recursive
> operation by default behavior

That is the end goal, very much.

> (e.g.  not introducing detached HEADs or
> controlling that via a set of additional options where needed).

As with the discussion of the submodule.repoLike option (the patch I
referenced in the other discussion), this is tricky to get the right
behavior, so it takes some more time to do.

Also what is right for a "git merge --recursive" might be totally different
from a "git submodule update --merge" as the former is not centered around
submodules but merging, such that a sensible default would be expected,
whereas the "submodule update" is allowed to have a rough edge.

From what I get from this discussion is that the submodule.repoLike patch 
needs to offer different modes of submodule operation.

Currently the submodules are handled with the "detached HEAD, period" mode,
whereas that patch proposes a "follow the submodule branch, trust me they're
in sync with the superproject magically" mode, but what you'd rather want to
see is a "don't mess with submodules HEAD detachments, but still have
superproject powers come to be".

As soon as we have one of these modes in place, adding another one
"should be easy", famous last words.

Stefan

 builtin/submodule--helper.c |  4 ++++
 t/t7406-submodule-update.sh | 41 +++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d38113a31a..e1aa3a9995 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1472,6 +1472,10 @@ static void determine_submodule_update_strategy(struct repository *r,
 		if (parse_submodule_update_strategy(val, out) < 0)
 			die(_("Invalid update mode '%s' configured for submodule path '%s'"),
 				val, path);
+	} else if (!repo_config_get_string_const(r, "submodule.update", &val)) {
+		if (parse_submodule_update_strategy(val, out) < 0)
+			die(_("Invalid update mode '%s' configured for 'submodule.update'"),
+				val);
 	} else if (sub->update_strategy.type != SM_UPDATE_UNSPECIFIED) {
 		out->type = sub->update_strategy.type;
 		out->command = sub->update_strategy.command;
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index e87164aa8f..05880fd48f 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -322,6 +322,33 @@ test_expect_success 'submodule update - rebase in .git/config' '
 	)
 '
 
+test_expect_success 'submodule update - rebase in generic .git/config' '
+	git -C super config submodule.update rebase &&
+	git -C super/submodule reset --hard HEAD~1 &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git submodule update submodule &&
+	 cd submodule &&
+	 compare_head
+	)
+'
+
+test_expect_success 'submodule.<name>.update overrides submodule.update' '
+	git -C super config submodule.update merge &&
+	git -C super config submodule.submodule.update rebase &&
+	git -C super/submodule reset --hard HEAD~1 &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git submodule update submodule &&
+	 cd submodule &&
+	 compare_head
+	)
+'
+
 test_expect_success 'submodule update - checkout in .git/config but --rebase given' '
 	(cd super &&
 	 git config submodule.submodule.update checkout
@@ -339,6 +366,20 @@ test_expect_success 'submodule update - checkout in .git/config but --rebase giv
 	)
 '
 
+test_expect_success 'submodule update - checkout in submodule.update in .git/config but --rebase given' '
+	test_when_finished "git -C super config --unset submodule.update" &&
+	git -C super config submodule.update checkout &&
+	git -C super/submodule reset --hard HEAD~1 &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git submodule update --rebase submodule &&
+	 cd submodule &&
+	 compare_head
+	)
+'
+
 test_expect_success 'submodule update - merge in .git/config' '
 	(cd super &&
 	 git config submodule.submodule.update merge
-- 
2.20.0.rc2.403.gdbc3b29805-goog

