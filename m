Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 078C81F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 11:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbeK0WKz (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 17:10:55 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45345 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbeK0WKy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 17:10:54 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so15429504plm.12
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 03:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=MuaP5KPgk1mbYEQPdNoheYV5waVc4AoSbUiPdNj2Fhc=;
        b=IuZqTs4w59G4Rw5Lx8laMzvVSF4s5EUi51J/0g34+ck+lKbwEQBIrXD/iy1g9uykiY
         d6RzpscmRnNhMk0F1TEKIfMZIXRMYH4/KyUW/KIRzcbnynE43COY8T/ifjsyCCj1xgIr
         d7WponhNBTVWkpTteA06T8OllotMcqZKVDoydijYDOHWX67alPtY8Av7vlm1EHIKyU7k
         9cevriOZJ6YYvVBz4gGDByyVzz/8ToPlFbOaLbC+FuKW+0PZTBnAwjdumCP5BWrJdsiz
         1X9+LJvI7Hug5v3sQMkUw/l80rtxJSFj3dPUUC6iawBZAu63t+9LFuIIstHKnKaJHEBe
         1ORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MuaP5KPgk1mbYEQPdNoheYV5waVc4AoSbUiPdNj2Fhc=;
        b=XOurYXnrv8M4jWFTnU6N/4wIE92T/vZ1r3X+4F9llVeM5eMryW8F3vRmg0zgLeMqcD
         cJwU+G1R5yI4M80G4EO1/1tD+75zokdjYN85gv415KLewoXMv39KXlhX4g9PqRrx/Tm+
         X7etMa8HYri5sW03v0HhB9gItLl0cANVK+1nnb8RO4Mc/Z+fAZeR5vVYZ+JrPE4L61+U
         VxNBBEOfk9Y9b2ru/o1NhRBeZHJdxk9IX7UoTReasvRDFXJoqfsgiBbHCfgbQWFwp2aO
         HK2MuYt1K9JJNQojimGef/zQ/jxCNfrchL25g0u7yEj04ttK1a0CHk6s+WHKOkSbRwJr
         coTg==
X-Gm-Message-State: AA+aEWYaT/6MoI9BYLI07RoKPAZ0gbHU7Nor5gOGxl6gmgoudn2Ayhu9
        BFVCCIczHTINjVhp/TbxSKhYX1sB
X-Google-Smtp-Source: AFSGD/UwL/15mEmPuBCW1AbFDZ6GEc8hj3sgjpaKD+8c3mHiWBqMB2bk46kHGK9K3pxRX9pWsgA4Iw==
X-Received: by 2002:a17:902:d206:: with SMTP id t6mr32342707ply.193.1543317200308;
        Tue, 27 Nov 2018 03:13:20 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id 202sm4484993pfy.87.2018.11.27.03.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 03:13:19 -0800 (PST)
Date:   Tue, 27 Nov 2018 03:13:19 -0800 (PST)
X-Google-Original-Date: Tue, 27 Nov 2018 11:13:15 GMT
Message-Id: <680385e4bd5c34a5fcf9651a776c52db61557652.1543317195.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.88.git.gitgitgadget@gmail.com>
References: <pull.88.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] rebase --stat: fix when rebasing to an unrelated history
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When rebasing to a commit history that has no common commits with the
current branch, there is no merge base. The scripted version of the `git
rebase` command was not prepared for that and spewed out

	fatal: ambiguous argument '': unknown revision or path not in
	the working tree.

but then continued (due to lack of error checking).

The built-in version of the `git rebase` command blindly translated that
shell script code, assuming that there is no need to test whether there
*was* a merge base, and due to its better error checking, exited with a
fatal error (because it tried to read the object with hash 00000000...
as a tree).

Fix both scripted and built-in versions to output something sensibly,
and add a regression test to keep this working in all eternity.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c          |  8 +++++---
 git-legacy-rebase.sh      |  6 ++++--
 t/t3406-rebase-message.sh | 10 ++++++++++
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5b3e5baec8..9e4b0b564f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1483,7 +1483,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 		if (options.flags & REBASE_VERBOSE)
 			printf(_("Changes from %s to %s:\n"),
-				oid_to_hex(&merge_base),
+				is_null_oid(&merge_base) ?
+				"(empty)" : oid_to_hex(&merge_base),
 				oid_to_hex(&options.onto->object.oid));
 
 		/* We want color (if set), but no pager */
@@ -1494,8 +1495,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
 		opts.detect_rename = DIFF_DETECT_RENAME;
 		diff_setup_done(&opts);
-		diff_tree_oid(&merge_base, &options.onto->object.oid,
-			      "", &opts);
+		diff_tree_oid(is_null_oid(&merge_base) ?
+			      the_hash_algo->empty_tree : &merge_base,
+			      &options.onto->object.oid, "", &opts);
 		diffcore_std(&opts);
 		diff_flush(&opts);
 	}
diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
index b97ffdc9dd..be3b241676 100755
--- a/git-legacy-rebase.sh
+++ b/git-legacy-rebase.sh
@@ -718,10 +718,12 @@ if test -n "$diffstat"
 then
 	if test -n "$verbose"
 	then
-		echo "$(eval_gettext "Changes from \$mb to \$onto:")"
+		mb_display="${mb:-(empty)}"
+		echo "$(eval_gettext "Changes from \$mb_display to \$onto:")"
 	fi
+	mb_tree="${mb:-$(git hash-object -t tree /dev/null)}"
 	# We want color (if set), but no pager
-	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
+	GIT_PAGER='' git diff --stat --summary "$mb_tree" "$onto"
 fi
 
 test -n "$interactive_rebase" && run_specific_rebase
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 38bd876cab..a1ee912118 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -91,4 +91,14 @@ test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
 	test_i18ngrep "Invalid whitespace option" err
 '
 
+test_expect_success 'rebase -i onto unrelated history' '
+	git init unrelated &&
+	test_commit -C unrelated 1 &&
+	git -C unrelated remote add -f origin "$PWD" &&
+	git -C unrelated branch --set-upstream-to=origin/master &&
+	git -C unrelated -c core.editor=true rebase -i -v --stat >actual &&
+	test_i18ngrep "Changes from (empty)" actual &&
+	test_i18ngrep "5 files changed" actual
+'
+
 test_done
-- 
gitgitgadget
