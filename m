Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB87D211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 13:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbeK3AHN (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 19:07:13 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36447 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbeK3AHN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 19:07:13 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so1012860plo.3
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 05:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=8hcQisDn3Am8z/Awg3OtQcpg2UBUC4plc095aQIpIA8=;
        b=ky2yEJCCmkM55pDLWKMQ36pUXpit+zkIqnA4xRH0C/Ggn0nWR5EBfPE00GMsmR2beQ
         Re2nTIn0PR2+oECzTdqp6ta7dP4bHyZJ47isBM9xxfi+Js0yEo1XT9bvTBLZHCNbmC0t
         e+m5tKVB5LpwZ6HxQSyI8CuDPZNF430bv3it66whS/pS0dcUSzYGv9woMdJMFufcM0s1
         PUjwKtmxN8rOU4ZgWczD4vyKQMs7QpuEN2t+1RlLh6byJSaf5M5PIVFIAgvTNG9BzWYK
         K/vifB4TgozofhppvLbWEaJZ2cBwcJWlXWER3dV4PpmHXVVv8zyYludE7EPSsaxpUdwF
         ZURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8hcQisDn3Am8z/Awg3OtQcpg2UBUC4plc095aQIpIA8=;
        b=Z8Ggw4wu8ELfLO4STb0Vtfqsq03xQSACKgOCrT8v37zDwUSzUHsEar+Uf8IxQ7nfXS
         t1u+zU/usbJV9akYd2Mt3C+9awlt7gVbzp2WxkxYtvwLvmrLIGCBWGhub0aBwM09t3yF
         fQdRrjGUDMZvTPejZa2R8hw0Y2KWpggLjLezw7JQbp5ltNMlmO10b4XeLiuFZkERP541
         8+4elpMraZm4t0Ydn7tl6smXgrohxz9rnl73SixuoFe9tlNzMbq1SJfEMMsgkt9nn44Y
         +lg1HogypFK+RcqQQxaTmqwwwtugCXB19jcolmP05DfjyVdrOtQCVP/cAx1N/6zogZQF
         7Ogg==
X-Gm-Message-State: AA+aEWbjWP7Bk+7Lvdf8cWVRVfIsYaC+c9qZvvkOMQor3GwI6yMKBiZj
        wtiwPcAb9dCHXEjanPoPd3MnEgAp
X-Google-Smtp-Source: AFSGD/U8RD8VXPlmg/35B0fBEjwqc6cy4/GRaN30ryxfH0z83JDBw+ZeaprOG7PS53CedF3yj86laA==
X-Received: by 2002:a17:902:2c03:: with SMTP id m3mr1324722plb.6.1543496514984;
        Thu, 29 Nov 2018 05:01:54 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id p24sm7655564pfk.155.2018.11.29.05.01.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 05:01:54 -0800 (PST)
Date:   Thu, 29 Nov 2018 05:01:54 -0800 (PST)
X-Google-Original-Date: Thu, 29 Nov 2018 13:01:50 GMT
Message-Id: <190c7856ad0c500107d0e063572890c151e4eae7.1543496511.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.88.v2.git.gitgitgadget@gmail.com>
References: <pull.88.git.gitgitgadget@gmail.com>
        <pull.88.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] rebase --stat: fix when rebasing to an unrelated
 history
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
current branch, there is no merge base. In diffstat mode, this means
that we cannot compare to the merge base, but we have to compare to the
empty tree instead.

Also, if running in verbose diffstat mode, we should not output

	Changes from <merge-base> to <onto>

as that does not make sense without any merge base.

Note: neither scripted nor built-in versoin of `git rebase` were
prepared for this situation well. We use this opportunity not only to
fix the bug(s), but also to make both versions' output consistent in
this instance. And add a regression test to keep this working in all
eternity.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c          | 18 ++++++++++++------
 git-legacy-rebase.sh      | 10 ++++++++--
 t/t3406-rebase-message.sh | 10 ++++++++++
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5b3e5baec8..1c6f817f4b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1481,10 +1481,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.flags & REBASE_DIFFSTAT) {
 		struct diff_options opts;
 
-		if (options.flags & REBASE_VERBOSE)
-			printf(_("Changes from %s to %s:\n"),
-				oid_to_hex(&merge_base),
-				oid_to_hex(&options.onto->object.oid));
+		if (options.flags & REBASE_VERBOSE) {
+			if (is_null_oid(&merge_base))
+				printf(_("Changes to %s:\n"),
+				       oid_to_hex(&options.onto->object.oid));
+			else
+				printf(_("Changes from %s to %s:\n"),
+				       oid_to_hex(&merge_base),
+				       oid_to_hex(&options.onto->object.oid));
+		}
 
 		/* We want color (if set), but no pager */
 		diff_setup(&opts);
@@ -1494,8 +1499,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
index b97ffdc9dd..b4c7dbfa57 100755
--- a/git-legacy-rebase.sh
+++ b/git-legacy-rebase.sh
@@ -718,10 +718,16 @@ if test -n "$diffstat"
 then
 	if test -n "$verbose"
 	then
-		echo "$(eval_gettext "Changes from \$mb to \$onto:")"
+		if test -z "$mb"
+		then
+			echo "$(eval_gettext "Changes to \$onto:")"
+		else
+			echo "$(eval_gettext "Changes from \$mb to \$onto:")"
+		fi
 	fi
+	mb_tree="${mb:-$(git hash-object -t tree /dev/null)}"
 	# We want color (if set), but no pager
-	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
+	GIT_PAGER='' git diff --stat --summary "$mb_tree" "$onto"
 fi
 
 test -n "$interactive_rebase" && run_specific_rebase
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 38bd876cab..c2c9950568 100755
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
+	test_i18ngrep "Changes to " actual &&
+	test_i18ngrep "5 files changed" actual
+'
+
 test_done
-- 
gitgitgadget
