Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80A5C1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 16:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933764AbeFYQmz (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 12:42:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51318 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754385AbeFYQmt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 12:42:49 -0400
Received: by mail-wm0-f66.google.com with SMTP id w137-v6so4711306wmw.1
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 09:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d52H1jQKJsfig3b89FXCk6n9K7WZTOifG/zoaTWrSj4=;
        b=CDBYddqv4JmMV1XPXVu+bgzzdcu6CZJW/gm9ZPrCndnxC3qdJUxEc05131EYCwwrYK
         VUdkPiBdNxTR3vCLUSp5U3PW+MwI21riJPDgZrlwbLW5O+qXtYG9LsDjZqrQc4AGKLX+
         u7676m9ApPfuiCcJ3tYXcYJeBM6srJCk/XQJ3gHo06V/oCao/O8vzfQMdaNzOnf7pgNT
         ywAOrQvahZLUjzMECy5Se/UwizFhloSBzBUCyNIXDxTidV71PIW8Kj7tOuh44Nk0ILJI
         deKW710Jd8kihrcgNZ3sVPLupE9skSJsD1KHDqs8yoUVsL5B4EOpHsVNo24jgl3Mx873
         Z4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d52H1jQKJsfig3b89FXCk6n9K7WZTOifG/zoaTWrSj4=;
        b=hH6XNnpBVVfZ+iODCQJ5QiuT3YShHofMmhfRxJ3Bbn8wrBK2fAPIzadJmzKHbZAnaS
         hpoL8qNyTI9vONf2qwp1OUd5o7qwiTpdDvvaEm0Y1esSWu9tj7IKBb4PakIQa8i7VnTq
         0PM/1SEpJcp72OAGgQURvq1hrK/4GbTSNfmok8XFG6xZeTOLSKdIrBd1xCOorhKzQDuK
         36pKPpGoE10Pd3Ijw5H7sC4NAEM+I2ZO41RvlLBN42XwYh9ySX3sdvQthtT6KeOLGbrY
         IA6o0V/6zM1yjhEz43VbNsH2g8wH0UTodYjSGc8P0wdlMwrr2sKDkeS1zdTUynYJjOQO
         KxgQ==
X-Gm-Message-State: APt69E3nrZQ7hcdKyR2/kUNQ3GIOdEKH4A4XgjTZnAE2FJHe4ztTEJI2
        yER90so9/G8vz3nr1AFo4ibgiVI1
X-Google-Smtp-Source: AAOMgpeto27sNGNbn7JnbvHaJJQYwYw1/ZEH5Nm5PRUSX2fsMtVRZMKyX3aPSPZ+mIM3GGXtAPO0lA==
X-Received: by 2002:a1c:130c:: with SMTP id 12-v6mr1521692wmt.127.1529944967735;
        Mon, 25 Jun 2018 09:42:47 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com (5-13-160-71.residential.rdsnet.ro. [5.13.160.71])
        by smtp.gmail.com with ESMTPSA id d14-v6sm2912904wro.24.2018.06.25.09.42.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 09:42:46 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, joel@teichroeb.net, gitster@pobox.com
Subject: [PATCH v6 4/4] stash: renamed test cases to be more descriptive
Date:   Mon, 25 Jun 2018 19:42:27 +0300
Message-Id: <0f49fc90bee5e6a297c49224f1451a7aee4c8635.1529943789.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.13.g506fc12fb
In-Reply-To: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Renamed some test cases' labels to be more descriptive and under 80
characters per line.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 t/t3903-stash.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index de6cab1fe..8d002a7f2 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -604,7 +604,7 @@ test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
 	test_cmp expected actual
 '
 
-test_expect_success 'stash drop - fail early if specified stash is not a stash reference' '
+test_expect_success 'drop: fail early if specified stash is not a stash ref' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD && git stash clear" &&
 	git reset --hard &&
@@ -618,7 +618,7 @@ test_expect_success 'stash drop - fail early if specified stash is not a stash r
 	git reset --hard HEAD
 '
 
-test_expect_success 'stash pop - fail early if specified stash is not a stash reference' '
+test_expect_success 'pop: fail early if specified stash is not a stash ref' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD && git stash clear" &&
 	git reset --hard &&
@@ -682,7 +682,7 @@ test_expect_success 'invalid ref of the form "n", n >= N' '
 	git stash drop
 '
 
-test_expect_success 'stash branch should not drop the stash if the branch exists' '
+test_expect_success 'branch: should not drop the stash if the branch exists' '
 	git stash clear &&
 	echo foo >file &&
 	git add file &&
@@ -693,7 +693,7 @@ test_expect_success 'stash branch should not drop the stash if the branch exists
 	git rev-parse stash@{0} --
 '
 
-test_expect_success 'stash branch should not drop the stash if the apply fails' '
+test_expect_success 'branch: should not drop the stash if the apply fails' '
 	git stash clear &&
 	git reset HEAD~1 --hard &&
 	echo foo >file &&
@@ -707,7 +707,7 @@ test_expect_success 'stash branch should not drop the stash if the apply fails'
 	git rev-parse stash@{0} --
 '
 
-test_expect_success 'stash apply shows status same as git status (relative to current directory)' '
+test_expect_success 'apply: shows same status as git status (relative to ./)' '
 	git stash clear &&
 	echo 1 >subdir/subfile1 &&
 	echo 2 >subdir/subfile2 &&
@@ -1048,7 +1048,7 @@ test_expect_success 'stash push -p with pathspec shows no changes only once' '
 	test_i18ncmp expect actual
 '
 
-test_expect_success 'stash push with pathspec shows no changes when there are none' '
+test_expect_success 'push: <pathspec> shows no changes when there are none' '
 	>foo &&
 	git add foo &&
 	git commit -m "tmp" &&
@@ -1058,7 +1058,7 @@ test_expect_success 'stash push with pathspec shows no changes when there are no
 	test_i18ncmp expect actual
 '
 
-test_expect_success 'stash push with pathspec not in the repository errors out' '
+test_expect_success 'push: <pathspec> not in the repository errors out' '
 	>untracked &&
 	test_must_fail git stash push untracked &&
 	test_path_is_file untracked
-- 
2.18.0.rc2.13.g506fc12fb

