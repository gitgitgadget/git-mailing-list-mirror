Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28BBB1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbeHMOPW (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:15:22 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:36318 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbeHMOPV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:15:21 -0400
Received: by mail-pl0-f44.google.com with SMTP id e11-v6so6775069plb.3
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 04:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=13JgL+1xNJBnl/+1o0JsJAz5AVIePBak9PgoCrL4S90=;
        b=eYumpnJ2/0w1NVPSIqqkQtD60oVzpMecZT0jZr5ksx32tO/axkP0mr8g5SMZB5umP/
         ItR0ftktTML5AYYByT1Em3nLNsYy1udKx840Dd2VQqYY6XVXATsShJX04+2dy0zjS/oK
         vOCBco0PnVqeWY0phAO3lg3rGe+aiqwYXTNagVsnNVmTfn6iUZMu34pW5/6OtzrFjwe7
         dMgD7FfGywP1NPlZb1hAS6r5vkjUnncz6765n1F9dsDeBqAd8TgOlm9MtmZX4ozuP05/
         AHdgd8HAJvY7LoxTGsnqjbOkbAb+hZuETX3r204UFhjfgouNopmYmUzUcNO3yvR0x65L
         v8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=13JgL+1xNJBnl/+1o0JsJAz5AVIePBak9PgoCrL4S90=;
        b=FHiLDmjq7SLDj6m67Ixiwhqb8E2pmvKTtjvBUJM7DJec5XicE1xxvny8oIJRhTxXpX
         f+p03rkg8v6BwhlXzzK5dbt0J1FftTcgDda2vTtp8TeD6d0HV3RlzcmGewGhYl5wE2mq
         eYbrRn51nRfP+v7pRHFp+Ycpm4quRRj8ily7m3mx8v59iR5vfBTXdOYfWY8FNyq9ffLM
         yHXGDiB2U8tfc3N5O5Xb74edFrJR7ADMszuY3lT/gHvkFSWOfKKM2F/ZSDL1i4sPxjqD
         24YBdhR9Kqct7w9aOyf5Nk6R6uHmtzKCrhyQEd9v5xNu0HSlm0qio8jksZmahs8zgWq3
         obAw==
X-Gm-Message-State: AOUpUlGCQSvTXOcMRkhvSChKlBsjK0B+1bJIIOcTY3AaIWp5XWguSIJ9
        sEq4cm071yjtLl31e3J96zk52C1I
X-Google-Smtp-Source: AA+uWPxrzfgQC0eECWqLX6VL/mgVf3+3GCYmXpSmsLlkkqATZ8GygvsYpJvps/8uR9vmxsJlCwzOFA==
X-Received: by 2002:a17:902:7c8e:: with SMTP id y14-v6mr16708303pll.265.1534160008248;
        Mon, 13 Aug 2018 04:33:28 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id g28-v6sm34837725pfe.41.2018.08.13.04.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 04:33:27 -0700 (PDT)
Date:   Mon, 13 Aug 2018 04:33:27 -0700 (PDT)
X-Google-Original-Date: Mon, 13 Aug 2018 11:32:53 GMT
Message-Id: <16e3cf27b515ba94412c48b0f58059f1f30cc08d.1534159977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v6.git.gitgitgadget@gmail.com>
References: <pull.1.v5.git.gitgitgadget@gmail.com>
        <pull.1.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 18/21] completion: support `git range-diff`
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

Tab completion of `git range-diff` is very convenient, especially
given that the revision arguments to specify the commit ranges to
compare are typically more complex than, say, what is normally passed
to `git log`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/completion/git-completion.bash | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 94c95516e..3d4ec3432 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1976,6 +1976,20 @@ _git_push ()
 	__git_complete_remote_or_refspec
 }
 
+_git_range_diff ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp "
+			--creation-factor= --dual-color
+			$__git_diff_common_options
+		"
+		return
+		;;
+	esac
+	__git_complete_revlist
+}
+
 _git_rebase ()
 {
 	__git_find_repo_path
-- 
gitgitgadget

