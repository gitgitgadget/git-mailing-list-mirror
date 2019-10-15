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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BCDA1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 10:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbfJOKZo (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 06:25:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34737 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730540AbfJOKZm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 06:25:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id j11so23183861wrp.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 03:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wwPh7DRcIA/F+5FgP4nbsOqPmtdwehHm7ZZOCpycCPw=;
        b=lsY7ckXVR0JuXpTcdnUeqh+g6eQya7L9lgYFZUeGtQpREjyRI6tIgsZkSEaSQTIxWA
         v2H+8iAB12BlpouBX+52UZlNH88ThzIi+QHtj2/pyZf2kHMyY3KfCbqpP7Vq02D9SaHT
         XwM+NYq3BzYgH4fUgeJsDukLoMSIVsOhL9vO0VAq5MoHY4RfAP2kJhqCEjqruXZYYFJV
         /i32NcD9jAM0/PwrkHiHMvPssb22ADjGIR1/IY3u6oQEYxTj7UGWlk1nK2nAo37EVZtD
         /ruV8rPoDjUGSIZZOjCpQD10GauKSXdDnb9uo9tNVPQDkjrdCAOtcsFnmvMejHSnMVQK
         jP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wwPh7DRcIA/F+5FgP4nbsOqPmtdwehHm7ZZOCpycCPw=;
        b=QoowTN/kC3a4/codraVGIuVSZuZ9NUFOcXTm/LxcYc2eErw/83luRndoBdN84TUGQB
         +E6GRDXaoZDchkHdTvYSA2Oiq49iRHhjpT0tHaoJ0ITyFznezFqqxCldbrjxpw9bAqC3
         sR9Jdpe9Buazf7vMoETqrHGKG+fWXJJn2Emh+u/PRJmt6H3luFo4PHlS+PCZ+NTN6joc
         1D8xIZHiDimzRiV70CsvUcN/sp4Jp0She4wbkeRyohGieCWGB3Me3neSH+nVfLR+Lcu6
         7HXa+tvWB+3tdfIeIbf1V7HviID3f3xos5sSAeuPa2gCc47BcHd811/a2UcYJkcI+Vie
         a5fw==
X-Gm-Message-State: APjAAAU9z9SGW/dIVrapnWES5lG8Z5IA8tkqPBIvTZq6vtY+AyVLJ14I
        wjZ4kmwtvqPDVw1IEOQXGquBT6Wi
X-Google-Smtp-Source: APXvYqzdR9RP4rl4C1XaDprR1bJyourLV7/CnSCLe8jZ1wKjQyaLlfp6HRasRTNPNG2vFEfY/48EJg==
X-Received: by 2002:a05:6000:1288:: with SMTP id f8mr14992446wrx.111.1571135140054;
        Tue, 15 Oct 2019 03:25:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o19sm26266333wmh.27.2019.10.15.03.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 03:25:39 -0700 (PDT)
Message-Id: <67a711754efce038914e8ec15c5dec4a5983566d.1571135132.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.388.v2.git.1571135132.gitgitgadget@gmail.com>
References: <pull.388.git.gitgitgadget@gmail.com>
        <pull.388.v2.git.1571135132.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 10:25:32 +0000
Subject: [PATCH v2 6/6] sequencer: run post-commit hook
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Prior to commit 356ee4659b ("sequencer: try to commit without forking
'git commit'", 2017-11-24) the sequencer would always run the
post-commit hook after each pick or revert as it forked `git commit` to
create the commit. The conversion to committing without forking `git
commit` omitted to call the post-commit hook after creating the commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                   |  1 +
 t/t3404-rebase-interactive.sh | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index cdc0d1dfba..da2decbd3a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1401,6 +1401,7 @@ static int try_to_commit(struct repository *r,
 		goto out;
 	}
 
+	run_commit_hook(0, r->index_file, "post-commit", NULL);
 	if (flags & AMEND_MSG)
 		commit_post_rewrite(r, current_head, oid);
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index c5d0326825..c573c99069 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1583,6 +1583,25 @@ test_expect_success 'valid author header when author contains single quote' '
 	test_cmp expected actual
 '
 
+test_expect_success 'post-commit hook is called' '
+	test_when_finished "rm -f .git/hooks/post-commit" &&
+	>actual &&
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/post-commit <<-\EOS &&
+	git rev-parse HEAD >>actual
+	EOS
+	(
+		set_fake_editor &&
+		FAKE_LINES="edit 4 1 reword 2 fixup 3" git rebase -i A E &&
+		echo x>file3 &&
+		git add file3 &&
+		FAKE_COMMIT_MESSAGE=edited git rebase --continue
+	) &&
+	git rev-parse HEAD@{5} HEAD@{4} HEAD@{3} HEAD@{2} HEAD@{1} HEAD \
+		>expect &&
+	test_cmp expect actual
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
gitgitgadget
