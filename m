Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A6E21F404
	for <e@80x24.org>; Fri, 31 Aug 2018 23:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeIADyy (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 23:54:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35926 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeIADyy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 23:54:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id b11-v6so6190899pfo.3
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 16:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uFstL4qbjdtac7FQG6tbUOQwSBId+sW2SHHcu6ewrls=;
        b=uS9OHuROJ8LsIeGPLuhq2oe1WSMDsLLkZMHvfNsv9Hz9QywPopAmiUn41fbpH75/C8
         K8A0GSiFvnet7q2UkY1i2uPgdTMjWh2qKug73xNm5YpjJzpQfUw1UImmWwVtUtR2H2VB
         iuCirPnbDxTqscI4ZiBVTkfatLVcAM9RSNex1lFio4QZYj/p3lPyvCrVlrKp+29ZSW2C
         fyphORD1HWTl42HcHUQsiWu7sZvav3YS3M3vvUcFa2ViGTQBekOFKrFD8CexcvSYGV9w
         EYwRwaXgzXQmVekNfcV4WesaGj1youWp8JQObAJjsaOxRCCjYgVsW3SN5aCpKwDbmRY2
         eeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uFstL4qbjdtac7FQG6tbUOQwSBId+sW2SHHcu6ewrls=;
        b=cTHjz7qQ7GnADmgoD7rwqgkdzKcNK3SshjCOLaNxNp52YlRhXS+nKztqWbkaFopy7o
         xUJNbidyzbM4iAHKIidd5Jme+ALKSCbsyrVya21H+9vxt0u+gUg7bxVmsvN9vhg3qCZA
         HD7c7hGTDnvG7ryeyXk/Lvf2vsy6sJdZX8K8VM6AOEWbS8OQxXJMhG7gHlgMMSZ93HTF
         6h1xziaZoMFDk2KqpHfzHTIRhVRYldZxpYyJMslwfiytgEZjuVt8ldifHTLoij6GHX4p
         2y4AgBUgsvSxQ7US6qs88xg15qIAblmMsRFND1syePz1gI9c935BB0m/XpkVSwwuLT+R
         VPBQ==
X-Gm-Message-State: APzg51AHQsPet4qOTucx6N7HqgrB/3FKL1ZoUsyetcTRSWiqnPJFQfYt
        Vs8xcrL6Ua8hkxMVuAn3VBDb/O7T
X-Google-Smtp-Source: ANB0VdZiZvxqzwpsyv3c02TZDQQm8cy7DtsCr1tBlmQVGrWv6+c/VG6OyDYWVl6mwJ0q64dUvdSUEA==
X-Received: by 2002:aa7:8591:: with SMTP id w17-v6mr18421351pfn.77.1535759104792;
        Fri, 31 Aug 2018 16:45:04 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id d184-v6sm31635838pfg.74.2018.08.31.16.45.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:45:04 -0700 (PDT)
Date:   Fri, 31 Aug 2018 16:45:04 -0700 (PDT)
X-Google-Original-Date: Fri, 31 Aug 2018 23:44:59 GMT
Message-Id: <0c9d0f75fc0dd28d55d4ed41d008182746fc86cd.1535759099.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.30.git.gitgitgadget@gmail.com>
References: <pull.30.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] rebase -i: be careful to wrap up fixup/squash chains
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

When an interactive rebase was stopped at the end of a fixup/squash
chain, the user might have edited the commit manually before continuing
(with either `git rebase --skip` or `git rebase --continue`, it does not
really matter which).

We need to be very careful to wrap up the fixup/squash chain also in
this scenario: otherwise the next fixup/squash chain would try to pick
up where the previous one was left.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c                  | 17 ++++++++++++++---
 t/t3415-rebase-autosquash.sh |  2 +-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 84bf598c3e..ac5c805c14 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3578,9 +3578,20 @@ static int commit_staged_changes(struct replay_opts *opts,
 		 * the commit message and if there was a squash, let the user
 		 * edit it.
 		 */
-		if (is_clean && !oidcmp(&head, &to_amend) &&
-		    opts->current_fixup_count > 0 &&
-		    file_exists(rebase_path_stopped_sha())) {
+		if (!is_clean || !opts->current_fixup_count)
+			; /* this is not the final fixup */
+		else if (oidcmp(&head, &to_amend) ||
+			 !file_exists(rebase_path_stopped_sha())) {
+			/* was a final fixup or squash done manually? */
+			if (!is_fixup(peek_command(todo_list, 0))) {
+				unlink(rebase_path_fixup_msg());
+				unlink(rebase_path_squash_msg());
+				unlink(rebase_path_current_fixups());
+				strbuf_reset(&opts->current_fixups);
+				opts->current_fixup_count = 0;
+			}
+		} else {
+			/* we are in a fixup/squash chain */
 			const char *p = opts->current_fixups.buf;
 			int len = opts->current_fixups.len;
 
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 7d5ea340b3..13f5688135 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -330,7 +330,7 @@ test_expect_success 'wrapped original subject' '
 	test $base = $parent
 '
 
-test_expect_failure 'abort last squash' '
+test_expect_success 'abort last squash' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	test_when_finished "git checkout master" &&
 
-- 
gitgitgadget
