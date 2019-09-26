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
	by dcvr.yhbt.net (Postfix) with ESMTP id 913A01F463
	for <e@80x24.org>; Thu, 26 Sep 2019 15:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfIZPaD (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 11:30:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38985 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbfIZPaC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 11:30:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id y3so2637613ljj.6
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cJGdPqSU11PM6WKMoDjYNtqzgxCbRtpAPJYrYtksTUw=;
        b=mDKG/vdNowpH42QB3XH2tqDVLPbuaz/g8U1/sLM9OMPKDOU8HeT70jHdTbfs0e2b3B
         kq5l69MM/jH++OgCFZRJgkyvNMF200B/DU0Dze8mrMG3KpK0BQh9hxVGX7Ybp7ZajyoR
         VL4KOipC2OaMgDIb+AcjBirsA/6BfK7MQ4JP/PUrlVtJAiYthAhosNYs7neIUFzgJdbL
         guKEOAMt+5N34wr+WgdaLa8rbk9xz/SB+AeuK420oQ1EvOJeYZrvVS1is7ruL8LHIwZY
         ei2HxgjbqXxfhjABhR2AbTWA6u6XwqgPysK08GRDYm/VWbgJyL6VkpJb67r2l4YtS5gs
         TsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cJGdPqSU11PM6WKMoDjYNtqzgxCbRtpAPJYrYtksTUw=;
        b=sT8u4/J6DX0D9/+JoL6SVkZSiVkNvuReQvlhD01bZ7pObFLnkd4heFVUMGa+40btWx
         3hwNuhww0WtGQd44B4+jnarK93/KuKyR5XMpQqVT6cLq24W5bVE2OLqzy/dCUtNNH0iI
         BkZeT6rCcklOvpH9qzmnY1NtB0hWKGlLlOKoRhRVhB3JODqv/PPRtZixWFcao7YaZkJx
         79EMhcRviBZfQ0S3qNBdpWfWJuxSKjNnZkGb0rLN0j5NVNTrX/9KzFRuWzGKg2EGlekM
         2H93iNxQm4dQOXpgRj/jcmbGt0yvGB4CWN2WGRnYbYtOHKraZM5aD2chRxaAyt1XHW0K
         /JjA==
X-Gm-Message-State: APjAAAUIybUqtKfRe0ptuaDaUx/H4YX1mo47o3i+V+OP3FXJGsXlbIF/
        G17Z90xBb/oi1vhft3p0S9DbnzRo
X-Google-Smtp-Source: APXvYqyStWg4eGQcno6gB3K028qDW3adQOHMt/J1ZgGr11MCtyll20Dd7YgoLrX5ooDkJD2RUk0ZYg==
X-Received: by 2002:a2e:9ad6:: with SMTP id p22mr3055018ljj.168.1569511799291;
        Thu, 26 Sep 2019 08:29:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j17sm576760lfb.11.2019.09.26.08.29.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 08:29:58 -0700 (PDT)
Date:   Thu, 26 Sep 2019 08:29:58 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 15:29:52 GMT
Message-Id: <8cfc935cdba316f513f2408c1f39c5d68d5258fc.1569511793.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.358.git.gitgitgadget@gmail.com>
References: <pull.358.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/4] git-gui--askyesno: allow overriding the window title
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

"Question?" is maybe not the most informative thing to ask. In the
absence of better information, it is the best we can do, of course.

However, Git for Windows' auto updater just learned the trick to use
git-gui--askyesno to ask the user whether to update now or not. And in
this scripted scenario, we can easily pass a command-line option to
change the window title.

So let's support that with the new `--title <title>` option.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-gui--askyesno | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/git-gui--askyesno b/git-gui--askyesno
index cf9c990d09..45b0260eff 100755
--- a/git-gui--askyesno
+++ b/git-gui--askyesno
@@ -12,10 +12,15 @@ if {$use_ttk} {
 	set NS ttk
 }
 
+set title "Question?"
 if {$argc < 1} {
 	puts stderr "Usage: $argv0 <question>"
 	exit 1
 } else {
+	if {$argc > 2 && [lindex $argv 0] == "--title"} {
+		set title [lindex $argv 1]
+		set argv [lreplace $argv 0 1]
+	}
 	set prompt [join $argv " "]
 }
 
@@ -47,5 +52,5 @@ proc yes {} {
 	exit 0
 }
 
-wm title . "Question?"
+wm title . $title
 tk::PlaceWindow .
-- 
gitgitgadget

