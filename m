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
	by dcvr.yhbt.net (Postfix) with ESMTP id 789771F463
	for <e@80x24.org>; Thu, 26 Sep 2019 15:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfIZPaD (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 11:30:03 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33076 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfIZPaC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 11:30:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id y127so2060493lfc.0
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 08:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o7H0eAkVOQrYQ/l8M8LRQgb39M1cTspu1n1arbg/hyk=;
        b=UZ4yPDAp/Vpry83V6yn9hvm95RU3PiV3w1DJ19+RIyEKIXUMIPZlCCBkOpIj5bYaZk
         47AHS3WXwbAN+px/mbHS4O9b8E9Q+BNbWAKbZnbg5z0SKkNEAAWNQfN1VZ5dVpG88hrJ
         hYmpX2dm9KsdE6AtofQ5d9Ot7XtYhieWsVoHvE3IYxZsvFQ/N3j+u4/x44zSkR82ga0U
         ZPAJsXeCy6HFYgIALrLQTTSTazbvMKLrPpG8v3zv+Imm/t6+blxrYGZR16ZobGLYIuUs
         hzxO6qdfCKGY5q7/zDk9A/b32E3dEVfkk7d4xIzSxcH12DbZxPNhcnXZfkp/87F1TDbH
         9Qcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o7H0eAkVOQrYQ/l8M8LRQgb39M1cTspu1n1arbg/hyk=;
        b=I/wE9ffydQfG6yFpctpMfCHIEqH8gSBujCFpGS7rhKzM7DgUZ7XiQaSCJ92K24E37/
         EkHgR38CgZVh6RL2WAPpCHXZjn0Cgc+rNkVu7skb7DYZPksZCkH2NCaSTcmjaV0OlPTs
         wERMJFcZsk3RTH4ArkIOMAsb8j9TfZ2B/RB+5160TuaNCTWwR+XChGqaSkqu+YtFT5kP
         zGl/rYtIte4kpSIHHfvkPsUV8GmdjF8jUALU0CMluAqbgs+CMnz8zvUdt3/vfqaeeOHL
         w6mqhzOkXwHlYb+raslpufZ86W/dPK3u0Y6MvLJYNYOxFrK52fOwHT6I0w0cb562GcBC
         k4UA==
X-Gm-Message-State: APjAAAUtNlndUiSKDzuVMsx+5LVGwTSuPcYyhiY/wZRP1Cndm+nJtXH8
        nJCvUnY3KO5jv2l0zR/sP+Nw6YmV
X-Google-Smtp-Source: APXvYqwP94XxN/1mAYpllZVkg7R0Ca1Hj3PzHU9Gi30H7BId8rz3QldVCJC+XtWjNXbzyr36ZWYraA==
X-Received: by 2002:a19:7605:: with SMTP id c5mr2767298lff.114.1569511800568;
        Thu, 26 Sep 2019 08:30:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16sm587832lfp.38.2019.09.26.08.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 08:30:00 -0700 (PDT)
Date:   Thu, 26 Sep 2019 08:30:00 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 15:29:53 GMT
Message-Id: <6025b38d2659caa111d2e5e9a1fa48d47de0e827.1569511793.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.358.git.gitgitgadget@gmail.com>
References: <pull.358.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/4] git-gui--askyesno (mingw): use Git for Windows' icon, if
 available
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

For additional GUI goodness.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-gui--askyesno | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/git-gui--askyesno b/git-gui--askyesno
index 45b0260eff..c0c82e7cbd 100755
--- a/git-gui--askyesno
+++ b/git-gui--askyesno
@@ -52,5 +52,17 @@ proc yes {} {
 	exit 0
 }
 
+if {$::tcl_platform(platform) eq {windows}} {
+	set icopath [file dirname [file normalize $argv0]]
+	if {[file tail $icopath] eq {git-core}} {
+		set icopath [file dirname $icopath]
+	}
+	set icopath [file dirname $icopath]
+	set icopath [file join $icopath share git git-for-windows.ico]
+	if {[file exists $icopath]} {
+		wm iconbitmap . -default $icopath
+	}
+}
+
 wm title . $title
 tk::PlaceWindow .
-- 
gitgitgadget
