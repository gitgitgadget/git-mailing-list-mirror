Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C2091F453
	for <e@80x24.org>; Tue, 22 Jan 2019 21:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfAVVW3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 16:22:29 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:43505 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfAVVWY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 16:22:24 -0500
Received: by mail-ed1-f44.google.com with SMTP id f9so20516519eds.10
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 13:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jOEJLrRKSNU5Ubvoy4Sb+1LnpkiwcYXZTV6mBbN+Jpc=;
        b=Vse+0zXU2fr06W1ycTeL6AdRrQa5apHwfJf2Hwbsb15qbP+bAHg0dR37lLC7KVva3Y
         GJSPnEBhXe4L2Y3ezn5O0xyWbrTdz+T81vAiuZl1yFijQd2OdCY0WClFZ8s2RmsFPH+W
         6vvPkMkz2i09FBwOiT/GapEokXtfonsbH/cqzfsHQY0aC6jVNATDjgzoTDulVIqQItY+
         TNVkK2YVoWnZnXUB/mT2zq9iVp/SI3fTrwgMZIbExH5PMALebm/NjuEcxIFIEVBz/eiP
         npeNqf8WUGLxx2WWGqiIyZvINMobZNRIvdjVYZzoDBVQ8oyxn7RYMUyqnOiUMNw5/MJc
         E98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jOEJLrRKSNU5Ubvoy4Sb+1LnpkiwcYXZTV6mBbN+Jpc=;
        b=reIo1TIlBXv0oTO3Flye9IQA6oWoPMe4dqe1RropOwuP1BOUwfYB10mMnw7sZgiWq0
         fzJlObwVNbGU+LA13p+z1Shj2Lf2wAgc5vapl4T9L3lFnGU/C5kwn8hq2G4bTwm5c87w
         Dvs9BpygN+evAf9xIKrAvJ+J6J0MYIid937/DgJHcnxe6xtnbwVJwmaMyW3GYAl9/NZh
         pN9oU+k186SvgzKA6rm8/7Rb57PIRnytvTWi9ixiSlVdCZ6K+OWpg8Ny7LO4Y8Bm/cNV
         z4pUfpHjwMih/syXnilV/uPheili2eRFO2NndwM9rK8K1MEmEozZI0f9HCkYM3VEei12
         GQPw==
X-Gm-Message-State: AJcUukfN/6gdBmitxV+eMLnGqoJtNAk/TUSI+5jBnW4cN2emw0keCVrg
        BgxZH7ECzKb7Fh+tvA2G/u1EgWfc
X-Google-Smtp-Source: ALg8bN6SzXsOqJ3rpEVmLr2FG3TlBV7xwbNJDhxR8CuYwFr1sZ/GpdKHzIWDFHBqCn0FpEZMtwEHyw==
X-Received: by 2002:a50:8b41:: with SMTP id l59mr151244edl.44.1548192142996;
        Tue, 22 Jan 2019 13:22:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x58sm9566916edm.10.2019.01.22.13.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 13:22:22 -0800 (PST)
Date:   Tue, 22 Jan 2019 13:22:22 -0800 (PST)
X-Google-Original-Date: Tue, 22 Jan 2019 21:22:09 GMT
Message-Id: <7eea9027f9e1073515b99ee296d742154ef14e26.1548192131.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.git.gitgitgadget@gmail.com>
References: <pull.108.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 12/14] trace2:data: add subverb to reset command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/reset.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/reset.c b/builtin/reset.c
index 59898c972e..b65b4a66db 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -340,6 +340,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (patch_mode) {
 		if (reset_type != NONE)
 			die(_("--patch is incompatible with --{hard,mixed,soft}"));
+		trace2_cmd_subverb("patch-interactive");
 		return run_add_interactive(rev, "--patch=reset", &pathspec);
 	}
 
@@ -356,6 +357,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (reset_type == NONE)
 		reset_type = MIXED; /* by default */
 
+	if (pathspec.nr)
+		trace2_cmd_subverb("path");
+	else
+		trace2_cmd_subverb(reset_type_names[reset_type]);
+
 	if (reset_type != SOFT && (reset_type != MIXED || get_git_work_tree()))
 		setup_work_tree();
 
-- 
gitgitgadget

