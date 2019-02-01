Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E5D31F453
	for <e@80x24.org>; Fri,  1 Feb 2019 17:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbfBAR7V (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 12:59:21 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:41145 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731523AbfBAR7L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 12:59:11 -0500
Received: by mail-ed1-f44.google.com with SMTP id a20so6134489edc.8
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 09:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J256ctfmigu5mFnIJRHP42N6y/j6eTLobV2FjgdQk+0=;
        b=Or1HRocQWMjpqYJNUo1ZC2QbCb9nr0pEfO0LPBeNtGs52FUbuXok3vLRi/kFzFP4f7
         hapbKMYWU2Obt692X82rM8Qd9evdzrx52nabg/3lLj2n2b82WM4cD/a9ilaScidNmddC
         Zeu1d0lcsHhrwEEcF0V2x78+AWG72Dl3srvmktMbofVYirQTCl8BiXNG+giO1+X9mPE6
         wl89SqeptcbVG4pFyNhk3QPztQ6ZOkPhrAYxwhSjB/ePxmv4jyDHQp67R3iD6fKX3rWK
         7H7XyraC4HdDiGmzYxTgU/5HaXay+CDH3NjIm6MuJSFaVsU6WHma6un2QlnqCosduHyT
         H1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J256ctfmigu5mFnIJRHP42N6y/j6eTLobV2FjgdQk+0=;
        b=o/nzpOmxpgRXL+IHJW1MElukWkG1uYvoGRcdUJMEjaWmtjoBc1IYBuGKq8kSL/yKL9
         aLSj0gX8gDiXV51d+pNwxLrU5WyQzdJ8KU/fhHSuXQpAuJ1wveRt/Xb0uxU0YkkKqNLJ
         RfyD7h7SW7AtRZM4LaPfpBxElHhO5sQHtEqmMR4i2Ol2L514tzOcKpsb3dDxip3G+o4r
         dzokgGUZeAPm7K9pHoCVEwvDnmGbvzqXdnDJQtUujl6iuHIB/azPPVrs7rU/hiDS4hga
         +s2/W/TAnyG3Wqbc4ZimkL/Hec8QxZe331VprZKD5cBANuv752Jh2x4sRmzHZkxRp35c
         k1+A==
X-Gm-Message-State: AJcUukcE9xm1CCPjQsgRRsKWBzjSPcqQQt4z8Vc8jNFM6qewze4ska9T
        6TiphkYpcWKozmFoEmpN91Y2ssnK
X-Google-Smtp-Source: ALg8bN5AuVMrEy2XRtpPsQWETt7o/fGgTlHsLv6+kL1E/QstAU0++9AHu6+2FfKhW4GR57/TCJLgXg==
X-Received: by 2002:a17:906:8596:: with SMTP id v22mr23935481ejx.41.1549043949630;
        Fri, 01 Feb 2019 09:59:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n11sm2208313edn.14.2019.02.01.09.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 09:59:09 -0800 (PST)
Date:   Fri, 01 Feb 2019 09:59:09 -0800 (PST)
X-Google-Original-Date: Fri, 01 Feb 2019 17:58:53 GMT
Message-Id: <5c7f0de22859094ac0d1abef0e0c719a61e9e8c1.1549043937.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v5.git.gitgitgadget@gmail.com>
References: <pull.108.v4.git.gitgitgadget@gmail.com>
        <pull.108.v5.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 12/15] trace2:data: add subverb to reset command
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
index 59898c972e..4e34c61401 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -340,6 +340,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (patch_mode) {
 		if (reset_type != NONE)
 			die(_("--patch is incompatible with --{hard,mixed,soft}"));
+		trace2_cmd_mode("patch-interactive");
 		return run_add_interactive(rev, "--patch=reset", &pathspec);
 	}
 
@@ -356,6 +357,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (reset_type == NONE)
 		reset_type = MIXED; /* by default */
 
+	if (pathspec.nr)
+		trace2_cmd_mode("path");
+	else
+		trace2_cmd_mode(reset_type_names[reset_type]);
+
 	if (reset_type != SOFT && (reset_type != MIXED || get_git_work_tree()))
 		setup_work_tree();
 
-- 
gitgitgadget

