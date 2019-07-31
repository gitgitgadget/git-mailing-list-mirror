Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 637C11F731
	for <e@80x24.org>; Wed, 31 Jul 2019 15:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfGaPSs (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 11:18:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39101 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbfGaPSm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 11:18:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so16967880wrt.6
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 08:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7fVMV9YC486EbkO5TSkcEYFKfWSOc03B0TLWjYb97nY=;
        b=hoErA4N7NBJF9EJ1U7B/IG7ELpI2OWovuA1+MWMdYknmHhrbu+5wcbA2FWkh7Pe5AF
         aACy32CSxK2uWKkR7g5fm7KhypPHL7xKklPC11+CtNBxSgIZlbj6HynN/JQEYPxYPUXG
         wXFKTrTVpFA4z2Urw3M++LHK2Q01njOgFuvcZEu7A7QeV4a0KzckD0jIXZMX2PsnuAkk
         hNaFEJbBi/qWLBMLRQF5ZxmXEN62jVgNcRdeVhTXkN37WhOKV7OzVv9AyncmLVrufByV
         4O2C73TUwVKA0h2YepZtx1iPXZGnEhFWPWO4hajLJFi8SKOxiglVUyxZRVlhi35xI9wb
         fQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7fVMV9YC486EbkO5TSkcEYFKfWSOc03B0TLWjYb97nY=;
        b=JzSB9QgudH9lMNGq6s1uJMT0gG2WMkOVaTW1csv6+W4UtIcQIfUB7oBITfgAvaXX9a
         vDx9LHZmdgAt98flUSm30tZUqCmg1eGxJfATKL/SqMW3cQRfVnBfChC1exXGY5djcHqW
         Sg8BHAlGqpNfLj0PcPPsMEPk89zBgze20FgxiMxT45PEPWklgdUO6XB9GSxqblYi6iiQ
         KDzz+KnBiLq88MPq1mh2Dusg8WshfIloXVqTYQ3CJO8l2mzQkFeQoBdFTqK5u2Cdw8Xh
         mOlahFIQTO0E8vqVvBElwJN6+Y/AMJ73t0mhPpLFADNKZdzR4UYAZXoDUpPQS9lTVOCg
         AOcw==
X-Gm-Message-State: APjAAAVmAkYTCKpXPYhoT7TzUdgANOMnEPp6Rz3Ks4dncpSd2t8K1YmM
        rLEQkVde5zfR3itd2mfccO7HwpGT
X-Google-Smtp-Source: APXvYqzsLlAhg14EFomrjzCg5m2ru5g26RuRv2oDMkNTNEmFTOd0Fpy/tgDJSf2DweJ8NGps+LXYjg==
X-Received: by 2002:adf:e444:: with SMTP id t4mr34079182wrm.262.1564586319056;
        Wed, 31 Jul 2019 08:18:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p3sm55857092wmg.15.2019.07.31.08.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:18:38 -0700 (PDT)
Date:   Wed, 31 Jul 2019 08:18:38 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Jul 2019 15:18:21 GMT
Message-Id: <e0645b3ad7e70519437e3b7a9ae6dc29488d13f2.1564586316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.v2.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
        <pull.294.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 01/16] Drop unused git-rebase--am.sh
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since 21853626ea (built-in rebase: call `git am` directly, 2019-01-18),
the built-in rebase already uses the built-in `git am` directly.

Now that d03ebd411c (rebase: remove the rebase.useBuiltin setting,
2019-03-18) even removed the scripted rebase, there is no longer any
user of `git-rebase--am.sh`, so let's just remove it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .gitignore        |  1 -
 Makefile          |  1 -
 builtin/rebase.c  |  4 ---
 git-rebase--am.sh | 85 -----------------------------------------------
 4 files changed, 91 deletions(-)
 delete mode 100644 git-rebase--am.sh

diff --git a/.gitignore b/.gitignore
index 2374f77a1a..875f3fc6e8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -122,7 +122,6 @@
 /git-range-diff
 /git-read-tree
 /git-rebase
-/git-rebase--am
 /git-rebase--common
 /git-rebase--interactive
 /git-rebase--preserve-merges
diff --git a/Makefile b/Makefile
index 8a7e235352..63e1973333 100644
--- a/Makefile
+++ b/Makefile
@@ -624,7 +624,6 @@ SCRIPT_SH += git-web--browse.sh
 
 SCRIPT_LIB += git-mergetool--lib
 SCRIPT_LIB += git-parse-remote
-SCRIPT_LIB += git-rebase--am
 SCRIPT_LIB += git-rebase--common
 SCRIPT_LIB += git-rebase--preserve-merges
 SCRIPT_LIB += git-sh-setup
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 21681a551b..4dd76ee576 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1153,10 +1153,6 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 	}
 
 	switch (opts->type) {
-	case REBASE_AM:
-		backend = "git-rebase--am";
-		backend_func = "git_rebase__am";
-		break;
 	case REBASE_PRESERVE_MERGES:
 		backend = "git-rebase--preserve-merges";
 		backend_func = "git_rebase__preserve_merges";
diff --git a/git-rebase--am.sh b/git-rebase--am.sh
deleted file mode 100644
index 6416716ee6..0000000000
--- a/git-rebase--am.sh
+++ /dev/null
@@ -1,85 +0,0 @@
-# This shell script fragment is sourced by git-rebase to implement
-# its default, fast, patch-based, non-interactive mode.
-#
-# Copyright (c) 2010 Junio C Hamano.
-#
-
-git_rebase__am () {
-
-case "$action" in
-continue)
-	git am --resolved --resolvemsg="$resolvemsg" \
-		${gpg_sign_opt:+"$gpg_sign_opt"} &&
-	move_to_original_branch
-	return
-	;;
-skip)
-	git am --skip --resolvemsg="$resolvemsg" &&
-	move_to_original_branch
-	return
-	;;
-show-current-patch)
-	exec git am --show-current-patch
-	;;
-esac
-
-if test -z "$rebase_root"
-	# this is now equivalent to ! -z "$upstream"
-then
-	revisions=$upstream...$orig_head
-else
-	revisions=$onto...$orig_head
-fi
-
-ret=0
-rm -f "$GIT_DIR/rebased-patches"
-
-git format-patch -k --stdout --full-index --cherry-pick --right-only \
-	--src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter \
-	--pretty=mboxrd --topo-order \
-	$git_format_patch_opt \
-	"$revisions" ${restrict_revision+^$restrict_revision} \
-	>"$GIT_DIR/rebased-patches"
-ret=$?
-
-if test 0 != $ret
-then
-	rm -f "$GIT_DIR/rebased-patches"
-	case "$head_name" in
-	refs/heads/*)
-		git checkout -q "$head_name"
-		;;
-	*)
-		git checkout -q "$orig_head"
-		;;
-	esac
-
-	cat >&2 <<-EOF
-
-	git encountered an error while preparing the patches to replay
-	these revisions:
-
-	    $revisions
-
-	As a result, git cannot rebase them.
-	EOF
-	return $ret
-fi
-
-git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" \
-	--patch-format=mboxrd \
-	$allow_rerere_autoupdate \
-	${gpg_sign_opt:+"$gpg_sign_opt"} <"$GIT_DIR/rebased-patches"
-ret=$?
-
-rm -f "$GIT_DIR/rebased-patches"
-
-if test 0 != $ret
-then
-	test -d "$state_dir" && write_basic_state
-	return $ret
-fi
-
-move_to_original_branch
-
-}
-- 
gitgitgadget

