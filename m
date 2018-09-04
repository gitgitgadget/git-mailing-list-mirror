Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D78791F404
	for <e@80x24.org>; Tue,  4 Sep 2018 22:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeIEC1E (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 22:27:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33359 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbeIEC1E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 22:27:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id b92-v6so2269129plb.0
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 14:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jVdj9quxdcCcHq5kT1hlt8+SuJK616W5drl2wkkvDR4=;
        b=E3kjcRUAP6KbI+WoQYMowz5xi61IMcYrjllZgUkoVhIzbrSgfsxaCJ9UGyrEKShHgV
         8Jj/loEOPPYLslfoSpbxkse8GOad7HznVp9Ekvz/ptiXZ7I9Ebwpc0IUenIoVrUD+zs7
         jRZkxn6YmBAtwk762y1xsYSbJANRBf6faxP87y3QDRVLykO5z0iexvXMtf0wqV+uFWfo
         +Zwy+F7fn7d/Xyy6b7QnJPAZ+NZTC/0pc8LzfddilCVcD9xvZd8CAKLpxZu9iYI9TEEa
         lCIA/um2nI8eVclZpl4D7eFlp80F6SGdpnkr4ppu/T9XIK+PwbgbrNK33Skqdzmpa/Mt
         xziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jVdj9quxdcCcHq5kT1hlt8+SuJK616W5drl2wkkvDR4=;
        b=q07HmFZ+4ZeRwOJW/QXZ9y1WVzuqjncyFa6VskkOScrKlkSlz/vvIOiXbQ8kSCSEPN
         pjiJ9sZyFDPpiC3qoDf/4XGlYf0L9C8TsiyNkoErYrsejexnPr42FXIP12fOB/lKGYAd
         rH4zh06R2rH0G0ht93MX0WUouuPlBT2yuMYCGMfCHD63eU6ahxhPT+GMwMcsYVG4vNg0
         qSlHa/zwK0Tc1IWgq4T9ZAxeHR9Vcd207+Iz+YermDN20RpjApsTt3zLb0xeXZp5Lr6M
         bEpYwRcSmEraB1mztVPLtfHlAyOMHFhPGKYPdaCULQMvE8LgjXO0Us2oQ74AEUKJAkKx
         HDsg==
X-Gm-Message-State: APzg51Ca9ZEnyPEyYal3YWGMfPwdbfSRdDCDm2XNQ8+BkilIaCntyl1V
        rjo53PP0RifjjwFOEGpiSfQwUu24
X-Google-Smtp-Source: ANB0VdbHFEqzNIcTyv+ULn77SH0jYryy2TeRcIujr8gtkc9+8rp/mRvEcdMhWo9Eb5uf+bf/yLgv8g==
X-Received: by 2002:a17:902:934c:: with SMTP id g12-v6mr35459123plp.67.1536098399501;
        Tue, 04 Sep 2018 14:59:59 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id s75-v6sm39805702pfd.108.2018.09.04.14.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 14:59:58 -0700 (PDT)
Date:   Tue, 04 Sep 2018 14:59:58 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:59:35 GMT
Message-Id: <1b6851e5e1e08eaaaa9e25c4a3cdae7ea1e6f8e9.1536098386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.33.v2.git.gitgitgadget@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
        <pull.33.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 08/18] builtin rebase: support `--autosquash`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pratik Karki <predatoramigo@gmail.com>

This commit adds support for the `--autosquash` option which is used to
automatically squash the commits marked as `squash` or `fixup` in their
messages. This is converted following `git-legacy-rebase.sh` closely.

This option can also be configured via the Git config setting
rebase.autosquash. To support this, we also add a custom
rebase_config() function in this commit that will be used instead (and
falls back to) git_default_config().

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 9c00f3568f..c80eebfbd2 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -96,6 +96,7 @@ struct rebase_options {
 	int signoff;
 	int allow_rerere_autoupdate;
 	int keep_empty;
+	int autosquash;
 };
 
 static int is_interactive(struct rebase_options *opts)
@@ -295,6 +296,7 @@ static int run_specific_rebase(struct rebase_options *opts)
 		opts->allow_rerere_autoupdate ?
 		"--rerere-autoupdate" : "--no-rerere-autoupdate");
 	add_var(&script_snippet, "keep_empty", opts->keep_empty ? "yes" : "");
+	add_var(&script_snippet, "autosquash", opts->autosquash ? "t" : "");
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -455,6 +457,11 @@ static int rebase_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
+	if (!strcmp(var, "rebase.autosquash")) {
+		opts->autosquash = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, data);
 }
 
@@ -609,6 +616,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			    "conflict")),
 		OPT_BOOL('k', "keep-empty", &options.keep_empty,
 			 N_("preserve empty commits during rebase")),
+		OPT_BOOL(0, "autosquash", &options.autosquash,
+			 N_("move commits that begin with "
+			    "squash!/fixup! under -i")),
 		OPT_END(),
 	};
 
-- 
gitgitgadget

